package com.webstart.repository;

import com.webstart.model.UserProfile;
import com.webstart.model.Users;
import org.springframework.data.jpa.repository.JpaRepository;


public interface UsersJpaRepository extends JpaRepository<Users,Integer>{
    Users findByUsernameAndPassword(String username,String password);
    Users findByUsername(String username);
}
