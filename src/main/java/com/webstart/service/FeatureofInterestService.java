package com.webstart.service;

import com.webstart.model.Crop;
import org.json.simple.JSONObject;

import java.util.List;


public interface FeatureofInterestService {
        boolean addCrop(Crop crop);
        public JSONObject findCropInfo(int id);

        JSONObject findByUserAndType(int id);
}
