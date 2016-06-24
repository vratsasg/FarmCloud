package com.webstart.service;


import com.webstart.model.Crop;
import com.webstart.model.Featureofinterest;
import com.webstart.repository.FeatureofinterestJpaRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

import java.util.HashSet;
import java.util.List;


import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

@Service("addCropService")
@Transactional
public class FeatureofInterestImpl implements FeatureofInterest {

    @Autowired
    FeatureofinterestJpaRepository featureofinterestJpaRepository;


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


}