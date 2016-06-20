package com.webstart.model;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;




@Entity
@Table(name = "featureofinteresttype")
public class Featureofinteresttype {


    @Id
    @Column(name = "featureofinteresttypeid")
    private long featureofinteresttypeid;

    public Featureofinteresttype() {

    }

    public Featureofinteresttype(long featureofinteresttypeid, String featureofinteresttype, List<Featureofinterest> featureofinterestList) {
        this.featureofinteresttypeid = featureofinteresttypeid;
        this.featureofinteresttype = featureofinteresttype;
        this.featureofinterestList = featureofinterestList;
    }

    public long getFeatureofinteresttypeid() {

        return featureofinteresttypeid;
    }

    public void setFeatureofinteresttypeid(long featureofinteresttypeid) {
        this.featureofinteresttypeid = featureofinteresttypeid;
    }

    public String getFeatureofinteresttype() {
        return featureofinteresttype;
    }

    public void setFeatureofinteresttype(String featureofinteresttype) {
        this.featureofinteresttype = featureofinteresttype;
    }

    public List<Featureofinterest> getFeatureofinterestList() {
        return featureofinterestList;
    }

    public void setFeatureofinterestList(List<Featureofinterest> featureofinterestList) {
        this.featureofinterestList = featureofinterestList;
    }

    @Column(length = 255)
    private String featureofinteresttype;


    @OneToMany(fetch = FetchType.EAGER, mappedBy = "featureofinteresttype", cascade = {CascadeType.ALL})
    private List<Featureofinterest> featureofinterestList = new ArrayList<Featureofinterest>();


}
