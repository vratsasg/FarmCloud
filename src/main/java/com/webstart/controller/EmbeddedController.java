package com.webstart.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.webstart.DTO.*;
import com.webstart.Enums.FeatureTypeEnum;
import com.webstart.Enums.MeasurementTypeEnum;
import com.webstart.service.FeatureofInterestService;
import com.webstart.service.MeasureService;
import com.webstart.service.UsersService;
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

    @RequestMapping(value = "measures", method = RequestMethod.POST)
    public @ResponseBody void postSensor(@RequestBody EmbeddedDataWrapper embeddedDataWrapper) {
        try {
            List<String> identList = new ArrayList<String>(new LinkedHashSet<String>(embeddedDataWrapper.GetFeatureIdentifiers()));
            List<FeatureidIdentifier> featureidIdentifiers = featureofInterestService.findFeatureIdByIdentifier(identList);

            for (final EmbeddedData embeddedData : embeddedDataWrapper.getEmList()) {
                int featureofinterestid = 0;
                for (int i = 0; i < featureidIdentifiers.size(); i++) {
                    if ((embeddedData.getZigbeeAddress()).equals(featureidIdentifiers.get(i).getIdentifier())) {
                        featureofinterestid = featureidIdentifiers.get(i).getFeatureinterestid();
                    }
                }

                Long seriesId = featureofInterestService.findseries(embeddedData.getObservationPropId(), featureofinterestid);
                measureService.saveMeasure(seriesId, embeddedData);
            }
            usersService.createNewNotification(featureidIdentifiers.get(0).getUserId(), String.format("save new measures been taken for end devices: %s ", identList.toString()));
            featureofInterestService.setFeatureMeasuringFalse(identList);
        } catch (Exception exc) {
            exc.printStackTrace();
        }
    }

    @RequestMapping(value = "irrigation", method = RequestMethod.POST)
    public @ResponseBody void postIrrigation(@RequestBody AutomaticWater automaticWater) {
        try {
            this.measureService.saveMeasure(automaticWater);
        } catch (Exception exc) {
            exc.printStackTrace();
        }
    }

    @RequestMapping(value = "{coordinator}/setup", method = RequestMethod.GET)
    public ResponseEntity<String> getSetup(@PathVariable("coordinator") String cordIdentifier) {
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

    @RequestMapping(value = "{coordinator}/irrigation", method = RequestMethod.GET)
    public ResponseEntity<String> getMeasuringIrrigation(@PathVariable("coordinator") String coordinator, HttpServletRequest request) {
        String JsonResp = null;
        JsonResp = featureofInterestService.findIrrigationAndMeasuring(coordinator);
        return new ResponseEntity<String>(JsonResp, HttpStatus.OK);
    }

    @RequestMapping(value = "{coordinator}/measures", method = RequestMethod.GET)
    public HttpStatus startMeasuring(@PathVariable("coordinator") String identifier) {
        boolean status;
        try {
            status = featureofInterestService.changeMeasuringFlag(identifier, FeatureTypeEnum.END_DEVICE.getValue());
        } catch (Exception e){
            return HttpStatus.INTERNAL_SERVER_ERROR;
        }

        if(!status) {
            return HttpStatus.INTERNAL_SERVER_ERROR;
        }

        return HttpStatus.OK;
    }

    @RequestMapping(value = "{coordinator}/enddevices", method = RequestMethod.GET)
    public ResponseEntity<String> getAllDevicesAddress(@PathVariable("coordinator") String coordinator) {
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

    @RequestMapping(value = "irrigation/automatic", method = RequestMethod.POST)
    public @ResponseBody void saveAutomacticWateringObservation(@RequestBody AutomaticWater automaticWatering) {
        try {
            List<String> identifiers = Arrays.asList(automaticWatering.getIdentifier());
            Long featureId = featureofInterestService.findIdsByIdentifier(identifiers).get(0);

            measureService.saveMeasure(automaticWatering);
            featureofInterestService.setFeatureMeasuringFalse(identifiers);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "irrigation/manual", method = RequestMethod.POST)
    public @ResponseBody void saveAutomacticWatering(@RequestBody AutomaticWater automaticWatering) {
        try {
            String identifier = automaticWatering.getIdentifier();
            measureService.saveMeasure(automaticWatering);
            featureofInterestService.setFeatureWateringFalse(identifier);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
