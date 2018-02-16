package com.webstart.DTO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import java.math.BigDecimal;
import java.util.Date;

public class AutomaticWater {
    @JsonProperty("autoIrrigFromTime")
//    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+1")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Temporal(TemporalType.TIME)
    private java.util.Date fromtime;

    @JsonProperty("autoIrrigUntilTime")
//    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+1")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Temporal(TemporalType.TIME)
    private java.util.Date untiltime;

    @JsonProperty("waterConsumption")
    BigDecimal wateringConsumption;

    @JsonProperty("identifier")
    private String identifier;

    public AutomaticWater() {
    }

    public AutomaticWater(Date fromtime, Date untiltime, BigDecimal wateringConsumption, String identifier) {
        this.fromtime = fromtime;
        this.untiltime = untiltime;
        this.wateringConsumption = wateringConsumption;
        this.identifier = identifier;
    }

    public String getIdentifier() {
        return identifier;
    }

    public void setIdentifier(String identifier) {
        this.identifier = identifier;
    }

    public Date getFromtime() {
        return fromtime;
    }

    public void setFromtime(Date fromtime) {
        this.fromtime = fromtime;
    }

    public Date getUntiltime() {
        return untiltime;
    }

    public void setUntiltime(Date untiltime) {
        this.untiltime = untiltime;
    }

    public BigDecimal getWateringConsumption() {
        return wateringConsumption;
    }

    public void setWateringConsumption(BigDecimal wateringConsumption) {
        if (wateringConsumption == null) {
            this.wateringConsumption = new BigDecimal(0);
        } else {
            this.wateringConsumption = wateringConsumption;
        }
    }

}
