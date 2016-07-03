package com.webstart.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.webstart.model.Crop;
import com.webstart.model.UserProfile;
import com.webstart.model.Users;
import com.webstart.service.FeatureofInterestService;
import com.webstart.service.MeasureService;
import com.webstart.service.ObservationProperyService;
import com.webstart.service.UsersService;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;


@Controller
public class HomeController {

    @Autowired
    FeatureofInterestService featureofInterestService;
    @Autowired
    UsersService usersService;
    @Autowired
    ObservationProperyService observationProperyService;
    @Autowired
    MeasureService measurement;

    @RequestMapping(value = "/ffffff", method = RequestMethod.POST)
    public ResponseEntity<Void> createcrop(@RequestBody Crop crop) {

        crop.getCropname();

        featureofInterestService.addCrop(crop);

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



    @RequestMapping(value = "/getobsproperties", method = RequestMethod.GET)
    public ResponseEntity<String> getObsProperties() {

        JSONObject obj = new JSONObject();

        obj = observationProperyService.getAllObsPropeties();

        System.out.println(obj.toJSONString());


        return new ResponseEntity<String>(obj.toJSONString(), HttpStatus.CREATED);
    }

    @RequestMapping(value = "/userprofile", method = RequestMethod.GET)
    public ResponseEntity<String> getUserProfile(HttpServletRequest httpServletRequest) {
        Users user = new Users();
        user = (Users) httpServletRequest.getSession().getAttribute("current_user");

        UserProfile userprofile = new UserProfile();
        String obj = usersService.getUserprofileuserByJson(user.getUser_id());

        return new ResponseEntity<String>(obj, HttpStatus.OK);
    }

    @RequestMapping(value = "/userprofile", method = RequestMethod.POST)
    public ResponseEntity<Boolean> saveUserProfile(HttpServletRequest httpServletRequest, @RequestBody UserProfile userprofile) {
        Users user = new Users();
        user = (Users) httpServletRequest.getSession().getAttribute("current_user");
        boolean isDone = usersService.saveUserProfiledata(userprofile);

        return new ResponseEntity<Boolean>(isDone, HttpStatus.CREATED);
    }
    
    
    

    @RequestMapping(value = "/firstPDev", method = RequestMethod.GET)
    public ResponseEntity<String> getFeatureEndDevices(HttpServletRequest request) {
        Users users = new Users();
        JSONObject obj = new JSONObject();
        users = (Users) request.getSession().getAttribute("current_user");

        obj = featureofInterestService.findByUserAndType(users.getUser_id());
        return new ResponseEntity<String>(obj.toJSONString(), HttpStatus.OK);
    }

    @RequestMapping(value = "/getStationCoords/{id}", method = RequestMethod.GET)
    public ResponseEntity<String> getStationCoords(@PathVariable("id") String id, HttpServletRequest request) {
        String stationcoords = featureofInterestService.findByFeatureofinterestid(Integer.parseInt(id));
        return new ResponseEntity<String>(stationcoords, HttpStatus.OK);
    }




    @RequestMapping(value = "/charthome/{id}", method = RequestMethod.GET)
    public ResponseEntity<String> getChartByDevice(@PathVariable("id") String id) {
        String temp = "40E7CC39";
        JSONArray obj = new JSONArray();

        obj = measurement.findDailyMeasure(id);
        System.out.println(obj.toJSONString());
        return new ResponseEntity<String>(obj.toJSONString(), HttpStatus.OK);
    }

    @RequestMapping(value = "/getObspMeasures", params = {"id", "mydevice"}, method = RequestMethod.GET)
    public ResponseEntity<String> getMeasuresByObsProperty(@RequestParam("id") Long id, @RequestParam("mydevice") String mydevice, HttpServletRequest request) {
        JSONArray obj = new JSONArray();
        Users users = (Users) request.getSession().getAttribute("current_user");

        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        String sentData = null;
        try {
            Date from = dateFormat.parse("2015-05-21 00:00:00");
            Date to = dateFormat.parse("2015-05-21 23:59:59");
            sentData = observationProperyService.getObservationsData(id, users.getUser_id(), mydevice, from, to);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }

        return new ResponseEntity<String>(sentData, HttpStatus.OK);
    }


}
