package com.webstart.service;

import com.webstart.DTO.AutomaticWater;
import com.webstart.DTO.CurrentMeasure;
import com.webstart.DTO.EmbeddedData;
import com.webstart.model.NumericValue;
import com.webstart.model.Observation;
import com.webstart.repository.*;
import org.joda.time.DateTime;
import org.joda.time.DateTimeZone;
import org.joda.time.LocalDateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.*;

import static org.hibernate.type.descriptor.java.JdbcDateTypeDescriptor.DATE_FORMAT;

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
            Timestamp timestampTo = observationJpaRepository.fiindlastdatetime(id);
            Timestamp timestampFrom = new Timestamp(timestampTo.getTime() - 24 * 60 * 60 * 1000);

            observationList = observationJpaRepository.findCurrentMeasure(id, timestampFrom, timestampTo);
            List<String> observableProperyList = observablePropertyJpaRepository.findallObsProperty();

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

    public void saveMeasure(Long seriesId, EmbeddedData embeddedData) {
        try {
            DateTimeFormatter dtf = DateTimeFormat.forPattern("yyyyMMddHHmmss");

            //Convert time to UTC
            TimeZone tz = TimeZone.getDefault();
            int offset = DateTimeZone.forID(tz.getID()).getOffset(new DateTime());
            DateTime localdt = new DateTime(DateTimeZone.forID(tz.getID()));
            localdt = localdt.minusMillis(offset);
            Timestamp ts = new Timestamp(localdt.getMillis());

            Observation observation = new Observation();
            observation.setSeriesid(seriesId);

            observation.setPhenomenontimestart(ts);
            observation.setPhenomenontimeend(ts);
            observation.setIdentifier(dtf.print(new DateTime(DateTimeZone.UTC)) + "-" + java.util.UUID.randomUUID());
            observation.setUnitid((long) embeddedData.getUnitId());

            observationJpaRepository.save(observation);

            NumericValue numericValue = new NumericValue();
            numericValue.setObservationid(observation.getObservationid());
            numericValue.setValue(embeddedData.getMeasureValue());
            numericValueJpaRepository.save(numericValue);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void saveMeasure(AutomaticWater automaticWater) {
        try {
            Long seriesid = seriesJpaRepository.findSeriesIdByEndDevice(automaticWater.getIdentifier()).get(0);
            BigDecimal waterCons = featureofinterestJpaRepository.getWaterConsumption(automaticWater.getIdentifier()).get(0);

            DateTimeFormatter dtf = DateTimeFormat.forPattern("yyyyMMddHHmmss");
            DateTimeFormatter dtfInput = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss");

            // TODO get timezone from database
            //TimeZone
            TimeZone tz = TimeZone.getTimeZone("Europe/Athens");

            // TODO create a function to reuturn the new datetime
            //Convert time to UTC
            int offset = DateTimeZone.forID(tz.getID()).getOffset(new DateTime());
            DateTime irrigdtFrom = LocalDateTime.parse(automaticWater.getFromtime(), dtfInput).toDateTime(DateTimeZone.forID(tz.getID()));
            irrigdtFrom = irrigdtFrom.minusMillis(offset);
            DateTime irrigdtUntil = LocalDateTime.parse(automaticWater.getUntiltime(), dtfInput).toDateTime(DateTimeZone.forID(tz.getID()));
            irrigdtUntil = irrigdtUntil.minusMillis(offset);

            Observation observation = new Observation();
            observation.setSeriesid(seriesid);
            observation.setPhenomenontimestart(new Timestamp(irrigdtFrom.getMillis()));
            observation.setPhenomenontimeend(new Timestamp(irrigdtUntil.getMillis()));

            observation.setIdentifier(dtf.print(new DateTime(DateTimeZone.UTC)) + "-" + java.util.UUID.randomUUID());
            observation.setUnitid((long) 22);

            observationJpaRepository.save(observation);

            NumericValue numericValue = new NumericValue();
            numericValue.setObservationid(observation.getObservationid());
            float diffmilliSec = irrigdtUntil.getMillis() - irrigdtFrom.getMillis();
            numericValue.setValue(new BigDecimal((diffmilliSec / 1000.0 / 3600.0) * waterCons.doubleValue()));
            numericValueJpaRepository.save(numericValue);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
