package com.webstart.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.webstart.DTO.*;
import com.webstart.model.*;
import com.webstart.service.FeatureofInterestService;
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

    @Autowired
    FeatureofInterestService featureofInterestService;

    @RequestMapping(value = "savemeasures", method = RequestMethod.POST)
    public ResponseEntity<Void> postSensor(@RequestBody EmbeddedDataWrapper embeddedDataWrapper) {

        List<String> identList = new ArrayList<String>();
        List<FeatureidIdentifier> featureidIdentifiers = new ArrayList<FeatureidIdentifier>();

        try {
            identList = new ArrayList<String>(new LinkedHashSet<String>(embeddedDataWrapper.GetFeatureIdentifiers()));
            featureidIdentifiers = featureofInterestService.findFeatureIdByIdentifier(identList);

            for (final EmbeddedData embeddedData : embeddedDataWrapper.getEmbeddedDataList()) {
                int featureofinterestid = 0;
                for (int i = 0; i < featureidIdentifiers.size(); i++) {
                    if ((embeddedData.getZbAddress()).equals(featureidIdentifiers.get(i).getIdentifier())) {
                        featureofinterestid = featureidIdentifiers.get(i).getFeatureinterestid();
                    }
                }

                Long seriesId = featureofInterestService.findseries(embeddedData.getObsid(), featureofinterestid);
                boolean check = featureofInterestService.saveTheMeasure(seriesId, embeddedData);
            }

            return new ResponseEntity<Void>(HttpStatus.CREATED);

        } catch (Exception exc) {
            exc.printStackTrace();
            return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "setup", method = RequestMethod.GET)
    public ResponseEntity<String> getSetup(@RequestParam("identifier") String cordIdentifier) {
        String JsonResp = null;
        try {
            EmebddedSetupDevicdeDto coordinatorSetuptimes = featureofInterestService.findCoordinatorTimes(cordIdentifier);
            List<FeatureObsPropMinMax> obspropminmaxList = featureofInterestService.findminmaxObservationValues(cordIdentifier);

            JSONObject jsonResult = new JSONObject();
            jsonResult.put("fromhour", coordinatorSetuptimes.getFromhour());
            jsonResult.put("fromminute", coordinatorSetuptimes.getFromminute());
            jsonResult.put("tohour", coordinatorSetuptimes.getTohour());
            jsonResult.put("tominute", coordinatorSetuptimes.getTominute());

            JSONArray minmaxvalues = new JSONArray();

            List<String> identifierList = new ArrayList<String>();

            for (FeatureObsPropMinMax obspropValue : obspropminmaxList) {
                identifierList.add(obspropValue.getIdentifier());
            }
            HashSet<String> endDevicesDistinctList = new HashSet<String>(identifierList);
            jsonResult.put("devicesnum", endDevicesDistinctList.size());

            for (String identifier : endDevicesDistinctList) {
                JSONObject element = new JSONObject();
                element.put("identifier", identifier);

                for (FeatureObsPropMinMax obspropValue : obspropminmaxList) {
                    if (obspropValue.getIdentifier().equalsIgnoreCase(identifier) && obspropValue.getObservablePropertyId() == 3) {
                        element.put("mintemp", obspropValue.getMinval());
                        element.put("maxtemp", obspropValue.getMaxval());
                    } else if (obspropValue.getIdentifier().equalsIgnoreCase(identifier) && obspropValue.getObservablePropertyId() == 4) {
                        element.put("minhumidity", obspropValue.getMinval());
                        element.put("maxhumidity", obspropValue.getMaxval());
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
        JsonResp = featureofInterestService.changeMeasuringFlag(user.getUser_id(), 3L);

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


}
