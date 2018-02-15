package com.webstart.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.webstart.DTO.*;
import com.webstart.Enums.FeatureTypeEnum;
import com.webstart.Enums.MeasurementTypeEnum;
import com.webstart.model.*;
import com.webstart.service.FeatureofInterestService;
import com.webstart.service.MeasureService;
import com.webstart.service.UsersService;
import org.joda.time.DateTime;
import org.joda.time.DateTimeZone;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@RestController
@RequestMapping(value = "embedded")
public class EmbeddedController {

    @Autowired FeatureofInterestService featureofInterestService;
    @Autowired MeasureService measureService;
    @Autowired UsersService usersService ;

    @RequestMapping(value = "savemeasures", method = RequestMethod.POST)
    public @ResponseBody void postSensor(@RequestBody EmbeddedDataWrapper embeddedDataWrapper) {
        try {
            List<String> identList = new ArrayList<String>(new LinkedHashSet<String>(embeddedDataWrapper.GetFeatureIdentifiers()));
            List<FeatureidIdentifier> featureidIdentifiers = featureofInterestService.findFeatureIdByIdentifier(identList);
            featureofInterestService.setFeatureMeasuringFalse(identList);

            for (final EmbeddedData embeddedData : embeddedDataWrapper.getEmList()) {
                int featureofinterestid = 0;
                embeddedData.setDatetimeMeasure(new DateTime(DateTimeZone.UTC).toDate());
                for (int i = 0; i < featureidIdentifiers.size(); i++) {
                    if ((embeddedData.getZigbeeAddress()).equals(featureidIdentifiers.get(i).getIdentifier())) {
                        featureofinterestid = featureidIdentifiers.get(i).getFeatureinterestid();
                    }
                }

                Long seriesId = featureofInterestService.findseries(embeddedData.getObservationPropId(), featureofinterestid);
                measureService.saveMeasure(seriesId, embeddedData);
                usersService.createNewNotification(featureidIdentifiers.get(0).getUserId(), String.format("save new measures been taken for end devices: %s ", identList.toString()));
            }
        } catch (Exception exc) {
            exc.printStackTrace();
        }
    }

    @RequestMapping(value = "saveirrigation", method = RequestMethod.POST)
    public @ResponseBody void postIrrigation(@RequestBody AutomaticWater automaticWater) {
        try {
            measureService.saveMeasure(automaticWater);
        } catch (Exception exc) {
            exc.printStackTrace();
        }
    }

    @RequestMapping(value = "setup", method = RequestMethod.GET)
    public ResponseEntity<String> getSetup(@RequestParam("identifier") String cordIdentifier) {
        String JsonResp = null;
        try {
            EmebddedSetupDevicdeDto coordinatorSetuptimes = featureofInterestService.findCoordinatorTimes(cordIdentifier);
            List<FeatureObsPropMinMax> obspropminmaxList = featureofInterestService.findminmaxObservationValues(cordIdentifier);

            JSONObject jsonResult = new JSONObject();
            jsonResult.put("fh", coordinatorSetuptimes.getFromhour());
            jsonResult.put("fm", coordinatorSetuptimes.getFromminute());
            jsonResult.put("th", coordinatorSetuptimes.getTohour());
            jsonResult.put("tm", coordinatorSetuptimes.getTominute());

            JSONArray minmaxvalues = new JSONArray();

            List<String> identifierList = new ArrayList<String>();

            for (FeatureObsPropMinMax obspropValue : obspropminmaxList) {
                identifierList.add(obspropValue.getIdentifier());
            }
            HashSet<String> endDevicesDistinctList = new HashSet<String>(identifierList);
            jsonResult.put("num", endDevicesDistinctList.size());

            for (String identifier : endDevicesDistinctList) {
                JSONObject element = new JSONObject();
                element.put("id", identifier);

                for (FeatureObsPropMinMax obspropValue : obspropminmaxList) {
                    if (obspropValue.getIdentifier().equalsIgnoreCase(identifier) && obspropValue.getObservablePropertyId() == MeasurementTypeEnum.TEMPERATURE.getValue()) {
                        element.put("mint", obspropValue.getMinval());
                        element.put("maxt", obspropValue.getMaxval());
                    } else if (obspropValue.getIdentifier().equalsIgnoreCase(identifier) && obspropValue.getObservablePropertyId() == MeasurementTypeEnum.SOIL_MOSTURE.getValue()) {
                        element.put("minh", obspropValue.getMinval());
                        element.put("maxh", obspropValue.getMaxval());
                    }
                }
                minmaxvalues.add(element);
            }

            jsonResult.put("devices", minmaxvalues);
            JsonResp = jsonResult.toJSONString();
        } catch (Exception exc) {
            exc.printStackTrace();
        }
        //JsonResp = featureofInterestService.findFeatureByIdentifier(cordIdentifier);
        return new ResponseEntity<String>(JsonResp, HttpStatus.OK);
    }

