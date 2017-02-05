package com.webstart.service.jms;

import org.springframework.jms.annotation.JmsListener;
import org.springframework.stereotype.Component;

@Component
public class JmsConsumer {
    @JmsListener(destination = "NotificationsQueue")
    public void receiveMessage(String message) {
        System.out.println("Received <" + message + ">");
    }
}
