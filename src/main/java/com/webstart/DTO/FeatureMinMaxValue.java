package com.webstart.DTO;

import java.math.BigDecimal;

public class FeatureMinMaxValue {
    private Long obspropertyid;
    private String obspropertName;
    private BigDecimal minval;
    private BigDecimal maxval;

    public FeatureMinMaxValue() {

    }

    public FeatureMinMaxValue(Long obspropertyid, String obspropertName, BigDecimal minval, BigDecimal maxval) {
        this.obspropertyid = obspropertyid;
        this.obspropertName = obspropertName;
        this.minval = minval;
        this.maxval = maxval;
    }

    public Long getObspropertyid() {
        return obspropertyid;
    }

    public void setObspropertyid(Long obspropertyid) {
        this.obspropertyid = obspropertyid;
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
}
