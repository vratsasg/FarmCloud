package com.webstart.model;


import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;

@Entity
@Table(name = "series")
public class Series {
    @JsonIgnore
    @Id
    @GeneratedValue
    private Long seriesid;


    @Column(name = "featureofinterestid")
    private Long featureofinterestid;


    @Column(name = "observablepropertyid")
    private Long observablepropertyid;

    @Column(name = "procedureid")
    private Long procedureid;

    @Column(name = "deleted")
    private String deleted = "F";


    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "procedureid", insertable = false, updatable = false)
    private Procedure procedure;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "observablepropertyid", insertable = false, updatable = false)
    private ObservableProperty observableProperty;

    @ManyToOne(fetch = FetchType.EAGER, optional=true)
    @JoinColumn(name = "featureofinterestid", insertable = false, updatable = false)
    private Featureofinterest featureofinterest;

    public Series(Long featureofinterestid, Long observablepropertyid, Long procedureid, String deleted, Procedure procedure, ObservableProperty observableProperty) {
        this.featureofinterestid = featureofinterestid;
        this.observablepropertyid = observablepropertyid;
        this.procedureid = procedureid;
        this.deleted = deleted;
        this.procedure = procedure;
        this.observableProperty = observableProperty;
    }

    public Series() {
    }

    public Long getSeriesid() {
        return seriesid;
    }

    public void setSeriesid(Long seriesid) {
        this.seriesid = seriesid;
    }

    public Long getFeatureofinterestid() {
        return featureofinterestid;
    }

    public void setFeatureofinterestid(Long featureofinterestid) {
        this.featureofinterestid = featureofinterestid;
    }

    public Long getObservablepropertyid() {
        return observablepropertyid;
    }

    public void setObservablepropertyid(Long observablepropertyid) {
        this.observablepropertyid = observablepropertyid;
    }

    public Long getProcedureid() {
        return procedureid;
    }

    public void setProcedureid(Long procedureid) {
        this.procedureid = procedureid;
    }

    public String getDeleted() {
        return deleted;
    }

    public void setDeleted(String deleted) {
        this.deleted = deleted;
    }

    public Procedure getProcedure() {
        return procedure;
    }

    public void setProcedure(Procedure procedure) {
        this.procedure = procedure;
    }

    public ObservableProperty getObservableProperty() {
        return observableProperty;
    }

    public void setObservableProperty(ObservableProperty observableProperty) {
        this.observableProperty = observableProperty;
    }


    public Featureofinterest getFeatureofinterest() {
        return featureofinterest;
    }

    public void setFeatureofinterest(Featureofinterest featureofinterest) {
        this.featureofinterest = featureofinterest;
    }


}
