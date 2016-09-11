package com.webstart.DTO;


import java.math.BigDecimal;

public class FeatureObsPropMinMax {

    private Integer featureofinterestid;
    private String identifier;
    private String name;
    private Long observablePropertyId;
    private Long obspropvalId;
    private String obspropertName;
    private BigDecimal minval;
    private BigDecimal maxval;

    public FeatureObsPropMinMax(Integer featureofinterestid, String identifier, String name, Long observablePropertyId, Long obspropvalId, String obspropertName, BigDecimal minval, BigDecimal maxval) {
        this.featureofinterestid = featureofinterestid;
        this.identifier = identifier;
        this.name = name;
        this.observablePropertyId = observablePropertyId;
        this.obspropvalId = obspropvalId;
        this.obspropertName = obspropertName;
        this.minval = minval;
        this.maxval = maxval;
    }

    public FeatureObsPropMinMax() {
    }

    public Long getObservablePropertyId() {
        return observablePropertyId;
    }

    public void setObservablePropertyId(Long observablePropertyId) {
        this.observablePropertyId = observablePropertyId;
    }

    public Long getObspropvalId() {
        return obspropvalId;
    }

    public void setObspropvalId(Long obspropvalId) {
        this.obspropvalId = obspropvalId;
    }

    public String getObspropertName() {
        return obspropertName;
    }

    public void setObspropertName(String obspropertName) {
        this.obspropertName = obspropertName;
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


    public Integer getFeatureofinterestid() {
        return featureofinterestid;
    }

    public void setFeatureofinterestid(Integer featureofinterestid) {
        this.featureofinterestid = featureofinterestid;
    }

    public String getIdentifier() {
        return identifier;
    }

    public void setIdentifier(String identifier) {
        this.identifier = identifier;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


}
