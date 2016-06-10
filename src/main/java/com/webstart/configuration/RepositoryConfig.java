package com.webstart.configuration;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

/**
 * Created by George on 23/12/2015.
 */

@Configuration
@EnableJpaRepositories(basePackages="com.webstart.repository")
public class RepositoryConfig {
}
