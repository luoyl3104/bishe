package com.baizhi.controller;


import com.baizhi.entity.Emp;
import com.baizhi.service.EmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("emp")
public class EmsController {

    @Autowired
    private EmpService emsService;

    @RequestMapping("findAll")
    @ResponseBody
    public Map<String,Object> findAll(Integer page,Integer rows){
        HashMap<String,Object> hashMap = new HashMap();
        List<Emp> all = emsService.findAll();
        List<Emp> list = emsService.findAll(page, rows);
        long size = all.size();
        long totalsPage = size%rows==0?size/rows:(size/rows+1);
        hashMap.put("records",size);
        hashMap.put("total",totalsPage);
        hashMap.put("page",page);
        hashMap.put("rows",list);
        return hashMap;
    }

}
