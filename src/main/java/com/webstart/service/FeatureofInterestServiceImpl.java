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

import java.math.BigDecimal;
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

    public JSONObject findCropInfo(int id) {
        List<Featureofinterest> featureofinterestList = featureofinterestJpaRepository.findByUserid(id);
        List<Integer> featureids = new ArrayList<Integer>();

        JSONObject obj1 = new JSONObject();
        JSONArray list = new JSONArray();
        JSONObject obj = new JSONObject();

        for (int k = 0; k < featureofinterestList.size(); k++) {
            if (featureofinterestList.get(k).getFeatureofinteresttypeid() == 3) {
                featureids.add(featureofinterestList.get(k).getFeatureofinterestid());
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

        List<CropInfoDTO> cropInfoList = featureofinterestJpaRepository.getFeatureByIds(featureids);
        List<String> tempList = new ArrayList<String>();


        //END DEVICE
        JSONArray finallist = new JSONArray();
        for (CropInfoDTO cropInfoDTO : cropInfoList) {
            tempList.add(String.valueOf((cropInfoDTO.getFeatureIdentifier())));
        }

        HashSet hs = new HashSet(tempList);
        tempList.clear();
        tempList.addAll(hs);

        for (int j = 0; j < tempList.size(); j++) {
            JSONObject finalobject = new JSONObject();
            JSONArray list2 = new JSONArray();

            int tmcounter = 0;
            for (CropInfoDTO cropInfoDTO : cropInfoList) {
                if (tempList.get(j).equals(String.valueOf((cropInfoDTO.getFeatureIdentifier())))) {
                    JSONObject tempobj = new JSONObject();
                    tempobj.put("kindofmeasurement", String.valueOf((cropInfoDTO.getObservableIdentifier())));
                    tempobj.put("sensorname", String.valueOf((cropInfoDTO.getProcedureIdentifier())));
                    tempobj.put("typeofmeasurement", String.valueOf((cropInfoDTO.getProcedureDescription())));
                    list2.add(tempobj);
                }

                if (tmcounter == 0) {
                    finalobject.put("description", String.valueOf((cropInfoDTO.getFeatureName())));
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

        //String temp = obj.toJSONString();
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

    public List<FeatureObsPropMinMax> findminmaxObservationValues(String identifier) {
        List<FeatureObsPropMinMax> results = null;
        try {
            results = featureofinterestJpaRepository.findChildMiMaxValuesByIdentifier(identifier);
        } catch (Exception exc) {
            exc.printStackTrace();
        }

        return results;

    }

    public String findMinMaxbyUserId(Integer userid) {
        String jsonInString = null;
        try {
            List<FeatureObsPropMinMax> results = featureofinterestJpaRepository.findFeatureMiMaxValuesByUserId(userid);

            List<FeatureObsProp> featureobsPropList = new ArrayList<FeatureObsProp>();
            featureobsPropList.add(new FeatureObsProp(results.get(0).getFeatureofinterestid(), results.get(0).getIdentifier(), results.get(0).getName()));

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
                        feature.getFeatureObsproplist().add(new FeatureMinMaxValue((obj.getObspropvalId()).longValue(), obj.getObspropertName(), obj.getMinval(), obj.getMaxval()));
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

        return jsonInString;
    }

    public String findFeatureByIdentifier(String identifier) {
        String jsonRes = null;

        try {
            List<Object[]> objects = featureofinterestJpaRepository.findDatesByIdentifier(identifier);


            if (objects.size() == 0)
                return jsonRes;

            Timestamp timestampFrom = (java.sql.Timestamp) objects.get(0)[0];
            Timestamp timestampTo = (java.sql.Timestamp) objects.get(0)[1];

            DateTime dtFROM = new DateTime(timestampFrom.getTime());
            DateTime dtTO = new DateTime(timestampTo.getTime());

            JSONObject Setup = new JSONObject();
            Setup.put("frHours", dtFROM.getHourOfDay());
            Setup.put("frMinutes", dtFROM.getMinuteOfHour());
            Setup.put("frSeconds", dtFROM.getSecondOfDay());
            Setup.put("toHours", dtTO.getHourOfDay());
            Setup.put("toMinutes", dtTO.getMinuteOfHour());
            Setup.put("toSeconds", dtTO.getSecondOfDay());

            jsonRes = Setup.toJSONString();
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

    public List<EmebddedSetupDevicdeDto> findEndDevicesTimes(String coordinatorAddress) {
        try {
            List<Object[]> list = featureofinterestJpaRepository.getEnddevicesTimes(coordinatorAddress);
            List<EmebddedSetupDevicdeDto> endDeviceList = new ArrayList<EmebddedSetupDevicdeDto>();
            for (Object[] obj : list) {
                endDeviceList.add(new EmebddedSetupDevicdeDto(obj[0].toString(), Integer.parseInt(obj[1].toString()), Integer.parseInt(obj[2].toString()), Integer.parseInt(obj[3].toString()), Integer.parseInt(obj[4].toString())));
            }

            return endDeviceList;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public EmebddedSetupDevicdeDto findCoordinatorTimes(String coordinatorAddress) {
        try {
            List<Object[]> list = featureofinterestJpaRepository.getCoordinatorTimes(coordinatorAddress);
            if (list.size() == 0)
                return null;

            EmebddedSetupDevicdeDto coordinatorTimes = new EmebddedSetupDevicdeDto(
                    coordinatorAddress,
                    Integer.parseInt(list.get(0)[1].toString()),
                    Integer.parseInt(list.get(0)[2].toString()),
                    Integer.parseInt(list.get(0)[3].toString()),
                    Integer.parseInt(list.get(0)[4].toString()));

            return coordinatorTimes;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    public Long findseries(int obs, Integer fid) {
        Long returnedL = null;

        try {
            Long obsg = Long.valueOf(obs);
            Long fidg = Long.valueOf(fid.longValue());

            List<Long> temOb = featureofinterestJpaRepository.getAllSeriesId(fidg, obsg);
            if (temOb.size() > 0)
                returnedL = temOb.get(0);
        } catch (Exception exc) {
            exc.printStackTrace();
        } finally {
            return returnedL;
        }
    }


    public String findIrrigationAndMeasuring(String corD) {
        String jsonresult = null;

        try {
            Integer idCord = null;

            List<Integer> cordinIds = featureofinterestJpaRepository.getIdbyIdent(corD);

            Iterator itr = cordinIds.iterator();
            while (itr.hasNext()) {
                idCord = (Integer) itr.next();
            }

            Long fidg = Long.valueOf(idCord.longValue());

            List<EndDeviceStatusDTO> identiFlagsObjects = featureofinterestJpaRepository.getIdentifierFlags(fidg);

            ObjectMapper mapper = new ObjectMapper();
            jsonresult = mapper.writeValueAsString(identiFlagsObjects);
        } catch (JsonProcessingException exc) {
            exc.printStackTrace();
        } finally {
            return jsonresult;
        }
    }

    public String changeMeasuringFlag(int usid, long typeId) {
        JSONObject returned = new JSONObject();

        try {
            featureofinterestJpaRepository.setMeasuringFlag(usid, typeId);
            returned.put("Flag", "true");
            return returned.toString();
        } catch (Exception e) {
            e.printStackTrace();
            returned.put("Flag", "false");
            return returned.toString();
        }
    }

    public AutomaticWater getAutomaticWater(int userid, String identifier) {
        AutomaticWater automaticWater = null;

        try {
            automaticWater = featureofinterestJpaRepository.getAutomaticWater(userid, identifier);
            return automaticWater;
        } catch (Exception exc) {
            exc.printStackTrace();
        } finally {
            return automaticWater;
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

    public void setFeatureMeasuringFalse(List<String> idertifierList) {
        try {
            featureofinterestJpaRepository.setMeasuringFlagFalse(idertifierList);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setAutomaticWateringTime(AutomaticWater automaticWater, int userid) {
        try {
            featureofinterestJpaRepository.setCoordinatorAlgorithmParams(automaticWater.getIdentifier(), automaticWater.getFromtime(), automaticWater.getUntiltime(), automaticWater.getWateringConsumption());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}