package com.webstart.model;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.math.BigDecimal;

/**
 * Created by George on 27/6/2016.
 */
public class CurrentMeasure {

    private String identifier;
    private Timestamp dateTime;
    private BigDecimal bigDecimal;

    public CurrentMeasure() {
    }

    public CurrentMeasure(String identifier, Timestamp dateTime, BigDecimal bigDecimal) {
        this.identifier = identifier;
        this.dateTime = dateTime;
        this.bigDecimal = bigDecimal;
    }

    public String getIdentifier() {
        return identifier;
    }

    public void setIdentifier(String identifier) {
        this.identifier = identifier;
    }

    public Timestamp getDateTime() {
        return dateTime;
    }

    public void setDateTime(Timestamp dateTime) {
        this.dateTime = dateTime;
    }

    public BigDecimal getBigDecimal() {
        return bigDecimal;
    }

    public void setBigDecimal(BigDecimal bigDecimal) {
        this.bigDecimal = bigDecimal;
    }
}
