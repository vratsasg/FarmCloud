package com.webstart.service;

import com.webstart.DTO.AutomaticWater;
import com.webstart.DTO.CurrentMeasure;
import com.webstart.DTO.EmbeddedData;
import com.webstart.model.NumericValue;
import com.webstart.model.Observation;
import com.webstart.model.Series;
import com.webstart.repository.*;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@Service("measurement")
@Transactional
public class MeasuresServiceImpl implements MeasureService {

    @Autowired
    ObservationJpaRepository observationJpaRepository;
    @Autowired
    ObservablePropertyJpaRepository observablePropertyJpaRepository;
    @Autowired
    NumericValueJpaRepository numericValueJpaRepository;
    @Autowired
    SeriesJpaRepository seriesJpaRepository;
    @Autowired
    FeatureofinterestJpaRepository featureofinterestJpaRepository;

    public JSONArray findDailyMeasure(String id) {
        JSONArray finalDataList = new JSONArray();
        List<CurrentMeasure> observationList = new ArrayList<CurrentMeasure>();

        try {

            ////TODO change this with lasttime of measure
            //Calendar calendar = Calendar.getInstance();
            //Date dateto = calendar.getTime(); //NOW
            //Timestamp timestampTo = new Timestamp(dateto.getTime());
            Timestamp timestampTo = observationJpaRepository.findlastdatetime(id);

            //calendar.add(Calendar.DATE, -1);
            //Date datefrom = calendar.getTime();
            //Timestamp timestampFrom = new Timestamp(datefrom.getTime());
            Timestamp timestampFrom = new Timestamp(timestampTo.getTime() - 24 * 60 * 60 * 1000);

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

    public void saveTheMeasure(Long seriesId, EmbeddedData embeddedData) {
        try {
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date from = dateFormat.parse(embeddedData.getDatetimeMeasure());

            Observation observation = new Observation();

            observation.setSeriesid(seriesId);
            observation.setPhenomenontimestart(new Timestamp(from.getTime()));
            observation.setPhenomenontimeend(new Timestamp(from.getTime()));
            observation.setResulttime(new Timestamp(from.getTime()));
            observation.setIdentifier(embeddedData.getDatetimeMeasure().replace("-", "").replace(":", "").replace(" ", "") + "-" + java.util.UUID.randomUUID());
            observation.setUnitid((long) embeddedData.getUnitId());
            observation.setDeleted("F");

            observationJpaRepository.save(observation);

            NumericValue numericValue = new NumericValue();
            numericValue.setObservationid(observation.getObservationid());
            numericValue.setValue(embeddedData.getMeasureValue());
            numericValueJpaRepository.save(numericValue);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void saveTheMeasure(AutomaticWater automaticWater) {
        try {
            Long seriesid = seriesJpaRepository.findSeriesIdByEndDevice(automaticWater.getIdentifier()).get(0);
            BigDecimal waterCons = featureofinterestJpaRepository.getWaterConsumption(automaticWater.getIdentifier()).get(0);

            DateFormat df = new SimpleDateFormat("yyyy/MM/dd/ HH:mm:ss");

            Observation observation = new Observation();
            observation.setSeriesid(seriesid);
            observation.setPhenomenontimestart(new Timestamp(automaticWater.getFromtime().getTime()));
            observation.setPhenomenontimeend(new Timestamp(automaticWater.getUntiltime().getTime()));
            observation.setResulttime(new Timestamp(automaticWater.getUntiltime().getTime()));
            observation.setIdentifier(df.format(automaticWater.getUntiltime()).replace("/", "").replace(":", "").replace(" ", "") + "-" + java.util.UUID.randomUUID());
            observation.setUnitid((long) 22);
            observation.setDeleted("F");

            observationJpaRepository.save(observation);

            NumericValue numericValue = new NumericValue();
            numericValue.setObservationid(observation.getObservationid());
            float diffmilliSec = automaticWater.getUntiltime().getTime() - automaticWater.getFromtime().getTime();
            numericValue.setValue(new BigDecimal((diffmilliSec / 1000.0 / 3600.0) * waterCons.doubleValue()));
            numericValueJpaRepository.save(numericValue);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
