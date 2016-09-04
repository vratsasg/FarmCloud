package com.webstart.repository;

import com.webstart.DTO.CropInfoDTO;
import com.webstart.DTO.EndDeviceStatusDTO;
import com.webstart.DTO.FeatureObsPropMinMax;
import com.webstart.DTO.FeatureidIdentifier;
import com.webstart.model.Featureofinterest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;


import java.util.Date;
import java.util.List;

public interface FeatureofinterestJpaRepository extends JpaRepository<Featureofinterest, Integer> {


    List<Featureofinterest> findByUserid(int id);

    List<Featureofinterest> findByUseridAndFeatureofinteresttypeid(int id, long l);

    @Query("select new com.webstart.DTO.CropInfoDTO(fi.identifier, fi.name, obs.Identifier, prc.identifier, prc.descriptionfile) " +
            "from Featureofinterest as fi " +
            "inner join fi.seriesList as flist " +
            "inner join flist.observableProperty as obs " +
            "inner join flist.procedure as prc " +
            "WHERE fi.featureofinterestid IN :inclList")
    List<CropInfoDTO> getFeatureByIds(@Param("inclList") List<Integer> featuresid);

    @Query("select NEW com.webstart.DTO.FeatureObsPropMinMax(feature.featureofinterestid, feature.identifier, feature.name, obspropval.obspropid, obs.Description, obspropval.minval, obspropval.maxval) " +
            "from Featureofinterest as feature " +
            "join feature.obspropminmaxList as obspropval " +
            "join obspropval.observableProperty as obs " +
            "where feature.userid = :user_id")
    List<FeatureObsPropMinMax> findFeatureMiMaxValuesByUserId(@Param("user_id") Integer userid);

    @Query("select fi.datetimefrom, fi.datetimeto " +
            "FROM Featureofinterest as fi " +
            "WHERE fi.identifier = :identif")
    List<Object[]> findDatesByIdentifier(@Param("identif") String identif);

    @Query("select children.identifier FROM Featureofinterest as fi " +
            "join fi.childrenFeatures children " +
            "WHERE fi.identifier = :identifier")
    List<String> findEndDevicesByCoord(@Param("identifier") String identifier);

    @Query("select distinct NEW com.webstart.DTO.FeatureidIdentifier(fi.featureofinterestid, fi.identifier) " +
            "FROM Featureofinterest as fi " +
            "WHERE fi.identifier IN :idenList")
    List<FeatureidIdentifier> getIdidentif(@Param("idenList") List<String> identStr);

    @Query("select si.seriesid " +
            "FROM Series as si " +
            "WHERE si.featureofinterestid = :featid and si.observablepropertyid = :obspropid")
    List<Long> getAllSeriesId(@Param("featid") Long fid, @Param("obspropid") Long obsg);

    @Query("select fi.featureofinterestid FROM Featureofinterest as fi  WHERE fi.identifier = :tid")
    List<Integer> getIdbyIdent(@Param("tid") String fidentent);

    @Query("select new com.webstart.DTO.EndDeviceStatusDTO(fi.identifier, fi.irrigation, fi.measuring) " +
            "FROM Featureofinterest as fi " +
            "WHERE fi.parentid = :pid " +
            "order by fi.identifier")
    List<EndDeviceStatusDTO> getIdentifierFlags(@Param("pid") Long parId);

    @Modifying
    @Query("update Featureofinterest f set f.measuring = true where f.userid IN :usid and f.featureofinteresttypeid = :tpid")
    @Transactional
    void setMeasuringFlag(@Param("usid") int useid, @Param("tpid") long ftypeid);


    @Modifying
    @Query("update Featureofinterest f set f.irrigation = true, f.datetimefrom = :dtfrom, f.datetimeto = :dtto " +
            "where f.userid = :usid and f.identifier = :identifier")
    @Transactional
    void setDeviceIrrigDates(@Param("usid") int userid, @Param("identifier") String device, @Param("dtfrom") Date datetimefrom, @Param("dtto") Date datetimeto);
}
