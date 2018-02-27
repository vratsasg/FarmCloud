package com.webstart.DTO;


import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class EndDeviceStatusDTO {

    @JsonProperty("id")
    private String identifier;
    @JsonProperty("irrig")
    private boolean irrigationStatus;
    @JsonProperty("meas")
    private boolean measuringStatus;

    @JsonIgnore
    @Temporal(TemporalType.TIME)
    private Date fromtime;

    @JsonIgnore
    @Temporal(TemporalType.TIME)
    private Date untiltime;

    @JsonProperty("frh")
    private int fromHour;
    @JsonProperty("frm")
    private int fromMinute;
    @JsonProperty("tom")
    private int toMinute;
    @JsonProperty("toh")
    private int toHour;


    public EndDeviceStatusDTO() {
    }

    public EndDeviceStatusDTO(String identifier, boolean irrigationStatus, boolean measuringStatus, Date fromtime, Date untiltime) {
        //TODO remove it from here
//        //TimeZone
//        TimeZone tz = TimeZone.getTimeZone("Europe/Athens");
//
//        //Convert time to UTC
//        int offset = DateTimeZone.forID(tz.getID()).getOffset(new DateTime());
//        Calendar cal = Calendar.getInstance();
//
//        cal.setTimeInMillis(fromtime.getTime());
//        cal.add(Calendar.MILLISECOND, offset);
//        fromtime = new Timestamp(cal.getTime().getTime());
//
//        cal.setTimeInMillis(untiltime.getTime());
//        cal.add(Calendar.MILLISECOND, offset);
//        untiltime = new Timestamp(cal.getTime().getTime());

        this.identifier = identifier;
        this.irrigationStatus = irrigationStatus;
        this.measuringStatus = measuringStatus;
        this.fromtime = fromtime;
        this.untiltime = untiltime;
    }

    public String getIdentifier() {
        return identifier;
    }

    public void setIdentifier(String identifier) {
        this.identifier = identifier;
    }

    public boolean isIrrigationStatus() {
        return irrigationStatus;
    }

    public void setIrrigationStatus(boolean irrigationStatus) {
        this.irrigationStatus = irrigationStatus;
    }

    public boolean isMeasuringStatus() {
        return measuringStatus;
    }

    public void setMeasuringStatus(boolean measuringStatus) {
        this.measuringStatus = measuringStatus;
    }

    public Date getFromtime() {
        return fromtime;
    }

    public void setFromtime(Date fromtime) {
        this.fromtime = fromtime;
    }

    public Date getUntiltime() {
        return untiltime;
    }

    public void setUntiltime(Date untiltime) {
        this.untiltime = untiltime;
    }

    public int getFromHour() {
        this.fromHour = 0;
        Calendar calendar = GregorianCalendar.getInstance(); // creates a new calendar instance
        if (this.getFromtime() != null) {
            calendar.setTime(this.getFromtime());   // assigns calendar to given date
            this.fromHour = calendar.get(Calendar.HOUR_OF_DAY);
        }

        return this.fromHour;
    }

    public int getFromMinute() {
        this.fromMinute = 0;
        if (this.getFromtime() != null) {
            Calendar calendar = GregorianCalendar.getInstance(); // creates a new calendar instance
            calendar.setTime(this.getFromtime());   // assigns calendar to given date
            this.fromMinute = calendar.get(Calendar.MINUTE);
        }

        return this.fromMinute;
    }

    public int getToMinute() {
        this.toMinute = 0;
        if (this.getUntiltime() != null) {
            Calendar calendar = GregorianCalendar.getInstance(); // creates a new calendar instance
            calendar.setTime(this.getUntiltime());   // assigns calendar to given date
            this.toMinute = calendar.get(Calendar.MINUTE);
        }

        return this.toMinute;
    }

    public int getToHour() {
        this.toHour = 0;
        if (this.getUntiltime() != null) {
            Calendar calendar = GregorianCalendar.getInstance(); // creates a new calendar instance
            calendar.setTime(this.getUntiltime());   // assigns calendar to given date
            this.toHour = calendar.get(Calendar.HOUR_OF_DAY);
        }

        return this.toHour;
    }

}
