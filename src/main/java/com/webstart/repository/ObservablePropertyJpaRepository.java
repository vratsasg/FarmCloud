package com.webstart.repository;

import com.webstart.model.ObservableProperty;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import com.webstart.Enums.MeasurementTypeEnum;
import java.util.List;

public interface ObservablePropertyJpaRepository extends JpaRepository<ObservableProperty, Integer> {
    List<ObservableProperty> findAll();

    @Query("select new com.webstart.model.ObservableProperty(obs.ObservablePropertyId, obs.HibernateDiscriminator, obs.Identifier, obs.Description) " +
            "FROM ObservableProperty as obs " +
            "WHERE obs.ObservablePropertyId <> 5 " +
            "order by obs.Description")
    List<ObservableProperty> findAllExceptWatering();

    @Query("select obs.Identifier FROM ObservableProperty as obs order by obs.Identifier")
    List<String> findallObsProperty();
}
