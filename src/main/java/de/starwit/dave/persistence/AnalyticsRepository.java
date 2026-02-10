package de.starwit.dave.persistence;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import org.springframework.transaction.annotation.Transactional;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

@Repository
@Transactional(readOnly = true)
public class AnalyticsRepository {

    @PersistenceContext
    EntityManager entityManager;
    
    String query = """
                select
                    time_bucket_gapfill('15 minutes', d.max_time) as time,
                    count(d.object_id),
                    d.route,
                    d.object_class_id
                from (
                    select 
                        observation_area_id,
                        object_id,
                        object_class_id,
                        first_value(l.crossing_time) over w_time as min_time,
                        last_value(l.crossing_time) over w_time as max_time,
                        first_value(m.name) over w_time || '/' || first_value(l.direction) over w_time ||
                        ' -> ' || last_value(m.name) over w_time || '/' || last_value(l.direction) over w_time as route,
                        count(object_id) over w_time as idx
                    from linecrossing l 
                        join metadata m on l.metadata_id = m.id
                    where l.crossing_time >= '2026-02-09 14:00:16' and l.crossing_time <= '2026-02-09 15:46:16'
                    window 
                        w_time as (partition by object_id order by l.crossing_time asc)
                ) d
                where d.idx = 2 and d.observation_area_id = 9
                    and d.max_time > '2026-02-09 14:00:16' and d.max_time < '2026-02-09 15:46:16'
                group by d.route, time, d.object_class_id
                order by time;            
            """;
    
    public List<CountResults> getCountings() {
        List<CountResults> countResults = new ArrayList<CountResults>();

        List<Object[]> result = entityManager.createNativeQuery(query).getResultList();
        
        for (Object[] r : result) {
            Instant time = (Instant) r[0];
            long count = 0;
            if(r[1] != null) {
                count = ((Number) r[1]).longValue();
            }
            String route = (String) r[2];
            long objectClassId = ((Number) r[3]).longValue();

            if (route.contains("dave")) {
                CountResults cr = new CountResults();
                cr.setTime(time);
                cr.setCount(count);
                cr.setRoute(route);
                cr.setObjectClassId(objectClassId);
                countResults.add(cr);
                System.out.println(cr.toString());
            } 
        }

        return countResults;
    }
    
}
