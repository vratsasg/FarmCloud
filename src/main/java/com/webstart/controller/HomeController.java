package com.webstart.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.webstart.DTO.*;
import com.webstart.Enums.FeatureTypeEnum;
import com.webstart.Enums.StatusTimeConverterEnum;
import com.webstart.Helpers.HelperCls;
import com.webstart.model.Featureofinterest;
import com.webstart.model.Users;
import com.webstart.service.*;
import jdk.nashorn.internal.runtime.ParserException;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class HomeController {

    @Autowired
    FeatureofInterestService featureofInterestService;
    @Autowired
    ObservationProperyService observationProperyService;
    @Autowired
    MeasureService measureservice;


    @RequestMapping(value = "/observableproperties", method = RequestMethod.GET)
    public ResponseEntity<String> getObsProperties(HttpServletRequest request) {
        JSONObject obj = new JSONObject();
        Users users = (Users) request.getSession().getAttribute("current_user");
        if(users == null){
            return new ResponseEntity(HttpStatus.UNAUTHORIZED);
        }

        obj = observationProperyService.getAllObsPropeties();
        return new ResponseEntity<String>(obj.toJSONString(), HttpStatus.CREATED);
    }

    @RequestMapping(value = "/features/profile", method = RequestMethod.GET)
    public ResponseEntity<String> getProfile(HttpServletRequest request) {
        Users users = (Users) request.getSession().getAttribute("current_user");
        if(users == null){
            return new ResponseEntity(HttpStatus.UNAUTHORIZED);
        }

        JSONObject obj = featureofInterestService.findCropInfo(users.getUser_id());

        return new ResponseEntity<String>(obj.toJSONString(), HttpStatus.OK);
    }

    @RequestMapping(value = "/features/profile", method = RequestMethod.POST)
    public @ResponseBody HttpStatus postSensor(@RequestBody List<FeatureSensor> featureSensorList, HttpServletRequest request) {
        Users users = (Users) request.getSession().getAttribute("current_user");
        if(users == null){
            return HttpStatus.UNAUTHORIZED;
        }

        try {
            for (final FeatureSensor featureSensor : featureSensorList) {
                featureofInterestService.setFeatureOfInterestData(featureSensor);
            }
        } catch (Exception exc) {
            exc.printStackTrace();
            return HttpStatus.INTERNAL_SERVER_ERROR;
        }
        return HttpStatus.OK;
    }

    @RequestMapping(value = "/enddevices", method = RequestMethod.GET)
    public ResponseEntity<String> getFeatureEndDevices(HttpServletRequest request) {
        String jsonresult = null;

        try {
            Users users = (Users) request.getSession().getAttribute("current_user");
            List<FeatureidIdentifier> results = featureofInterestService.findByUserAndType(users.getUser_id(), FeatureTypeEnum.END_DEVICE.getValue());
            ObjectMapper mapper = new ObjectMapper();
            jsonresult = mapper.writeValueAsString(results);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ResponseEntity<String>(jsonresult, HttpStatus.OK);
    }

    @RequestMapping(value = "/station/coords", method = RequestMethod.GET)
    public ResponseEntity<String> getStationCoords(HttpServletRequest request) {
        String jsonresult = null;

        try {
            Users users = (Users) request.getSession().getAttribute("current_user");
            List<FeatureidIdentifier> results = featureofInterestService.findByUserAndType(users.getUser_id(), FeatureTypeEnum.STATION.getValue());
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

    @RequestMapping(value = "/{mydevice}/{observablePropertyId}/measures/counter", params = {"dtstart", "dtend"}, method = RequestMethod.GET)
    public ResponseEntity<Long> getTotalMeasuresCounter(@PathVariable("observablePropertyId") Long observablePropertyId, @PathVariable("mydevice") String mydevice, @RequestParam("dtstart") String datetimestart, @RequestParam("dtend") String datetimeend, HttpServletRequest request) {
        Users users = (Users) request.getSession().getAttribute("current_user");
        if(users == null) {
            return new ResponseEntity(HttpStatus.UNAUTHORIZED);
        }
        Long sentData = 0L;

        try {
            Featureofinterest featureofinterest = featureofInterestService.getFeatureofinterestByIdentifier(mydevice);
            DateTimeFormatter dtfInput = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss");
            HelperCls.ConvertToDateTime convertable = new HelperCls.ConvertToDateTime();
            Date from = convertable.GetUTCDateTime(datetimestart, dtfInput, featureofinterest.getTimezone(), StatusTimeConverterEnum.TO_UTC).toDate();
            Date to = convertable.GetUTCDateTime(datetimeend, dtfInput, featureofinterest.getTimezone(), StatusTimeConverterEnum.TO_UTC).toDate();
            sentData = observationProperyService.getObservationsCounter(observablePropertyId, users.getUser_id(), mydevice, from, to);
        } catch (ParserException parseExc) {
            parseExc.printStackTrace();
            new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
        } catch (Exception e) {
            e.printStackTrace();
            new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
        }

        return new ResponseEntity<Long>(sentData, HttpStatus.OK);
    }

    @RequestMapping(value = "/{mydevice}/{observablePropertyId}/measures", params = {"dtstart", "dtend"}, method = RequestMethod.GET)
    public ResponseEntity<String> getMeasuresByObsProperty(@PathVariable("observablePropertyId") Long observablePropertyId, @PathVariable("mydevice") String mydevice, @RequestParam("dtstart") String datetimestart, @RequestParam("dtend") String datetimeend, HttpServletRequest request) {
        Users users = (Users) request.getSession().getAttribute("current_user");
        if(users == null) {
            return new ResponseEntity(HttpStatus.UNAUTHORIZED);
        }

        String sentData = null;
        try {
            Featureofinterest featureofinterest = featureofInterestService.getFeatureofinterestByIdentifier(mydevice);
            DateTimeFormatter dtfInput = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss");
            HelperCls.ConvertToDateTime convertable = new HelperCls.ConvertToDateTime();
            Date from = convertable.GetUTCDateTime(datetimestart, dtfInput, featureofinterest.getTimezone(), StatusTimeConverterEnum.TO_UTC).toDate();
            Date to = convertable.GetUTCDateTime(datetimeend, dtfInput, featureofinterest.getTimezone(), StatusTimeConverterEnum.TO_UTC).toDate();
            sentData = observationProperyService.getObservationsData(observablePropertyId, users.getUser_id(), mydevice, from, to);

            if (sentData == null) {
                sentData = "{\"unit\":\"\",\"measuredata\":[]}";
            }

        } catch (Exception e) {
            e.printStackTrace();
            new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
        }

        return new ResponseEntity<String>(sentData, HttpStatus.OK);
    }

    @RequestMapping(value = "/{mydevice}/watering/measures", params = {"dtstart", "dtend"}, method = RequestMethod.GET)
    public ResponseEntity<String> getMeasuresByObsProperty(@RequestParam("dtstart") String datetimestart, @RequestParam("dtend") String datetimeend, HttpServletRequest request, @PathVariable("mydevice") String mydevice) {
        JSONArray obj = new JSONArray();
        Users user = (Users) request.getSession().getAttribute("current_user");
        int userid = user.getUser_id();

        String sentData = null;
        try {
            Featureofinterest featureofinterest = featureofInterestService.getFeatureofinterestByIdentifier(mydevice);
            DateTimeFormatter dtfInput = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss");
            HelperCls.ConvertToDateTime convertable = new HelperCls.ConvertToDateTime();
            Date from = convertable.GetUTCDateTime(datetimestart, dtfInput, featureofinterest.getTimezone(), StatusTimeConverterEnum.TO_UTC).toDate();
            Date to = convertable.GetUTCDateTime(datetimeend, dtfInput, featureofinterest.getTimezone(), StatusTimeConverterEnum.TO_UTC).toDate();
            //
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

    @RequestMapping(value = "/measures/lastdate", method = RequestMethod.GET)
    public ResponseEntity<String> getMeasuresByObsProperty(HttpServletRequest request) {
        JSONArray obj = new JSONArray();
        Users users = (Users) request.getSession().getAttribute("current_user");

        String sentData = null;
        try {
            sentData = observationProperyService.getLastObservationsDate(users.getUser_id());
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

        return new ResponseEntity<String>(sentData, HttpStatus.OK);

    }


    @RequestMapping(value = "/{mydevice}/measures/last", method = RequestMethod.GET)
    public
    @ResponseBody
    List<ObservationMeasure> getMeasuresByObsProperty(@PathVariable("mydevice") String mydevice, HttpServletRequest request) {
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

    @RequestMapping(value = "/{mydevice}/watering/last", method = RequestMethod.GET)
    public
    @ResponseBody
    AutomaticWater getLastWateringMeasures(@PathVariable("mydevice") String mydevice, HttpServletRequest request) {
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

    @RequestMapping(value = "/{mydevice}/irrigation/times",params = {"dtfrom", "dtto"}, method = RequestMethod.POST)
    public ResponseEntity setIrrigationDates(@PathVariable("mydevice") String mydevice, @RequestParam("dtfrom") String datefrom, @RequestParam("dtto") String dateto, HttpServletRequest request) {
        Users users = (Users) request.getSession().getAttribute("current_user");

        try {
            AutomaticWater automaticWater = new AutomaticWater(datefrom, dateto, new BigDecimal(0), mydevice);
            measureservice.saveMeasure(automaticWater);
            boolean sentData = featureofInterestService.setDeviceIrrigaDate(users.getUser_id(), mydevice, datefrom, dateto);
            if (!sentData)
                return new ResponseEntity(HttpStatus.BAD_REQUEST);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity(HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity(HttpStatus.OK);
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

    @RequestMapping(value = "/wateringprofile/minmax", method = RequestMethod.POST)
    public @ResponseBody ResponseEntity.BodyBuilder saveWateringProfile(@RequestBody List<FeatureObsProp> featureObsPropList, HttpServletRequest request) {
        Users users = (Users) request.getSession().getAttribute("current_user");
        if(users == null){
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED);
        }

        try {
            List<FeatureMinMaxValue> featureMinMaxValuesList = new ArrayList<FeatureMinMaxValue>();
            for (FeatureObsProp featureObsProp : featureObsPropList) {
                featureMinMaxValuesList.addAll(featureObsProp.getFeatureObsproplist());
            }
            observationProperyService.setObservationMinmaxValues(featureMinMaxValuesList);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR);
        }

        return ResponseEntity.status(HttpStatus.OK);
    }

    @RequestMapping(value = "{coordinator}/automaticwater/dates", method = RequestMethod.GET)
    public @ResponseBody AutomaticWater getAutomaticWaterTimes(@PathVariable("coordinator") String coordinator, HttpServletRequest request) {
        AutomaticWater automaticWater;

        try {
            Users users = (Users) request.getSession().getAttribute("current_user");
            automaticWater = featureofInterestService.getAutomaticWater(users.getUser_id(), coordinator);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

        return automaticWater;
    }

    @RequestMapping(value = "/automaticwater/dates", method = RequestMethod.POST)
    public @ResponseBody ResponseEntity saveAutomacticWatering(HttpServletRequest request, @RequestBody AutomaticWater automaticWatering) {
        try {
            Users user = (Users) request.getSession().getAttribute("current_user");
            if(user == null){
                return new ResponseEntity(HttpStatus.UNAUTHORIZED);
            }
            int userid = user.getUser_id();
            featureofInterestService.setAutomaticWateringTime(automaticWatering, userid);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
        }

        return new ResponseEntity(HttpStatus.OK);
    }

}
