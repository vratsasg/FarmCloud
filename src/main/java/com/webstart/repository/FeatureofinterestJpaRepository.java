package com.webstart.repository;

import com.webstart.DTO.FeatureidIdentifier;
import com.webstart.model.Featureofinterest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.repository.Repository;


import java.util.List;

public interface FeatureofinterestJpaRepository extends JpaRepository<Featureofinterest, Integer> {


    List<Featureofinterest> findByUserid(int id);

    @Query("select fi.identifier ,fi.name,obs.Identifier,prc.identifier,prc.descriptionfile from Featureofinterest as fi inner join fi.seriesList as flist inner join flist.observableProperty as obs inner join flist.procedure as prc WHERE fi.featureofinterestid IN :inclList")
    List<Object[]> find(@Param("inclList") List<Integer> featuresid);

    List<Featureofinterest> findByUseridAndFeatureofinteresttypeid(int id, long l);

    @Query("select fi.datetimefrom,fi.datetimeto FROM Featureofinterest as fi  WHERE fi.identifier IN :identif")
    List<Object[]> findByIdentifier(@Param("identif") String identif);

    @Query("select distinct fi.featureofinterestid ,fi.identifier FROM Featureofinterest as fi  WHERE fi.identifier IN :idenList")
    List<Object[]> getIdidentif(@Param("idenList") List<String> identStr);

    @Query("select si.seriesid FROM Series as si  WHERE si.featureofinterestid IN :featid and si.observablepropertyid IN :obs")
    List<Object[]> serid(@Param("featid") Long fid, @Param("obs") Long obsg);


}
