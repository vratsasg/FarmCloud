package com.webstart.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "proceduredescriptionformat")
public class ProcedureDescriptionFormat {
    @JsonIgnore
    @Id
    @GeneratedValue
    private long proceduredescriptionformatid;

    @Column(length = 255)
    private String proceduredescriptionformat;

    @OneToMany(mappedBy = "procedureDescriptionFormat", cascade = {CascadeType.ALL})

    private List<Procedure> procedure_list = new ArrayList<Procedure>();

    public ProcedureDescriptionFormat(String proceduredescriptionformat, List<Procedure> procedure_list) {
        this.proceduredescriptionformat = proceduredescriptionformat;
        this.procedure_list = procedure_list;
    }

    public ProcedureDescriptionFormat() {

    }

    public long getProceduredescriptionformatid() {
        return proceduredescriptionformatid;
    }

    public void setProceduredescriptionformatid(long proceduredescriptionformatid) {
        this.proceduredescriptionformatid = proceduredescriptionformatid;
    }

    public String getProceduredescriptionformat() {
        return proceduredescriptionformat;
    }

    public void setProceduredescriptionformat(String proceduredescriptionformat) {
        this.proceduredescriptionformat = proceduredescriptionformat;
    }

    public List<Procedure> getProcedure_list() {
        return procedure_list;
    }

    public void setProcedure_list(List<Procedure> procedure_list) {
        this.procedure_list = procedure_list;
    }
}
