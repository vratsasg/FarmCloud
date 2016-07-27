package com.webstart.service;

import com.webstart.model.Crop;
import org.json.simple.JSONObject;
import java.util.List;

public interface FeatureofInterestService {
        boolean addCrop(Crop crop);

        String findByFeatureofinterestid(int id);

        String findFeatureByIdentifier(String identi);

        JSONObject findCropInfo(int id);
        JSONObject findByUserAndType(int id);
}
