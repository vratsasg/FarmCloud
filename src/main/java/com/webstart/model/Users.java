package com.webstart.model;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by George on 24/12/2015.
 */
@Entity
@Table(name="users")
public class Users {


    public Integer getUser_id() {
        return user_id;
    }

    public Users(String username, String password, String email, UsersRole usersRole, List<Featureofinterest> featureofinterestList) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.usersRole = usersRole;
        this.featureofinterestList = featureofinterestList;
    }

    public Users() {

    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;

    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public UsersRole getUsersRole() {
        return usersRole;
    }

    public void setUsersRole(UsersRole usersRole) {
        this.usersRole = usersRole;
    }

    public List<Featureofinterest> getFeatureofinterestList() {
        return featureofinterestList;
    }

    public void setFeatureofinterestList(List<Featureofinterest> featureofinterestList) {
        this.featureofinterestList = featureofinterestList;
    }

    @Id
    @GeneratedValue

    private Integer user_id;

    @Column(length = 20)

    private String username;


    @Column(length = 20)
    private String password;

    @Column(length = 30)
    private String email;


    @ManyToOne(fetch = FetchType.EAGER)

    @JoinColumn(name="user_role_id")
    private UsersRole usersRole;


    @OneToMany(fetch = FetchType.EAGER, mappedBy = "usersfeatures", cascade = {CascadeType.ALL})
    private List<Featureofinterest> featureofinterestList = new ArrayList<Featureofinterest>();













}
