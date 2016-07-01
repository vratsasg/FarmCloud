package com.webstart.service;

import com.webstart.model.UserProfile;
import com.webstart.model.Users;
import org.json.simple.JSONObject;

import java.util.List;

/**
 * Created by George on 27/12/2015.
 */
public interface UsersService {

    //List<Users> findAll();
    Users findUser(String username,String password);
    //Users findUser(int id);
    JSONObject userByJson(Integer userid);
    String getUserprofileuserByJson(Integer userid);

    boolean saveUserProfiledata(UserProfile usprof);

}
