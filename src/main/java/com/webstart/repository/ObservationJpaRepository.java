package com.webstart.repository;


import com.webstart.DTO.CurrentMeasure;
import com.webstart.model.Observation;
import org.hibernate.annotations.NamedNativeQuery;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import javax.persistence.EntityResult;
import javax.persistence.FieldResult;
import javax.persistence.SqlResultSetMapping;
import java.sql.Timestamp;
import java.util.List;

public interface ObservationJpaRepository extends JpaRepository<Observation, Long> {

    @Query(value = "SELECT obsp.Identifier, obs.phenomenontimestart, nv.value " +
            "From Series s " +
            "INNER JOIN Featureofinterest fi on s.featureofinterestid = fi.featureofinterestid " +
            "INNER JOIN ObservableProperty obsp on s.observablepropertyid = obsp.ObservablePropertyId " +
            "INNER JOIN Observation obs on s.seriesid = obs.seriesid " +
            "INNER JOIN NumericValue nv on nv.observationid = obs.observationid " +
            "where fi.identifier = ?1 and obs.phenomenontimestart >= ?2 AND obs.phenomenontimestart <= ?3 " +
            "order by obs.phenomenontimestart",
            nativeQuery = true)
    List<CurrentMeasure> findCurrentMeasure(String ident, Timestamp t1, Timestamp t2);

    @Query(value = "select feat.identifier, obsprop.Description, obs.phenomenontimestart, num.value, u.unit " +
            "from Observation obs " +
            "inner join NumericValue num on obs.observationid = num.observationid " +
            "inner join unit u on obs.unitid = u.unitid " +
            "inner join Series s on obs.seriesid = s.seriesid " +
            "inner join Featureofinterest feat on s.featureofinterestid = feat.featureofinterestid " +
            "inner join ObservableProperty obsprop on s.observablepropertyid = obsprop.ObservablePropertyId " +
            "where obsprop.ObservablePropertyId = ?1 " +
            "AND feat.userid = ?2 " +
            "AND feat.identifier = ?3 " +
            "AND obs.phenomenontimestart >= ?4 AND obs.phenomenontimestart <= ?5 " +
            "order by obs.phenomenontimestart",
            nativeQuery = true)
    List<Object[]> findMeasureByObsPropId(Long obspropid, int userId, String identifier, Timestamp t1, Timestamp t2);


    @Query(value = "select count(*) " +
            "from Observation obs " +
            "inner join NumericValue num on obs.observationid = num.observationid " +
            "inner join unit u on obs.unitid = u.unitid " +
            "inner join Series s on obs.seriesid = s.seriesid " +
            "inner join Featureofinterest feat on s.featureofinterestid = feat.featureofinterestid " +
            "inner join ObservableProperty obsprop on s.observablepropertyid = obsprop.ObservablePropertyId " +
            "where obsprop.ObservablePropertyId = ?1 " +
            "AND feat.userid = ?2 " +
            "AND feat.identifier = ?3 " +
            "AND obs.phenomenontimestart >= ?4 AND obs.phenomenontimestart <= ?5 ",
            nativeQuery = true)
    Long findMeasuresCount(Long obspropid, int userId, String identifier, Timestamp t1, Timestamp t2);


    @Query(value = "select max(obs.phenomenontimestart) " +
                        "from Observation obs " +
                        "inner join Series s on obs.seriesid = s.seriesid " +
                        "inner join Featureofinterest feat on s.featureofinterestid = feat.featureofinterestid " +
            "where feat.userid = ?1 and s.observablepropertyid != 5",
                nativeQuery = true)
    Timestamp findlastdatetime(int userId);

    @Query(value = "select max(obs.phenomenontimestart) " +
            "from Observation obs " +
            "inner join Series s on obs.seriesid = s.seriesid " +
            "inner join Featureofinterest feat on s.featureofinterestid = feat.featureofinterestid " +
            "where feat.identifier = ?1 and s.observablepropertyid != 5",
            nativeQuery = true)
    Timestamp findlastdatetime(String identifier);

    @Query(value =
            "select obsprop.Description, obs.phenomenontimestart, num.value, u.unit " +
                    "from Observation obs " +
                    "inner join NumericValue num on obs.observationid = num.observationid " +
                    "inner join unit u on obs.unitid = u.unitid " +
                    "inner join Series s on obs.seriesid = s.seriesid " +
                    "inner join Featureofinterest feat on s.featureofinterestid = feat.featureofinterestid " +
                    "inner join ObservableProperty obsprop on s.observablepropertyid = obsprop.ObservablePropertyId " +
                    "where feat.userid = ?1 AND feat.identifier = ?2 AND obs.phenomenontimestart = ?3 AND s.observablepropertyid != 5 " +
                    "order by obsprop.Description ",
            nativeQuery = true)
    List<Object[]> findLastMeasures(int userId, String identifier, Timestamp t1);

    @Query(value = "select max(obs.phenomenontimestart) " +
            "from Observation obs " +
            "inner join Series s on obs.seriesid = s.seriesid " +
            "inner join Featureofinterest feat on s.featureofinterestid = feat.featureofinterestid " +
            "where feat.userid = ?1 and feat.identifier = ?2 and s.observablepropertyid = 5",
            nativeQuery = true)
    Timestamp findWateringlastdatetime(int userId, String identifier);

    @Query(value =
            "select feat.identifier, obsprop.Description, obs.phenomenontimestart, obs.phenomenontimeend, num.value, u.unit " +
                    "from Observation obs " +
                    "inner join NumericValue num on obs.observationid = num.observationid " +
                    "inner join unit u on obs.unitid = u.unitid " +
                    "inner join Series s on obs.seriesid = s.seriesid " +
                    "inner join Featureofinterest feat on s.featureofinterestid = feat.featureofinterestid " +
                    "inner join ObservableProperty obsprop on s.observablepropertyid = obsprop.ObservablePropertyId " +
                    "where feat.userid = ?1 AND feat.identifier = ?2 AND obs.phenomenontimestart >= ?3 AND obs.phenomenontimeend <= ?4 AND s.observablepropertyid = 5 " +
                    "order by obsprop.Description ",
            nativeQuery = true)
    List<Object[]> findWateringMeasures(int userId, String identifier, Timestamp t1, Timestamp t2);

    @Query(value =
            "select obsprop.Description, obs.phenomenontimestart, obs.phenomenontimeend, num.value, u.unit " +
                    "from Observation obs " +
                    "inner join NumericValue num on obs.observationid = num.observationid " +
                    "inner join unit u on obs.unitid = u.unitid " +
                    "inner join Series s on obs.seriesid = s.seriesid " +
                    "inner join Featureofinterest feat on s.featureofinterestid = feat.featureofinterestid " +
                    "inner join ObservableProperty obsprop on s.observablepropertyid = obsprop.ObservablePropertyId " +
                    "where feat.userid = ?1 AND feat.identifier = ?2 AND obs.phenomenontimestart = ?3 AND s.observablepropertyid = 5 " +
                    "order by obsprop.Description ",
            nativeQuery = true)
    List<Object[]> findLastWateringMeasures(int userId, String identifier, Timestamp t1);


}
