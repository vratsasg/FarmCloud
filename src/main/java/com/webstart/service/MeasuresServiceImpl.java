package com.webstart.service;

import com.webstart.model.CurrentMeasure;
import com.webstart.model.Observation;
import com.webstart.repository.ObservationJpaRepository;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

@Service("measurement")
@Transactional
public class MeasuresServiceImpl implements MeasureService {

    @Autowired
    ObservationJpaRepository observationJpaRepository;

    public JSONArray findDailyMeasure(String id) {

        JSONObject Finalobj = new JSONObject();

        List<CurrentMeasure> observationList = new ArrayList<CurrentMeasure>();

        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = null;
        try {
            date = dateFormat.parse("2015-05-21 00:00:00");

        } catch (ParseException e) {
            e.printStackTrace();
        }
        long time = date.getTime();
        Timestamp t1 = new Timestamp(time);


        DateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date2 = null;
        try {
            date2 = dateFormat.parse("2015-05-21 23:59:59");

        } catch (ParseException e) {
            e.printStackTrace();
        }
        long time2 = date2.getTime();
        Timestamp t2 = new Timestamp(time2);


        observationList = observationJpaRepository.findCurrentMeasure(id, t1, t2);

        String temp = "Temperature";
        String itemp = "Internal Temperature";

        Iterator itr = observationList.iterator();
        JSONArray temperatureList = new JSONArray();
        JSONArray intertemperatureList = new JSONArray();

        while (itr.hasNext()) {
            Object[] objec = (Object[]) itr.next();


            JSONArray internvalues = new JSONArray();


            if (temp.equals(String.valueOf(objec[0]))) {

                Timestamp timestamp = (Timestamp) objec[1];
                String value = String.valueOf(objec[2]);

                long stampTime = timestamp.getTime() / 1000L;

                String strTd = String.valueOf(stampTime);


                internvalues.add(strTd);
                internvalues.add(value);

                temperatureList.add(internvalues);

            }
            if (itemp.replaceAll("\\s+", "").equalsIgnoreCase(String.valueOf(objec[0]).replaceAll("\\s+", ""))) {

                Timestamp timestamp = (Timestamp) objec[1];
                String value = String.valueOf(objec[2]);

                long stampTime = timestamp.getTime() / 1000L;

                String strTd = String.valueOf(stampTime);


                internvalues.add(strTd);
                internvalues.add(value);

                intertemperatureList.add(internvalues);

            }

        }

        JSONObject tempobject = new JSONObject();
        JSONObject internaltempobject = new JSONObject();

        tempobject.put("key", "Temperature");
        tempobject.put("values", temperatureList);


        internaltempobject.put("values", intertemperatureList);
        internaltempobject.put("key", "Internal Temperature");


        JSONArray finalTempList = new JSONArray();

        finalTempList.add(tempobject);
        finalTempList.add(internaltempobject);

        return finalTempList;
    }
}
