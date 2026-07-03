package de.starwit.dave.persistence;

import java.sql.Timestamp;
import java.sql.Types;
import java.time.Instant;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional(readOnly = true)
public class AnalyticsRepository {

    private Logger log = LoggerFactory.getLogger(AnalyticsRepository.class);

    private final NamedParameterJdbcTemplate jdbcTemplate;

    public AnalyticsRepository(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    String query = """
            select
                count(r.object_id) as count,
                r.object_class_id as object_class_id,
                r.compass_dir_from as compass_dir_from,
                r.compass_dir_to as compass_dir_to
            from (
                select
                    observation_area_id,
                    object_id,
                    object_class_id,
                    first_value(l.crossing_time) over w_time as min_time,
                    last_value(l.crossing_time) over w_time as max_time,
                    first_value(m.direction) over w_time as compass_dir_from,
                    last_value(m.direction) over w_time as compass_dir_to,
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
                and r.compass_dir_from <> r.compass_dir_to
                and r.dir_from = 'in' and r.dir_to = 'out'
            group by r.object_class_id, r.compass_dir_from, r.compass_dir_to;
            """;

    public List<CountResults> getCountings(long observationAreaId, Instant innerStart, Instant intervalStart,
            Instant intervalEnd) {
        log.debug("Select data from innerStart=" + innerStart + " intervalStart=" + intervalStart + " intervalEnd="
                + intervalEnd);

        return jdbcTemplate.query(query,
                new MapSqlParameterSource()
                        .addValue("innerStart", Timestamp.from(innerStart), Types.TIMESTAMP)
                        .addValue("intervalStart", Timestamp.from(intervalStart), Types.TIMESTAMP)
                        .addValue("intervalEnd", Timestamp.from(intervalEnd), Types.TIMESTAMP)
                        .addValue("observationAreaId", observationAreaId),
                BeanPropertyRowMapper.newInstance(CountResults.class));
    }
}
