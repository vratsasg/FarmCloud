package com.webstart.DTO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

public class AutomaticWater {
    @JsonProperty("autoIrrigFromTime")
//    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+1")
//    @Temporal(TemporalType.TIME)
    private String fromtime;

    @JsonProperty("autoIrrigUntilTime")
//    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+1")
//    @Temporal(TemporalType.TIME)
    private String untiltime;

    @JsonProperty("waterConsumption")
    BigDecimal wateringConsumption;

    @JsonProperty("identifier")
    private String identifier;

    public AutomaticWater() {
    }

    public AutomaticWater(String fromtime, String untiltime, BigDecimal wateringConsumption, String identifier) {
        this.fromtime = fromtime;
        this.untiltime = untiltime;
        this.wateringConsumption = wateringConsumption;
        this.identifier = identifier;
    }

    public AutomaticWater(Timestamp fromtime, Timestamp untiltime, BigDecimal wateringConsumption, String identifier) {
        this.fromtime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(fromtime);
        this.untiltime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(untiltime);
        this.wateringConsumption = wateringConsumption;
        this.identifier = identifier;
    }

    public AutomaticWater(Date fromtime, Date untiltime, BigDecimal wateringConsumption, String identifier) {
        this.fromtime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(fromtime);
        this.untiltime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(untiltime);
        this.wateringConsumption = wateringConsumption;
        this.identifier = identifier;
    }

    public String getIdentifier() {
        return identifier;
    }

    public void setIdentifier(String identifier) {
        this.identifier = identifier;
    }

    public String getFromtime() {
        return fromtime;
    }

    public void setFromtime(String fromtime) {
        this.fromtime = fromtime;
    }

    public String getUntiltime() {
        return untiltime;
    }

    public void setUntiltime(String untiltime) {
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
