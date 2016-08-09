package com.webstart.service;

import com.webstart.DTO.FeatureidIdentifier;
import com.webstart.DTO.Crop;
import com.webstart.DTO.EmbeddedData;
import org.json.simple.JSONObject;

import java.util.Date;
import java.util.List;

public interface FeatureofInterestService {
        //READ
        String findByFeatureofinterestid(int id);
        String findFeatureByIdentifier(String identi);

        List<FeatureidIdentifier> findFeatureIdByIdentifier(List<String> stringList);
        JSONObject findCropInfo(int id);
        JSONObject findByUserAndType(int id);

        String findMinMaxbyUserId(Integer userid);

        Long findseries(int obs, Integer fid);
        String findIrrigationAndMeasuring(String corD);
        String changeMeasuringFlag(int usid, long typeId);

        //INSERT, UPDATE
        public boolean setDeviceIrrigaDate(int usid, String device, Date from, Date to);

        boolean saveTheMeasure(Long series, EmbeddedData embeddedData);

        boolean addCrop(Crop crop);
}
