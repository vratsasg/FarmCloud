package com.webstart.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.time.LocalDateTime;

/**
 * Created by George on 25/5/2016.
 */

@Entity
@Table(name = "observation")
public class Observation {
    @JsonIgnore
    @Id
    @GeneratedValue
    private long observationid;

    private long seriesid;

    private LocalDateTime phenomenontimestart;
    private LocalDateTime phhenomenontimeend;
    private LocalDateTime resulttime;
    private LocalDateTime validtimestart;
    private LocalDateTime validtimeend;

    @Column(length = 1)
    private String deleted;

    @Column(length = 255)
    private String identifier;

    private Long codespaceid;

    @Column(length = 255)
    private String description;

    private Long unitid;
}
