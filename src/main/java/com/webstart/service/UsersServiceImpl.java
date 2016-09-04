package com.webstart.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.webstart.model.UserProfile;
import com.webstart.model.Users;
import com.webstart.repository.UserProfileJpaRepository;
import com.webstart.repository.UsersJpaRepository;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by George on 27/12/2015.
 */

@Service("usersService")
@Transactional
public class UsersServiceImpl implements UsersService{

    @Autowired
    private UsersJpaRepository usersJpaRepository;

    @Autowired
    private UserProfileJpaRepository userProfileJpaRepository;

    public List<Users> findAll(){
        return usersJpaRepository.findAll();
    }

    public Users findUser(int userid){
        Users user;
        user= usersJpaRepository.findOne(userid);
        return user;
    }

    public Users findUser(String username,String password){
        Users user;
        user= usersJpaRepository.findByUsernameAndPassword(username,password);
        return user;
    }

    public boolean CheckUserExists(String username)
    {
        Users user;
        user = usersJpaRepository.findByUsername(username);
        return user != null ? true : false;
    }

    public Users CreateUser(Users user)
    {
        usersJpaRepository.save(user);
        return user;
    }

    public UserProfile getUserProfileById(int id){
        UserProfile userprofile = userProfileJpaRepository.findOne(id);
        return userprofile;
    }


    public JSONObject userByJson(Integer userid) {
        JSONObject jsonObject = new JSONObject();
        Users user;
        user = usersJpaRepository.findOne(userid);

        jsonObject.put("username", user.getUsername());

        return jsonObject;
    }



    public String getUserprofileuserByJson(Integer userid) {
        //JSONObject jsonObject = new JSONObject();
        //Users user = usersJpaRepository.findOne(userid);

        ObjectMapper mapper = new ObjectMapper();

        //Object to JSON in String
        String jsonInString = null;
        UserProfile userprofile = userProfileJpaRepository.findOne(userid);
        try {
            jsonInString = mapper.writeValueAsString(userprofile);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

        return jsonInString;
    }

    public boolean saveUserProfiledata(UserProfile usprof) {
        try {
            userProfileJpaRepository.save(usprof);
        } catch (Exception exc) {
            exc.printStackTrace();
            return false;
        }

        return true;
    }



}
