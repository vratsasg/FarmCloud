package com.webstart.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;

/**
 * Created by George on 7/6/2016.
 */

@Entity

@Table(name = "featurerelation")
public class Featurerelation {

    @JsonIgnore
    @EmbeddedId
    MyKey myKey;

    public Featurerelation(long parentfeatureid,long childfeatureid){

        this.myKey=new MyKey(parentfeatureid,childfeatureid);

    }




}
