package com.webstart.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.webstart.Enums.StatusTimeConverterEnum;
import com.webstart.Helpers.HelperCls;
import com.webstart.model.Featureofinterest;
import com.webstart.model.Notifications;
import com.webstart.model.UserProfile;
import com.webstart.model.Users;
import com.webstart.repository.FeatureofinterestJpaRepository;
import com.webstart.repository.NotificationsJpaRepository;
import com.webstart.repository.UserProfileJpaRepository;
import com.webstart.repository.UsersJpaRepository;
import org.joda.time.DateTime;
import org.joda.time.DateTimeZone;
import org.joda.time.Instant;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

@Service("usersService")
@Transactional
public class UsersServiceImpl implements UsersService{

    @Autowired
    private UsersJpaRepository usersJpaRepository;
    @Autowired
    private UserProfileJpaRepository userProfileJpaRepository;
    @Autowired
    private NotificationsJpaRepository notificationsJpaRepository;
    @Autowired
    FeatureofinterestJpaRepository featureofinterestJpaRepository;
    Logger logger = LoggerFactory.getLogger(this.getClass());


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

    public UserProfile getUserProfile(Integer userid) {
        UserProfile userprofile = userProfileJpaRepository.findOne(userid);
        return userprofile;
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

    public void makeNotificationRead(int notificationid) {
        try {
            Notifications notification = this.notificationsJpaRepository.getByNotificationid(notificationid);
            //
            notification.setIsreaded(true);
            this.notificationsJpaRepository.save(notification);
        } catch(Exception e){
           e.printStackTrace();
        }
    }

    public void createNewNotification(int userid, String message, int notificationType) {
        try {
            //Convert time to UTC
            DateTimeZone tz = DateTimeZone.getDefault();
            int offset = tz.getOffset(new Instant());
            DateTime utcdt = new DateTime(DateTimeZone.UTC);
            Timestamp ts = new Timestamp(utcdt.getMillis() - offset);
            //
            Notifications notification = new Notifications(userid, message, false, ts, notificationType);
            //
            notificationsJpaRepository.save(notification);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Notifications> getUserCounterNotifications(Integer userId) {
        List<Notifications> notifications = null;

        try {
            notifications = this.notificationsJpaRepository.getAllByUseridAndIsreaded(userId, false);
            //
            List<Featureofinterest> enddevices = this.featureofinterestJpaRepository.getAllByUseridAndFeatureofinteresttypeid(userId, 3L);
            int offset = DateTimeZone.getDefault().getOffset(new Instant());
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            DateTimeFormatter dtfInput = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss");
            //
            //Convert Datetime created to user timezone
            for (Notifications notification : notifications) {
                HelperCls.ConvertToDateTime convertable = new HelperCls.ConvertToDateTime();
                DateTime dt = convertable.GetUTCDateTime(sdf.format(notification.getDatecreated()), dtfInput, enddevices.get(0).getTimezone(), StatusTimeConverterEnum.TO_TIMEZONE);
                Timestamp ts = new Timestamp(dt.getMillis() - offset);
                notification.setDatecreated(ts);
                //
                logger.debug("params: dt={}, ts={}", dt, ts);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            return notifications;
        }
    }

}
