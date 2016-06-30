package com.webstart.repository;

import com.webstart.model.UserProfile;
import com.webstart.model.Users;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by DimDesktop on 26/6/2016.
 */
public interface UserProfileJpaRepository extends JpaRepository<UserProfile,Integer> {
    //UserProfile findByUser_id(int id);
}
