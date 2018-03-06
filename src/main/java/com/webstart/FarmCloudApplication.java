package com.webstart;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class FarmCloudApplication {
    public static void main(String[] args){
        SpringApplication farmCloudApp = new SpringApplication(FarmCloudApplication.class);
        farmCloudApp.run(args);
    }
}
