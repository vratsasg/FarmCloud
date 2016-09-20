package com.webstart.DTO;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.math.BigDecimal;

/**
 * Created by George on 24/5/2016.
 */
public class EmbeddedData {
    @JsonProperty("zb")
    private String zigbeeAddress;

    @JsonProperty("mv")
    private BigDecimal measureValue;

    @JsonProperty("dt")
    private String datetimeMeasure;

    @JsonProperty("oid")
    private int ObservationPropId;

    @JsonProperty("uid")
    private int UnitId;

    public EmbeddedData() {
    }

    public EmbeddedData(String zigbeeAddress, BigDecimal measureValue, String datetimeMeasure, int ObservationPropId, int UnitId) {
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

    public String getDatetimeMeasure() {
        return datetimeMeasure;
    }

    public void setDatetimeMeasure(String datetimeMeasure) {
        this.datetimeMeasure = datetimeMeasure;
    }
}

