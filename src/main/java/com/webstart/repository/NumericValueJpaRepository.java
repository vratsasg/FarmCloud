package com.webstart.repository;

import com.webstart.model.NumericValue;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by George on 3/8/2016.
 */
public interface NumericValueJpaRepository extends JpaRepository<NumericValue, Long> {
}
