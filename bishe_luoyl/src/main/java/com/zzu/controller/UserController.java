package com.zzu.controller;


import com.zzu.entity.Province;
import com.zzu.entity.User;
import com.zzu.entity.UserEcharts;
import com.zzu.entity.UserList;
import com.zzu.service.ProvinceService;
import com.zzu.service.UserService;
import org.apache.commons.io.FilenameUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

@RestController
@RequestMapping("user")
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private ProvinceService provinceService;

    //修改个人信息
    @RequestMapping("update")
    public Map<String,Object> editUser(User user){
        Map<String, Object> map = userService.updateUser(user);
        return map;
    }

    //回显个人信息
    @RequestMapping("mine")
    public Map<String,Object> queryOne(HttpSession session){
        Map<String,Object> map = new HashMap<>();
        List<Province> provinces = provinceService.findAll();
        map.put("provinces",provinces);
        User user = (User) session.getAttribute("user");
        User one = userService.findOne(user);
        map.put("user",one);
        //System.out.println(one);
        return map;
    }

    //安全退出
    @RequestMapping("exit")
    public void exit(HttpSession session){
        session.invalidate();
    }

    //登陆验证
    @RequestMapping("login")
    public Map<String,Object> login(User user){
        Map<String, Object> map = userService.login(user);
        return map;
    }
    //注册
    @RequestMapping("register")
    public Map<String,Object> register(MultipartFile aaa ,User user,HttpServletRequest request) throws IOException {
        Map<String,Object> map = new HashMap<>();
        User user1 = userService.findByUsername(user.getUsername());
        //System.out.println("---------------"+user.getProvince().getId());
        if(user1 == null){
            //上传头像
            String realPath = request.getSession().getServletContext().getRealPath("/userAvatars");
            //获取文件名
            String filename = aaa.getOriginalFilename();
            //获取文件类型
            String extension = FilenameUtils.getExtension(filename);
            //以当前系统时间戳为新的文件名
            long time = new Date().getTime();
            String newFilename = String.valueOf(time) + "." +extension;
            //完成文件上传
            aaa.transferTo(new File(realPath,newFilename));
            user.setAvatar(newFilename);
            userService.register(user);
            map.put("success",true);
        }else {
            map.put("success",false);
        }
        return map;
    }

    //修改用户状态
    @RequestMapping("updateType")
    public void updateType(User user){
        if(user.getType().equals("激活")){
            user.setType("冻结");
        }else {
            user.setType("激活");
        }
        userService.updateType(user);
    }

    @RequestMapping("queryByPage")
    public Map<String,Object> queryByPage(Integer page,Integer rows){
        HashMap<String, Object> map = new HashMap<>();
        Integer start = (page-1)*rows;
        List<User> users = userService.findByPage(start, rows);
        Long totals = userService.findTotals();
        Long pageTotal = totals%rows==0?totals/rows:totals/rows+1;
        map.put("page",page);
        map.put("total",pageTotal);
        map.put("records",totals);
        map.put("rows",users);
        return map;
    }

    //导出用户信息
    @RequestMapping("export")
    public void export(HttpServletResponse response, HttpServletRequest request) throws IOException {
        HSSFWorkbook workbook = new HSSFWorkbook();
        //导出的表
        HSSFSheet user = workbook.createSheet("user");
        //行 参数：下标
        HSSFRow row = user.createRow(0);

        //表头
        String[] strs = {"id","username","password","sex","phone","email","type","registDate"};
        for (int i = 0;i<strs.length;i++){
            HSSFCell cell = row.createCell(i);
            cell.setCellValue(strs[i]);
        }
        //调用业务层获取数据
        List<User> users = userService.findAll();

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        for(int i = 0;i<users.size();i++){
            HSSFRow row1 = user.createRow(i + 1);
            row1.createCell(0).setCellValue(users.get(i).getId());
            row1.createCell(1).setCellValue(users.get(i).getUsername());
            row1.createCell(2).setCellValue(users.get(i).getPassword());
            row1.createCell(3).setCellValue(users.get(i).getSex());
            row1.createCell(5).setCellValue(users.get(i).getPhone());
            row1.createCell(6).setCellValue(users.get(i).getEmail());
            row1.createCell(7).setCellValue(users.get(i).getType());
            String format = sdf.format(users.get(i).getRegistDate());
            row1.createCell(8).setCellValue(format);
        }
        //设置表名
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String format = simpleDateFormat.format(new Date());
        String fileName = "用户信息表" + "-" + format + ".xls" ;
        //设置响应头
        response.setHeader("content-disposition","attachment;fileName="+ URLEncoder.encode(fileName,"UTF-8"));
        //设置响应类型
        response.setContentType("application/vnd.ms-excel");

        ServletOutputStream outputStream = response.getOutputStream();
        try{
            workbook.write(outputStream);
            workbook.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //用户分布图
    @RequestMapping("map")
    public Map<String,Object> map(){
        HashMap<String, Object> map = new HashMap<>();
        ArrayList<UserEcharts> boys = new ArrayList<>();
        ArrayList<UserEcharts> girls = new ArrayList<>();
        List<UserList> echarts = userService.echarts();
        for (UserList userList : echarts) {
            List<UserEcharts> userEcharts = userList.getUserEcharts();
            for (UserEcharts userEchart : userEcharts) {
                if(userEchart.getSex().equals("男")){
                    boys.add(userEchart);
                }else {
                    girls.add(userEchart);
                }
            }
        }
        map.put("boy",boys);
        map.put("girl",girls);
        return map;
    }

}
