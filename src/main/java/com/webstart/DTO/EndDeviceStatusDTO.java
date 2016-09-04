package com.webstart.DTO;

public class EndDeviceStatusDTO {

    private String identifier;
    private boolean irrigationStatus;
    private boolean measuringStatus;

    public EndDeviceStatusDTO() {
    }

    public EndDeviceStatusDTO(String identifier, boolean irrigationStatus, boolean measuringStatus) {
        this.identifier = identifier;
        this.irrigationStatus = irrigationStatus;
        this.measuringStatus = measuringStatus;
    }

    public String getIdentifier() {
        return identifier;
    }

    public void setIdentifier(String identifier) {
        this.identifier = identifier;
    }

    public boolean getIrrigationStatus() {
        return irrigationStatus;
    }

    public void setIrrigationStatus(boolean irrigationStatus) {
        this.irrigationStatus = irrigationStatus;
    }

    public boolean getMeasuringStatus() {
        return measuringStatus;
    }

    public void setMeasuringStatus(boolean measuringStatus) {
        this.measuringStatus = measuringStatus;
    }
}
