package com.zzu.controller;

import com.zzu.entity.Province;
import com.zzu.service.ProvinceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("province")
public class ProvinceController {

    @Autowired
    private ProvinceService provinceService;

    @RequestMapping("queryAll")
    public String queryAll(HttpServletRequest request){
        List<Province> provinces = provinceService.findAll();
        request.setAttribute("provinces",provinces);
        return "register";
    }

}
