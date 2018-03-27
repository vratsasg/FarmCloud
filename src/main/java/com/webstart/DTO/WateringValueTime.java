package com.webstart.DTO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import java.math.BigDecimal;
import java.sql.Timestamp;

public class WateringValueTime {

    @JsonProperty("value")
    private BigDecimal value;
    //    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+2")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Temporal(TemporalType.TIME)
    @JsonProperty("phenomenonTimeStart")
    private Timestamp phenomenonDateTimeFrom;
    //
    @JsonProperty("phenomenonTimeEnd")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Temporal(TemporalType.TIME)
    private Timestamp phenomenonDateTimeTo;
//
//    @JsonProperty("phenomenonTimeStart")
//    private Long phenomenonNumTimeFrom;
//    @JsonProperty("phenomenonTimeEnd")
//    private Long phenomenonNumTimeTo;
//
    @JsonProperty("totalDuration")
    private String dateTimeDiff;


    public WateringValueTime() {

    }

    public WateringValueTime(BigDecimal value, Timestamp phenomenonDateTimeFrom, Timestamp phenomenonDateTimeTo) {
        this.value = value;
        this.phenomenonDateTimeFrom = phenomenonDateTimeFrom;
        this.phenomenonDateTimeTo = phenomenonDateTimeTo;

        long diffSeconds = this.phenomenonDateTimeFrom.getTime() - this.phenomenonDateTimeFrom.getTime();
        this.dateTimeDiff = String.format("%1$d hours, %2$d minutes", diffSeconds / (60 * 60 * 1000), diffSeconds / (60 * 1000) % 60);

    }

    public BigDecimal getValue() {
        return value;
    }

    public void setValue(BigDecimal value) {
        this.value = value;
    }

    public Timestamp getPhenomenonDateTimeFrom() {
        return phenomenonDateTimeFrom;
    }

    public void setPhenomenonDateTimeFrom(Timestamp phenomenonDateTimeFrom) {
        this.phenomenonDateTimeFrom = phenomenonDateTimeFrom;
    }

    public Timestamp getPhenomenonDateTimeTo() {
        return phenomenonDateTimeTo;
    }

    public void setPhenomenonDateTimeTo(Timestamp phenomenonDateTimeTo) {
        this.phenomenonDateTimeTo = phenomenonDateTimeTo;
    }

    public Long getPhenomenonNumTimeFrom() {
        return this.getPhenomenonDateTimeFrom().getTime();
    }

//    public void setPhenomenonNumTimeFrom(Long phenomenonNumTimeFrom) {
//        this.phenomenonNumTimeFrom = phenomenonNumTimeFrom;
//    }

    public Long getPhenomenonNumTimeTo() {
        return this.getPhenomenonDateTimeTo().getTime();
    }

//    public void setPhenomenonNumTimeTo(Long phenomenonNumTimeTo) {
//        this.phenomenonNumTimeTo = phenomenonNumTimeTo;
//    }

    public void setDateTimeDiff(String dateTimeDiff) {
        this.dateTimeDiff = dateTimeDiff;
    }

    public String getDateTimeDiff() {
        long diffSeconds = this.getPhenomenonNumTimeTo() - this.getPhenomenonNumTimeFrom();
        long diffMinutes = diffSeconds / (60 * 1000) % 60;
        long diffHours = diffSeconds / (60 * 60 * 1000);

        if(diffHours == 0L){
            return String.format("%1$d minutes", diffMinutes);
        }

        return String.format("%1$d hours and %2$d minutes", diffHours, diffMinutes);
    }


}
