package com.zzu.controller;

import com.zzu.entity.Comment;
import com.zzu.entity.Province;
import com.zzu.entity.User;
import com.zzu.entity.View;
import com.zzu.service.CommentService;
import com.zzu.service.ProvinceService;
import com.zzu.service.ViewService;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Date;
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

    //删除信息
    @RequestMapping("del")
    public void remove(String id){
        viewService.removeView(id);
        commentService.deleteByViewId(id);
    }

    //查询地址
    @RequestMapping("queryAllProvince")
    public Map<String,Object> queryAllProvince(){
        HashMap<String, Object> map = new HashMap<>();
        List<Province> provinces = provinceService.findAll();
        map.put("provinces",provinces);
        return map;
    }

    //添加景点信息
    @RequestMapping("addView")
    public Map<String,Object> addView(MultipartFile file, HttpSession session, View view) throws IOException {
        Map<String,Object> map = new HashMap<>();
        User user = (User) session.getAttribute("user");
        if(user == null){
            map.put("message",false);
        }else {
            //图片上传
            String realPath = session.getServletContext().getRealPath("/uploadViews");
            //获取文件名
            String filename = file.getOriginalFilename();
            //获取文件类型
            String extension = FilenameUtils.getExtension(filename);
            //以当前系统时间戳为新的文件名
            long time = new Date().getTime();
            String newFilename = String.valueOf(time) + "." +extension;
            //完成文件上传
            file.transferTo(new File(realPath,newFilename));
            view.setUser(user);
            view.setPath("uploadViews/"+newFilename);
            view.setPicture(newFilename);
            //添加到数据库
            viewService.addView(view);
            map.put("message",true);
        }
        return map;
    }

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
    public Map<String,Object> myView(Integer page,HttpSession session){
        HashMap<String, Object> map = new HashMap<>();
        User user = (User) session.getAttribute("user");
        if(user == null){
            map.put("message",false);
        }else {
            List<View> views = viewService.findByUser(null, null);
            Long totals = Long.valueOf(views.size());
            Long pageTotal = totals%3==0?totals/3:totals/3+1;
            List<Comment> comments = commentService.findAll();
            map.put("views",views);
            map.put("pageTotal",pageTotal);
            map.put("comments",comments);
            map.put("pageNow",page);
            map.put("message",true);
        }
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
    public Map<String,Object> queryByPage(View view,Integer page,String provinceId){
        HashMap<String, Object> map = new HashMap<>();
        Long totals = viewService.findTotals();
        Integer rows = 10;
        page = page == null?1:page;
        Integer start = (page - 1)*rows;
        Province province = new Province();
        province.setId(provinceId);
        view.setProvince(province);
        List<View> views = viewService.findByPage(start, rows,view);
        Long pageTotal = totals%rows==0?totals/rows:totals/rows+1;
        map.put("views",views);
        map.put("totals",totals);
        map.put("pageTotal",pageTotal);
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
    public void updateType(String id){
        //System.out.println("=============="+id);
        View view = viewService.findOne(id);
        if(view.getType().equals("开放")){
            view.setType("关闭");
        }else {
            view.setType("开放");
        }
        viewService.updateType(view);
    }

}
