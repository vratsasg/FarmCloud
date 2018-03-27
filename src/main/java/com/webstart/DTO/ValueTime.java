package com.webstart.DTO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import java.math.BigDecimal;
import java.sql.Timestamp;

public class ValueTime {

//    private Long phenomenonTime;
    private BigDecimal value;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Temporal(TemporalType.TIME)
    @JsonProperty("phenomenonDateTime")
    private Timestamp phenomenonDateTime;

    public ValueTime(Timestamp phenomenonDateTime, BigDecimal value) {
        this.value = value;
        this.phenomenonDateTime = phenomenonDateTime;
    }

    public ValueTime() {

    }

//    public Timestamp getPhenomenonTime() {
//        return phenomenonTime;
//    }
//
//    public void setPhenomenonTime(Timestamp phenomenonTime) {
//        this.phenomenonTime = phenomenonTime;
//    }

    public BigDecimal getValue() {
        return value;
    }

    public void setValue(BigDecimal value) {
        this.value = value;
    }

    public Timestamp getPhenomenonDateTime() {
        return phenomenonDateTime;
    }

    public void setPhenomenonDateTime(Timestamp phenomenonDateTime) {
        this.phenomenonDateTime = phenomenonDateTime;
    }
}
