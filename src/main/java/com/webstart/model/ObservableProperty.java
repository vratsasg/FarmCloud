package com.webstart.model;


import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;


@Entity
@Table(name = "observableproperty")
public class ObservableProperty {
    @JsonIgnore
    @Id
    @Column(name = "observablepropertyid")
    private Long ObservablePropertyId;

    @Column(name = "hibernatediscriminator")
    private String HibernateDiscriminator;

    @Column(name = "identifier")
    private String Identifier;

    @Column(name = "description")
    private String Description;


    @OneToMany(fetch = FetchType.EAGER, mappedBy = "observableProperty", cascade = {CascadeType.ALL})
    private List<Series> seriesList = new ArrayList<Series>();

    public ObservableProperty() {
    }

    public ObservableProperty(Long observablePropertyId, String hibernateDiscriminator, String identifier, String description, List<Series> seriesList) {
        ObservablePropertyId = observablePropertyId;
        HibernateDiscriminator = hibernateDiscriminator;
        Identifier = identifier;
        Description = description;
        this.seriesList = seriesList;
    }

    public Long getObservablePropertyId() {
        return ObservablePropertyId;
    }

    public void setObservablePropertyId(Long observablePropertyId) {
        ObservablePropertyId = observablePropertyId;
    }

    public String getHibernateDiscriminator() {
        return HibernateDiscriminator;
    }

    public void setHibernateDiscriminator(String hibernateDiscriminator) {
        HibernateDiscriminator = hibernateDiscriminator;
    }

    public String getIdentifier() {
        return Identifier;
    }

    public void setIdentifier(String identifier) {
        Identifier = identifier;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String description) {
        Description = description;
    }

    public List<Series> getSeriesList() {
        return seriesList;
    }

    public void setSeriesList(List<Series> seriesList) {
        this.seriesList = seriesList;
    }
}
