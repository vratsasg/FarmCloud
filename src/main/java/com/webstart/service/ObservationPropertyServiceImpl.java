package com.webstart.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.webstart.DTO.ObservableMeasure;
import com.webstart.DTO.ObservationMeasure;
import com.webstart.DTO.ValueTime;
import com.webstart.model.*;
import com.webstart.repository.ObservablePropertyJpaRepository;
import com.webstart.repository.ObservationJpaRepository;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;

import java.sql.Timestamp;
import java.util.*;


@Service("observationProperyService")
@Transactional
public class ObservationPropertyServiceImpl implements ObservationProperyService {

    @Autowired
    ObservablePropertyJpaRepository observablePropertyJpaRepository;
    @Autowired
    ObservationJpaRepository observationJpaRepository;

    public JSONObject getAllObsPropeties() {

        JSONObject finalobj = new JSONObject();
        JSONArray list = new JSONArray();

        List<ObservableProperty> obsPropertiesList = new ArrayList<ObservableProperty>();
        obsPropertiesList = observablePropertyJpaRepository.findAll();

        for (int i = 0; i < obsPropertiesList.size(); i++) {
            JSONObject obj = new JSONObject();
            obj.put("observablepropertyid", obsPropertiesList.get(i).getObservablePropertyId());
            obj.put("description", obsPropertiesList.get(i).getDescription());
            list.add(obj);
        }


        finalobj.put("obsprop", list);
        String temp = finalobj.toJSONString();


        return finalobj;
    }


    public String getObservationsData(Long obspropId, int userId, String identifier, Date from, Date to) {
        String jsonInString = null;

        try {
            java.sql.Timestamp timeFrom = new java.sql.Timestamp(from.getTime());
            java.sql.Timestamp timeTo = new java.sql.Timestamp(to.getTime());

            List<Object[]> listofObjs = observationJpaRepository.findMeasureByObsPropId(obspropId, userId, identifier, timeFrom, timeTo);

            if (listofObjs.size() == 0) {
                return null;
            }

            ObservableMeasure obsMeasure = new ObservableMeasure();
            Object[] obj = listofObjs.get(0);

            obsMeasure.setIdentifier(String.valueOf(listofObjs.get(0)[0]));
            obsMeasure.setObservableProperty(String.valueOf(listofObjs.get(0)[1]));
            obsMeasure.setUnit(String.valueOf(listofObjs.get(0)[4]));
            List<ValueTime> ls = new ArrayList<ValueTime>();

            Iterator itr = listofObjs.iterator();
            while (itr.hasNext()) {
                Object[] objec = (Object[]) itr.next();
                //Object[] objValueTime = new Object[2];

                Timestamp tTime = (java.sql.Timestamp) objec[2];

                ls.add(new ValueTime(tTime.getTime() / 1000L, (BigDecimal) objec[3]));
            }

            obsMeasure.setMeasuredata(ls);
            ObjectMapper mapper = new ObjectMapper();

            //Object to JSON in String
            jsonInString = mapper.writeValueAsString(obsMeasure);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return null;
        }

        System.out.println(jsonInString);
        return jsonInString;
    }

    public String getLastObservationsDate(int userId) {
        String jsonInString;

        try {
            Timestamp lastdate = observationJpaRepository.findlastdatetime(userId);
            ObjectMapper mapper = new ObjectMapper();
            jsonInString = mapper.writeValueAsString(lastdate);

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

        return jsonInString;
    }

    public String getLastObservationbyIdentifier(int userId, String identifier) {
        String jsonInString = null;

        try {
            Timestamp lastdate = observationJpaRepository.findlastdatetime(userId);
            List<Object[]> listMeasures = observationJpaRepository.findLastMeasures(userId, identifier, lastdate);

            if (listMeasures.size() == 0) {
                return null;
            }

            List<ObservationMeasure> ls = new ArrayList<ObservationMeasure>();
            Iterator itr = listMeasures.iterator();

            while (itr.hasNext()) {
                Object[] objec = (Object[]) itr.next();

                Timestamp tTime = (java.sql.Timestamp) objec[1];
                //select obsprop.Description, obs.phenomenontimestart, num.value, u.unit
                ls.add(new ObservationMeasure(tTime.getTime() / 1000L, (BigDecimal) objec[2], objec[3].toString(), objec[0].toString()));
            }

            ObjectMapper mapper = new ObjectMapper();

            //Object to JSON in String
            jsonInString = mapper.writeValueAsString(ls);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return null;
        }

        return jsonInString;
    }

}


