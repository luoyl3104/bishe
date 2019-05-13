package com.zzu.service.impl;

import com.zzu.dao.UserDAO;
import com.zzu.dao.UserEchartsDAO;
import com.zzu.entity.User;
import com.zzu.entity.UserList;
import com.zzu.service.UserService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.*;

@Service
@Transactional
public class UserServiceImpl implements UserService {

    @Resource
    private UserDAO userDAO;
    @Resource
    private UserEchartsDAO userEchartsDAO;

    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public List<User> findByPage(Integer start, Integer rows) {
        return userDAO.selectByPage(start,rows);
    }

    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public Long findTotals() {
        return Long.valueOf(userDAO.selectCount(new User()));
    }

    @Override
    public List<User> findAll() {
        return userDAO.selectAll();
    }

    @Override
    public List<UserList> echarts() {
        return userEchartsDAO.findAll();
    }

    @Override
    public void updateType(User user) {
        userDAO.updateByPrimaryKeySelective(user);
    }

    @Override
    public void register(User user) {
        user.setType("激活");
        user.setId(UUID.randomUUID().toString());
        user.setRegistDate(new Date());
        userDAO.insertUser(user);
    }

    //用于回显
    @Override
    public User findOne(User user) {
       return userDAO.selectByUsername(user.getUsername());
    }

    @Override
    public User findByUsername(String username) {
        return userDAO.selectByUsername(username);
    }

    @Override
    public Map<String,Object> login(User user) {
        HashMap<String, Object> map = new HashMap<>();
        String message;
        User loginUser = userDAO.selectByUsername(user.getUsername());
        if(loginUser == null){
            message = "用户名不存在~！";
            map.put("message",message);
        }else{
            if(loginUser.getPassword().equals(user.getPassword())){
                if(loginUser.getType().equals("冻结")){
                    message = "该用户已被冻结~！";
                    map.put("message",message);
                }else {
                    HttpSession session = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest().getSession();
                    session.setAttribute("user",loginUser);
                    message = "login success";
                    map.put("message",message);
                }
            }else {
                message = "您输入的密码有误~！";
                map.put("message",message);
            }
        }
        return map;
    }

    @Override
    public Map<String, Object> updateUser(User user) {
        Map<String,Object> map = new HashMap<>();
        User user1 = userDAO.selectByUsername(user.getUsername());
        if (user1 != null && !user1.getId().equals(user.getId())) {
            map.put("update",false);
        }else {
            userDAO.updateUser(user);
            map.put("update",true);
        }
        return map;
    }
}
