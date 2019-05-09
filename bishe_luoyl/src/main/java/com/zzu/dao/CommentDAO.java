package com.zzu.dao;

import com.zzu.entity.Comment;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface CommentDAO extends Mapper<Comment> {

    //查询所有评论
    public List<Comment> selectByPage(@Param("start") Integer start,@Param("rows") Integer rows);

}
