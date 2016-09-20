package com.webstart.service;

import com.webstart.DTO.*;
import org.json.simple.JSONObject;

import java.util.Date;
import java.util.List;

public interface FeatureofInterestService {
        //READ
        String findByFeatureofinterestid(int id);
        String findFeatureByIdentifier(String identi);

        List<FeatureidIdentifier> findFeatureIdByIdentifier(List<String> stringList);

        List<FeatureObsPropMinMax> findminmaxObservationValues(String identifier);

        List<EmebddedSetupDevicdeDto> findEndDevicesTimes(String coordinatorAddress);

        EmebddedSetupDevicdeDto findCoordinatorTimes(String coordinatorAddress);
        JSONObject findCropInfo(int id);
        JSONObject findByUserAndType(int id);

        String findByIdentifier(String coordinator);

        String findMinMaxbyUserId(Integer userid);

        Long findseries(int obs, Integer fid);
        String findIrrigationAndMeasuring(String corD);
        String changeMeasuringFlag(int usid, long typeId);

        //INSERT, UPDATE
        boolean setDeviceIrrigaDate(int usid, String device, Date from, Date to);
        boolean addCrop(Crop crop);
}
