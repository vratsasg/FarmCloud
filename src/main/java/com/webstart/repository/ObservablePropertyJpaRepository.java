package com.webstart.repository;

import com.webstart.model.ObservableProperty;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * Created by George on 21/6/2016.
 */
public interface ObservablePropertyJpaRepository extends JpaRepository<ObservableProperty, Integer> {
    List<ObservableProperty> findAll();

    @Query("select obs.Identifier FROM ObservableProperty as obs order by obs.Identifier")
    List<String> findallObsProperty();
}
