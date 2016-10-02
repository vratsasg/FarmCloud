package com.webstart.DTO;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonRootName;

import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import java.math.BigDecimal;
import java.util.Date;

@JsonRootName("coordinator")
public class AutomaticWater {
    @JsonProperty("automaticIrrigationFromTime")
    @Temporal(TemporalType.TIME)
    private java.util.Date fromtime;

    @JsonProperty("automaticIrrigationUntilTime")
    @Temporal(TemporalType.TIME)
    private java.util.Date untiltime;

    @JsonProperty("wateringConsumption")
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
