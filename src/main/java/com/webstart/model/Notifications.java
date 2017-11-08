package com.webstart.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Date;

@Entity
@Table(name = "notifications")
public class Notifications {

    @Id
    @GeneratedValue
    private int notificationid;

    @Column(name = "userid")
    private int userid;

    @Column(name = "description")
    private String description;

    @Column(name = "isreaded")
    private boolean isreaded;

    @Column(name = "datecreated")
    private Timestamp datecreated;

    @ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "userid", insertable = false, updatable = false)
    private Users userNotification;

    public Notifications() {
    }

    public Notifications(Integer notificationid, Integer userid, String description, boolean isreaded, Timestamp datecreated) {
        this.userid = userid;
        this.description = description;
        this.isreaded = isreaded;
        this.notificationid = notificationid;
        this.datecreated = datecreated;
    }


    public Integer getNotifid() {
        return notificationid;
    }

    public void setNotifid(Integer notificationid) {
        this.notificationid = notificationid;
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
        return isreaded;
    }

    public void setReadable(boolean isreaded) {
        this.isreaded = isreaded;
    }

    public Date getDatecreated() {
        return datecreated;
    }

    public void setDatecreated(Timestamp datecreated) {
        this.datecreated = datecreated;
    }

}
