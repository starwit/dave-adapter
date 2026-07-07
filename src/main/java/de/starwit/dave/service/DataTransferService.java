package de.starwit.dave.service;

import java.io.IOException;
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

    private List<MeasureMapping> measureMappings = new ArrayList<>();

    @PostConstruct
    private void init() {
        log.info("Initializing with configured mapping file");
        HashMap<String, Integer> defaultIntersectionMappings = initializeIntersectionMappingsFromFile();
        initializeMappingsFromFile(defaultIntersectionMappings);
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

        Map<String, List<CountResultPerType>> countResults = LoadMeasuredData();
        log.debug("Data to transfer: " + countResults.toString());

        countResults.keySet().forEach(k -> {
            log.info("Transferring data for counting ID: " + k);
            prepareAndSendData(countResults.get(k), k);
        });
    }

    public void prepareAndSendData(List<CountResultPerType> data, String countId) {
        String body = serializeToJSON(data, countId);
        log.debug("Serialized data to JSON: " + body);
        if (body.equals("[]")) {
            log.info("No data to send for counting ID " + countId + ". Skipping transfer.");
            return;
        }
        String response = authService.sendData(body, daveUrl);
        log.debug(response);
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

    private Map<String, List<CountResultPerType>> LoadMeasuredData() {
        Map<String, List<CountResultPerType>> result = new HashMap<>();

        var now = Instant.now();

        // Calculate how many seconds have passed since the start of the current
        // 15-minute block
        long secondsInQuarter = 15 * 60;
        long secondsToSubtract = now.getEpochSecond() % secondsInQuarter;

        // Subtract those seconds and clear nanoseconds to get the aligned interval
        // boundaries
        Instant lastQuarterEnd = now.minusSeconds(secondsToSubtract).truncatedTo(ChronoUnit.SECONDS);
        Instant lastQuarterStart = lastQuarterEnd.minus(Duration.ofMinutes(15));
        Instant innerStart = lastQuarterStart.minus(lookbackDuration);

        for (MeasureMapping measureMapping : measureMappings) {
            List<CountResults> cr = analyticsRepository.getCountings(
                    Long.parseLong(measureMapping.getObservationAreaId()), innerStart, lastQuarterStart,
                    lastQuarterEnd);
            log.debug("Data from analytics repository: " + cr.toString());

            List<CountResultPerType> convertedToRow = mapToRowResult(measureMapping, cr,
                    lastQuarterStart, lastQuarterEnd);
            log.debug("Converted data to DAVe format: " + convertedToRow.toString());
            if (convertedToRow.isEmpty()) {
                log.info("No data for counting ID " + measureMapping.getDaveCountingId()
                        + " in the last interval. Creating empty data.");
                convertedToRow = createEmptyData(measureMapping.getDaveCountingId(), lastQuarterStart, lastQuarterEnd);
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
                        daveDirection, 0, 0, 0, 0, 0, 0);
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
                    busse, kraftraeder, fahrradfahrer, fussgaenger);
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
}
