package com.webstart.DTO;

/**
 * identifier, " +
 * "to_char(childfi.datetimefrom, 'HH24') as fromhour, " +
 * "to_char(childfi.datetimefrom, 'MI') as fromminute, " +
 * "to_char(childfi.datetimeto, 'HH24') as tohour, " +
 * "to_char(childfi.datetimeto, 'MI') as tominute " +
 */

public class EmebddedSetupDevicdeDto {

    private String identifier;
    private Integer fromhour;
    private Integer fromminute;
    private Integer tohour;
    private Integer tominute;

    public EmebddedSetupDevicdeDto() {
    }

    public EmebddedSetupDevicdeDto(String identifier, Integer fromhour, Integer fromminute, Integer tohour, Integer tominute) {
        this.identifier = identifier;
        this.fromhour = fromhour;
        this.fromminute = fromminute;
        this.tohour = tohour;
        this.tominute = tominute;
    }

    public String getIdentifier() {
        return identifier;
    }

    public void setIdentifier(String identifier) {
        this.identifier = identifier;
    }

    public Integer getFromhour() {
        return fromhour;
    }

    public void setFromhour(Integer fromhour) {
        this.fromhour = fromhour;
    }

    public Integer getFromminute() {
        return fromminute;
    }

    public void setFromminute(Integer fromminute) {
        this.fromminute = fromminute;
    }

    public Integer getTohour() {
        return tohour;
    }

    public void setTohour(Integer tohour) {
        this.tohour = tohour;
    }

    public Integer getTominute() {
        return tominute;
    }

    public void setTominute(Integer tominute) {
        this.tominute = tominute;
    }
}
