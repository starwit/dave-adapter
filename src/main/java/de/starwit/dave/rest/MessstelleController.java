package de.starwit.dave.rest;

import de.muenchen.dave.geodateneai.gen.api.MessstelleApi;
import de.muenchen.dave.geodateneai.gen.model.MessstelleDto;
import de.muenchen.dave.geodateneai.gen.model.UnauffaelligerTagDto;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.NativeWebRequest;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/messstelle")
public class MessstelleController implements MessstelleApi {

    @GetMapping
    public ResponseEntity<List<MessstelleDto>> getMessstellen() {
        // TODO: Implement the logic to handle the request
        return ResponseEntity.ok(List.of(new MessstelleDto()));
    }

    @GetMapping("/unauffaellige-tage-for-each-messstelle")
    public ResponseEntity<List<UnauffaelligerTagDto>> getUnauffaelligeTageForEachMessstelle() {
        // TODO: Implement the logic to handle the request
        return ResponseEntity.ok(List.of(new UnauffaelligerTagDto()));
    }

    @Override
    public Optional<NativeWebRequest> getRequest() {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'getRequest'");
    }

    @Override
    public ResponseEntity<List<UnauffaelligerTagDto>> getUnauffaelligeTageForEachMessstelle(
            @NotNull @Valid LocalDate startDate, @NotNull @Valid LocalDate endDate) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'getUnauffaelligeTageForEachMessstelle'");
    }
}
