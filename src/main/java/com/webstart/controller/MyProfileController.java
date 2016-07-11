package com.webstart.controller;

import com.webstart.model.Users;
import com.webstart.service.FeatureofInterestService;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@Controller
public class MyProfileController {


    @Autowired
    FeatureofInterestService featureofInterestService;

    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public ResponseEntity<String> getProfile(HttpServletRequest request) {
        Users users = (Users) request.getSession().getAttribute("current_user");
        JSONObject obj = new JSONObject();

        obj = featureofInterestService.findCropInfo(users.getUser_id());

        return new ResponseEntity<String>(obj.toJSONString(), HttpStatus.OK);
    }
}
