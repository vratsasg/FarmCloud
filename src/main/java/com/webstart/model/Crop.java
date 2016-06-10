package com.webstart.model;

import java.util.ArrayList;
import java.util.List;


public class Crop {


    private String cropname;
    private String stationname;
    private String cropdescription;
    private String stationdescription;
    private List<Device> devices = new ArrayList<Device>();


    public String getCropname() {
        return cropname;
    }

    public void setCropname(String cropname) {
        this.cropname = cropname;
    }

    public String getStationname() {
        return stationname;
    }

    public void setStationname(String stationname) {
        this.stationname = stationname;
    }

    public String getCropdescription() {
        return cropdescription;
    }

    public void setCropdescription(String cropdescription) {
        this.cropdescription = cropdescription;
    }

    public String getStationdescription() {
        return stationdescription;
    }

    public void setStationdescription(String stationdescription) {
        this.stationdescription = stationdescription;
    }


    public List<Device> getDevices() {
        return devices;
    }

    public void setDevices(List<Device> Devices) {
        this.devices = Devices;
    }
}
