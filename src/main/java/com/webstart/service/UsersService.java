package com.webstart.service;

import com.webstart.model.Users;

import java.util.List;

/**
 * Created by George on 27/12/2015.
 */
public interface UsersService {

    public List<Users> findAll();

    Users findUser(String username,String password);
    Users findUser(int id);
}
