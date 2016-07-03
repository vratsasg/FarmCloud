package com.webstart.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * Created by DimDesktop on 3/7/2016.
 */
public class ValueTime {

    private Timestamp phenomenonTime;
    private BigDecimal value;

    public ValueTime(Timestamp phenomenonTime, BigDecimal value) {
        this.phenomenonTime = phenomenonTime;
        this.value = value;
    }

    public ValueTime() {
    }

    public Timestamp getPhenomenonTime() {
        return phenomenonTime;
    }

    public void setPhenomenonTime(Timestamp phenomenonTime) {
        this.phenomenonTime = phenomenonTime;
    }

    public BigDecimal getValue() {
        return value;
    }

    public void setValue(BigDecimal value) {
        this.value = value;
    }
}
