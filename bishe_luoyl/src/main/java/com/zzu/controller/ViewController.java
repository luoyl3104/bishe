package com.zzu.controller;

import com.zzu.entity.Comment;
import com.zzu.entity.Province;
import com.zzu.entity.View;
import com.zzu.service.CommentService;
import com.zzu.service.ProvinceService;
import com.zzu.service.ViewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("view")
public class ViewController {

    @Autowired
    private ViewService viewService;
    @Autowired
    private CommentService commentService;
    @Autowired
    private ProvinceService provinceService;


    //展示详情
    @RequestMapping("viewDetail")
    public Map<String,Object> viewDetail(String viewId){
        HashMap<String, Object> map = new HashMap<>();
        View view = viewService.findOne(viewId);
        List<Comment> comments = commentService.findByViewId(viewId);
        map.put("view",view);
        map.put("comments",comments);
        return map;
    }

    //与我相关
    @RequestMapping("myView")
    public Map<String,Object> myView(Integer page){
        HashMap<String, Object> map = new HashMap<>();
        List<View> views = viewService.findByUser(null, null);
        Long totals = Long.valueOf(views.size());
        Long pageTotal = totals%3==0?totals/3:totals/3+1;
        List<Comment> comments = commentService.findAll();
        map.put("views",views);
        map.put("pageTotal",pageTotal);
        map.put("comments",comments);
        map.put("pageNow",page);
        return map;
    }

    //前台图片展示
    @RequestMapping("img")
    public Map<String,Object> img(){
        HashMap<String, Object> map = new HashMap<>();
        List<View> views = viewService.findByUser(0,5);
        List<Province> provinces = provinceService.findAll();
        map.put("views",views);
        map.put("provinces",provinces);
        return map;
    }

    //用于后台管理
    @RequestMapping("queryView")
    public Map<String,Object> queryByPage(Integer page,Integer rows){
        HashMap<String, Object> map = new HashMap<>();
        Long totals = viewService.findTotals();
        Integer start = (page - 1)*rows;
        View view = new View();
        Province province = new Province();
        view.setProvince(province);
        List<View> views = viewService.findByPage(start, rows,view);
        Long pageTotal = totals%rows==0?totals/rows:totals/rows+1;
        map.put("rows",views);
        map.put("records",totals);
        map.put("total",pageTotal);
        map.put("page",page);
        return map;
    }

    //前台展示
    @RequestMapping("show")
    public Map<String,Object> showAll(Integer page,String name,String provinceId){
        Map<String, Object> map = new HashMap<>();
        Long totals = viewService.findTotals();
        Integer start;
        Integer pageNow = page == null?1:page;
        if(page==null){
            start = 0;
        }else {
            start = (page-1)*3;
        }
        View view = new View();
        view.setName(name);
        Province province = new Province();
        province.setId(provinceId);
        view.setProvince(province);
        List<View> views = viewService.findByPage(start, 3, view);
        Long pageTotal = totals%3==0?totals/3:totals/3+1;
        List<Comment> comments = commentService.findAll();
        map.put("views",views);
        map.put("pageTotal",pageTotal);
        map.put("comments",comments);
        map.put("pageNow",pageNow);
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
