package com.zzu.service.impl;

import com.zzu.dao.AdminDAO;
import com.zzu.entity.Admin;
import com.zzu.service.AdminService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Service
@Transactional
public class AdminServiceImpl implements AdminService {

    @Resource
    private AdminDAO adminDAO;


    @Override
    public Map<String, Object> login(Admin admin) {
        HashMap<String, Object> map = new HashMap<>();
        String message;
        Admin login = adminDAO.login(admin.getName());
        if(login == null){
            message = "您输入的用户名不存在~！";
            map.put("message",message);
        }else {
            if(login.getPassword().equals(admin.getPassword())){
                HttpSession session = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest().getSession();
                session.setAttribute("admin",login);
                map.put("message","success");
            }else {
                message = "您输入的密码有误~！";
                map.put("message",message);
            }
        }
        return map;
    }
}
