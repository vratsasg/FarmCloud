package com.webstart.model;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by George on 7/6/2016.
 */


@Entity
@Table(name = "featureofinteresttype")
public class Featureofinteresttype {


    @Id
    @Column(name = "featureofinteresttypeid")
    private long featureofinteresttypeid;


    @Column(length = 255)
    private String featureofinteresttype;


    @OneToMany(mappedBy = "featureofinteresttype", cascade = {CascadeType.ALL})
    private List<Featureofinterest> featureofinterestList = new ArrayList<Featureofinterest>();


}
