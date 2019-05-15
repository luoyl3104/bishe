package com.zzu.dao;

import com.zzu.entity.Comment;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface CommentDAO extends Mapper<Comment> {

    //查询所有评论
    public List<Comment> selectByPage(@Param("start") Integer start,@Param("rows") Integer rows);

    //无参数查所有
    public List<Comment> selectAllComment();

    //根据view_id查
    public List<Comment> selectByViewId(String viewId);

    //添加评论
    public void insertComment(Comment comment);
}
