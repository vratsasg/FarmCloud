package com.webstart.service;


import com.webstart.model.Crop;
import com.webstart.model.Featureofinterest;
import com.webstart.repository.FeatureofinterestJpaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("addCropService")
@Transactional
public class AddCropServiceImpl implements AddCropService {

    @Autowired
    FeatureofinterestJpaRepository featureofinterestJpaRepository;


    Featureofinterest featureofinterest=new Featureofinterest();

    @Override
    public boolean addCrop(Crop crop){

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

        if((featureofinterestJpaRepository.save(featureofinterest))!=null){

            return true;

        }

        return false;
    }


}