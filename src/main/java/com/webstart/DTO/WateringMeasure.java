package com.webstart.DTO;


import java.util.List;

public class WateringMeasure {

    private String ObservableProperty;
    private String Identifier;
    private String unit;
    private List<WateringValueTime> measuredata;

    public WateringMeasure() {
    }

    public WateringMeasure(String observableProperty, String identifier, String unit, List<WateringValueTime> measuredata) {
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

    public List<WateringValueTime> getMeasuredata() {
        return measuredata;
    }

    public void setMeasuredata(List<WateringValueTime> measuredata) {
        this.measuredata = measuredata;
    }
}
