package com.webstart.service;

import com.webstart.model.Crop;
import org.json.simple.JSONObject;

import java.util.List;

/**
 * Created by George on 9/6/2016.
 */
public interface AddCropService {


        boolean addCrop(Crop crop);

        public JSONObject findCropInfo(int id);

}
