package com.zzu.controller;


import com.zzu.entity.Admin;
import com.zzu.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
@RequestMapping("admin")
public class AdminController {

    @Autowired
    private AdminService adminService;


    @RequestMapping("login")
    @ResponseBody
    public Map<String,Object> login(Admin admin){
        Map<String, Object> map = adminService.login(admin);
        return map;
    }

    //验证码验证
    @RequestMapping("checkCode")
    @ResponseBody
    public boolean checkCode(String code, HttpSession session){
        String text = (String) session.getAttribute("code");
        if(code.equals(text)){
            return true;
        }else {
            return false;
        }
    }

    //退出登录
    @RequestMapping("exit")
    public String exit(HttpSession session){
        session.invalidate();
        return "adminLogin";
    }
}
