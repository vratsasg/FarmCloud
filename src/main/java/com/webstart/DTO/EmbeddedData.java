package com.webstart.DTO;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * Created by George on 24/5/2016.
 */
public class EmbeddedData {


    private String zbAddress;
    private String observableProperty;
    private BigDecimal measureValue;
    private String datetime;
    private int obsid;

//    private float humidity;
//    private float itemp;
//    private float wtemp;
//    private int soil;


    public EmbeddedData() {
    }

    public EmbeddedData(String zbAddress, String observableProperty, BigDecimal measureValue, String datetime, int obsid) {
        this.zbAddress = zbAddress;
        this.observableProperty = observableProperty;
        this.measureValue = measureValue;
        this.datetime = datetime;
        this.obsid = obsid;
    }

    public String getZbAddress() {
        return zbAddress;
    }

    public void setZbAddress(String zbAddress) {
        this.zbAddress = zbAddress;
    }

    public String getObservableProperty() {
        return observableProperty;
    }

    public void setObservableProperty(String observableProperty) {
        this.observableProperty = observableProperty;
    }

    public BigDecimal getMeasureValue() {
        return measureValue;
    }

    public void setMeasureValue(BigDecimal measureValue) {
        this.measureValue = measureValue;
    }

    public String getDatetime() {
        return datetime;
    }

    public void setDatetime(String datetime) {
        this.datetime = datetime;
    }

    public int getObsid() {
        return obsid;
    }

    public void setObsid(int obsid) {
        this.obsid = obsid;
    }
}

