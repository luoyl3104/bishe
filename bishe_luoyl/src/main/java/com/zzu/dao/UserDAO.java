package com.zzu.dao;

import com.zzu.entity.User;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface UserDAO extends Mapper<User> {

    public List<User> selectByPage(@Param("user")User user,@Param("start") Integer start, @Param("rows") Integer rows);

    public User selectByUsername(String username);

    public User selectById(String id);

    //注册
    public void insertUser(User user);

    //修改用户信息
    public void updateUser(User user);

}
