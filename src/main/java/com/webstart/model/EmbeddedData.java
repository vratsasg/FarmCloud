package com.webstart.model;

import java.time.LocalDateTime;

/**
 * Created by George on 24/5/2016.
 */
public class EmbeddedData {


    private String zbAddress;
    private float humidity;
    private float itemp;
    private float wtemp;
    private int soil;
    private LocalDateTime mdate;

    public float getHumidity() {
        return humidity;
    }

    public void setHumidity(float humidity) {
        this.humidity = humidity;
    }

    public float getItemp() {
        return itemp;
    }

    public void setItemp(float itemp) {
        this.itemp = itemp;
    }

    public String getZbAddress() {
        return zbAddress;
    }

    public void setZbAddress(String zbAddress) {
        this.zbAddress = zbAddress;
    }

    public float getWtemp() {
        return wtemp;
    }

    public void setWtemp(float wtemp) {
        this.wtemp = wtemp;
    }

    public int getSoil() {
        return soil;
    }

    public LocalDateTime getMdate() {
        return mdate;
    }

    public void setMdate(LocalDateTime mdate) {
        this.mdate = mdate;
    }

    public void setSoil(int soil) {
        this.soil = soil;
    }




}

