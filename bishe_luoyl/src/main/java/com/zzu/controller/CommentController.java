package com.zzu.controller;

import com.zzu.entity.Comment;
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

    @RequestMapping("queryByPage")
    public Map<String,Object> queryByPage(Integer page,Integer rows){
        HashMap<String, Object> map = new HashMap<>();
        Integer start = (page-1)*rows;
        List<Comment> comments = commentService.findByPage(start, rows);
        Long total = commentService.findTotal();
        Long pageTotal = total%rows==0?total/rows:total/rows+1;
        map.put("rows",comments);
        map.put("records",total);
        map.put("total",pageTotal);
        map.put("page",page);
        return map;
    }

    //删除
    @RequestMapping("remove")
    public void remove(String id){
        commentService.deleteComment(id);
    }

}
