package com.webstart.controller;

import com.webstart.DTO.EmbeddedDataWrapper;
import com.webstart.DTO.FeatureidIdentifier;
import com.webstart.model.*;
import com.webstart.service.FeatureofInterestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.*;


/**
 * Created by George on 22/5/2016.
 */
@RestController
public class EmbeddedController {

    @Autowired
    FeatureofInterestService featureofInterestService;


    @RequestMapping(value = "/embedded/", method = RequestMethod.POST)
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


            System.out.println("test");
            return new ResponseEntity<Void>(HttpStatus.CREATED);

        } catch (Exception exc) {
            exc.printStackTrace();
            return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);
        }
    }


    @RequestMapping(value = "/getsetup", method = RequestMethod.GET)
    public ResponseEntity<String> getSetup(@RequestParam("identifier") String CordIdentifier) {

        String JsonResp = null;

        JsonResp = featureofInterestService.findFeatureByIdentifier(CordIdentifier);

        return new ResponseEntity<String>(JsonResp, HttpStatus.OK);

    }


}
