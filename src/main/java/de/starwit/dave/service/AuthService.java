package de.starwit.dave.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.oauth2.client.OAuth2AuthorizeRequest;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClient;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientManager;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClient;

@Service
public class AuthService {

    private Logger log = LoggerFactory.getLogger(AuthService.class);

    @Value("${app.auth.enabled:true}")
    private boolean daveAuth;

    @Value("${spring.security.oauth2.client.registration.daveclient.client-id}")
    private String clientId;

    @Value("${spring.security.oauth2.client.provider.daveprovider.token-uri}")
    private String tokenUri;

    @Autowired
    private OAuth2AuthorizedClientManager authorizedClientManager;

    @Autowired
    private RestClient restClient;


    public String sendData(String body, String url) {

        String result = "";

        if(daveAuth) {
            log.info("sending data with authentication using client " + clientId + " at IdP " + tokenUri);

            Authentication principal = new AnonymousAuthenticationToken(
                    "key",
                    "system",
                    AuthorityUtils.createAuthorityList("ROLE_SYSTEM"));

            OAuth2AuthorizeRequest authorizeRequest = OAuth2AuthorizeRequest
                    .withClientRegistrationId("daveclient")
                    .principal(principal)
                    .build();

            OAuth2AuthorizedClient authorizedClient = authorizedClientManager.authorize(authorizeRequest);

            String accessToken = authorizedClient.getAccessToken().getTokenValue();

            log.debug(accessToken);

            ResponseEntity<String> response = restClient.post()
                    .uri(url)
                    .header("Authorization", "Bearer " + accessToken)
                    .header("Content-Type", "application/json")
                    .header("Accept", "*/*")
                    .body(body)
                    .retrieve()
                    .toEntity(String.class);

            log.info("Send update to DAVe with response code " + response.getStatusCode());

            result = response.getBody();
        } else {
            ResponseEntity<String> response = restClient.post()
                    .uri(url)
                    .header("Content-Type", "application/json")
                    .header("Accept", "*/*")
                    .body(body)
                    .retrieve()
                    .toEntity(String.class);
            log.info("Send update to DAVe with response code " + response.getStatusCode());

            result = response.getBody();
        }

        return result;
    }

}
