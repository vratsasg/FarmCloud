package com.webstart.service;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.webstart.DTO.FeatureidIdentifier;
import com.webstart.model.*;
import com.webstart.repository.FeatureofinterestJpaRepository;

import com.webstart.repository.NumericValueJpaRepository;
import com.webstart.repository.ObservationJpaRepository;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.data.geo.Point;

import java.awt.*;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

@Service("featureofInterestService")
@Transactional
public class FeatureofInterestServiceImpl implements FeatureofInterestService {

    @Autowired
    FeatureofinterestJpaRepository featureofinterestJpaRepository;
    @Autowired
    ObservationJpaRepository observationJpaRepository;
    @Autowired
    NumericValueJpaRepository numericValueJpaRepository;

    @Override
    public boolean addCrop(Crop crop) {
        Featureofinterest featureofinterest = new Featureofinterest();

        crop.getCropname();
        crop.getCropdescription();
        crop.getStationname();
        crop.getStationdescription();
        crop.getDevices();

        featureofinterest.setHibernatediscriminator("N");
        featureofinterest.setFeatureofinteresttypeid(1);
        featureofinterest.setIdentifier(crop.getCropname());
        featureofinterest.setCodespaceid(Long.parseLong(null));
        featureofinterest.setName(crop.getCropdescription());
        featureofinterest.setDescriptionxml(null);
        featureofinterest.setUrl(null);
        featureofinterest.setGeom(null);

        //featureofinterest.setGeom(null);

        if ((featureofinterestJpaRepository.save(featureofinterest)) != null) {

            return true;
        }

        return false;
    }

    @Override
    public JSONObject findCropInfo(int id) {
        List<Featureofinterest> featureofinterestList = new ArrayList<Featureofinterest>();


        featureofinterestList = featureofinterestJpaRepository.findByUserid(id);

        List<Integer> featureids = new ArrayList<Integer>();

        JSONObject obj1 = new JSONObject();
        JSONArray list = new JSONArray();
        JSONObject obj = new JSONObject();


        for (int k = 0; k < featureofinterestList.size(); k++) {
            int indexl = 0;
            if (featureofinterestList.get(k).getFeatureofinteresttypeid() == 3) {

                featureids.add(indexl, featureofinterestList.get(k).getFeatureofinterestid());
                indexl++;

            } else if (featureofinterestList.get(k).getFeatureofinteresttypeid() == 1) {

                ///CROP
                obj1.put("identifier", featureofinterestList.get(k).getIdentifier());
                obj1.put("description", featureofinterestList.get(k).getName());


            } else if (featureofinterestList.get(k).getFeatureofinteresttypeid() == 2) {

                JSONObject obj2 = new JSONObject();

                //STATION
                obj2.put("identifier", featureofinterestList.get(k).getIdentifier());
                obj2.put("description", featureofinterestList.get(k).getName());
                list.add(obj2);


            }


        }

        List<Object[]> objects = new ArrayList<Object[]>();
        objects = featureofinterestJpaRepository.find(featureids);

        List<String> tempList = new ArrayList<String>();


        //END DEVICE

        JSONArray finallist = new JSONArray();
        int i = 0;
        for (Object[] obje : objects) {

            tempList.add(i, String.valueOf((obje[0])));
            i++;
        }

        HashSet hs = new HashSet(tempList);
        tempList.clear();
        tempList.addAll(hs);


        for (int j = 0; j < tempList.size(); j++) {
            JSONObject finalobject = new JSONObject();
            JSONArray list2 = new JSONArray();

            int tmcounter = 0;
            for (Object[] objet : objects) {

                if (tempList.get(j).equals(String.valueOf((objet[0])))) {

                    JSONObject tempobj = new JSONObject();

                    tempobj.put("kindofmeasurement", String.valueOf((objet[2])));
                    tempobj.put("sensorname", String.valueOf((objet[3])));
                    tempobj.put("typeofmeasurement", String.valueOf((objet[4])));

                    list2.add(tempobj);
                }

                if (tmcounter == 0) {
                    finalobject.put("description", String.valueOf((objet[1])));
                }
                tmcounter++;
            }

            finalobject.put("sensors", list2);
            finalobject.put("identifier", tempList.get(j));

            finallist.add(finalobject);
        }


        obj.put("crop", obj1);
        obj.put("stations", list);
        obj.put("devices", finallist);


        String temp = obj.toJSONString();


        return obj;
    }


    public JSONObject findByUserAndType(int id) {

        JSONObject finobj = new JSONObject();
        List<Featureofinterest> objects = new ArrayList<Featureofinterest>();
        JSONArray nlist = new JSONArray();

        long l = 3L;
        objects = featureofinterestJpaRepository.findByUseridAndFeatureofinteresttypeid(id, l);

        for (int c = 0; c < objects.size(); c++) {

            JSONObject tmpObj = new JSONObject();

            tmpObj.put("identifier", objects.get(c).getIdentifier());
            nlist.add(tmpObj);
        }

        finobj.put("enddevices", nlist);

        return finobj;
    }

