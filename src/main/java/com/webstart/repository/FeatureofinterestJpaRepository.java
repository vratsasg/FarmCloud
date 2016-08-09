package com.webstart.repository;

import com.webstart.DTO.FeatureidIdentifier;
import com.webstart.model.Featureofinterest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.repository.Repository;
import org.springframework.transaction.annotation.Transactional;


import javax.persistence.ColumnResult;
import javax.persistence.ConstructorResult;
import javax.persistence.SqlResultSetMapping;
import java.util.Date;
import java.util.List;

public interface FeatureofinterestJpaRepository extends JpaRepository<Featureofinterest, Integer> {


    List<Featureofinterest> findByUserid(int id);

    List<Featureofinterest> findByUseridAndFeatureofinteresttypeid(int id, long l);

    @Query("select fi.identifier ,fi.name,obs.Identifier,prc.identifier,prc.descriptionfile " +
            "from Featureofinterest as fi " +
            "inner join fi.seriesList as flist " +
            "inner join flist.observableProperty as obs " +
            "inner join flist.procedure as prc " +
            "WHERE fi.featureofinterestid IN :inclList")
    List<Object[]> find(@Param("inclList") List<Integer> featuresid);

    @Query("select feature.featureofinterestid, feature.identifier, feature.name, obs.Description as obspropertyDescr, obspropval.obspropid, obspropval.minval, obspropval.maxval " +
            "from Featureofinterest as feature " +
            "join feature.obspropminmaxList as obspropval " +
            "join obspropval.observableProperty as obs " +
            "where feature.userid = :user_id")
    List<Object[]> findFeatureMiMaxValuesByUserId(@Param("user_id") Integer userid);

    @Query("select fi.datetimefrom,fi.datetimeto FROM Featureofinterest as fi  WHERE fi.identifier IN :identif")
    List<Object[]> findByIdentifier(@Param("identif") String identif);

    @Query("select distinct fi.featureofinterestid ,fi.identifier FROM Featureofinterest as fi  WHERE fi.identifier IN :idenList")
    List<Object[]> getIdidentif(@Param("idenList") List<String> identStr);

    @Query("select si.seriesid FROM Series as si  WHERE si.featureofinterestid IN :featid and si.observablepropertyid IN :obs")
    List<Object[]> serid(@Param("featid") Long fid, @Param("obs") Long obsg);


    @Query("select fi.featureofinterestid FROM Featureofinterest as fi  WHERE fi.identifier IN :tid")
    List<Object[]> getIdbyIdent(@Param("tid") String fidentent);

    @Query("select fi.identifier,fi.irrigation,fi.measuring FROM Featureofinterest as fi  WHERE fi.parentid IN :pid")
    List<Object[]> getIdentifierFlags(@Param("pid") Long parId);


    @Modifying
    @Query("update Featureofinterest f set f.measuring = true where f.userid IN :usid and f.featureofinteresttypeid IN :tpid")
    @Transactional
    void setMeasuringFlag(@Param("usid") int useid, @Param("tpid") long ftypeid);


    @Modifying
    @Query("update Featureofinterest f set f.irrigation = true, f.datetimefrom = :dtfrom, f.datetimeto = :dtto where f.userid = :usid and f.identifier = :identifier")
    @Transactional
    void setDeviceIrrigDates(@Param("usid") int userid, @Param("identifier") String device, @Param("dtfrom") Date datetimefrom, @Param("dtto") Date datetimeto); //TODO return boolean true/false
//
//    @Modifying
//    @Query("update User u set u.firstname = ?1, u.lastname = ?2 where u.id = ?3")
//    void setUserInfoById(String firstname, String lastname, Integer userId);
//
//
//    @Modifying
//    @Query("update JsonContactImport x set x.isImported = true where x.id in :ids")
//    @Transactional
//    void updateImported(@Param("ids") List<Long> ids);
}
