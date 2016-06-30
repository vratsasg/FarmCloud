package com.webstart.service;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;


public interface MeasureService {

    JSONArray findDailyMeasure(String id);
}
