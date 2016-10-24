package com.webstart.DTO;


import java.math.BigDecimal;
import java.sql.Timestamp;

public class WateringValueTime {


    private BigDecimal value;
    private Timestamp phenomenonDateTimeFrom;
    private Timestamp phenomenonDateTimeTo;
    private Long phenomenonNumTimeFrom;
    private Long phenomenonNumTimeTo;
    private String DateTimeDiff;

    public WateringValueTime() {
    }

    public WateringValueTime(BigDecimal value, Timestamp phenomenonDateTimeFrom, Timestamp phenomenonDateTimeTo) {
        this.value = value;
        this.phenomenonDateTimeFrom = phenomenonDateTimeFrom;
        this.phenomenonDateTimeTo = phenomenonDateTimeTo;
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
        return this.getPhenomenonDateTimeFrom().getTime() / 1000L;
    }

    public Long getPhenomenonNumTimeTo() {
        return this.getPhenomenonDateTimeTo().getTime() / 1000L;
    }

    public String getDateTimeDiff() {
        long diffSeconds = this.getPhenomenonNumTimeTo() - this.getPhenomenonNumTimeFrom();
        long diffMinutes = diffSeconds / (60 * 1000) % 60;
        long diffHours = diffSeconds / (60 * 60 * 1000);

        return String.format("Total Watering Consumption: %1%d hours and %2%d minutes", diffHours, diffMinutes);
    }
}
