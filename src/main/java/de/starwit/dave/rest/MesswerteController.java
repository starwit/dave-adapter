package de.starwit.dave.rest;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import de.muenchen.dave.geodateneai.gen.api.MesswerteApi;
import de.muenchen.dave.geodateneai.gen.model.IntervalDto;
import de.muenchen.dave.geodateneai.gen.model.IntervalResponseDto;
import de.muenchen.dave.geodateneai.gen.model.MesswertRequestDto;
import de.muenchen.dave.geodateneai.gen.model.TagesaggregatRequestDto;
import de.muenchen.dave.geodateneai.gen.model.TagesaggregatResponseDto;

@RestController
@RequestMapping("/messwerte")
public class MesswerteController implements MesswerteApi{

    @PostMapping("/intervals")
    public ResponseEntity<IntervalResponseDto> getIntervalle(@RequestBody MesswertRequestDto request) {
        IntervalResponseDto irdto = new IntervalResponseDto();
        irdto = createMockIntervalResponse().getBody();
        //
        return ResponseEntity.ok(irdto);
    }

    @PostMapping("/daily-aggregates")
    public ResponseEntity<TagesaggregatResponseDto> getMeanOfDailyAggregatesPerMQ(@RequestBody TagesaggregatRequestDto request) {
        // TODO: Implement the logic to handle the request
        return ResponseEntity.ok(new TagesaggregatResponseDto());
    }

    protected static ResponseEntity<IntervalResponseDto> createMockIntervalResponse() {
        // Mock IntervalResponseDto for testing
        IntervalResponseDto mockResponse = new IntervalResponseDto();

        List<IntervalDto> sampleIntervals = getMockIntervals();

        mockResponse.setMeanOfSummedUpMessquerschnitteForEachIntervalOverMesstage(sampleIntervals);
        mockResponse.setIncludedMeasuringDays(5);

        return ResponseEntity.ok(mockResponse);
    }

