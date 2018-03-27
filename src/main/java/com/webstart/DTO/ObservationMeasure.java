package com.webstart.DTO;

import com.fasterxml.jackson.annotation.JsonInclude;

import java.math.BigDecimal;
import java.sql.Timestamp;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class ObservationMeasure extends ValueTime {
    public String unit;
    public String ObservableProperty;

    public ObservationMeasure(BigDecimal value, Timestamp phenomenonDateTime, String unit, String observableProperty) {
        super(phenomenonDateTime, value);
        this.unit = unit;
        ObservableProperty = observableProperty;
    }

    public ObservationMeasure() {
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getObservableProperty() {
        return ObservableProperty;
    }

    public void setObservableProperty(String observableProperty) {
        ObservableProperty = observableProperty;
    }
}
