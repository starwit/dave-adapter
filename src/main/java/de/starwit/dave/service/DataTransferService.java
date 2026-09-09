package de.starwit.dave.service;

import java.io.IOException;
import java.nio.file.AtomicMoveNotSupportedException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.nio.file.StandardOpenOption;
import java.time.Duration;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import de.starwit.dave.dto.CountResultPerType;
import de.starwit.dave.dto.MeasureMapping;
import de.starwit.dave.persistence.AnalyticsRepository;
import de.starwit.dave.persistence.CountResults;
import jakarta.annotation.PostConstruct;
import tools.jackson.core.JacksonException;
import tools.jackson.core.type.TypeReference;
import tools.jackson.databind.json.JsonMapper;

@Service
public class DataTransferService {

    private Logger log = LoggerFactory.getLogger(DataTransferService.class);

    @Autowired
    AnalyticsRepository analyticsRepository;

    @Autowired
    AuthService authService;

    @Autowired
    JsonMapper mapper;

    boolean active = true;

    @Value("${app.dave.url:http://localhost:8080/detector/save-latest-detections}")
    private String daveUrl;

    @Value("${app.mapping:classpath:sampleMapping.json}")
    private Resource mappingFileLocation;

    @Value("${app.mapping.intersection:classpath:defaultIntersectionMapping.json}")
    private Resource defaultIntersectionMapping;

    @Value("${app.lookback_duration:1m}")
    private Duration lookbackDuration;

    @Value("${app.transfer_state_file:./.dave-adapter-transfer-state.json}")
    private String transferStateFile;

    private List<MeasureMapping> measureMappings = new ArrayList<>();
    private final Map<String, Long> transferredIntervalEnds = new HashMap<>();
    private final Object transferStateLock = new Object();

    @PostConstruct
    private void init() {
        log.info("Initializing with configured mapping file");
        loadTransferState();
        HashMap<String, Integer> defaultIntersectionMappings = initializeIntersectionMappingsFromFile();
        initializeMappingsFromFile(defaultIntersectionMappings);
    }

    private void loadTransferState() {
        Path statePath = Path.of(transferStateFile);
        if (!Files.exists(statePath)) {
            log.info("No persisted transfer state found at {}. Starting without transfer history.", statePath);
            return;
        }

        try (var inputStream = Files.newInputStream(statePath)) {
            Map<String, Long> loadedState = mapper.readValue(inputStream,
                    new TypeReference<HashMap<String, Long>>() {
                    });
            synchronized (transferStateLock) {
                transferredIntervalEnds.clear();
                transferredIntervalEnds.putAll(loadedState);
            }
            log.info("Loaded transfer state for {} counting IDs from {}.", transferredIntervalEnds.size(), statePath);
        } catch (IOException | JacksonException e) {
            log.error("Error loading transfer state from {}", statePath, e);
        }
    }

    private void persistTransferState() {
        Path statePath = Path.of(transferStateFile);
        Path absoluteStatePath = statePath.toAbsolutePath();
        Path parent = absoluteStatePath.getParent();

        try {
            if (parent != null) {
                Files.createDirectories(parent);
            }

            Path tempPath = absoluteStatePath.resolveSibling(absoluteStatePath.getFileName() + ".tmp");
            try (var outputStream = Files.newOutputStream(tempPath,
                    StandardOpenOption.CREATE,
                    StandardOpenOption.TRUNCATE_EXISTING,
                    StandardOpenOption.WRITE)) {
                mapper.writeValue(outputStream, transferredIntervalEnds);
            }

            try {
                Files.move(tempPath, absoluteStatePath,
                        StandardCopyOption.REPLACE_EXISTING,
                        StandardCopyOption.ATOMIC_MOVE);
            } catch (AtomicMoveNotSupportedException e) {
                Files.move(tempPath, absoluteStatePath, StandardCopyOption.REPLACE_EXISTING);
            }
        } catch (IOException e) {
            log.error("Error persisting transfer state to {}", absoluteStatePath, e);
        }
    }

    private boolean wasIntervalAlreadyTransferred(String countId, Instant intervalEnd) {
        synchronized (transferStateLock) {
            Long lastTransferredIntervalEnd = transferredIntervalEnds.get(countId);
            return lastTransferredIntervalEnd != null && lastTransferredIntervalEnd >= intervalEnd.getEpochSecond();
        }
    }

    private void markIntervalAsTransferred(String countId, Instant intervalEnd) {
        synchronized (transferStateLock) {
            long epochSecond = intervalEnd.getEpochSecond();
            Long knownIntervalEnd = transferredIntervalEnds.get(countId);
            if (knownIntervalEnd != null && knownIntervalEnd >= epochSecond) {
                return;
            }

            transferredIntervalEnds.put(countId, epochSecond);
            persistTransferState();
        }
    }

