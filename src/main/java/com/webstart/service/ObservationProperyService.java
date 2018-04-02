package com.webstart.service;

import com.webstart.DTO.*;
import org.joda.time.DateTime;
import org.json.simple.JSONObject;
import java.util.List;

public interface ObservationProperyService {
    JSONObject getAllObsPropeties();
    //
    WateringMeasure getWateringData(int userId, String identifier, DateTime from, DateTime to);
    //
    Long getObservationsCounter(Long obspropId, int userId, String identifier, DateTime from, DateTime to);
    //
    ObservableMeasure getObservationData(Long obspropId, int userId, String identifier, DateTime from, DateTime to);
    //
    String getLastObservationsDate(int userId);
    //
    List<ObservationMeasure> getLastObservationbyIdentifier(int userId, String identifier);
    //
    AutomaticWater getLastWateringObsbyIdentifier(int userId, String identifier);
    //
    void setObservationMinmaxValues(List<FeatureMinMaxValue> observationMinmaxList);
}
