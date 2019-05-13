package com.zzu.service;

import com.zzu.entity.User;
import com.zzu.entity.UserList;

import java.util.List;
import java.util.Map;

public interface UserService {

    public List<User> findByPage(Integer start,Integer rows);

    public Long findTotals();

    public List<User> findAll();

    public List<UserList> echarts();

    public void updateType(User user);

    public void register(User user);

    public User findOne(User user);

    public User findByUsername(String username);

    public Map<String,Object> login(User user);

    public Map<String,Object> updateUser(User user);
}
