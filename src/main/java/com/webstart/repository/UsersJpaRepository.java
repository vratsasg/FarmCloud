package com.webstart.repository;

import com.webstart.model.Notifications;
import com.webstart.model.UserProfile;
import com.webstart.model.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;


public interface UsersJpaRepository extends JpaRepository<Users, Integer> {
    Users findByUsernameAndPassword(String username, String password);

    Users findByUsername(String username);

    @Query("select new com.webstart.model.Notifications(pin.notifid ,pin.userid,pin.description,pin.readable ) from Users as us " +
            "inner join us.notificationsArrayList as pin " +
            "where us.user_id =:usid and pin.readable = false ")
    List<Notifications> getNotifByUser(@Param("usid") Integer user_id);

//    @Query("select us.notificationsArrayList.size from Users as us inner join us.notificationsArrayList where us.user_id =:usid")
//    Integer getNotifCounterByUser(@Param("usid") Integer user_id);


}

