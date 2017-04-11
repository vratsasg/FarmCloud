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

    @Query("select notification " +
            "from Notifications as notification " +
            "where notification.userid =:usid AND notification.isreaded = false")
    List<Notifications> getNotifByUser(@Param("usid") Integer user_id);

}

