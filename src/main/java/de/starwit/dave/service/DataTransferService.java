package de.starwit.dave.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
        Map<String, List<CountResults>> countResults = getData();
        log.debug("Data to transfer: " + countResults.toString());

        countResults.keySet().forEach(k -> {
            log.info("Transferring data for counting ID: " + k);
            sendData(countResults.get(k), k);
        });
    }

    public void sendData(List<CountResults> data, String countId) {
        String body = createSpotsRequestBody(data, countId);
        HttpEntity<String> request = new HttpEntity<String>(body, getHeaders());
        ResponseEntity<String> response = restTemplate.exchange(daveUrl, HttpMethod.POST, request, String.class);
        log.info("Update response from DAVE: " + response.getStatusCode());
        log.debug("Request body: " + body);
    }

    private HttpHeaders getHeaders() {
        HttpHeaders headers = new HttpHeaders();
        // headers.set("Authorization","Bearer " + token);
        headers.setContentType(MediaType.APPLICATION_JSON);
        return headers;
    }

    private String createSpotsRequestBody(List<CountResults> data, String countId) {
        StringBuilder sb = new StringBuilder();
        sb.append("[");
        for (CountResults cr : data) {
            sb.append("\n{");
            sb.append("\"zaehlungId\": \"" + countId + "\",\n");
            sb.append("\"startUhrzeit\": \"" + cr.getTime().toString() + "\",\n");
            sb.append("\"endeUhrzeit\": \"" + cr.getTime().toString() + "\",\n");
            sb.append("\"pkw\": " + cr.getCount() + ",\n");
            sb.append("\"lkw\": 0,\n");
            sb.append("\"lastzuege\": 0,\n");
            sb.append("\"busse\": 0,\n");
            sb.append("\"kraftraeder\": 0,\n");
            sb.append("\"fahrradfahrer\": 0,\n");
            sb.append("\"fussgaenger\": 0,\n");
            sb.append("\"von\": " + cr.getNameFrom() + ",\n");
            sb.append("\"nach\": " + cr.getNameTo() + " \n");
            sb.append("},");
        }
        if (data.size() > 0) {
            sb.deleteCharAt(sb.length() - 1);
        }
        sb.append("]");
        return sb.toString();
    }

    private Map<String, List<CountResults>> getData() {
        Map<String, List<CountResults>> result = new HashMap<>();

        for (MeasureMapping mm : measureMappings) {
            List<CountResults> cr = analyticsRepository.getCountings(Long.parseLong(mm.getObservationAreaId()));
            log.debug("Data from analytics repository: " + cr.toString());
            for (CountResults c : cr) {
                c.setNameFrom(mm.getIntersectionMapping().get(c.getNameFrom()));
                c.setNameTo(mm.getIntersectionMapping().get(c.getNameTo()));
            }
            result.put(mm.getDaveCountingId(), cr);
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
