package com.webstart.repository;

import com.webstart.model.ObservableProperty;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * Created by George on 21/6/2016.
 */
public interface ObservablePropertyJpaRepository extends JpaRepository<ObservableProperty, Integer> {
    List<ObservableProperty> findAll();
}
