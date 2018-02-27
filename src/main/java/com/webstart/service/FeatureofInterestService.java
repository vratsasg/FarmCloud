package com.webstart.service;

import com.webstart.DTO.*;
import com.webstart.model.Featureofinterest;
import org.json.simple.JSONObject;

import java.util.Date;
import java.util.List;

public interface FeatureofInterestService {
        //READ
        String findByFeatureofinterestid(int id);
        //
        String findFeatureByIdentifier(String identi);
        //
        Featureofinterest getFeatureofinterestByIdentifier(String identifier);
        //
        List<FeatureidIdentifier> findFeatureIdByIdentifier(List<String> stringList);
        //
        List<Long> findIdsByIdentifier(List<String> idStr);
        //
        List<FeatureObsPropMinMax> findminmaxObservationValues(String identifier);
        //
        List<EmebddedSetupDevicdeDto> findEndDevicesTimes(String coordinatorAddress);
        //
        EmebddedSetupDevicdeDto findCoordinatorTimes(String coordinatorAddress);
        //
        JSONObject findCropInfo(int id);
        //
        List<FeatureidIdentifier> findByUserAndType(int id, long typeId);
        //
        String findByIdentifier(String coordinator);
        //
        String findMinMaxbyUserId(Integer userid);
        //
        Long findseries(int obs, Integer fid);
        //
        String findIrrigationAndMeasuring(String corD);
        //
        AutomaticWater getAutomaticWater(int userid, String identifier);

        //INSERT, UPDATE
        boolean changeMeasuringFlag(String identifier, long typeId);
        //
        boolean setDeviceIrrigaDate(int usid, String device, String from, String to);
        //
        boolean addCrop(Crop crop);
        //
        void setFeatureMeasuringFalse(List<String> idertifierList);
        //
        void setAutomaticWateringTime(AutomaticWater automaticWater, int userid);
        //
        void setFeatureOfInterestData(FeatureSensor featureSensor);
        //
        void setFeatureWateringFalse(String id);
}
