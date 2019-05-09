package com.zzu.dao;

import com.zzu.entity.View;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface ViewDAO extends Mapper<View> {

    public List<View> selectByPage(@Param("start") Integer start, @Param("rows") Integer rows);

    public View findOne(String id);

}
