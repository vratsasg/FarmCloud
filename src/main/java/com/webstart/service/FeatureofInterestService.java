package com.webstart.service;

import com.webstart.DTO.FeatureidIdentifier;
import com.webstart.model.Crop;
import com.webstart.model.EmbeddedData;
import org.json.simple.JSONObject;
import java.util.List;

public interface FeatureofInterestService {
        boolean addCrop(Crop crop);

        String findByFeatureofinterestid(int id);
        String findFeatureByIdentifier(String identi);

        List<FeatureidIdentifier> findFeatureIdByIdentifier(List<String> stringList);
        JSONObject findCropInfo(int id);
        JSONObject findByUserAndType(int id);

        Long findseries(int obs, Integer fid);

        boolean saveTheMeasure(Long series, EmbeddedData embeddedData);

        String findIrrigationAndMeasuring(String corD);
}