    private static List<IntervalDto> getMockIntervals() {
        // Create sample intervals with all fields set
        List<IntervalDto> sampleIntervals = new ArrayList<>();

        IntervalDto interval1 = new IntervalDto();
        interval1.setMqId(1234);
        interval1.setDatumUhrzeitVon(LocalDateTime.of(2026, 1, 21, 6, 0));
        interval1.setDatumUhrzeitBis(LocalDateTime.of(2026, 1, 21, 6, 15));
        interval1.setTagesTyp(IntervalDto.TagesTypEnum.DTV);
        interval1.setAnzahlLfw(BigDecimal.valueOf(100));
        interval1.setAnzahlLkw(BigDecimal.valueOf(20));
        interval1.setAnzahlKrad(BigDecimal.valueOf(5));
        interval1.setAnzahlBus(BigDecimal.valueOf(3));
        interval1.setAnzahlRad(BigDecimal.valueOf(30));
        interval1.setSummeAllePkw(BigDecimal.valueOf(200));
        interval1.setSummeLastzug(BigDecimal.valueOf(12));
        interval1.setSummeGueterverkehr(BigDecimal.valueOf(32));
        interval1.setSummeSchwerverkehr(BigDecimal.valueOf(40));
        interval1.setSummeKraftfahrzeugverkehr(BigDecimal.valueOf(128));
        interval1.setProzentSchwerverkehr(BigDecimal.valueOf(31.25));
        interval1.setProzentGueterverkehr(BigDecimal.valueOf(25.0));
        sampleIntervals.add(interval1);

        IntervalDto interval2 = new IntervalDto();
        interval2.setMqId(1234);
        interval2.setDatumUhrzeitVon(LocalDateTime.of(2026, 1, 21, 6, 15));
        interval2.setDatumUhrzeitBis(LocalDateTime.of(2026, 1, 21, 6, 30));
        interval2.setTagesTyp(IntervalDto.TagesTypEnum.DTV);
        interval2.setAnzahlLfw(BigDecimal.valueOf(120));
        interval2.setAnzahlLkw(BigDecimal.valueOf(25));
        interval2.setAnzahlKrad(BigDecimal.valueOf(8));
        interval2.setAnzahlBus(BigDecimal.valueOf(4));
        interval2.setAnzahlRad(BigDecimal.valueOf(35));
        interval2.setSummeAllePkw(BigDecimal.valueOf(240));
        interval2.setSummeLastzug(BigDecimal.valueOf(15));
        interval2.setSummeGueterverkehr(BigDecimal.valueOf(50));
        interval2.setSummeSchwerverkehr(BigDecimal.valueOf(48));
        interval2.setSummeKraftfahrzeugverkehr(BigDecimal.valueOf(157));
        interval2.setProzentSchwerverkehr(BigDecimal.valueOf(30.57));
        interval2.setProzentGueterverkehr(BigDecimal.valueOf(25.48));
        sampleIntervals.add(interval2);

        IntervalDto interval3 = new IntervalDto();
        interval3.setMqId(1235);
        interval3.setDatumUhrzeitVon(LocalDateTime.of(2026, 1, 21, 6, 0));
        interval3.setDatumUhrzeitBis(LocalDateTime.of(2026, 1, 21, 6, 15));
        interval3.setTagesTyp(IntervalDto.TagesTypEnum.DTV);
        interval3.setAnzahlLfw(BigDecimal.valueOf(23));
        interval3.setAnzahlLkw(BigDecimal.valueOf(12));
        interval3.setAnzahlKrad(BigDecimal.valueOf(5));
        interval3.setAnzahlBus(BigDecimal.valueOf(3));
        interval3.setAnzahlRad(BigDecimal.valueOf(12));
        interval3.setSummeAllePkw(BigDecimal.valueOf(100));
        interval3.setSummeLastzug(BigDecimal.valueOf(12));
        interval3.setSummeGueterverkehr(BigDecimal.valueOf(32));
        interval3.setSummeSchwerverkehr(BigDecimal.valueOf(40));
        interval3.setSummeKraftfahrzeugverkehr(BigDecimal.valueOf(128));
        interval3.setProzentSchwerverkehr(BigDecimal.valueOf(31.25));
        interval3.setProzentGueterverkehr(BigDecimal.valueOf(25.0));
        sampleIntervals.add(interval3);

        IntervalDto interval4 = new IntervalDto();
        interval4.setMqId(1235);
        interval4.setDatumUhrzeitVon(LocalDateTime.of(2026, 1, 21, 6, 15));
        interval4.setDatumUhrzeitBis(LocalDateTime.of(2026, 1, 21, 6, 30));
        interval4.setTagesTyp(IntervalDto.TagesTypEnum.DTV);
        interval4.setAnzahlLfw(BigDecimal.valueOf(30));
        interval4.setAnzahlLkw(BigDecimal.valueOf(25));
        interval4.setAnzahlKrad(BigDecimal.valueOf(8));
        interval4.setAnzahlBus(BigDecimal.valueOf(4));
        interval4.setAnzahlRad(BigDecimal.valueOf(4));
        interval4.setSummeAllePkw(BigDecimal.valueOf(120));
        interval4.setSummeLastzug(BigDecimal.valueOf(15));
        interval4.setSummeGueterverkehr(BigDecimal.valueOf(40));
        interval4.setSummeSchwerverkehr(BigDecimal.valueOf(48));
        interval4.setSummeKraftfahrzeugverkehr(BigDecimal.valueOf(400));
        interval4.setProzentSchwerverkehr(BigDecimal.valueOf(30.57));
        interval4.setProzentGueterverkehr(BigDecimal.valueOf(25.48));
        sampleIntervals.add(interval4);

        IntervalDto interval5 = new IntervalDto();
        interval5.setMqId(1236);
        interval5.setDatumUhrzeitVon(LocalDateTime.of(2026, 1, 21, 6, 0));
        interval5.setDatumUhrzeitBis(LocalDateTime.of(2026, 1, 21, 6, 15));
        interval5.setTagesTyp(IntervalDto.TagesTypEnum.DTV);
        interval5.setAnzahlLfw(BigDecimal.valueOf(23));
        interval5.setAnzahlLkw(BigDecimal.valueOf(12));
        interval5.setAnzahlKrad(BigDecimal.valueOf(5));
        interval5.setAnzahlBus(BigDecimal.valueOf(3));
        interval5.setAnzahlRad(BigDecimal.valueOf(12));
        interval5.setSummeAllePkw(BigDecimal.valueOf(100));
        interval5.setSummeLastzug(BigDecimal.valueOf(12));
        interval5.setSummeGueterverkehr(BigDecimal.valueOf(32));
        interval5.setSummeSchwerverkehr(BigDecimal.valueOf(40));
        interval5.setSummeKraftfahrzeugverkehr(BigDecimal.valueOf(128));
        interval5.setProzentSchwerverkehr(BigDecimal.valueOf(31.25));
        interval5.setProzentGueterverkehr(BigDecimal.valueOf(25.0));
        sampleIntervals.add(interval5);

        IntervalDto interval6 = new IntervalDto();
        interval6.setMqId(1235);
        interval6.setDatumUhrzeitVon(LocalDateTime.of(2026, 1, 21, 6, 15));
        interval6.setDatumUhrzeitBis(LocalDateTime.of(2026, 1, 21, 6, 30));
        interval6.setTagesTyp(IntervalDto.TagesTypEnum.DTV);
        interval6.setAnzahlLfw(BigDecimal.valueOf(30));
        interval6.setAnzahlLkw(BigDecimal.valueOf(25));
        interval6.setAnzahlKrad(BigDecimal.valueOf(8));
        interval6.setAnzahlBus(BigDecimal.valueOf(4));
        interval6.setAnzahlRad(BigDecimal.valueOf(4));
        interval6.setSummeAllePkw(BigDecimal.valueOf(120));
        interval6.setSummeLastzug(BigDecimal.valueOf(15));
        interval6.setSummeGueterverkehr(BigDecimal.valueOf(40));
        interval6.setSummeSchwerverkehr(BigDecimal.valueOf(48));
        interval6.setSummeKraftfahrzeugverkehr(BigDecimal.valueOf(157));
        interval6.setProzentSchwerverkehr(BigDecimal.valueOf(30.57));
        interval6.setProzentGueterverkehr(BigDecimal.valueOf(25.48));
        sampleIntervals.add(interval6);
        return sampleIntervals;
    }

}
