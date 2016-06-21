package com.webstart.model;


import javax.persistence.*;


@Entity
@Table(name = "observableproperty")
public class ObservableProperty {

    @Id
    @Column(name = "observablepropertyid")
    private Long ObservablePropertyId;

    @Column(name = "hibernatediscriminator")
    private String HibernateDiscriminator;

    @Column(name = "identifier")
    private String Identifier;

    @Column(name = "description")
    private String Description;


    public ObservableProperty() {
    }

    public ObservableProperty(Long observablePropertyId, String hibernateDiscriminator, String identifier, String description) {
        ObservablePropertyId = observablePropertyId;
        HibernateDiscriminator = hibernateDiscriminator;
        Identifier = identifier;
        Description = description;
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
}
