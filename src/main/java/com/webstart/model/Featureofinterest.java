package com.webstart.model;

//import org.geolatte.geom.Geometry;

import com.fasterxml.jackson.annotation.JsonIgnore;

import com.vividsolutions.jts.geom.Point;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;


@Entity
@Table(name = "featureofinterest")
public class Featureofinterest {

    @JsonIgnore
    @Id
    @GeneratedValue
    private Integer featureofinterestid;

    @Column(length = 1, name = "hibernatediscriminator")
    private String hibernatediscriminator;

    @Column(name = "featureofinteresttypeid")
    private long featureofinteresttypeid;

    @Column(length = 255, name = "identifier")
    private String identifier;

    @Column(name = "codespaceid")
    private Long codespaceid;

    @Column(name = "name")
    private String name;

    @Column(name = "descriptionxml")
    private String descriptionxml;

    @Column(length = 255, name = "url")
    private String url;

    @Column(name="parentId")
    private Long parentid;


    @Column(name = "datetimefrom")
    private Timestamp datetimefrom;

    @Column(name = "datetimeto")
    private Timestamp datetimeto;

    @Column(name = "irrigation")
    private Boolean irrigation;

    @Column(name = "measuring")
    private Boolean measuring;






    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "featureofinteresttypeid", insertable = false, updatable = false)
    private Featureofinteresttype featureofinteresttype;

    @Type(type = "jts_geometry")
    @Column(name = "geom", columnDefinition = "Point")
    private Point geom;


    @Column(name = "userid")
    private int userid;


    @ManyToOne(fetch = FetchType.EAGER, optional = true)
    @JoinColumn(name = "userid", insertable = false, updatable = false)
    private Users userfeature;

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "featureofinterest", cascade = {CascadeType.ALL})
    private List<Series> seriesList = new ArrayList<Series>();

    ////Autorelation
    @ManyToOne(fetch = FetchType.EAGER, optional = true)
    @JoinColumn(name = "parentid", insertable = false, updatable = false)
    private Featureofinterest parentFeature;

    @OneToMany(mappedBy = "parentFeature",fetch = FetchType.LAZY, cascade = {CascadeType.ALL})
    private List<Featureofinterest> childrenFeatures;

    //@ManyToOne(fetch = FetchType.LAZY, optional = true)
    //private Featureofinterest parentFeature;
    //
    //@OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, mappedBy = "parentFeature")
    //private List<Featureofinterest> childrenFeatures;


    public Featureofinterest() {

    }

    public Featureofinterest(int userid, Point geom, Boolean measuring, Boolean irrigation, Timestamp datetimeto, Timestamp datetimefrom, Long parentid, String url, String descriptionxml, String name, Long codespaceid, String identifier, long featureofinteresttypeid, String hibernatediscriminator) {
        this.userid = userid;
        this.geom = geom;
        this.measuring = measuring;
        this.irrigation = irrigation;
        this.datetimeto = datetimeto;
        this.datetimefrom = datetimefrom;
        this.parentid = parentid;
        this.url = url;
        this.descriptionxml = descriptionxml;
        this.name = name;
        this.codespaceid = codespaceid;
        this.identifier = identifier;
        this.featureofinteresttypeid = featureofinteresttypeid;
        this.hibernatediscriminator = hibernatediscriminator;
    }

    public Timestamp getDatetimefrom() {
        return datetimefrom;
    }

    public void setDatetimefrom(Timestamp datetimefrom) {
        this.datetimefrom = datetimefrom;
    }

    public Timestamp getDatetimeto() {
        return datetimeto;
    }

    public void setDatetimeto(Timestamp datetimeto) {
        this.datetimeto = datetimeto;
    }

    public Boolean getIrrigation() {
        return irrigation;
    }

    public void setIrrigation(Boolean irrigation) {
        this.irrigation = irrigation;
    }

    public Boolean getMeasuring() {
        return measuring;
    }

    public void setMeasuring(Boolean measuring) {
        this.measuring = measuring;
    }

    public Integer getFeatureofinterestid() {
        return featureofinterestid;
    }

    public void setFeatureofinterestid(Integer featureofinterestid) {
        this.featureofinterestid = featureofinterestid;
    }

    public String getHibernatediscriminator() {
        return hibernatediscriminator;
    }

    public void setHibernatediscriminator(String hibernatediscriminator) {
        this.hibernatediscriminator = hibernatediscriminator;
    }

    public long getFeatureofinteresttypeid() {
        return featureofinteresttypeid;
    }

    public void setFeatureofinteresttypeid(long featureofinteresttypeid) {
        this.featureofinteresttypeid = featureofinteresttypeid;
    }

    public String getIdentifier() {
        return identifier;
    }

    public void setIdentifier(String identifier) {
        this.identifier = identifier;
    }

    public Long getCodespaceid() {
        return codespaceid;
    }

    public void setCodespaceid(Long codespaceid) {
        this.codespaceid = codespaceid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescriptionxml() {
        return descriptionxml;
    }

    public void setDescriptionxml(String descriptionxml) {
        this.descriptionxml = descriptionxml;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Long getParentid() {
        return parentid;
    }

    public void setParentid(Long parentid) {
        this.parentid = parentid;
    }

    public Featureofinteresttype getFeatureofinteresttype() {
        return featureofinteresttype;
    }

    public void setFeatureofinteresttype(Featureofinteresttype featureofinteresttype) {
        this.featureofinteresttype = featureofinteresttype;
    }

    public Point getGeom() {
        return geom;
    }

    public void setGeom(Point geom) {
        this.geom = geom;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public Users getUserfeature() {
        return userfeature;
    }

    public void setUserfeature(Users usersfeatures) {
        this.userfeature = usersfeatures;
    }

    public List<Series> getSeriesList() {
        return seriesList;
    }

    public void setSeriesList(List<Series> seriesList) {
        this.seriesList = seriesList;
    }

    public Featureofinterest getParentFeature() {
        return parentFeature;
    }

    public void setParentFeature(Featureofinterest parentFeature) {
        this.parentFeature = parentFeature;
    }

    public List<Featureofinterest> getChildrenFeatures() {
        return childrenFeatures;
    }

    public void setChildrenFeatures(List<Featureofinterest> childrenFeatures) {
        this.childrenFeatures = childrenFeatures;
    }


}
