package com.webstart.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.math.BigDecimal;

@Entity
@Table(name = "numericvalue")
public class NumericValue {

    @Id
    @Column(name = "observationid")
    private Long observationid;


    @Column(name = "value")
    private BigDecimal value;

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
}
