package com.webstart.repository;


import com.webstart.model.CurrentMeasure;
import com.webstart.model.Observation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.sql.Timestamp;
import java.util.List;

public interface ObservationJpaRepository extends JpaRepository<Observation, Long> {

    @Query(value = "SELECT obsp.Identifier, obs.phenomenontimestart, nv.value From Series s INNER JOIN Featureofinterest fi on s.featureofinterestid = fi.featureofinterestid INNER JOIN ObservableProperty obsp on s.observablepropertyid = obsp.ObservablePropertyId INNER JOIN Observation obs on s.seriesid = obs.seriesid INNER JOIN NumericValue nv on nv.observationid = obs.observationid where fi.identifier = ?1 and obs.phenomenontimestart >= ?2 AND obs.phenomenontimestart <= ?3 order by obs.phenomenontimestart", nativeQuery = true)
    List<CurrentMeasure> findCurrentMeasure(String ident, Timestamp t1, Timestamp t2);

}
