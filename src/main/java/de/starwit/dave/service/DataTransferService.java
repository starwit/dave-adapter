package de.starwit.dave.service;

import java.time.Duration;
import java.time.Instant;
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
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

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
    private RestTemplate restTemplate;

    boolean active = true;

    @Value("${app.dave.url:http://localhost:8080/detector/saveLatestDetections}")
    private String daveUrl;

    @Value("${app.dave.auth:true}")
    private boolean daveAuth;

    @Value("${app.dave.auth.token:someToken}")
    private String daveToken;

    @Value("${app.test:false}")
    private boolean testMode;

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
        log.debug("Request body: " + body);
        HttpEntity<String> request = new HttpEntity<String>(body, getHeaders());
        ResponseEntity<String> response = restTemplate.exchange(daveUrl, HttpMethod.POST, request, String.class);
        log.info("Update response from DAVE: " + response.getStatusCode());
    }

    private HttpHeaders getHeaders() {
        HttpHeaders headers = new HttpHeaders();
        // headers.set("Authorization","Bearer " + token);
        headers.setContentType(MediaType.APPLICATION_JSON);
        return headers;
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

        for (MeasureMapping mm : measureMappings) {
            List<CountResults> cr = analyticsRepository.getCountings(Long.parseLong(mm.getObservationAreaId()));
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
