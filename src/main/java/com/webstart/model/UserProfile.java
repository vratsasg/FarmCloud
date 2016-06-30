
package com.webstart.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.annotations.Parameter;

@Entity
@Table(name="userprofile")
public class UserProfile {
    @JsonIgnore
    @Id
    @Column(name = "user_id", unique=true, nullable=false)
    @GeneratedValue(generator="gen")
    @GenericGenerator(name="gen", strategy="foreign", parameters=@Parameter(name="property", value="users"))
    private Integer userId;

    @Column(length = 20, nullable=false)
    private String firstname;

    @Column(length = 20, nullable=false)
    private String lastname;

    @Column(length = 20, nullable=false)
    private String fathersname;

    @Column(length = 50)
    private String address;

    @Column(length = 10)
    private String addressnum;

    @Column(length = 10)
    private String zipcode;

    @Column(length = 15)
    private String telephone;

    @Column(length = 15)
    private String mobile;

    private LocalDateTime dateofbirth;

    //    @OneToOne
//    @JoinColumn(name="user_id")
    @OneToOne(cascade = CascadeType.ALL)
    @PrimaryKeyJoinColumn
    @JsonIgnore
    private Users user;

    public UserProfile() {
    }

    public UserProfile(String firstname, String address, String fathersname, String lastname, String addressnum, String zipcode, String telephone, String mobile, LocalDateTime dateofbirth, Users employeeDetail, Users user) {
        this.firstname = firstname;
        this.address = address;
        this.fathersname = fathersname;
        this.lastname = lastname;
        this.addressnum = addressnum;
        this.zipcode = zipcode;
        this.telephone = telephone;
        this.mobile = mobile;
        this.dateofbirth = dateofbirth;
        this.user = user;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getFathersname() {
        return fathersname;
    }

    public void setFathersname(String fathersname) {
        this.fathersname = fathersname;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getAddressnum() {
        return addressnum;
    }

    public void setAddressnum(String addressnum) {
        this.addressnum = addressnum;
    }

    public String getZipcode() {
        return zipcode;
    }

    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public LocalDateTime getDateofbirth() {
        return dateofbirth;
    }

    public void setDateofbirth(LocalDateTime dateofbirth) {
        this.dateofbirth = dateofbirth;
    }

    public Users getUser() {
        return user;
    }

    public void setUser(Users user) {
        this.user = user;
    }
}