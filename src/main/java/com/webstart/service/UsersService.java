package com.webstart.service;

import com.webstart.model.Notifications;
import com.webstart.model.UserProfile;
import com.webstart.model.Users;
import org.json.simple.JSONObject;

import java.security.Timestamp;
import java.util.List;

/**
 * Created by George on 27/12/2015.
 */
public interface UsersService {
    Users findUser(String username,String password);
    JSONObject userByJson(Integer userid);
    String getUserprofileuserByJson(Integer userid);

    UserProfile getUserProfile(Integer userid);
    boolean saveUserProfiledata(UserProfile usprof);
    void createNewNotification(int userid, String message);

    List<Notifications> getUserCounterNotifications(Integer userId);

}
