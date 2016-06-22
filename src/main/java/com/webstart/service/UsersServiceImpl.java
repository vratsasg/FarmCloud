package com.webstart.service;

import com.webstart.model.Users;
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
        if(user != null)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public Users CreateUser(Users user)
    {
        usersJpaRepository.save(user);
        return user;
    }


    public JSONObject userByJson(Integer userid) {
        JSONObject jsonObject = new JSONObject();
        Users user;
        user = usersJpaRepository.findOne(userid);

        jsonObject.put("username", user.getUsername());

        return jsonObject;
    }

}
