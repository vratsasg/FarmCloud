package com.webstart.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.webstart.model.Users;
import com.webstart.service.UsersService;
import jdk.nashorn.api.scripting.JSObject;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping(value="/")
public class IndexController {

    @Autowired
    private UsersService usersService;

    @RequestMapping(value="/",method= RequestMethod.GET)
    public String getIndexPage() {
        //  usersList= usersService.findAll();
        return "index";
    }


    @RequestMapping(value="/login",method=RequestMethod.POST)
    public String validate(@RequestParam("username_n") String username, @RequestParam("password_n") String password,Model model,HttpServletRequest request ){
        Users users = usersService.findUser(username,password);

        if(users==null){
            model.addAttribute("alert_message", "Wrong Username/Password!");
            model.addAttribute("alert_class", "alert alert-danger");
            return "index";
        }else{
            request.getSession().setAttribute("current_user",users);
            users=(Users)request.getSession().getAttribute("current_user");

            model.addAttribute("current_user",users);
            return "home";
        }
    }

    @RequestMapping(value="/logout",method=RequestMethod.POST)
    public String signout(Model model,HttpServletRequest request){
        request.getSession().removeAttribute("current_user");
        model.addAttribute("alert_message", "You have successfully log out!");
        model.addAttribute("alert_class", "alert alert-success alert_successSave");

        return "index";
    }

    @RequestMapping(value = "/topbaruser", method = RequestMethod.GET)
    public ResponseEntity<String> getObsProperties(HttpServletRequest request) throws JsonProcessingException {
        Users users;
        users = (Users) request.getSession().getAttribute("current_user");
        //
        JSONObject jsonObject;
        jsonObject = usersService.userByJson(users.getUser_id());

        return new ResponseEntity<String>(jsonObject.toJSONString(), HttpStatus.OK);
    }

}