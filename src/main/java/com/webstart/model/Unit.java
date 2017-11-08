package com.webstart.model;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Table
@Entity(name = "unit")
public class Unit {

    @Id
    @Column(name = "unitid")
    private Long unitid;

    @Column(name = "unit", length = 255)
    private String unit;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "unit", cascade = {CascadeType.ALL})
    private List<Observation> observationList = new ArrayList<Observation>();

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

    public List<Observation> getObservationList() {
        return observationList;
    }

    public void setObservationList(List<Observation> observationList) {
        this.observationList = observationList;
    }
}