    private TransferInterval determineTransferInterval(Instant referenceTime) {
        long secondsInQuarter = Duration.ofMinutes(15).getSeconds();
        long secondsToSubtract = referenceTime.getEpochSecond() % secondsInQuarter;
        Instant intervalEnd = referenceTime.minusSeconds(secondsToSubtract).truncatedTo(ChronoUnit.SECONDS);
        Instant intervalStart = intervalEnd.minus(Duration.ofMinutes(15));
        Instant innerStart = intervalStart.minus(lookbackDuration);
        return new TransferInterval(innerStart, intervalStart, intervalEnd);
    }

    private HashMap<String, Integer> initializeIntersectionMappingsFromFile() {
        HashMap<String, Integer> intersectionMapping = new HashMap<>();
        if (defaultIntersectionMapping.exists()) {
            try (var inputStream = defaultIntersectionMapping.getInputStream()) {
                intersectionMapping.putAll(mapper.readValue(inputStream,
                        new TypeReference<HashMap<String, Integer>>() {
                        }));
            } catch (IOException | JacksonException e) {
                log.error("Error loading intersection mapping resource: " + defaultIntersectionMapping, e);
            }
        } else {
            log.error("Intersection mapping resource does not exist: " + defaultIntersectionMapping);
        }
        return intersectionMapping;
    }

    private void initializeMappingsFromFile(HashMap<String, Integer> defaultIntersectionMappings) {
        if (mappingFileLocation.exists()) {
            try (var inputStream = mappingFileLocation.getInputStream()) {
                MeasureMapping[] mapping = mapper.readValue(inputStream, MeasureMapping[].class);
                measureMappings = List.of(mapping);
                for (MeasureMapping measureMapping : measureMappings) {
                    if (measureMapping.getIntersectionMapping() == null
                            || measureMapping.getIntersectionMapping().isEmpty()) {
                        log.debug("No intersection mapping found for observation area ID: "
                                + measureMapping.getObservationAreaId() + ". Using default intersection mapping.");
                        measureMapping.setIntersectionMapping(defaultIntersectionMappings);
                    }
                }
                log.debug(measureMappings.toString());
            } catch (IOException | JacksonException e) {
                log.error("Error loading mapping resource: " + mappingFileLocation, e);
            }
        } else {
            log.error("Mapping resource does not exist: " + mappingFileLocation);
        }
    }

    @Scheduled(fixedRateString = "${app.update_interval}")
    public void transferData() {
        log.debug("Using this measurement mapping: " + measureMappings.toString());

        if (!active) {
            log.info("Data transfer is not active. Skipping data transfer.");
            return;
        }
        log.info("Transferring data...");

        TransferInterval transferInterval = determineTransferInterval(Instant.now());

        Map<String, List<CountResultPerType>> countResults = loadMeasuredData(transferInterval);
        log.debug("Data to transfer: " + countResults.toString());

        countResults.keySet().forEach(k -> {
            if (wasIntervalAlreadyTransferred(k, transferInterval.intervalEnd())) {
                log.info("Skipping already transmitted interval ending {} for counting ID {}.",
                        transferInterval.intervalEnd(), k);
                return;
            }

            log.info("Transferring data for counting ID: " + k);
            if (prepareAndSendData(countResults.get(k), k)) {
                markIntervalAsTransferred(k, transferInterval.intervalEnd());
            }
        });
    }

    private boolean prepareAndSendData(List<CountResultPerType> data, String countId) {
        String body = serializeToJSON(data, countId);
        log.debug("Serialized data to JSON: " + body);
        if (body.equals("[]")) {
            log.info("No data to send for counting ID " + countId + ". Skipping transfer.");
            return false;
        }
        String response = authService.sendData(body, daveUrl);
        log.debug(response);
        return true;
    }

    private String serializeToJSON(List<CountResultPerType> data, String countId) {
        List<String> filteredData = new ArrayList<>();
        for (CountResultPerType cr : data) {
            if (cr.getFrom() == null || cr.getTo() == null) {
                log.warn("Skipping entry with missing from/to mapping: " + cr.toString());
                continue;
            }
            try {
                filteredData.add(mapper.writeValueAsString(cr));
            } catch (JacksonException e) {
                log.warn("Error serializing data to JSON: " + e.getMessage());
            }
        }
        return "[" + String.join(",", filteredData) + "]";
    }

