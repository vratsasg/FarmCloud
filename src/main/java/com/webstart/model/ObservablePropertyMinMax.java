package com.webstart.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "observablepropertyminmax")
public class ObservablePropertyMinMax {

    @Id
    @Column(name = "obspropertyid")
    private Long obspropid;

    @JsonIgnore
    @Column(name = "featureofinterestid")
    private Long featureofinterestid;

    @JsonIgnore
    @Column(name = "observablepropertyid")
    private Long observablepropertyid;

    @Column(name = "minval")
    private BigDecimal minval;

    @Column(name = "maxval")
    private BigDecimal maxval;

    @ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "featureofinterestid", insertable = false, updatable = false)
    private Featureofinterest featureofinterest;

    @ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "observablepropertyid", insertable = false, updatable = false)
    private ObservableProperty observableProperty;

    public ObservablePropertyMinMax() {
    }

    public ObservablePropertyMinMax(Long obspropid, Long featureofinterestid, Long observablepropertyid, BigDecimal minval, BigDecimal maxval, Featureofinterest featureofinterest, ObservableProperty observableProperty) {
        this.obspropid = obspropid;
        this.featureofinterestid = featureofinterestid;
        this.observablepropertyid = observablepropertyid;
        this.minval = minval;
        this.maxval = maxval;
        this.featureofinterest = featureofinterest;
        this.observableProperty = observableProperty;
    }

    public Long getObspropid() {
        return obspropid;
    }

    public void setObspropid(Long obspropid) {
        this.obspropid = obspropid;
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

    public BigDecimal getMinval() {
        return minval;
    }

    public void setMinval(BigDecimal minval) {
        this.minval = minval;
    }

    public BigDecimal getMaxval() {
        return maxval;
    }

    public void setMaxval(BigDecimal maxval) {
        this.maxval = maxval;
    }

    public Featureofinterest getFeatureofinterest() {
        return featureofinterest;
    }

    public void setFeatureofinterest(Featureofinterest featureofinterest) {
        this.featureofinterest = featureofinterest;
    }

    public ObservableProperty getObservableproperty() {
        return observableProperty;
    }

    public void setObservableproperty(ObservableProperty observableproperty) {
        this.observableProperty = observableproperty;
    }
}
