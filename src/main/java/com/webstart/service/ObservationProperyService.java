package com.webstart.service;

import org.json.simple.JSONObject;

import java.security.Timestamp;
import java.util.Date;
import java.util.List;

/**
 * Created by George on 21/6/2016.
 */
public interface ObservationProperyService {
    JSONObject getAllObsPropeties();

    String getObservationsData(Long obspropId, int userId, String identifier, Date from, Date to);
}
