package com.webstart.model;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by DimDesktop on 6/1/2016.
 */

@Entity
@Table(name = "proceduredescriptionformat")
public class ProcedureDescriptionFormat {

    @Id
    @GeneratedValue
    private long proceduredescriptionformatid;

    @Column(length = 255)
    private String proceduredescriptionformat;


    @OneToMany(mappedBy = "procedureDescriptionFormat", cascade = {CascadeType.ALL})

    private List<Procedure> procedure_list = new ArrayList<Procedure>();

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

    public ProcedureDescriptionFormat(String proceduredescriptionformat, List<Procedure> procedure_list) {
        this.proceduredescriptionformat = proceduredescriptionformat;
        this.procedure_list = procedure_list;
    }

    public ProcedureDescriptionFormat() {
    }


}
