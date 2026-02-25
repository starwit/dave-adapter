package de.starwit.dave.persistence;

import java.time.Duration;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;

@Repository
@Transactional(readOnly = true)
public class AnalyticsRepository {

    private Logger log = LoggerFactory.getLogger(AnalyticsRepository.class);

    @PersistenceContext
    EntityManager entityManager;
    
    String query = """
                select
                    time_bucket('15 minutes', r.max_time) as time,
                    count(r.object_id),
                    r.object_class_id,
                    r.name_from,
                    r.name_to
                from (
                    select 
                        observation_area_id,
                        object_id,
                        object_class_id,
                        first_value(l.crossing_time) over w_time as min_time,
                        last_value(l.crossing_time) over w_time as max_time,
                        first_value(m.name) over w_time as name_from,
                        last_value(m.name) over w_time as name_to,
                        first_value(l.direction) over w_time as dir_from,
                        last_value(l.direction) over w_time as dir_to,
                        count(object_id) over w_time as idx
                    from linecrossing l 
                        join metadata m on l.metadata_id = m.id
                    where l.crossing_time >= :startTime
                        and observation_area_id = :observationAreaId
                    window 
                        w_time as (partition by object_id order by l.crossing_time asc)
                ) r
                where r.max_time > :startTime and r.max_time < :endTime
                    and r.name_from <> r.name_to
                    and r.dir_from = 'in' and r.dir_to = 'out'
                group by r.object_class_id, r.name_from, r.name_to, time
                order by time;           
            """;
    public List<CountResults> getCountings(long observationAreaId, Instant start, Instant end) {
        log.debug("Select data from " + start);
        List<CountResults> countResults = new ArrayList<CountResults>();

        Query nQuery = entityManager.createNativeQuery(query)
            .setParameter("startTime", start)
            .setParameter("endTime", end)
            .setParameter("observationAreaId", observationAreaId);
        List<Object[]> result = nQuery.getResultList();
        
        for (Object[] r : result) {
            Instant time = (Instant) r[0];
            long count = 0;
            if(r[1] != null) {
                count = ((Number) r[1]).longValue();
            }
            int objectClassId = ((Number) r[2]).intValue();
            String nameFrom = (String) r[3];
            String nameTo = (String) r[4];

            CountResults cr = new CountResults();
            cr.setTime(time);
            cr.setNameFrom(nameFrom);
            cr.setNameTo(nameTo);
            cr.setCount(count);
            cr.setObjectClassId(objectClassId);
            countResults.add(cr);
        }

        log.debug("Analytics DB result " + countResults.toString());
        
        return countResults;
    }    
}
