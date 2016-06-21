package com.webstart.controller;

import com.webstart.model.Crop;
import com.webstart.service.FeatureofInterest;
import com.webstart.service.ObservationProperyService;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class HomeController {

   @Autowired
   FeatureofInterest featureofInterest;

    @RequestMapping(value = "/ffffff", method = RequestMethod.POST)
    public ResponseEntity<Void> createcrop(@RequestBody Crop crop) {

        crop.getCropname();

        featureofInterest.addCrop(crop);

        System.out.println("oooooooo");
        /*System.out.println("Creating User " + user.getUsername());

        if (userService.isUserExist(user)) {
            System.out.println("A User with name " + user.getUsername() + " already exist");
            return new ResponseEntity<Void>(HttpStatus.CONFLICT);
        }

        userService.saveUser(user);

        HttpHeaders headers = new HttpHeaders();
        headers.setLocation(ucBuilder.path("/user/{id}").buildAndExpand(user.getId()).toUri());
        return new ResponseEntity<Void>(headers, HttpStatus.CREATED);*/

        return new ResponseEntity<Void>( HttpStatus.CREATED);
    }

    @Autowired
    ObservationProperyService observationProperyService;

    @RequestMapping(value = "/getobsproperties", method = RequestMethod.GET)
    public ResponseEntity<String> getObsProperties() {

        JSONObject obj = new JSONObject();

        obj = observationProperyService.getAllObsPropeties();


        return new ResponseEntity<String>(obj.toJSONString(), HttpStatus.CREATED);
    }





}
