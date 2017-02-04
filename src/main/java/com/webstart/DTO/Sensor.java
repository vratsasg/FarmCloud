package com.webstart.DTO;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * Created by DimDesktop on 30/1/2017.
 */
public class Sensor {

    @JsonProperty(value = "sensorname")
    private String name;
    @JsonProperty(value = "typeofmeasurement")
    private String measurementType;
    @JsonProperty(value = "kindofmeasurement")
    private String measurementKind;

    public Sensor() {
    }

    public Sensor(String name, String measurementType, String measurementKind) {
        this.name = name;
        this.measurementType = measurementType;
        this.measurementKind = measurementKind;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMeasurementType() {
        return measurementType;
    }

    public void setMeasurementType(String measurementType) {
        this.measurementType = measurementType;
    }

    public String getMeasurementKind() {
        return measurementKind;
    }

    public void setMeasurementKind(String measurementKind) {
        this.measurementKind = measurementKind;
    }
}
