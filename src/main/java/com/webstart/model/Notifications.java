package com.webstart.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;

/**
 * Created by George on 13/9/2016.
 */
@Entity
@Table(name = "notifications")
public class Notifications {


    @Id
    @GeneratedValue
    private Integer notifid;

    @Column(name = "userid")
    private Integer userid;

    @Column(name = "description")
    private String description;

    @Column(name = "readable")
    private boolean readable;

    public Notifications() {
    }

    public Notifications(Integer notifid, Integer userid, String description, boolean readable) {
        this.userid = userid;
        this.description = description;
        this.readable = readable;
        this.notifid = notifid;
    }


    @ManyToOne(fetch = FetchType.EAGER, optional = true)
    @JoinColumn(name = "userid", insertable = false, updatable = false)
    private Users usersnotif;


    public Integer getNotifid() {
        return notifid;
    }

    public void setNotifid(Integer notifid) {
        this.notifid = notifid;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isReadable() {
        return readable;
    }

    public void setReadable(boolean readable) {
        this.readable = readable;
    }
}
