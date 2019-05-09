package com.zzu.dao;

import com.zzu.entity.User;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface UserDAO extends Mapper<User> {

    public List<User> selectByPage(@Param("start") Integer start, @Param("rows") Integer rows);

    public User selectByUsername(String username);
}
