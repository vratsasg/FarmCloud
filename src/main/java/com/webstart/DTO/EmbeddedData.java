package com.webstart.DTO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by George on 24/5/2016.
 */
public class EmbeddedData {
    @JsonProperty("zb")
    private String zigbeeAddress;

    @JsonProperty("mv")
    private BigDecimal measureValue;

    @JsonProperty("dt")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+1")
    @Temporal(TemporalType.TIME)
    private Date datetimeMeasure;

    @JsonProperty("oid")
    private int ObservationPropId;

    @JsonProperty("uid")
    private int UnitId;

    public EmbeddedData() {
    }

    public EmbeddedData(String zigbeeAddress, BigDecimal measureValue, Date datetimeMeasure, int ObservationPropId, int UnitId) {
        this.zigbeeAddress = zigbeeAddress;
        this.measureValue = measureValue;
        this.datetimeMeasure = datetimeMeasure;
        this.ObservationPropId = ObservationPropId;
        this.UnitId = UnitId;
    }

    public String getZigbeeAddress() {
        return zigbeeAddress;
    }

    public void setZigbeeAddress(String zigbeeAddress) {
        this.zigbeeAddress = zigbeeAddress;
    }

    public BigDecimal getMeasureValue() {
        return measureValue;
    }

    public void setMeasureValue(BigDecimal measureValue) {
        this.measureValue = measureValue;
    }

    public int getObservationPropId() {
        return ObservationPropId;
    }

    public void setObservationPropId(int observationPropId) {
        this.ObservationPropId = observationPropId;
    }

    public int getUnitId() {
        return UnitId;
    }

    public void setUnitId(int unitId) {
        this.UnitId = unitId;
    }

    public Date getDatetimeMeasure() {
        return datetimeMeasure;
    }

    public void setDatetimeMeasure(Date datetimeMeasure) {
        this.datetimeMeasure = datetimeMeasure;
    }
}

