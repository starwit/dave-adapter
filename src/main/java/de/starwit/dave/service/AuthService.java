package de.starwit.dave.service;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

import de.starwit.dave.dto.AuthTokenResponse;

@Service
public class AuthService {

    private Logger log = LoggerFactory.getLogger(AuthService.class);

    @Value("${app.auth.username}")
    private String username;

    @Value("${app.auth.password}")
    private String password;

    @Value("${app.auth.clientid}")
    private String clientId;
    
    @Value("${app.auth.tokenurl}")
    private String authUrl;

    @Value("${app.auth.enabled:true}")
    private boolean daveAuth;
    
    private LocalDateTime tokenTimeStamp;
    
    private String token = null;

    @Autowired
    private RestTemplate restTemplate;
    
    private ObjectMapper mapper;

    private void getAccessToken() {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        MultiValueMap<String, String> map= new LinkedMultiValueMap<String, String>();
        map.add("client_id", clientId);
        map.add("grant_type", "password"); 
        map.add("username", username.trim());
        map.add("password", password.trim());
        map.add("scope", "openid profile email");

        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<MultiValueMap<String, String>>(map, headers);
        HttpEntity<String> response;
        try {
            response = restTemplate.postForEntity(authUrl, request, String.class);
        } catch (HttpClientErrorException e) {
            log.error("Can't get access token for user " + username + " with error: " + e.getMessage());
            token = null;
            return;
        }

        mapper = new ObjectMapper().configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        try {
            AuthTokenResponse authResponse = mapper.readValue(response.getBody(), AuthTokenResponse.class);
            token = authResponse.getAccessToken();
            tokenTimeStamp = LocalDateTime.now();
            log.debug("Token succesfully loaded");
        } catch (JsonProcessingException e) {
            log.error("Can't parse auth response " + e.getMessage());
        }
    }

    private void checkIfTokenIsStillValid() {
        if(token == null) {
            getAccessToken();
        } else {
            LocalDateTime now = LocalDateTime.now();
            long diff = ChronoUnit.MILLIS.between(tokenTimeStamp, now);
            log.debug("Token age " + diff);
            // token is too old, try again to aqcuire one
            if(diff > 2590000) {
                log.debug("Token too old, get a new one");
                getAccessToken();
            }
        }
    }

    public String sendData(String body, String url) {
        
        HttpHeaders headers = new HttpHeaders();
        if(daveAuth) {
            checkIfTokenIsStillValid();
            headers.set("Authorization","Bearer " + token);
        }
        
        headers.setContentType(MediaType.APPLICATION_JSON);

        log.debug("Request body: " + body);
        HttpEntity<String> request = new HttpEntity<String>(body, headers);
        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, request, String.class);

        log.info("Update response from DAVE: " + response.getStatusCode());
        return response.getBody().toString();
    }
    
}
