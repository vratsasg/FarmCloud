package com.webstart.service;


import com.webstart.model.Crop;
import com.webstart.model.Featureofinterest;
import com.webstart.repository.FeatureofinterestJpaRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

@Service("addCropService")
@Transactional
public class AddCropServiceImpl implements AddCropService {

    @Autowired
    FeatureofinterestJpaRepository featureofinterestJpaRepository;


    Featureofinterest featureofinterest = new Featureofinterest();

    @Override
    public boolean addCrop(Crop crop) {

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

        JSONObject obj = new JSONObject();
        JSONObject obj1 = new JSONObject();


        JSONArray list = new JSONArray();
        JSONArray list2 = new JSONArray();


        for (int i = 0; i < featureofinterestList.size(); i++) {

            if (featureofinterestList.get(i).getFeatureofinteresttypeid() == 1) {

                obj1.put("identifier", featureofinterestList.get(i).getIdentifier());
                obj1.put("description", featureofinterestList.get(i).getName());


            } else if (featureofinterestList.get(i).getFeatureofinteresttypeid() == 2) {

                JSONObject obj2 = new JSONObject();

                obj2.put("identifier", featureofinterestList.get(i).getIdentifier());
                obj2.put("description", featureofinterestList.get(i).getName());
                list.add(obj2);


            } else if (featureofinterestList.get(i).getFeatureofinteresttypeid() == 3) {

                JSONObject obj3 = new JSONObject();
                obj3.put("identifier", featureofinterestList.get(i).getIdentifier());
                obj3.put("description", featureofinterestList.get(i).getName());
                list2.add(obj3);


            } else {

                return null;
            }


        }

        obj.put("crop", obj1);
        obj.put("stations", list);
        obj.put("devices", list2);


        String temp = obj.toJSONString();

        System.out.println(temp);

        return obj;
    }
}