    private Map<String, List<CountResultPerType>> loadMeasuredData(TransferInterval transferInterval) {
        Map<String, List<CountResultPerType>> result = new HashMap<>();

        for (MeasureMapping measureMapping : measureMappings) {
            List<CountResults> cr = analyticsRepository.getCountings(
                    Long.parseLong(measureMapping.getObservationAreaId()), transferInterval.innerStart(),
                    transferInterval.intervalStart(), transferInterval.intervalEnd());
            log.debug("Data from analytics repository: " + cr.toString());

            List<CountResultPerType> convertedToRow = mapToRowResult(measureMapping, cr,
                    transferInterval.intervalStart(), transferInterval.intervalEnd());
            log.debug("Converted data to DAVe format: " + convertedToRow.toString());
            if (convertedToRow.isEmpty()) {
                log.info("No data for counting ID " + measureMapping.getDaveCountingId()
                        + " in the last interval. Creating empty data.");
                convertedToRow = createEmptyData(measureMapping.getDaveCountingId(), transferInterval.intervalStart(),
                        transferInterval.intervalEnd());
            }
            result.put(measureMapping.getDaveCountingId(), convertedToRow);
        }

        return result;
    }

    private List<CountResultPerType> createEmptyData(String countId, Instant start, Instant end) {
        List<CountResultPerType> emptyData = new ArrayList<>();
        if (measureMappings.get(0) != null) {
            var mappings = measureMappings.get(0).getIntersectionMapping();
            Set<String> keys = mappings.keySet();
            if (keys.size() != 0) {
                String first = keys.iterator().next();
                Integer daveDirection = findFirstNonEmptyMapping(first, mappings);
                CountResultPerType emptyResult = new CountResultPerType(countId, start, end, daveDirection,
                        daveDirection, 0, 0, 0, 0, 0, 0, 0);
                emptyData.add(emptyResult);
            }
        }

        return emptyData;
    }

    private Integer findFirstNonEmptyMapping(String first, Map<String, Integer> mappings) {
        for (Map.Entry<String, Integer> entry : mappings.entrySet()) {
            if (entry.getValue() != null) {
                return entry.getValue();
            }
        }
        return null;
    }

    private List<CountResultPerType> mapToRowResult(MeasureMapping measureMapping, List<CountResults> data,
            Instant start,
            Instant end) {
        List<CountResultPerType> result = new ArrayList<>();

        Set<String> allRoutes = new HashSet<>();
        for (CountResults countResult : data) {
            allRoutes.add(countResult.getCompassDirFrom() + "->" + countResult.getCompassDirTo());
        }

        for (String route : allRoutes) {
            int pkw = 0;
            int lkw = 0;
            int busse = 0;
            int kraftraeder = 0;
            int lastzuege = 0;
            int fahrradfahrer = 0;
            int fussgaenger = 0;

            for (CountResults countResult : data) {
                if ((countResult.getCompassDirFrom() + "->" + countResult.getCompassDirTo()).equals(route)) {
                    if (countResult.getObjectClassId() == 2) {
                        pkw += countResult.getCount();
                    } else if (countResult.getObjectClassId() == 7) {
                        lkw += countResult.getCount();
                    } else if (countResult.getObjectClassId() == 5) {
                        busse += countResult.getCount();
                    } else if (countResult.getObjectClassId() == 3) {
                        kraftraeder += countResult.getCount();
                    } else if (countResult.getObjectClassId() == 1) {
                        fahrradfahrer += countResult.getCount();
                    } else if (countResult.getObjectClassId() == 0) {
                        fussgaenger += countResult.getCount();
                    }
                }
            }

            String[] routes = route.split("->");
            Integer dave_von = measureMapping.getIntersectionMapping().get(routes[0]);
            Integer dave_nach = measureMapping.getIntersectionMapping().get(routes[1]);
            if (dave_von == null || dave_nach == null) {
                log.warn("Skipping route with missing mapping: " + route);
                continue;
            }
            CountResultPerType crpt = new CountResultPerType(measureMapping.getDaveCountingId(), start, end, dave_von,
                    dave_nach, pkw, lkw,
                    busse, kraftraeder, lastzuege, fahrradfahrer, fussgaenger);
            result.add(crpt);
        }

        return result;
    }

    public List<MeasureMapping> getMeasureMappings() {
        return measureMappings;
    }

    public List<MeasureMapping> setMeasureMappings(List<MeasureMapping> mappings) {
        this.measureMappings = mappings;
        return measureMappings;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    private record TransferInterval(Instant innerStart, Instant intervalStart, Instant intervalEnd) {
    }
}
