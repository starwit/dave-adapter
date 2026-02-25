package de.starwit.dave.service;

import java.io.File;
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
import org.springframework.core.io.ClassPathResource;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;

import de.starwit.dave.dto.CountResultPerType;
import de.starwit.dave.dto.MeasureMapping;
import de.starwit.dave.persistence.AnalyticsRepository;
import de.starwit.dave.persistence.CountResults;
import jakarta.annotation.PostConstruct;

@Service
public class DataTransferService {

    private Logger log = LoggerFactory.getLogger(DataTransferService.class);

    @Autowired
    AnalyticsRepository analyticsRepository;

    @Autowired
    AuthService authService;

    boolean active = true;

    @Value("${app.dave.url:http://localhost:8080/detector/save-latest-detections}")
    private String daveUrl;

    @Value("${app.test:false}")
    private boolean testMode;

    @Value("${app.mapping:sampleMapping.json}")
    private String mappingFileLocation;

    private List<MeasureMapping> measureMappings = new ArrayList<>();

    @PostConstruct
    private void init() {
        if (testMode) {
            try {
                log.info("Initializing DataTransferService with sample mapping.");
                var loadedMappings = new ObjectMapper().readValue(
                        new ClassPathResource("sampleMapping.json").getInputStream(), MeasureMapping[].class);
                measureMappings = List.of(loadedMappings);
                log.info("Loaded measure mappings: " + measureMappings.toString());
            } catch (Exception e) {
                log.error("Error loading sample mapping: " + e.getMessage());
            }
        } else {
            log.info("Initializing with configured mapping file");
            File mappingFile= new File(mappingFileLocation);
            if(mappingFile.exists() && mappingFile.isFile() && mappingFile.canRead()) {
                try {
                    MeasureMapping[] mapping = new ObjectMapper().readValue(mappingFile, MeasureMapping[].class);
                    measureMappings = List.of(mapping);
                } catch (IOException e) {
                    log.error("Error loading mapping file: " + e.getMessage());
                    active = false;
                }
            } else {
                log.error("Mapping file does not exist or cannot be read: " + mappingFileLocation);
                active = false;
            }
        }
    }

    @Scheduled(fixedRateString = "${app.update_frequency}")
    public void transferData() {
        log.debug("Using this measurement mapping: " + measureMappings.toString());

        if (!active) {
            log.info("Data transfer is not active. Skipping data transfer.");
            return;
        }
        log.info("Transferring data...");
        
        Map<String, List<CountResultPerType>> countResults = getData();
        log.debug("Data to transfer: " + countResults.toString());

        countResults.keySet().forEach(k -> {
            log.info("Transferring data for counting ID: " + k);
            sendData(countResults.get(k), k);
        });
    }

    public void sendData(List<CountResultPerType> data, String countId) {
        String body = createSpotsRequestBody(data, countId);
        String response = authService.sendData(body, daveUrl);
        log.debug(response);
    }

    private String createSpotsRequestBody(List<CountResultPerType> data, String countId) {
        StringBuilder sb = new StringBuilder();
        sb.append("[");
        for (CountResultPerType cr : data) {
            sb.append("\n{");
            sb.append("\"zaehlungId\": \"" + countId + "\",\n");
            sb.append("\"startUhrzeit\": \"" + cr.getStart() + "\",\n");
            sb.append("\"endeUhrzeit\": \"" + cr.getEnd() + "\",\n");
            sb.append("\"pkw\": " + cr.getPkw() + ",\n");
            sb.append("\"lkw\": " + cr.getLkw() + ",\n");
            sb.append("\"lastzuege\": 0,\n");
            sb.append("\"busse\": " + cr.getBusse() + ",\n");
            sb.append("\"kraftraeder\": " + cr.getKraftraeder() + ",\n");
            sb.append("\"fahrradfahrer\": " + cr.getFahrradfahrer() + ",\n");
            sb.append("\"fussgaenger\": " + cr.getFussgaenger() + ",\n");
            sb.append("\"von\": " + cr.getFrom() + ",\n");
            sb.append("\"nach\": " + cr.getTo() + " \n");
            sb.append("},");
        }
        if (data.size() > 0) {
            sb.deleteCharAt(sb.length() - 1);
        }
        sb.append("]");
        return sb.toString();
    }

    private Map<String, List<CountResultPerType>> getData() {
        Map<String, List<CountResultPerType>> result = new HashMap<>();

        var now = Instant.now();

        // Calculate how many seconds have passed since the start of the current 15-minute block
        long secondsInQuarter = 15 * 60; 
        long secondsToSubtract = now.getEpochSecond() % secondsInQuarter;

        // Subtract those seconds and clear nanoseconds
        Instant lastQuarterEnd = now.minusSeconds(secondsToSubtract).truncatedTo(ChronoUnit.SECONDS);
        Instant lastQuarterStart = lastQuarterEnd.minus(Duration.ofMinutes(15));

        for (MeasureMapping mm : measureMappings) {
            List<CountResults> cr = analyticsRepository.getCountings(Long.parseLong(mm.getObservationAreaId()), lastQuarterStart, lastQuarterEnd);
            log.debug("Data from analytics repository: " + cr.toString());

            List<CountResultPerType> convertedToRow = mapToRowResult(cr, Instant.now().minus(Duration.ofMinutes(15)), Instant.now());
            for (CountResultPerType c : convertedToRow) {
                c.setFrom(mm.getIntersectionMapping().get(c.getFrom()));
                c.setTo(mm.getIntersectionMapping().get(c.getTo()));
            }
            log.debug("Converted data to DAVe format: " + convertedToRow.toString());
            result.put(mm.getDaveCountingId(), convertedToRow);
        }

        return result;
    }

    private List<CountResultPerType> mapToRowResult(List<CountResults> data, Instant start, Instant end) {
        List<CountResultPerType> result = new ArrayList<>();

        Map<Instant, List<CountResults>> map = new HashMap<>();
        for (CountResults cr : data) {
            if (!map.containsKey(cr.getTime())) {
                map.put(cr.getTime(), new ArrayList<>());
            }
            map.get(cr.getTime()).add(cr);
        }

        for (Instant time : map.keySet()) {
            List<CountResults> crs = map.get(time);
            Set<String> allRoutes = new HashSet<>();
            for (CountResults countResult : crs) {
                allRoutes.add(countResult.getNameFrom() + "->" + countResult.getNameTo());
            }
            
            for (String route : allRoutes) {
                int pkw = 0;
                int lkw = 0;
                int busse = 0;
                int kraftraeder = 0;
                int fahrradfahrer = 0;
                int fussgaenger = 0;

                for (CountResults countResult : crs) {
                    if ((countResult.getNameFrom() + "->" + countResult.getNameTo()).equals(route)) {
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
                CountResultPerType crpt = new CountResultPerType(start, end, routes[0], routes[1], pkw, lkw, busse, kraftraeder, fahrradfahrer, fussgaenger);
                result.add(crpt);
            }          
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
