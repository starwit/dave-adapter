package de.starwit.dave.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import de.starwit.dave.dto.MeasureMapping;
import de.starwit.dave.service.DataTransferService;
import io.swagger.v3.oas.annotations.Operation;

@RestController
@RequestMapping(path = "${rest.base-path}/mapping")
public class MappingController {

    @Autowired
    DataTransferService dataTransferService;
    
    @Operation(summary = "Get all current mappings between Observatory and DAVe")
    @GetMapping
    public List<MeasureMapping> getMappings() {
        return dataTransferService.getMeasureMappings();
    }

    @Operation(summary = "Get all current mappings between Observatory and DAVe")
    @PostMapping
    public List<MeasureMapping> setMappings(@RequestBody List<MeasureMapping> mappings) {
        return dataTransferService.setMeasureMappings(mappings);
    }

    @Operation(summary = "Is mapped data transfer active?")
    @GetMapping(path = "/active")
    public boolean getisActive() {
        return dataTransferService.isActive();
    }

    @Operation(summary = "Activate or deactivate mapped data transfer")
    @PostMapping(path = "/active")
    public void setActive(@RequestBody boolean active) {
        dataTransferService.setActive(active);
    }

}