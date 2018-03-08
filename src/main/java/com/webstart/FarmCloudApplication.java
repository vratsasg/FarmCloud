package com.webstart;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.system.ApplicationPidFileWriter;

@SpringBootApplication
public class FarmCloudApplication {
    public static void main(String[] args){
        SpringApplication farmCloudApp = new SpringApplication(FarmCloudApplication.class);
        farmCloudApp.addListeners(new ApplicationPidFileWriter());
        farmCloudApp.run(args);
    }
}
