package com.webstart.service;

import com.webstart.model.Notifications;
import com.webstart.model.UserProfile;
import com.webstart.model.Users;
import org.json.simple.JSONObject;

import java.security.Timestamp;
import java.util.List;

public interface UsersService {
    Users findUser(String username,String password);
    //
    JSONObject userByJson(Integer userid);
    //
    String getUserprofileuserByJson(Integer userid);
    //
    List<Notifications> getUserCounterNotifications(Integer userId);
    //
    UserProfile getUserProfile(Integer userid);
    //
    boolean saveUserProfiledata(UserProfile usprof);
    //
    void makeNotificationRead(int notificationid);
    //
    void createNewNotification(int userid, String message, int notificationType);
}
