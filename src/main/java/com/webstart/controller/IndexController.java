package com.webstart.controller;

import com.webstart.model.Users;
import com.webstart.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by George on 23/12/2015.
 */
@Controller
@RequestMapping(value="/")
public class IndexController {

    @Autowired
    private UsersService usersService;

    private List<Users> usersList= new ArrayList<Users>();


    @RequestMapping(value="/",method= RequestMethod.GET)
    public String getIndexPage() {


        usersList= usersService.findAll();

        return "index";
    }


    @RequestMapping(value="/login",method=RequestMethod.POST)
    public String validate(@RequestParam("username_n") String username, @RequestParam("password_n") String password,Model model,HttpServletRequest request ){

        System.out.println(username + "" + password);

        Users users;
        users=usersService.findUser(username,password);


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
        model.addAttribute("alert_class", "alert alert-success alert_messa");

        return "index";
    }



}