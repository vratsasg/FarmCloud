package com.webstart.model;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;


/**
 * Created by George on 9/6/2016.
 */
@Embeddable
public class MyKey implements Serializable {

    public long getChildfeatureid() {
        return childfeatureid;
    }

    public void setChildfeatureid(long childfeatureid) {
        this.childfeatureid = childfeatureid;
    }

    public long getParentfeatureid() {
        return parentfeatureid;
    }

    public void setParentfeatureid(long parentfeatureid) {
        this.parentfeatureid = parentfeatureid;
    }

    @Column(name="parentfeatureid")

    private long parentfeatureid;

    @Column(name="childfeatureid")
    private long childfeatureid;


    public MyKey(long parentfeatureid,long childfeatureid){

        this.parentfeatureid=parentfeatureid;
        this.childfeatureid=childfeatureid;
    }
}
