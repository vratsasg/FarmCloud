package com.webstart.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;


@Entity
@Table(name = "procedure")
public class Procedure {

    @JsonIgnore
    @Id
    @GeneratedValue
    private long procedureid;

    @Column(length = 1, name = "hibernatediscriminator")
    private String hibernatediscriminator;

    @Column(name = "proceduredescriptionformatid")
    private long proceduredescriptionformatid;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "proceduredescriptionformatid", insertable = false, updatable = false)
    private ProcedureDescriptionFormat procedureDescriptionFormat;


    @OneToMany(fetch = FetchType.LAZY, mappedBy = "procedure", cascade = {CascadeType.ALL})
    private List<Series> seriesList = new ArrayList<Series>();


    @Column(length = 255, name = "identifier")
    private String identifier;

    @Column(name = "deleted")
    private boolean deleted;

    @Column(length = 2000, name = "descriptionfile")
    private String descriptionfile;

    public long getProcedureid() {
        return procedureid;
    }

    public void setProcedureid(long procedureid) {
        this.procedureid = procedureid;
    }

    public String getHibernatediscriminator() {
        return hibernatediscriminator;
    }

    public void setHibernatediscriminator(String hibernatediscriminator) {
        this.hibernatediscriminator = hibernatediscriminator;
    }

    public long getProceduredescriptionformatid() {
        return proceduredescriptionformatid;
    }

    public void setProceduredescriptionformatid(long proceduredescriptionformatid) {
        this.proceduredescriptionformatid = proceduredescriptionformatid;
    }

    public ProcedureDescriptionFormat getProcedureDescriptionFormat() {
        return procedureDescriptionFormat;
    }

    public void setProcedureDescriptionFormat(ProcedureDescriptionFormat procedureDescriptionFormat) {
        this.procedureDescriptionFormat = procedureDescriptionFormat;
    }

    public List<Series> getSeriesList() {
        return seriesList;
    }

    public void setSeriesList(List<Series> seriesList) {
        this.seriesList = seriesList;
    }

    public String getIdentifier() {
        return identifier;
    }

    public void setIdentifier(String identifier) {
        this.identifier = identifier;
    }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    public String getDescriptionfile() {
        return descriptionfile;
    }

    public void setDescriptionfile(String descriptionfile) {
        this.descriptionfile = descriptionfile;
    }

    public Procedure(String hibernatediscriminator, long proceduredescriptionformatid, ProcedureDescriptionFormat procedureDescriptionFormat, List<Series> seriesList, String identifier, boolean deleted, String descriptionfile) {
        this.hibernatediscriminator = hibernatediscriminator;
        this.proceduredescriptionformatid = proceduredescriptionformatid;
        this.procedureDescriptionFormat = procedureDescriptionFormat;
        this.seriesList = seriesList;
        this.identifier = identifier;
        this.deleted = deleted;
        this.descriptionfile = descriptionfile;
    }


    public Procedure() {
    }
}
