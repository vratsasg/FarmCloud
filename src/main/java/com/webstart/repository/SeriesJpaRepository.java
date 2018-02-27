package com.webstart.repository;

import com.webstart.model.Series;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface SeriesJpaRepository extends JpaRepository<Series, Long> {
    @Query("select serie.seriesid FROM Series as serie " +
            "join serie.featureofinterest as fi " +
            "WHERE fi.identifier = :identifier and serie.observablepropertyid = 5")
    List<Long> findSeriesIdByEndDevice(@Param("identifier") String identifier);
}
