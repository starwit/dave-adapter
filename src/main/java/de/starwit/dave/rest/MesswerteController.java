package de.starwit.dave.rest;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import de.muenchen.dave.geodateneai.gen.api.MesswerteApi;
import de.muenchen.dave.geodateneai.gen.model.IntervalDto;
import de.muenchen.dave.geodateneai.gen.model.IntervalResponseDto;
import de.muenchen.dave.geodateneai.gen.model.IntervalsForMqIdDto;
import de.muenchen.dave.geodateneai.gen.model.MesswertRequestDto;
import de.muenchen.dave.geodateneai.gen.model.TagesaggregatRequestDto;
import de.muenchen.dave.geodateneai.gen.model.TagesaggregatResponseDto;

@RestController
@RequestMapping("/messwerte")
public class MesswerteController implements MesswerteApi {

    static Random r = new Random();

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
        IntervalResponseDto mockResponse = getMockIntervals();
        return ResponseEntity.ok(mockResponse);
    }

    private static IntervalResponseDto getMockIntervals() {
        IntervalResponseDto mockResponse = new IntervalResponseDto();
        mockResponse.setIncludedMeasuringDays(5);

        List<IntervalDto> sampleIntervals = new ArrayList<>();
        List<IntervalDto> sampleIntervals1 = new ArrayList<>();
        List<IntervalDto> sampleIntervals2 = new ArrayList<>();
        List<IntervalDto> sampleIntervals3 = new ArrayList<>();

        List<IntervalDto> dailyDtos1 = new ArrayList<>();
        List<IntervalDto> dailyDtos2 = new ArrayList<>();

        IntervalsForMqIdDto intervalForMqIdDto1 = new IntervalsForMqIdDto();
        intervalForMqIdDto1.setMqId(1234);

        IntervalsForMqIdDto intervalForMqIdDto2 = new IntervalsForMqIdDto();
        intervalForMqIdDto2.setMqId(1235);

        IntervalsForMqIdDto dayForMqIdDto1 = new IntervalsForMqIdDto();
        dayForMqIdDto1.setMqId(1234);

        IntervalsForMqIdDto dayForMqIdDto2 = new IntervalsForMqIdDto();
        dayForMqIdDto2.setMqId(1235);

        int end = 0;
        int endday = 0;
        long totalIntervals = 0;

        for (int day = 28; day < 29; day++) {

            dailyDtos1 = new ArrayList<>();
            IntervalDto dailyInterval1 = new IntervalDto();
            dailyDtos2 = new ArrayList<>();
            IntervalDto dailyInterval2 = new IntervalDto();
            totalIntervals = 0;

            for (int j = 0; j < 23; j++) {
                for (int i = 0; i < 4; i++) { 

                    end = (i + 1) * 15;
                    endday = j;
                    if (end == 60) {
                        end = 0;
                        endday = j + 1;
                    }
                    totalIntervals++;

                    IntervalDto interval1 = new IntervalDto();
                    interval1.setMqId(1234);
                    interval1.setDatumUhrzeitVon(LocalDateTime.of(2026, 1, day, j, i * 15));
                    interval1.setDatumUhrzeitBis(LocalDateTime.of(2026, 1, day, endday, end));
                    interval1.setTagesTyp(IntervalDto.TagesTypEnum.DTV);
                    interval1.setAnzahlLfw(BigDecimal.valueOf(r.nextInt(10)));
                    interval1.setAnzahlLkw(BigDecimal.valueOf(r.nextInt(10)));
                    interval1.setAnzahlKrad(BigDecimal.valueOf(r.nextInt(10)));
                    interval1.setAnzahlBus(BigDecimal.valueOf(r.nextInt(10)));
                    interval1.setAnzahlRad(BigDecimal.valueOf(r.nextInt(10)));
                    interval1.setSummeAllePkw(BigDecimal.valueOf(r.nextInt(10)));
                    interval1.setSummeLastzug(BigDecimal.valueOf(r.nextInt(10)));
                    sampleIntervals1.add(interval1);

                    dailyInterval1.setDatumUhrzeitVon(LocalDateTime.of(2026, 1, day, 0, 0));
                    dailyInterval1.setDatumUhrzeitBis(LocalDateTime.of(2026, 1, day, 23, 59));
                    dailyInterval1.setTagesTyp(IntervalDto.TagesTypEnum.DTV);
                    dailyInterval1.setAnzahlLfw(dailyInterval1.getAnzahlLfw() == null ? interval1.getAnzahlLfw() : dailyInterval1.getAnzahlLfw().add(interval1.getAnzahlLfw()));
                    dailyInterval1.setAnzahlLkw(dailyInterval1.getAnzahlLkw() == null ? interval1.getAnzahlLkw() : dailyInterval1.getAnzahlLkw().add(interval1.getAnzahlLkw()));
                    dailyInterval1.setAnzahlKrad(dailyInterval1.getAnzahlKrad() == null ? interval1.getAnzahlKrad() : dailyInterval1.getAnzahlKrad().add(interval1.getAnzahlKrad()));
                    dailyInterval1.setAnzahlBus(dailyInterval1.getAnzahlBus() == null ? interval1.getAnzahlBus() : dailyInterval1.getAnzahlBus().add(interval1.getAnzahlBus()));
                    dailyInterval1.setAnzahlRad(dailyInterval1.getAnzahlRad() == null ? interval1.getAnzahlRad() : dailyInterval1.getAnzahlRad().add(interval1.getAnzahlRad()));
                    dailyInterval1.setSummeAllePkw(dailyInterval1.getSummeAllePkw() == null ? interval1.getSummeAllePkw() : dailyInterval1.getSummeAllePkw().add(interval1.getSummeAllePkw()));
                    dailyInterval1.setSummeLastzug(dailyInterval1.getSummeLastzug() == null ? interval1.getSummeLastzug() : dailyInterval1.getSummeLastzug().add(interval1.getSummeLastzug()));
                    
                    IntervalDto interval2 = new IntervalDto();
                    interval2.setMqId(1235);
                    interval2.setDatumUhrzeitVon(LocalDateTime.of(2026, 1, day, j, i * 15));
                    interval2.setDatumUhrzeitBis(LocalDateTime.of(2026, 1, day, endday, end));
                    interval2.setTagesTyp(IntervalDto.TagesTypEnum.DTV);
                    interval2.setAnzahlLfw(BigDecimal.valueOf(r.nextInt(10)));
                    interval2.setAnzahlLkw(BigDecimal.valueOf(r.nextInt(10)));
                    interval2.setAnzahlKrad(BigDecimal.valueOf(r.nextInt(10)));
                    interval2.setAnzahlBus(BigDecimal.valueOf(r.nextInt(10)));
                    interval2.setAnzahlRad(BigDecimal.valueOf(r.nextInt(10)));
                    interval2.setSummeAllePkw(BigDecimal.valueOf(r.nextInt(10)));
                    interval2.setSummeLastzug(BigDecimal.valueOf(r.nextInt(10)));
                    sampleIntervals2.add(interval2);

                    dailyInterval2.setDatumUhrzeitVon(LocalDateTime.of(2026, 1, day, 0, 0));
                    dailyInterval2.setDatumUhrzeitBis(LocalDateTime.of(2026, 1, day, 23, 59));
                    dailyInterval2.setTagesTyp(IntervalDto.TagesTypEnum.DTV);
                    dailyInterval2.setAnzahlLfw(dailyInterval2.getAnzahlLfw() == null ? interval2.getAnzahlLfw() : dailyInterval2.getAnzahlLfw().add(interval2.getAnzahlLfw()));
                    dailyInterval2.setAnzahlLkw(dailyInterval2.getAnzahlLkw() == null ? interval2.getAnzahlLkw() : dailyInterval2.getAnzahlLkw().add(interval2.getAnzahlLkw()));
                    dailyInterval2.setAnzahlKrad(dailyInterval2.getAnzahlKrad() == null ? interval2.getAnzahlKrad() : dailyInterval2.getAnzahlKrad().add(interval2.getAnzahlKrad()));
                    dailyInterval2.setAnzahlBus(dailyInterval2.getAnzahlBus() == null ? interval2.getAnzahlBus() : dailyInterval2.getAnzahlBus().add(interval2.getAnzahlBus()));
                    dailyInterval2.setAnzahlRad(dailyInterval2.getAnzahlRad() == null ? interval2.getAnzahlRad() : dailyInterval2.getAnzahlRad().add(interval2.getAnzahlRad()));
                    dailyInterval2.setSummeAllePkw(dailyInterval2.getSummeAllePkw() == null ? interval2.getSummeAllePkw() : dailyInterval2.getSummeAllePkw().add(interval2.getSummeAllePkw()));
                    dailyInterval2.setSummeLastzug(dailyInterval2.getSummeLastzug() == null ? interval2.getSummeLastzug() : dailyInterval2.getSummeLastzug().add(interval2.getSummeLastzug()));

                    IntervalDto interval3 = new IntervalDto();
                    interval3.setDatumUhrzeitVon(LocalDateTime.of(2026, 1, day, j, i * 15));
                    interval3.setDatumUhrzeitBis(LocalDateTime.of(2026, 1, day, endday, end));
                    interval3.setTagesTyp(IntervalDto.TagesTypEnum.DTV);
                    interval3.setAnzahlLfw(interval1.getAnzahlLfw().add(interval2.getAnzahlLfw()));
                    interval3.setAnzahlLkw(interval1.getAnzahlLkw().add(interval2.getAnzahlLkw()));
                    interval3.setAnzahlKrad(interval1.getAnzahlKrad().add(interval2.getAnzahlKrad()));
                    interval3.setAnzahlBus(interval1.getAnzahlBus().add(interval2.getAnzahlBus()));
                    interval3.setAnzahlRad(interval1.getAnzahlRad().add(interval2.getAnzahlRad()));
                    interval3.setSummeAllePkw(interval1.getSummeAllePkw().add(interval2.getSummeAllePkw()));
                    interval3.setSummeLastzug(interval1.getSummeLastzug().add(interval2.getSummeLastzug()));
                    sampleIntervals3.add(interval3);
                }
            }

            dailyInterval1.setMqId(1234);
            dailyInterval1.setAnzahlLfw(BigDecimal.valueOf(dailyInterval1.getAnzahlLfw().intValue() / totalIntervals));
            dailyInterval1.setAnzahlLkw(BigDecimal.valueOf(dailyInterval1.getAnzahlLkw().intValue() / totalIntervals));
            dailyInterval1.setAnzahlKrad(BigDecimal.valueOf(dailyInterval1.getAnzahlKrad().intValue() / totalIntervals));
            dailyInterval1.setAnzahlBus(BigDecimal.valueOf(dailyInterval1.getAnzahlBus().intValue() / totalIntervals));
            dailyInterval1.setAnzahlRad(BigDecimal.valueOf(dailyInterval1.getAnzahlRad().intValue() / totalIntervals));
            dailyDtos1.add(dailyInterval1);

            dailyInterval2.setMqId(1235);
            dailyInterval2.setAnzahlLfw(BigDecimal.valueOf(dailyInterval2.getAnzahlLfw().intValue() / totalIntervals));
            dailyInterval2.setAnzahlLkw(BigDecimal.valueOf(dailyInterval2.getAnzahlLkw().intValue() / totalIntervals));
            dailyInterval2.setAnzahlKrad(BigDecimal.valueOf(dailyInterval2.getAnzahlKrad().intValue() / totalIntervals));
            dailyInterval2.setAnzahlBus(BigDecimal.valueOf(dailyInterval2.getAnzahlBus().intValue() / totalIntervals));
            dailyInterval2.setAnzahlRad(BigDecimal.valueOf(dailyInterval2.getAnzahlRad().intValue() / totalIntervals));
            dailyDtos2.add(dailyInterval2);
        }

        calculateTrafficSums(sampleIntervals1);
        calculateTrafficSums(sampleIntervals2);
        calculateTrafficSums(sampleIntervals3);
        calculateTrafficSums(dailyDtos1);
        calculateTrafficSums(dailyDtos2);

        sampleIntervals.addAll(sampleIntervals1);
        sampleIntervals.addAll(sampleIntervals2);

        intervalForMqIdDto1.setIntervals(sampleIntervals1);
        intervalForMqIdDto2.setIntervals(sampleIntervals2);
       
        mockResponse.setMeanOfSummedUpMessquerschnitteForEachIntervalOverMesstage(sampleIntervals3);
        mockResponse.addMeanForEachIntervalAndEachMessquerschnittOverMesstageItem(intervalForMqIdDto1);
        mockResponse.addMeanForEachIntervalAndEachMessquerschnittOverMesstageItem(intervalForMqIdDto2);

        dayForMqIdDto1.setIntervals(dailyDtos1);
        dayForMqIdDto2.setIntervals(dailyDtos2);

        mockResponse.addMeanOfSummedUpDailyIntervalsForEachMessquerschnittOverMesstageItem(dayForMqIdDto1);
        mockResponse.addMeanOfSummedUpDailyIntervalsForEachMessquerschnittOverMesstageItem(dayForMqIdDto2);
        return mockResponse;
    }

    private static void calculateTrafficSums(List<IntervalDto> sampleIntervals1) {
        for (IntervalDto intervalDto : sampleIntervals1) {
            intervalDto.setSummeKraftfahrzeugverkehr(intervalDto.getSummeAllePkw()
                    .add(intervalDto.getAnzahlLfw())
                    .add(intervalDto.getAnzahlLkw())
                    .add(intervalDto.getAnzahlKrad())
                    .add(intervalDto.getAnzahlBus()));
            intervalDto.setSummeSchwerverkehr(intervalDto.getAnzahlLkw()
                    .add(intervalDto.getSummeLastzug()
                    .add(intervalDto.getAnzahlBus())));
            intervalDto.setSummeGueterverkehr(intervalDto.getAnzahlLkw()
                    .add(intervalDto.getSummeLastzug()));
        }
    }
}
