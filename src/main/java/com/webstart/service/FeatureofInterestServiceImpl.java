package com.webstart.service;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.webstart.DTO.*;
import com.webstart.model.*;
import com.webstart.repository.FeatureofinterestJpaRepository;

import com.webstart.repository.NumericValueJpaRepository;
import com.webstart.repository.ObservationJpaRepository;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.DateTimeException;
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

    //TODO CHAOS A.D sepultura
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
        objects = featureofinterestJpaRepository.getFeatureByIds(featureids);

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

        objects = featureofinterestJpaRepository.findByUseridAndFeatureofinteresttypeid(id, 3L);

        for (int c = 0; c < objects.size(); c++) {
            JSONObject tmpObj = new JSONObject();
            tmpObj.put("identifier", objects.get(c).getIdentifier());
            nlist.add(tmpObj);
        }

        finobj.put("enddevices", nlist);

        return finobj;
    }

    public String findByIdentifier(String coordinator) {
        String jsonresult = null;

        try {
            List<String> results = featureofinterestJpaRepository.findEndDevicesByCoord(coordinator);
            ObjectMapper mapper = new ObjectMapper();
            jsonresult = mapper.writeValueAsString(results);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return jsonresult;
    }

    public String findMinMaxbyUserId(Integer userid) {
        String jsonInString = null;
        try {
            List<FeatureObsPropMinMax> results = featureofinterestJpaRepository.findFeatureMiMaxValuesByUserId(userid);

            List<FeatureObsProp> featureobsPropList = new ArrayList<FeatureObsProp>();
            featureobsPropList.add(new FeatureObsProp((Integer) results.get(0).getFeatureofinterestid(), results.get(0).getIdentifier(), results.get(0).getName()));

            for (FeatureObsPropMinMax obj : results) {
                boolean newaddition = true;
                for (int i = 0; i < featureobsPropList.size(); i++) {
                    FeatureObsProp feature = featureobsPropList.get(i);
                    if (obj.getFeatureofinterestid() == feature.getFeatureofinterestid()) {
                        newaddition = false;
                    }
                }

                if (newaddition) {
                    featureobsPropList.add(new FeatureObsProp(obj.getFeatureofinterestid(), obj.getIdentifier(), obj.getName()));
                }
            }

            for (FeatureObsPropMinMax obj : results) {
                for (FeatureObsProp feature : featureobsPropList) {
                    if (obj.getFeatureofinterestid() == feature.getFeatureofinterestid()) {
                        feature.getFeatureObsproplist().add(new FeatureMinMaxValue((obj.getObspropertyid()).longValue(), obj.getObspropertName(), obj.getMinval(), obj.getMaxval()));
                    }
                }
            }

            //Object to JSON in String
            ObjectMapper mapper = new ObjectMapper();
            jsonInString = mapper.writeValueAsString(featureobsPropList);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

        return jsonInString;

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

        try {
            List<Object[]> objects = featureofinterestJpaRepository.findDatesByIdentifier(identi);

            if (objects.size() == 0)
                return jsonRes;

            Timestamp timestampFrom = (java.sql.Timestamp) objects.get(0)[0];
            Timestamp timestampTo = (java.sql.Timestamp) objects.get(0)[1];

            DateTime dtFROM = new DateTime(timestampFrom.getTime());
            DateTime dtTO = new DateTime(timestampTo.getTime());

            JSONObject TimerSetup = new JSONObject();
            TimerSetup.put("frHours", dtFROM.getHourOfDay());
            TimerSetup.put("frMinutes", dtFROM.getMinuteOfHour());
            TimerSetup.put("frSeconds", dtFROM.getSecondOfDay());
            TimerSetup.put("toHours", dtTO.getHourOfDay());
            TimerSetup.put("toMinutes", dtTO.getMinuteOfHour());
            TimerSetup.put("toSeconds", dtTO.getSecondOfDay());

            jsonRes = TimerSetup.toJSONString();
        } catch (DateTimeException exc) {
            exc.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            return jsonRes;
        }
    }

    public List<FeatureidIdentifier> findFeatureIdByIdentifier(List<String> idStr) {
        try {
            List<FeatureidIdentifier> list = featureofinterestJpaRepository.getIdidentif(idStr);
            return list;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    //TODO lol lol lol what the iterator means?
    public Long findseries(int obs, Integer fid) {
        Long obsg = new Long(obs);
        Long fidg = Long.valueOf(fid.longValue());
        Long returnedL = null;
        List<Long> temOb = featureofinterestJpaRepository.getAllSeriesId(fidg, obsg);

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

            observation.setSeriesid(seriesId);
            observation.setPhenomenontimestart(new Timestamp(from.getTime()));
            observation.setPhenomenontimeend(new Timestamp(from.getTime()));
            observation.setResulttime(new Timestamp(from.getTime()));
            observation.setIdentifier(embeddedData.getDatetime().replace("-", "").replace(":", "").replace(" ", "") + "-" + java.util.UUID.randomUUID());
            observation.setUnitid(1L);
            observation.setDeleted("F");

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

    //TODO change this mess
    public String findIrrigationAndMeasuring(String corD) {
        Integer idCord = null;

        List<Integer> cordinIds = featureofinterestJpaRepository.getIdbyIdent(corD);

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
            return returned.put("Flag", "true").toString();
        } catch (Exception e) {
            e.printStackTrace();
            return returned.put("Flag", "false").toString();
        }
    }

    public boolean setDeviceIrrigaDate(int usid, String device, Date from, Date to) {
        try {
            featureofinterestJpaRepository.setDeviceIrrigDates(usid, device, from, to);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


}