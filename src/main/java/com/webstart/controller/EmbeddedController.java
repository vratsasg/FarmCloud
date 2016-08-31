package com.webstart.controller;

import com.webstart.DTO.EmbeddedData;
import com.webstart.DTO.EmbeddedDataWrapper;
import com.webstart.DTO.FeatureidIdentifier;
import com.webstart.model.*;
import com.webstart.service.FeatureofInterestService;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import sun.reflect.annotation.ExceptionProxy;

import javax.servlet.http.HttpServletRequest;
import java.util.*;


/**
 * Created by George on 22/5/2016.
 */
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
    public ResponseEntity<String> getSetup(@RequestParam("identifier") String CordIdentifier) {
        String JsonResp = null;
        JsonResp = featureofInterestService.findFeatureByIdentifier(CordIdentifier);
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


}
