package com.webstart.repository;

import com.webstart.model.Notifications;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface NotificationsJpaRepository extends JpaRepository<Notifications, Integer> {
    Notifications getByNotificationid(int notificationId);
    List<Notifications> getAllByUseridAndIsreaded(int userid, boolean isReaded);
}
