package com.webstart.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "numericvalue")
public class NumericValue {

    @Id
    @Column(name = "observationid")
    private Long observationid;


    @Column(name = "value")
    private BigDecimal value;

//    @JsonIgnore
//    @OneToOne(cascade=CascadeType.ALL)
//    @PrimaryKeyJoinColumn
//    public Observation observation;


    public Long getObservationid() {
        return observationid;
    }

    public void setObservationid(Long observationid) {
        this.observationid = observationid;
    }

    public BigDecimal getValue() {
        return value;
    }

    public void setValue(BigDecimal value) {
        this.value = value;
    }


    public NumericValue() {
    }

    public NumericValue(Long observationid, BigDecimal value) {
        this.observationid = observationid;
        this.value = value;
    }
//
//    public Observation getObservation() {
//        return observation;
//    }
//
//    public void setObservation(Observation observation) {
//        this.observation = observation;
//    }
}
