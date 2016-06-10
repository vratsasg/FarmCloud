package com.webstart.configuration;

/**
 * Created by George on 23/12/2015.
 */

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;

import javax.sql.DataSource;
import java.util.Collections;

@Configuration
@PropertySource("classpath:hibernate.properties")
public class JpaConfig {

    @Autowired private Environment env;
    @Autowired private DataSource dataSource;

    @Bean
    public LocalContainerEntityManagerFactoryBean entityManagerFactory() {

        HibernateJpaVendorAdapter hibernateJpa = new HibernateJpaVendorAdapter();
        hibernateJpa.setDatabasePlatform(env.getProperty("hibernate.dialect"));
        hibernateJpa.setShowSql(env.getProperty("hibernate.show_sql", Boolean.class));

        LocalContainerEntityManagerFactoryBean emf = new LocalContainerEntityManagerFactoryBean();

       /* try {
            Connection conn =dataSource.getConnection();
            Statement stmt = conn.createStatement();
           stmt.execute("INSERT INTO public.users(\n" +
                   "            username, password, email, user_role_id, user_id)\n" +
                   "    VALUES ('zeo', '444', 'ant', '2', '6');\n");
        } catch (SQLException e) {
            e.printStackTrace();
        }*/

        emf.setDataSource(dataSource);
        emf.setPackagesToScan("com.webstart.model");
        emf.setJpaVendorAdapter(hibernateJpa);
        emf.setJpaPropertyMap(Collections.singletonMap("javax.persistence.validation.mode", "none"));
        return emf;
    }

    @Bean
    public JpaTransactionManager transactionManager() {
        JpaTransactionManager txnMgr = new JpaTransactionManager();
        txnMgr.setEntityManagerFactory(entityManagerFactory().getObject());
        return txnMgr;
    }

}