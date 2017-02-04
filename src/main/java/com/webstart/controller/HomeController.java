package com.webstart.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.webstart.DTO.*;
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
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
    MeasureService measureservice;


    @RequestMapping(value = "/obsproperties", method = RequestMethod.GET)
    public ResponseEntity<String> getObsProperties() {
        JSONObject obj = new JSONObject();
        obj = observationProperyService.getAllObsPropeties();
        return new ResponseEntity<String>(obj.toJSONString(), HttpStatus.CREATED);
    }

    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public ResponseEntity<String> getProfile(HttpServletRequest request) {
        Users users = (Users) request.getSession().getAttribute("current_user");
        JSONObject obj = featureofInterestService.findCropInfo(users.getUser_id());
        return new ResponseEntity<String>(obj.toJSONString(), HttpStatus.OK);
    }

    @RequestMapping(value = "/firstPDev", method = RequestMethod.GET)
    public ResponseEntity<String> getFeatureEndDevices(HttpServletRequest request) {
        String jsonresult = null;

        try {
            Users users = (Users) request.getSession().getAttribute("current_user");
            List<FeatureidIdentifier> results = featureofInterestService.findByUserAndType(users.getUser_id(), 3L);
            ObjectMapper mapper = new ObjectMapper();
            jsonresult = mapper.writeValueAsString(results);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ResponseEntity<String>(jsonresult, HttpStatus.OK);
    }

    @RequestMapping(value = "/coordinator/stationcoords", method = RequestMethod.GET)
    public ResponseEntity<String> getStationCoords(HttpServletRequest request) {
        String jsonresult = null;

        try {
            Users users = (Users) request.getSession().getAttribute("current_user");
            List<FeatureidIdentifier> results = featureofInterestService.findByUserAndType(users.getUser_id(), 2L);
            jsonresult = featureofInterestService.findByFeatureofinterestid(results.get(0).getFeatureinterestid());
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ResponseEntity<String>(jsonresult, HttpStatus.OK);
    }

    @RequestMapping(value = "/charthome/{id}", method = RequestMethod.GET)
    public ResponseEntity<String> getChartByDevice(@PathVariable("id") String id) {
        JSONArray obj = new JSONArray();
        obj = measureservice.findDailyMeasure(id);
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

    @RequestMapping(value = "/watering/measures", params = {"mydevice", "dtstart", "dtend"}, method = RequestMethod.GET)
    public ResponseEntity<String> getMeasuresByObsProperty(@RequestParam("mydevice") String mydevice, @RequestParam("dtstart") String datetimestart, @RequestParam("dtend") String datetimeend, HttpServletRequest request) {
        JSONArray obj = new JSONArray();
        Users user = (Users) request.getSession().getAttribute("current_user");
        int userid = user.getUser_id();

        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String sentData = null;
        try {
            Date from = dateFormat.parse(datetimestart);
            Date to = dateFormat.parse(datetimeend);
            WateringMeasure wateringMeasure = observationProperyService.getWateringData(userid, mydevice, from, to);

            if (wateringMeasure == null) {
                sentData = "{\"unit\":\"\",\"measuredata\":[]}";
            } else {

                ObjectMapper mapper = new ObjectMapper();
                //Object to JSON in String
                sentData = mapper.writeValueAsString(wateringMeasure);
            }


        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return null;
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


    @RequestMapping(value = "/getLastMeasuresByDate", method = RequestMethod.GET)
    public
    @ResponseBody
    List<ObservationMeasure> getMeasuresByObsProperty(@RequestParam("identifier") String mydevice, HttpServletRequest request) {
        Users users = (Users) request.getSession().getAttribute("current_user");
        List<ObservationMeasure> sentData = new ArrayList<ObservationMeasure>();
        try {
            sentData = observationProperyService.getLastObservationbyIdentifier(users.getUser_id(), mydevice);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

        return sentData;
    }

    @RequestMapping(value = "/lastWateringMeasures", method = RequestMethod.GET)
    public
    @ResponseBody
    AutomaticWater getLastWateringMeasures(@RequestParam("identifier") String mydevice, HttpServletRequest request) {
        Users users = (Users) request.getSession().getAttribute("current_user");
        AutomaticWater sentData = null;

        try {
            sentData = observationProperyService.getLastWateringObsbyIdentifier(users.getUser_id(), mydevice);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

        return sentData;
    }

    @RequestMapping(value = "/setIrrigationDates", method = RequestMethod.POST)
    public ResponseEntity<String> setIrrigationDates(@RequestParam("identifier") String device, @RequestParam("dtfrom") String datefrom, @RequestParam("dtto") String dateto, HttpServletRequest request) {
        Users users = (Users) request.getSession().getAttribute("current_user");
        boolean sentData;

        try {
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date from = dateFormat.parse(datefrom);
            Date to = dateFormat.parse(dateto);

            AutomaticWater automaticWater = new AutomaticWater(from, to, new BigDecimal(0), device);
            measureservice.saveMeasure(automaticWater);
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
    public ResponseEntity<String> getStationMinMaxValues(HttpServletRequest request) {
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
    public
    @ResponseBody
    void saveWateringProfile(@RequestBody List<FeatureObsProp> featureObsPropList) {
        try {
            List<FeatureMinMaxValue> featureMinMaxValuesList = new ArrayList<FeatureMinMaxValue>();
            for (FeatureObsProp featureObsProp : featureObsPropList) {
                featureMinMaxValuesList.addAll(featureObsProp.getFeatureObsproplist());
            }
            observationProperyService.setObservationMinmaxValues(featureMinMaxValuesList);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/automaticwater/getdates", method = RequestMethod.GET)
    public
    @ResponseBody
    AutomaticWater getAutomaticWaterTimes(HttpServletRequest request, @RequestParam("identifier") String device) {
//        String jsonInString = null;
        AutomaticWater automaticWater = null;

        try {
            Users users = (Users) request.getSession().getAttribute("current_user");
            automaticWater = featureofInterestService.getAutomaticWater(users.getUser_id(), device);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

        return automaticWater;
    }

    @RequestMapping(value = "/automaticwater/save", method = RequestMethod.POST)
    public
    @ResponseBody
    void saveAutomacticWatering(HttpServletRequest request, @RequestBody AutomaticWater automaticWatering) {
        try {
            Users user = (Users) request.getSession().getAttribute("current_user");
            int userid = user.getUser_id();
            featureofInterestService.setAutomaticWateringTime(automaticWatering, userid);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/myprofile/save", method = RequestMethod.POST)
    public
    @ResponseBody
    void postSensor(@RequestBody List<FeatureSensor> featureSensorList) {
        try {
            for (final FeatureSensor featureSensor : featureSensorList) {
                featureofInterestService.setFeatureOfInterestData(featureSensor);
            }

        } catch (Exception exc) {
            exc.printStackTrace();
        }
    }


}