    @RequestMapping(value = "measureIrrigation", method = RequestMethod.GET)
    public ResponseEntity<String> getMeasuringIrrigation(@RequestParam("identifier") String coordinator) {
        String JsonResp = null;
        JsonResp = featureofInterestService.findIrrigationAndMeasuring(coordinator);
        return new ResponseEntity<String>(JsonResp, HttpStatus.OK);
    }

    @RequestMapping(value = "measures", method = RequestMethod.GET)
    public ResponseEntity<String> startMeasuring(HttpServletRequest request) {
        String JsonResp = null;
        Users user = (Users) request.getSession().getAttribute("current_user");
        //TODO change without userid from ControlPanel Service on angular
        JsonResp = featureofInterestService.changeMeasuringFlag(user.getUser_id(), FeatureTypeEnum.END_DEVICE.getValue());
        return new ResponseEntity<String>(JsonResp, HttpStatus.OK);
    }

    @RequestMapping(value = "endDeviceAddresses", method = RequestMethod.GET)
    public ResponseEntity<String> getAllDevicesAddress(@RequestParam("identifier") String coordinator) {
        String JsonResults = null;

        try {
            JsonResults = featureofInterestService.findByIdentifier(coordinator);
        } catch (Exception e) {
            return new ResponseEntity<String>(JsonResults, HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<String>(JsonResults, HttpStatus.OK);
    }


    @RequestMapping(value = "endDevicesTime", method = RequestMethod.GET)
    public ResponseEntity<String> getAllDevicesWateringTime(@RequestParam("identifier") String coordinator) {
        String JsonResults = null;

        try {
            ObjectMapper mapper = new ObjectMapper();
            List<EmebddedSetupDevicdeDto> ls = featureofInterestService.findEndDevicesTimes(coordinator);
            JsonResults = mapper.writeValueAsString(ls);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return new ResponseEntity<String>(JsonResults, HttpStatus.BAD_REQUEST);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>(JsonResults, HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<String>(JsonResults, HttpStatus.OK);
    }

    @RequestMapping(value = "automaticwatering/save", method = RequestMethod.POST)
    public @ResponseBody void saveAutomacticWateringObservation(HttpServletRequest request, @RequestBody AutomaticWater automaticWatering) {
        try {
            List<String> identifiers = Arrays.asList(automaticWatering.getIdentifier());
            Long featureId = featureofInterestService.findIdsByIdentifier(identifiers).get(0);

            measureService.saveMeasure(automaticWatering);
            featureofInterestService.setFeatureMeasuringFalse(identifiers);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "manualwatering/save", method = RequestMethod.POST)
    public @ResponseBody void saveAutomacticWatering(HttpServletRequest request, @RequestBody AutomaticWater automaticWatering) {
        try {
            String identifier = automaticWatering.getIdentifier();
            measureService.saveMeasure(automaticWatering);
            featureofInterestService.setFeatureWateringFalse(identifier);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
