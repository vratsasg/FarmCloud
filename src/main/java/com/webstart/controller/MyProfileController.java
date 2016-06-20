package com.webstart.controller;

import com.webstart.model.Featureofinterest;
import com.webstart.model.Users;
import com.webstart.service.AddCropService;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.beans.factory.annotation.Value;

@Controller
public class MyProfileController {


    @Autowired
    AddCropService addCropService;


    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public ResponseEntity<String> getProfile(HttpServletRequest request) {


        Users users = (Users) request.getSession().getAttribute("current_user");
        JSONObject obj = new JSONObject();

        obj = addCropService.findCropInfo(users.getUser_id());


        System.out.println("mphka sto profile");

        return new ResponseEntity<String>(obj.toJSONString(), HttpStatus.OK);
    }
}
