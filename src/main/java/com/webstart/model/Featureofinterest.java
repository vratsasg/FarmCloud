package com.webstart.model;

//import org.geolatte.geom.Geometry;

import com.vividsolutions.jts.geom.Geometry;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by George on 7/6/2016.
 */

@Entity
@Table(name = "featureofinterest")
public class Featureofinterest {

    public Featureofinterest(String hibernatediscriminator, long featureofinteresttypeid, String identifier, Long codespaceid, String name, String descriptionxml, String url, Featureofinteresttype featureofinteresttype, Geometry geom, int userid, Users usersfeatures, List<Series> seriesList) {
        this.hibernatediscriminator = hibernatediscriminator;
        this.featureofinteresttypeid = featureofinteresttypeid;
        this.identifier = identifier;
        this.codespaceid = codespaceid;
        this.name = name;
        this.descriptionxml = descriptionxml;
        this.url = url;
        this.featureofinteresttype = featureofinteresttype;
        this.geom = geom;
        this.userid = userid;
        this.usersfeatures = usersfeatures;
        this.seriesList = seriesList;
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

    public Featureofinteresttype getFeatureofinteresttype() {
        return featureofinteresttype;
    }

    public void setFeatureofinteresttype(Featureofinteresttype featureofinteresttype) {
        this.featureofinteresttype = featureofinteresttype;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public Geometry getGeom() {
        return geom;
    }

    public void setGeom(Geometry geom) {
        this.geom = geom;
    }

    public Users getUsersfeatures() {
        return usersfeatures;
    }

    public void setUsersfeatures(Users usersfeatures) {
        this.usersfeatures = usersfeatures;
    }

    public List<Series> getSeriesList() {
        return seriesList;
    }

    public void setSeriesList(List<Series> seriesList) {
        this.seriesList = seriesList;
    }

    public Featureofinterest() {

    }

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


    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "featureofinteresttypeid", insertable = false, updatable = false)
    private Featureofinteresttype featureofinteresttype;

    @Column(name = "geom", columnDefinition = "Geometry")
    private Geometry geom;


    @Column(name = "userid")
    private int userid;


    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "userid", insertable = false, updatable = false)
    private Users usersfeatures;


    @OneToMany(fetch = FetchType.EAGER, mappedBy = "observableProperty", cascade = {CascadeType.ALL})
    private List<Series> seriesList = new ArrayList<Series>();

}
