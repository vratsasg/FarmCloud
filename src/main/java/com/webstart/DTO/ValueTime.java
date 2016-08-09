package com.webstart.DTO;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * Created by DimDesktop on 3/7/2016.
 */
public class ValueTime {

    private Long phenomenonTime;
    private BigDecimal value;

    public ValueTime(Long phenomenonTime, BigDecimal value) {
        this.phenomenonTime = phenomenonTime;
        this.value = value;
    }

    public ValueTime() {
    }

    public Long getPhenomenonTime() {
        return phenomenonTime;
    }

    public void setPhenomenonTime(Long phenomenonTime) {
        this.phenomenonTime = phenomenonTime;
    }

    public BigDecimal getValue() {
        return value;
    }

    public void setValue(BigDecimal value) {
        this.value = value;
    }
}
