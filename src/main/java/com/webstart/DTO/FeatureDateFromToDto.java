package com.webstart.DTO;


import java.sql.Timestamp;
import java.util.Date;

public class FeatureDateFromToDto {

    private Date datetimeFrom;
    private Date datetimeTo;

    public FeatureDateFromToDto(Timestamp datetimeFrom, Timestamp datetimeTo) {
        this.datetimeFrom = datetimeFrom;
        this.datetimeTo = datetimeTo;
    }

    public Date getDatetimeFrom() {
        return datetimeFrom;
    }

    public void setDatetimeFrom(Date datetimeFrom) {
        this.datetimeFrom = datetimeFrom;
    }

    public Date getDatetimeTo() {
        return datetimeTo;
    }

    public void setDatetimeTo(Date datetimeTo) {
        this.datetimeTo = datetimeTo;
    }
}
