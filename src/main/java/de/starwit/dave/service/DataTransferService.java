package de.starwit.dave.service;

import java.time.Duration;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import de.starwit.dave.persistence.AnalyticsRepository;
import de.starwit.dave.persistence.CountResults;

@Service
public class DataTransferService {

    private Logger log = LoggerFactory.getLogger(DataTransferService.class);

    @Autowired
    AnalyticsRepository analyticsRepository;

    @Autowired
    private RestTemplate restTemplate;

    @Value("${app.dave.url:http://localhost:8080/detector/saveLatestDetections}")
    private String daveUrl;

    private String countId = "339f992e-0925-4f6d-9e75-099bc520ad2c";

    @Scheduled(fixedRateString = "${app.update_frequency}")
    public void transferData() {
        log.info("Transferring data...");
        // var countResults = analyticsRepository.getCountings();
        List<CountResults> countResults = createTestData(4);
        sendData(countResults);
    }

    public void sendData(List<CountResults> data) {
        String body = createSpotsRequestBody(data);
        HttpEntity<String> request = new HttpEntity<String>(body, getHeaders());
        ResponseEntity<String> response = restTemplate.exchange(daveUrl, HttpMethod.POST, request, String.class);
        log.info("Update response from DAVE: " + response.getStatusCode());
        System.out.println("Request body: " + body);
    }

    private HttpHeaders getHeaders() {
        HttpHeaders headers = new HttpHeaders();
        // headers.set("Authorization","Bearer " + token);
        headers.setContentType(MediaType.APPLICATION_JSON);
        return headers;
    }

    private String createSpotsRequestBody(List<CountResults> data) {
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
            sb.append("\"von\": " + cr.getDaveFromRoute() + ",\n");
            sb.append("\"nach\": " + cr.getDaveToRoute() + " \n");
            sb.append("},");
        }
        if (data.size() > 0) {
            sb.deleteCharAt(sb.length() - 1);
        }
        sb.append("]");
        return sb.toString();
    }

    private List<CountResults> createTestData(int numRoutes) {
        List<CountResults> countResults = new ArrayList<>();
        for (int k = 0; k < 1; k++) {
            for (int i = 1; i <= numRoutes; i++) {
                for (int j = 1; j <= numRoutes; j++) {
                    CountResults cr = new CountResults();
                    cr.setTime(Instant.now().minus((Duration.ofMinutes(15)).multipliedBy(k)));
                    cr.setCount(10);
                    cr.setObjectClassId(2);
                    cr.setDaveFromRoute(i);
                    cr.setDaveToRoute(j);
                    countResults.add(cr);
                }
            }
        }
        return countResults;
    }

}
