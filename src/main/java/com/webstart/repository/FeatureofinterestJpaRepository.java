package com.webstart.repository;

import com.webstart.model.Featureofinterest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.repository.Repository;


import java.util.List;

public interface FeatureofinterestJpaRepository extends JpaRepository<Featureofinterest, Integer> {


    List<Featureofinterest> findByUserid(int id);


    @Query(" from Featureofinterest as fi inner join fetch fi.seriesList as flist inner join Series.featureofinterestid WHERE fi.featureofinterestid IN :inclList")
    List<Object[]> find(@Param("inclList") List<Integer> featuresid);




}
