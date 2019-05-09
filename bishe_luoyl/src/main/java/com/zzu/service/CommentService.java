package com.zzu.service;

import com.zzu.entity.Comment;

import java.util.List;

public interface CommentService {


    public List<Comment> findByPage(Integer start,Integer rows);

    public Long findTotal();

    public void deleteComment(String id);

}
