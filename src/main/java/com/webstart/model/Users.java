package com.webstart.model;

import javax.persistence.*;

/**
 * Created by George on 24/12/2015.
 */
@Entity
@Table(name="users")
public class Users {


    @Id
    @GeneratedValue
    private Integer user_id;

    @Column(length = 20)

    private String username;



    @Column(length = 20)
    private String password;

    @Column(length =30)
    private String email;

    public UsersRole getUsersRole() {
        return usersRole;
    }

    public void setUsersRole(UsersRole usersRole) {
        this.usersRole = usersRole;
    }

    public Integer getUser_id() {
        return user_id;
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

    @ManyToOne(fetch = FetchType.LAZY)

    @JoinColumn(name="user_role_id")
    private UsersRole usersRole;
















}
