package com.webstart.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.sql.Timestamp;


@Entity
@Table(name = "observation")
public class Observation {
    @JsonIgnore
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "observationid_seq")
    @SequenceGenerator(name = "observationid_seq", sequenceName = "observationid_seq", allocationSize = 1)
    private Long observationid;

    @Column(name = "seriesid")
    private long seriesid;

    @Column(name = "phenomenontimestart")
    private Timestamp phenomenontimestart;

    @Column(name = "phenomenontimeend")
    private Timestamp phenomenontimeend;

    @Column(name = "resulttime")
    private Timestamp resulttime;

    @Column(name = "validtimestart")
    private Timestamp validtimestart;

    @Column(name = "validtimeend")
    private Timestamp validtimeend;

    @Column(length = 1, name = "deleted")
    private String deleted;


    @Column(length = 255, name = "identifier")
    private String identifier;

    @Column(name = "codespaceid")
    private Long codespaceid;


    @Column(length = 255, name = "description")
    private String description;

    @Column(name = "unitid")
    private Long unitid;


//    @OneToOne(fetch = FetchType.EAGER, mappedBy="observation", cascade=CascadeType.ALL)
//    public NumericValue numericValue;

//    public NumericValue getNumericValue() {
//        return numericValue;
//    }
//
//    public void setNumericValue(NumericValue numericValue) {
//        this.numericValue = numericValue;
//    }

    public Observation() {
    }


    public Long getObservationid() {
        return observationid;
    }

    public void setObservationid(Long observationid) {
        this.observationid = observationid;
    }

    public long getSeriesid() {
        return seriesid;
    }

    public void setSeriesid(long seriesid) {
        this.seriesid = seriesid;
    }

    public Timestamp getPhenomenontimestart() {
        return phenomenontimestart;
    }

    public void setPhenomenontimestart(Timestamp phenomenontimestart) {
        this.phenomenontimestart = phenomenontimestart;
    }

    public Timestamp getPhenomenontimeend() {
        return phenomenontimeend;
    }

    public void setPhenomenontimeend(Timestamp phenomenontimeend) {
        this.phenomenontimeend = phenomenontimeend;
    }

    public Timestamp getResulttime() {
        return resulttime;
    }

    public void setResulttime(Timestamp resulttime) {
        this.resulttime = resulttime;
    }

    public Timestamp getValidtimestart() {
        return validtimestart;
    }

    public void setValidtimestart(Timestamp validtimestart) {
        this.validtimestart = validtimestart;
    }

    public Timestamp getValidtimeend() {
        return validtimeend;
    }

    public void setValidtimeend(Timestamp validtimeend) {
        this.validtimeend = validtimeend;
    }

    public String getDeleted() {
        return deleted;
    }

    public void setDeleted(String deleted) {
        this.deleted = deleted;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Long getUnitid() {
        return unitid;
    }

    public void setUnitid(Long unitid) {
        this.unitid = unitid;
    }
}