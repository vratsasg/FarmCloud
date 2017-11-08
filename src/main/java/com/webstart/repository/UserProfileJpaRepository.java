package com.webstart.repository;

import com.webstart.model.UserProfile;
import com.webstart.model.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;


public interface UserProfileJpaRepository extends JpaRepository<UserProfile,Integer> {
    //UserProfile findByUser_id(int id);

//    @Query("select new com.webstart.model.UserProfile(up.userId, up.firstname, up.address, up.fathersname, up.lastname, up.addressnum, up.zipcode, up.telephone, up.mobile, up.dateofbirth, null) " +
//            "from UserProfile as up " +
//            "WHERE up.userId = :userid")
//    List<UserProfile> getProfileByUsrerId(@Param("userid") int userid);

}
