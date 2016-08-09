package com.webstart.DTO;

import java.math.BigDecimal;

/**
 * Created by DimDesktop on 11/7/2016.
 */
public class ObservationMeasure extends ValueTime {
    public String unit;
    public String ObservableProperty;

    public ObservationMeasure(Long phenomenonTime, BigDecimal value, String unit, String observableProperty) {
        super(phenomenonTime, value);
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
