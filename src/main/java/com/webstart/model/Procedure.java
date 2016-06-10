package com.webstart.model;

import javax.persistence.*;

/**
 * Created by DimDesktop on 6/1/2016.
 */

@Entity
@Table(name = "procedure")
public class Procedure {


    @Id
    @GeneratedValue
    private long procedureid;

    @Column(length = 1,name="hibernatediscriminator")
    private String hibernatediscriminator;

    @Column(name="proceduredescriptionformatid")
    private long proceduredescriptionformatid;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "proceduredescriptionformatid",insertable=false, updatable=false)
    private ProcedureDescriptionFormat procedureDescriptionFormat;

    @Column(length = 255,name="identifier")
    private String identifier;

    @Column(name="deleted")
    private boolean deleted;

    @Column(length = 2000,name="descriptionfile")
    private String descriptionfile;

    public Procedure(String hibernatediscriminator, long proceduredescriptionformatid, ProcedureDescriptionFormat procedureDescriptionFormat, String identifier, boolean deleted, String descriptionfile) {
        this.hibernatediscriminator = hibernatediscriminator;
        this.proceduredescriptionformatid = proceduredescriptionformatid;
        this.procedureDescriptionFormat = procedureDescriptionFormat;
        this.identifier = identifier;
        this.deleted = deleted;
        this.descriptionfile = descriptionfile;
    }

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

    public ProcedureDescriptionFormat getProcedureDescriptionFormat() {
        return procedureDescriptionFormat;
    }

    public void setProcedureDescriptionFormat(ProcedureDescriptionFormat procedureDescriptionFormat) {
        this.procedureDescriptionFormat = procedureDescriptionFormat;
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

    public long getProceduredescriptionformatid() {
        return proceduredescriptionformatid;
    }

    public void setProceduredescriptionformatid(long proceduredescriptionformatid) {
        this.proceduredescriptionformatid = proceduredescriptionformatid;
    }
}
