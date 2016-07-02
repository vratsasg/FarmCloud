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

        JSONObject obj = new JSONObject();

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

        Iterator itr = observationList.iterator();

        String temp = "Temperature";
        String ihum = "InternalHumidity";
        String itemp = "Internal Temperature";
        String soil = "Soil Moisture";

        JSONArray finalDataList = new JSONArray();

        JSONArray temperatureList = new JSONArray();
        JSONArray intertemperatureList = new JSONArray();

        JSONArray internHumidity = new JSONArray();
        JSONArray internSoilMoisture = new JSONArray();

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

            if (soil.replaceAll("\\s+", "").equalsIgnoreCase(String.valueOf(objec[0]).replaceAll("\\s+", ""))) {

                Timestamp timestamp = (Timestamp) objec[1];
                String value = String.valueOf(objec[2]);

                long stampTime = timestamp.getTime() / 1000L;

                String strTd = String.valueOf(stampTime);


                internvalues.add(strTd);
                internvalues.add(value);

                internSoilMoisture.add(internvalues);

            }

            if (ihum.replaceAll("\\s+", "").equalsIgnoreCase(String.valueOf(objec[0]).replaceAll("\\s+", ""))) {

                Timestamp timestamp = (Timestamp) objec[1];
                String value = String.valueOf(objec[2]);

                long stampTime = timestamp.getTime() / 1000L;

                String strTd = String.valueOf(stampTime);


                internvalues.add(strTd);
                internvalues.add(value);

                internHumidity.add(internvalues);

            }

        }

        JSONObject tempobject = new JSONObject();
        JSONObject internaltempobject = new JSONObject();

        JSONObject Temperatures = new JSONObject();


        tempobject.put("key", "Temperature");
        tempobject.put("values", temperatureList);


        internaltempobject.put("values", intertemperatureList);
        internaltempobject.put("key", "Internal Temperature");

        JSONArray finalTempList = new JSONArray();

        finalTempList.add(tempobject);
        finalTempList.add(internaltempobject);

        Temperatures.put("Temperatures", finalTempList);


        JSONObject Humidities = new JSONObject();
        JSONArray finalHumList = new JSONArray();
        JSONObject soilobject = new JSONObject();
        JSONObject internalhum = new JSONObject();

        soilobject.put("key", "Soil Moisture");
        soilobject.put("values", internSoilMoisture);

        internalhum.put("key", "Internal Humidity");
        internalhum.put("values", internHumidity);


        finalHumList.add(soilobject);
        finalHumList.add(internalhum);


        Humidities.put("Humidities", finalHumList);

        finalDataList.add(Temperatures);
        finalDataList.add(Humidities);


        System.out.println("eeee");

        String finalsended = finalDataList.toJSONString();

        System.out.println(finalDataList);

        return finalDataList;

    }
}
