package com.zzu.service;

import com.zzu.entity.Comment;

import java.util.List;
import java.util.Map;

public interface CommentService {


    public List<Comment> findByPage(Comment comment,Integer start,Integer rows);

    public Long findTotal();

    public void deleteComment(String id);

    public List<Comment> findAll();

    public List<Comment> findByViewId(String viewId);

    public Map<String,Object> addComment(Comment comment);

    public void deleteByViewId(String id);

}
