package com.zzu.dao;

import com.zzu.entity.View;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface ViewDAO extends Mapper<View> {

    public List<View> selectByPage(@Param("start") Integer start, @Param("rows") Integer rows,@Param("view") View view);

    public View findOne(String id);

    public List<View> selectByUsername(@Param("start") Integer start,@Param("rows") Integer rows,@Param("username") String username);

    public void insertView(View view);


}