    public String findByFeatureofinterestid(int id) {
        ObjectMapper mapper = new ObjectMapper();

        //Object to JSON in String
        String jsonInString = null;
        int key = 2;
        Featureofinterest featureofinterest = featureofinterestJpaRepository.findOne(key);
        try {
            List<Double> coords = Arrays.asList(featureofinterest.getGeom().getX(), featureofinterest.getGeom().getY());
            jsonInString = mapper.writeValueAsString(coords);
            //jsonInString = mapper.writeValueAsString(featureofinterest.getGeom().toString());
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

        System.out.println(jsonInString);
        return jsonInString;
    }


    public String findFeatureByIdentifier(String identi) {
        String jsonRes = null;

        Timestamp timestampFrom = null;
        Timestamp timestampTo = null;

        List<Object[]> objects = featureofinterestJpaRepository.findByIdentifier(identi);

        for (Object[] obje : objects) {
            timestampFrom = (java.sql.Timestamp) obje[0];
            timestampTo = (java.sql.Timestamp) obje[1];
        }

        Date datefrom = new Date(timestampFrom.getTime());
        Date dateto = new Date(timestampTo.getTime());

        DateTime dtFROM = new DateTime(datefrom);
        DateTime dtTO = new DateTime(dateto);


        int frHours = dtFROM.getHourOfDay();
        int frMinutes = dtFROM.getMinuteOfHour();
        int frSeconds = dtFROM.getSecondOfDay();


        int toHours = dtTO.getHourOfDay();
        int toMinutes = dtTO.getMinuteOfHour();
        int toSeconds = dtTO.getSecondOfDay();

        JSONObject TimerSetup = new JSONObject();


        TimerSetup.put("frHours", frHours);
        TimerSetup.put("frMinutes", frMinutes);
        TimerSetup.put("frSeconds", frSeconds);

        TimerSetup.put("toHours", toHours);
        TimerSetup.put("toMinutes", toMinutes);
        TimerSetup.put("toSeconds", toSeconds);


        jsonRes = TimerSetup.toJSONString();

        System.out.println(jsonRes);


        return jsonRes;
    }

    @Override
    public List<FeatureidIdentifier> findFeatureIdByIdentifier(List<String> idStr) {
        List<FeatureidIdentifier> returnedList = new ArrayList<FeatureidIdentifier>();

        List<Object[]> list = featureofinterestJpaRepository.getIdidentif(idStr);

        for (Object[] object : list) {
            //returnedList
            FeatureidIdentifier featureidIdentifier = new FeatureidIdentifier((Integer) object[0], object[1].toString());
            returnedList.add(featureidIdentifier);
        }

        return returnedList;
    }

    public Long findseries(int obs, Integer fid) {

        Long obsg = new Long(obs);

        Long fidg = Long.valueOf(fid.longValue());

        Long returnedL = null;

        List<Object[]> temOb = featureofinterestJpaRepository.serid(fidg, obsg);


        Iterator itr = temOb.iterator();
        while (itr.hasNext()) {
            returnedL = (Long) itr.next();
        }
        return returnedL;

    }

    public boolean saveTheMeasure(Long seriesId, EmbeddedData embeddedData) {
        try {
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date from = dateFormat.parse(embeddedData.getDatetime());


            Observation observation = new Observation();

            //observation.setObservationid(500L);
            observation.setSeriesid(seriesId);
            observation.setPhenomenontimestart(new Timestamp(from.getTime()));
            observation.setPhenomenontimeend(new Timestamp(from.getTime()));
            observation.setResulttime(new Timestamp(from.getTime()));
            //observation.setNumericValue(numericValue);
            observation.setIdentifier(embeddedData.getDatetime().replace("-", "").replace(":", "").replace(" ", "") + "-" + java.util.UUID.randomUUID());
            observation.setUnitid(1L);
            observation.setDeleted("F");

            //numericValue.setObservation(observation);

            observationJpaRepository.save(observation);

            NumericValue numericValue = new NumericValue();
            numericValue.setObservationid(observation.getObservationid());
            numericValue.setValue(embeddedData.getMeasureValue());
            numericValueJpaRepository.save(numericValue);


            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public String findIrrigationAndMeasuring(String corD) {

        Integer idCord = null;

        List<Object[]> cordinIds = featureofinterestJpaRepository.getIdbyIdent(corD);

        Iterator itr = cordinIds.iterator();
        while (itr.hasNext()) {
            idCord = (Integer) itr.next();
        }

        Long fidg = Long.valueOf(idCord.longValue());

        List<Object[]> identiFlagsObjects = featureofinterestJpaRepository.getIdentifierFlags(fidg);

        JSONArray retur = new JSONArray();

        for (Object[] objec : identiFlagsObjects) {

            JSONObject element = new JSONObject();

            element.put("identifier", String.valueOf(objec[0]));
            element.put("irrigation", String.valueOf(objec[1]));
            element.put("measurement", String.valueOf(objec[2]));

            retur.add(element);
        }

        JSONObject finObj = new JSONObject();

        finObj.put("Data", retur);


        System.out.println(finObj.toJSONString());

        return finObj.toJSONString();
    }


    public String changeMeasuringFlag(int usid, long typeId) {

        JSONObject returned = new JSONObject();


        try {

            featureofinterestJpaRepository.setMeasuringFlag(usid, typeId);

            returned.put("Flag", "true");


        } catch (Exception e) {


            System.out.println(e);

            returned.put("Flag", "false").toString();
        }


        System.out.println(returned.toJSONString());

        return returned.toJSONString();


    }


}