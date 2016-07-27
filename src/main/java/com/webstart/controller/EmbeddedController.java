package com.webstart.controller;

import com.webstart.model.EmbeddedData;
import com.webstart.model.Featureofinterest;
import com.webstart.service.FeatureofInterestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Created by George on 22/5/2016.
 */
@RestController
public class EmbeddedController {

    @Autowired
    FeatureofInterestService featureofInterestService;


    @RequestMapping(value = "/embedded/", method = RequestMethod.POST)
    public ResponseEntity<Void> postSensor(@RequestBody EmbeddedData embeddedData) {

        String str = "1986-04-08 12:30:00";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime dateTime = LocalDateTime.parse(str, formatter);

        System.out.println(embeddedData.getZbAddress());

       // HttpHeaders headers = new HttpHeaders();
      //  headers.setLocation(ucBuilder.path("/embedded/{id}").buildAndExpand(endDev.getHumidity()).toUri());
        return new ResponseEntity<Void>(HttpStatus.CREATED);

    }


    @RequestMapping(value = "/getsetup", method = RequestMethod.GET)
    public ResponseEntity<String> getSetup(@RequestParam("identifier") String CordIdentifier) {

//        @RequestParam("identifier") String CordIdentifier

        String JsonResp = null;

        JsonResp = featureofInterestService.findFeatureByIdentifier(CordIdentifier);


        // HttpHeaders headers = new HttpHeaders();
        //  headers.setLocation(ucBuilder.path("/embedded/{id}").buildAndExpand(endDev.getHumidity()).toUri());
        return new ResponseEntity<String>(JsonResp, HttpStatus.OK);

    }




}
