package com.webstart.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Table
@Entity(name = "unit")
public class Unit {

    @Id
    @Column(name = "unitid")
    private Long unitid;

    @Column(name = "unit", length = 255)
    private String unit;

    public Unit() {
    }

    public Unit(Long unitid, String unit) {
        this.unitid = unitid;
        this.unit = unit;
    }

    public Long getUnitid() {
        return unitid;
    }

    public void setUnitid(Long unitid) {
        this.unitid = unitid;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }
}
