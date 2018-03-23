package com.webstart.DTO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.joda.time.DateTime;

import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;

public class EmbeddedData {
    @JsonProperty("zb")
    private String zigbeeAddress;

    @JsonProperty("mv")
    private BigDecimal measureValue;

    @JsonProperty("dt")
//    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+2")
//    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
//    @Temporal(TemporalType.TIME)
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

