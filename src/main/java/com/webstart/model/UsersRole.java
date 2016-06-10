package com.webstart.model;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by George on 27/12/2015.
 */
@Entity
@Table(name="user_role")
public class UsersRole {

    @Id
    @GeneratedValue

    private Integer user_role_id;

    @Column(length = 20)
    private String name;

    @Column(length = 80)
    private String description;


    @OneToMany(mappedBy ="usersRole",cascade = {CascadeType.ALL})
    private List<Users> users_list= new ArrayList<Users>();





    public Integer getUser_role_id() {
        return user_role_id;
    }

    public void setUser_role_id(Integer user_role_id) {
        this.user_role_id = user_role_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<Users> getUsers_list() {
        return users_list;
    }

    public void setUsers_list(List<Users> users_list) {
        this.users_list = users_list;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }







}
