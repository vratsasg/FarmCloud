package com.webstart.controller;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.webstart.DTO.FeatureMinMaxValue;
import com.webstart.DTO.FeatureObsProp;
import com.webstart.DTO.FeatureidIdentifier;
import com.webstart.DTO.ObservableMeasure;
import com.webstart.model.UserProfile;
import com.webstart.model.Users;
import com.webstart.service.*;
import jdk.nashorn.internal.runtime.ParserException;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

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


    @RequestMapping(value = "/obsproperties", method = RequestMethod.GET)
    public ResponseEntity<String> getObsProperties() {
        JSONObject obj = new JSONObject();
        obj = observationProperyService.getAllObsPropeties();
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

    @RequestMapping(value = "/coordinator/stationcoords/{id}", method = RequestMethod.GET)
    public ResponseEntity<String> getStationCoords(@PathVariable("id") String id, HttpServletRequest request) {
        String stationcoords = featureofInterestService.findByFeatureofinterestid(Integer.parseInt(id));
        return new ResponseEntity<String>(stationcoords, HttpStatus.OK);
    }

    @RequestMapping(value = "/charthome/{id}", method = RequestMethod.GET)
    public ResponseEntity<String> getChartByDevice(@PathVariable("id") String id) {
        JSONArray obj = new JSONArray();
        obj = measurement.findDailyMeasure(id);
        return new ResponseEntity<String>(obj.toJSONString(), HttpStatus.OK);
    }

    @RequestMapping(value = "/totalMeasuresCounter", params = {"id", "mydevice", "dtstart", "dtend"}, method = RequestMethod.GET)
    public ResponseEntity<Long> getTotalMeasuresCounter(@RequestParam("id") Long id, @RequestParam("mydevice") String mydevice, @RequestParam("dtstart") String datetimestart, @RequestParam("dtend") String datetimeend, HttpServletRequest request) {
        Users users = (Users) request.getSession().getAttribute("current_user");
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Long sentData = 0L;

        try {
            Date from = dateFormat.parse(datetimestart);
            Date to = dateFormat.parse(datetimeend);
            sentData = observationProperyService.getObservationsCounter(id, users.getUser_id(), mydevice, from, to);
        } catch (ParserException parseExc) {
            parseExc.printStackTrace();
            new ResponseEntity<Long>(sentData, HttpStatus.EXPECTATION_FAILED);
        } catch (Exception e) {
            e.printStackTrace();
            new ResponseEntity<Long>(sentData, HttpStatus.EXPECTATION_FAILED);
        }

        return new ResponseEntity<Long>(sentData, HttpStatus.OK);
    }

    @RequestMapping(value = "/getObspMeasures", params = {"id", "mydevice", "dtstart", "dtend"}, method = RequestMethod.GET)
    public ResponseEntity<String> getMeasuresByObsProperty(@RequestParam("id") Long id, @RequestParam("mydevice") String mydevice, @RequestParam("dtstart") String datetimestart, @RequestParam("dtend") String datetimeend, HttpServletRequest request) {
        JSONArray obj = new JSONArray();
        Users users = (Users) request.getSession().getAttribute("current_user");

        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String sentData = null;
        try {
            Date from = dateFormat.parse(datetimestart);
            Date to = dateFormat.parse(datetimeend);
            sentData = observationProperyService.getObservationsData(id, users.getUser_id(), mydevice, from, to);

            if (sentData == null) {
                sentData = "{\"unit\":\"\",\"measuredata\":[]}";
            }

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

        return new ResponseEntity<String>(sentData, HttpStatus.OK);
    }

    @RequestMapping(value = "/getLastMeasureDate", method = RequestMethod.GET)
    public ResponseEntity<String> getMeasuresByObsProperty(HttpServletRequest request) {
        JSONArray obj = new JSONArray();
        Users users = (Users) request.getSession().getAttribute("current_user");

        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String sentData = null;
        try {
            sentData = observationProperyService.getLastObservationsDate(users.getUser_id());
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

        return new ResponseEntity<String>(sentData, HttpStatus.OK);

    }

    //identifier
    @RequestMapping(value = "/getLastMeasuresByDate", method = RequestMethod.GET)
    public ResponseEntity<String> getMeasuresByObsProperty(@RequestParam("identifier") String mydevice, HttpServletRequest request) {
        Users users = (Users) request.getSession().getAttribute("current_user");

        String sentData = null;
        try {
            sentData = observationProperyService.getLastObservationbyIdentifier(users.getUser_id(), mydevice);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

        return new ResponseEntity<String>(sentData, HttpStatus.OK);
    }

    @RequestMapping(value = "/setIrrigationDates", method = RequestMethod.POST)
    public ResponseEntity<String> setIrrigationDates(@RequestParam("identifier") String device, @RequestParam("dtfrom") String datefrom, @RequestParam("dtto") String dateto, HttpServletRequest request) {
        Users users = (Users) request.getSession().getAttribute("current_user");
        boolean sentData;

        try {
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date from = dateFormat.parse(datefrom);
            Date to = dateFormat.parse(dateto);

            sentData = featureofInterestService.setDeviceIrrigaDate(users.getUser_id(), device, from, to);
            if (!sentData)
                return new ResponseEntity<String>("false", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("false", HttpStatus.EXPECTATION_FAILED);
        }

        return new ResponseEntity<String>("true", HttpStatus.OK);
    }

    @RequestMapping(value = "/wateringprofile/minmax", method = RequestMethod.GET)
    public ResponseEntity<String> getStationCoords(HttpServletRequest request) {
        String jsonInString = null;

        try {
            Users users = (Users) request.getSession().getAttribute("current_user");
            jsonInString = featureofInterestService.findMinMaxbyUserId(users.getUser_id());
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("false", HttpStatus.EXPECTATION_FAILED);
        }

        return new ResponseEntity<String>(jsonInString, HttpStatus.OK);
    }

    @RequestMapping(value = "/wateringprofile/saveminmax", method = RequestMethod.POST)
    public ResponseEntity<String> saveWateringProfile(@RequestParam(("jsonval")) String jsonvalue, HttpServletRequest httpServletRequest) {
        Users user = (Users) httpServletRequest.getSession().getAttribute("current_user");

        try {
            ObjectMapper mapper = new ObjectMapper();
            List<FeatureObsProp> myObjects = mapper.readValue(jsonvalue, new TypeReference<List<FeatureObsProp>>() {
            });
            List<FeatureMinMaxValue> featureMinMaxValuesList = new ArrayList<FeatureMinMaxValue>();
            for (FeatureObsProp featureObsProp : myObjects) {
                featureMinMaxValuesList.addAll(featureObsProp.getFeatureObsproplist());
            }
            observationProperyService.setObservationMinmaxValues(featureMinMaxValuesList);
        } catch (IOException exc) {
            exc.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("false", HttpStatus.NOT_IMPLEMENTED);
        }

        return new ResponseEntity<String>("true", HttpStatus.OK);
    }




}
