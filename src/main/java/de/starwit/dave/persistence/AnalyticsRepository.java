package de.starwit.dave.persistence;

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
                where l.crossing_time >= :innerStart and l.crossing_time <= :intervalEnd
                    and observation_area_id = :observationAreaId
                window
                    w_time as (partition by object_id order by l.crossing_time asc)
            ) r
            where r.max_time >= :intervalStart
                and r.name_from <> r.name_to
                and r.dir_from = 'in' and r.dir_to = 'out'
            group by r.object_class_id, r.name_from, r.name_to;
            """;

    public List<CountResults> getCountings(long observationAreaId, Instant innerStart, Instant intervalStart, Instant intervalEnd) {
        log.debug("Select data from innerStart=" + innerStart + " intervalStart=" + intervalStart + " intervalEnd=" + intervalEnd);
        List<CountResults> countResults = new ArrayList<CountResults>();

        Query nQuery = entityManager.createNativeQuery(query)
            .setParameter("innerStart", innerStart)
            .setParameter("intervalStart", intervalStart)
            .setParameter("intervalEnd", intervalEnd)
            .setParameter("observationAreaId", observationAreaId);
        List<Object[]> result = nQuery.getResultList();

        for (Object[] r : result) {
            long count = 0;
            if (r[0] != null) {
                count = ((Number) r[0]).longValue();
            }
            int objectClassId = ((Number) r[1]).intValue();
            String nameFrom = (String) r[2];
            String nameTo = (String) r[3];

            CountResults cr = new CountResults();
            cr.setCount(count);
            cr.setObjectClassId(objectClassId);
            cr.setNameFrom(nameFrom);
            cr.setNameTo(nameTo);
            countResults.add(cr);
        }

        log.debug("Analytics DB result " + countResults.toString());

        return countResults;
    }
}
