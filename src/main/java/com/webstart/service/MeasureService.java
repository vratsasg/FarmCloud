package com.webstart.service;

import com.webstart.DTO.AutomaticWater;
import com.webstart.DTO.EmbeddedData;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import java.sql.Timestamp;


public interface MeasureService {

    JSONArray findDailyMeasure(String id);

    void saveMeasure(Long series, EmbeddedData embeddedData, Timestamp measuredt);

    void saveMeasure(AutomaticWater automaticWater);
}
