package de.starwit.dave.persistence;

import java.time.Duration;
import java.time.Instant;
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
                    time_bucket_gapfill('15 minutes', r.max_time) as time,
                    count(r.object_id),
                    r.name_from,
                    r.name_to
                from (
                    select 
                        observation_area_id,
                        object_id,
                        first_value(l.crossing_time) over w_time as min_time,
                        last_value(l.crossing_time) over w_time as max_time,
                        first_value(m.name) over w_time as name_from,
                        last_value(m.name) over w_time as name_to,
                        first_value(l.direction) over w_time as dir_from,
                        last_value(l.direction) over w_time as dir_to,
                        count(object_id) over w_time as idx
                    from linecrossing l 
                        join metadata m on l.metadata_id = m.id
                    where l.crossing_time >= :date
                        and observation_area_id = :observationAreaId
                    window 
                        w_time as (partition by object_id order by l.crossing_time asc)
                ) r
                where r.max_time > :date and r.max_time < NOW()
                    and r.name_from <> r.name_to
                    and r.dir_from = 'in' and r.dir_to = 'out'
                group by r.name_from, r.name_to, time
                order by time;           
            """;
    
    public List<CountResults> getCountings(long observationAreaId) {
        List<CountResults> countResults = new ArrayList<CountResults>();

        var timeslot = Instant.now().minus((Duration.ofMinutes(15)));
        Query nQuery = entityManager.createNativeQuery(query).setParameter("date", timeslot).setParameter("observationAreaId", observationAreaId);
        List<Object[]> result = nQuery.getResultList();
        
        for (Object[] r : result) {
            Instant time = (Instant) r[0];
            long count = 0;
            if(r[1] != null) {
                count = ((Number) r[1]).longValue();
            }

            String nameFrom = (String) r[2];
            String nameTo = (String) r[3];

            CountResults cr = new CountResults();
            cr.setTime(time);
            cr.setNameFrom(nameFrom);
            cr.setNameTo(nameTo);
            cr.setCount(count);
            cr.setObjectClassId(2);
            countResults.add(cr);
        }

        return countResults;
    }
    
}
