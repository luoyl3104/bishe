package com.zzu.controller;

import com.zzu.entity.View;
import com.zzu.service.ViewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@ResponseBody
@RequestMapping("view")
public class ViewController {

    @Autowired
    private ViewService viewService;

    @RequestMapping("queryView")
    public Map<String,Object> queryByPage(Integer page,Integer rows){
        HashMap<String, Object> map = new HashMap<>();
        Long totals = viewService.findTotals();
        Integer start = (page - 1)*rows;
        List<View> views = viewService.findByPage(start, rows);
        Long pageTotal = totals%rows==0?totals/rows:totals/rows+1;
        map.put("rows",views);
        map.put("records",totals);
        map.put("total",pageTotal);
        map.put("page",page);
        return map;
    }

    @RequestMapping("queryOne")
    public View queryOne(String id){
        View view = viewService.findOne(id);
        return view;
    }


    @RequestMapping("remove")
    public void removeView(String id){
        viewService.removeView(id);
    }

    //管理员修改状态
    @RequestMapping("updateType")
    public void updateType(View view){
        if(view.getType().equals("开放")){
            view.setType("关闭");
        }else {
            view.setType("开放");
        }
        viewService.updateType(view);
    }

}
