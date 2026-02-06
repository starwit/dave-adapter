package de.starwit.dave.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
public class DataTransferService {

    private Logger log = LoggerFactory.getLogger(DataTransferService.class);

    @Scheduled(fixedRateString = "${app.update_frequency}")
    public void transferData() {
        log.info("Transferring data...");
    }
    
}
