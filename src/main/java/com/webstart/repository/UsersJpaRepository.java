package com.webstart.repository;

import com.webstart.model.Users;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by George on 27/12/2015.
 */
public interface UsersJpaRepository extends JpaRepository<Users,Integer>{
    Users findByUsernameAndPassword(String username,String password);
    Users findByUsername(String username);
}
