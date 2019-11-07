package com.zzu.controller;

import com.zzu.entity.Comment;
import com.zzu.entity.View;
import com.zzu.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("comment")
public class CommentController {

    @Autowired
    private CommentService commentService;

    //添加评论
    @RequestMapping("save")
    public Map<String,Object> saveComment(String content,String viewId){
        View view = new View();
        view.setId(viewId);
        Comment comment = new Comment();
        comment.setContent(content);
        comment.setView(view);
        Map<String, Object> map = commentService.addComment(comment);
        return map;
    }

    @RequestMapping("queryByPage")
    public Map<String,Object> queryByPage(Integer page,Comment comment){
        HashMap<String, Object> map = new HashMap<>();
        Integer rows = 10;
        page = page == null?1:page;
        Integer start = (page-1)*rows;
        List<Comment> comments = commentService.findByPage(comment,start, rows);
        Long total = commentService.findTotal();
        Long pageTotal = total%rows==0?total/rows:total/rows+1;
        map.put("comments",comments);
        map.put("totals",total);
        map.put("pageTotal",pageTotal);
        map.put("page",page);
        return map;
    }

    //删除
    @RequestMapping("remove")
    public void remove(String id){
        commentService.deleteComment(id);
    }

}
