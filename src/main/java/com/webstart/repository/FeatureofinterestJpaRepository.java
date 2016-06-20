package com.webstart.repository;

import com.webstart.model.Featureofinterest;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface FeatureofinterestJpaRepository extends JpaRepository<Featureofinterest, Integer> {

    List<Featureofinterest> findByUserid(int id);
}
