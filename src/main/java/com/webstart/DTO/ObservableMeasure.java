package com.webstart.DTO;

import com.webstart.DTO.ValueTime;

import java.util.List;

public class ObservableMeasure {

    private String ObservableProperty;
    private String Identifier;
    private String unit;
    private List<ValueTime> measuredata;


    public ObservableMeasure() {
    }

    public ObservableMeasure(String observableProperty, String identifier, String unit, List<ValueTime> measuredata) {
        ObservableProperty = observableProperty;
        Identifier = identifier;
        this.unit = unit;
        this.measuredata = measuredata;
    }

    public String getObservableProperty() {
        return ObservableProperty;
    }

    public void setObservableProperty(String observableProperty) {
        ObservableProperty = observableProperty;
    }

    public String getIdentifier() {
        return Identifier;
    }

    public void setIdentifier(String identifier) {
        Identifier = identifier;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public List<ValueTime> getMeasuredata() {
        return measuredata;
    }

    public void setMeasuredata(List<ValueTime> measuredata) {
        this.measuredata = measuredata;
    }
}

