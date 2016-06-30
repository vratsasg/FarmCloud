package com.webstart.controller;

import com.webstart.model.Crop;
import com.webstart.model.Users;

import com.webstart.service.FeatureofInterestService;
import com.webstart.service.MeasureService;
import com.webstart.service.ObservationProperyService;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;


@Controller
public class HomeController {

    @Autowired
    FeatureofInterestService featureofInterestService;

    @RequestMapping(value = "/ffffff", method = RequestMethod.POST)
    public ResponseEntity<Void> createcrop(@RequestBody Crop crop) {

        crop.getCropname();

        featureofInterestService.addCrop(crop);

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

        return new ResponseEntity<Void>(HttpStatus.CREATED);
    }

    @Autowired
    ObservationProperyService observationProperyService;

    @RequestMapping(value = "/getobsproperties", method = RequestMethod.GET)
    public ResponseEntity<String> getObsProperties() {

        JSONObject obj = new JSONObject();

        obj = observationProperyService.getAllObsPropeties();


        return new ResponseEntity<String>(obj.toJSONString(), HttpStatus.CREATED);
    }

    @RequestMapping(value = "/firstPDev", method = RequestMethod.GET)
    public ResponseEntity<String> getFeatureEndDevices(HttpServletRequest request) {
        Users users = new Users();

        JSONObject obj = new JSONObject();
        users = (Users) request.getSession().getAttribute("current_user");

        obj = featureofInterestService.findByUserAndType(users.getUser_id());

        System.out.println(obj.toJSONString());

        return new ResponseEntity<String>(obj.toJSONString(), HttpStatus.OK);


    }


    @Autowired
    MeasureService measurement;

    @RequestMapping(value = "/charthome/{id}", method = RequestMethod.GET)
    public ResponseEntity<String> getChartByDevice(@PathVariable("id") String id, HttpServletRequest request) {
        //   Users users=new Users();
        String temp = "40E7CC39";
        JSONArray obj = new JSONArray();
        //  users=(Users)request.getSession().getAttribute("current_user");

        obj = measurement.findDailyMeasure(id);


        System.out.println(obj.toJSONString());

        return new ResponseEntity<String>(obj.toJSONString(), HttpStatus.OK);


    }

}
