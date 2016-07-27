package com.webstart.DTO;

import java.sql.Timestamp;


public class SetupData {

    private Timestamp datefrom;

    private Timestamp dateto;

    private boolean irrigation = false;

    private boolean meausering = false;

    public SetupData() {
    }


    public SetupData(Timestamp datefrom, Timestamp dateto, boolean meausering, boolean irrigation) {
        this.datefrom = datefrom;
        this.dateto = dateto;
        this.meausering = meausering;
        this.irrigation = irrigation;
    }

    public Timestamp getDatefrom() {
        return datefrom;
    }

    public void setDatefrom(Timestamp datefrom) {
        this.datefrom = datefrom;
    }

    public Timestamp getDateto() {
        return dateto;
    }

    public void setDateto(Timestamp dateto) {
        this.dateto = dateto;
    }

    public boolean isIrrigation() {
        return irrigation;
    }

    public void setIrrigation(boolean irrigation) {
        this.irrigation = irrigation;
    }

    public boolean isMeausering() {
        return meausering;
    }

    public void setMeausering(boolean meausering) {
        this.meausering = meausering;
    }
}
