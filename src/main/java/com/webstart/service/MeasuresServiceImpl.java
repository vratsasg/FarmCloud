package com.webstart.service;

import com.webstart.DTO.CurrentMeasure;
import com.webstart.repository.ObservablePropertyJpaRepository;
import com.webstart.repository.ObservationJpaRepository;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service("measurement")
@Transactional
public class MeasuresServiceImpl implements MeasureService {

    @Autowired
    ObservationJpaRepository observationJpaRepository;
    @Autowired
    ObservablePropertyJpaRepository observablePropertyJpaRepository;

    public JSONArray findDailyMeasure(String id) {
        JSONArray finalDataList = new JSONArray();
        List<CurrentMeasure> observationList = new ArrayList<CurrentMeasure>();

        try {
            Calendar calendar = Calendar.getInstance();
            Date dateto = calendar.getTime(); //NOW
            Timestamp timestampTo = new Timestamp(dateto.getTime());

            calendar.add(Calendar.DATE, -1);
            Date datefrom = calendar.getTime();
            Timestamp timestampFrom = new Timestamp(datefrom.getTime());

            observationList = observationJpaRepository.findCurrentMeasure(id, timestampFrom, timestampTo);
            List<String> observableProperyList = observablePropertyJpaRepository.findallObsProperty();

//            if(observationList.size() == 0)
//                return null;

            //Create a hash table with all observable properties
            Hashtable<String, JSONArray> obspropValues = new Hashtable<String, JSONArray>();
            for (String obsprop : observableProperyList) {
                obspropValues.put(obsprop, new JSONArray());
            }

            Iterator itr = observationList.iterator();
            while (itr.hasNext()) {
                Object[] object = (Object[]) itr.next();
                JSONArray internvalues = new JSONArray();

                String value = String.valueOf(object[2]);
                String strTd = String.valueOf(((Timestamp) object[1]).getTime() / 1000L);
                internvalues.add(strTd);
                internvalues.add(value);

                JSONArray jsonarr = obspropValues.get(String.valueOf(object[0]));
                if (jsonarr != null) {
                    jsonarr.add(internvalues);
                }
            }

            List<JSONObject> tempJsonObjectsList = new ArrayList<JSONObject>();

            for (String obsprop : observableProperyList) {
                JSONArray jsonarr = obspropValues.get(obsprop);
                if (jsonarr != null) {
                    JSONObject tmpObject = new JSONObject();
                    tmpObject.put("key", obsprop);
                    tmpObject.put("values", jsonarr);
                    tempJsonObjectsList.add(tmpObject);
                }
            }

            JSONArray finalHumList = new JSONArray();
            JSONArray finalTempList = new JSONArray();
            for (JSONObject jsonObj : tempJsonObjectsList) {
                JSONObject newjsonobject = new JSONObject();
                newjsonobject.put("key", jsonObj.get("key").toString());
                newjsonobject.put("values", jsonObj.get("values"));

                if (jsonObj.get("key").toString().toLowerCase().contains("temperature")) {
                    finalTempList.add(newjsonobject);
                } else {
                    finalHumList.add(newjsonobject);
                }
            }

            JSONObject Temperatures = new JSONObject();
            JSONObject Humidities = new JSONObject();
            Temperatures.put("Temperatures", finalTempList);
            Humidities.put("Humidities", finalHumList);

            finalDataList.add(Temperatures);
            finalDataList.add(Humidities);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return finalDataList;


    }
}
