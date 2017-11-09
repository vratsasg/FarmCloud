package com.webstart.repository;

import com.webstart.model.UserProfile;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserProfileJpaRepository extends JpaRepository<UserProfile,Integer> {

//    @Query("select new com.webstart.model.UserProfile(up.userId, up.firstname, up.address, up.fathersname, up.lastname, up.addressnum, up.zipcode, up.telephone, up.mobile, up.dateofbirth, null) " +
//            "from UserProfile as up " +
//            "WHERE up.userId = :userid")
//    List<UserProfile> getProfileByUsrerId(@Param("userid") int userid);

}
