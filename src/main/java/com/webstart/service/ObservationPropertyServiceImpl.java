package com.webstart.service;

import com.webstart.model.ObservableProperty;
import com.webstart.repository.ObservablePropertyJpaRepository;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;


@Service("observationProperyService")
@Transactional
public class ObservationPropertyServiceImpl implements ObservationProperyService {

    @Autowired
    ObservablePropertyJpaRepository observablePropertyJpaRepository;

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

}


