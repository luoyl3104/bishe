package com.zzu.service.impl;

import com.zzu.dao.CommentDAO;
import com.zzu.entity.Comment;
import com.zzu.entity.User;
import com.zzu.service.CommentService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.*;

@Service
@Transactional
public class CommentServiceImpl implements CommentService {

    @Resource
    private CommentDAO commentDAO;

    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public List<Comment> findByPage(Comment comment,Integer start, Integer rows) {
        return commentDAO.selectByPage(comment,start,rows);
    }

    @Override
    public Long findTotal() {
        return Long.valueOf(commentDAO.selectCount(new Comment()));
    }

    @Override
    public void deleteComment(String id) {
        Comment comment = new Comment();
        comment.setId(id);
        commentDAO.delete(comment);
    }

    @Override
    public List<Comment> findAll() {
        return commentDAO.selectAllComment();
    }

    @Override
    public List<Comment> findByViewId(String viewId) {
        return commentDAO.selectByViewId(viewId);
    }

    @Override
    public Map<String, Object> addComment(Comment comment) {
        Map<String,Object> map = new HashMap<>();
        HttpSession session = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest().getSession();
        User user = (User) session.getAttribute("user");
        if(user == null){
            map.put("message",false);
        }else {
            comment.setId(""+Math.abs(new Random().nextInt()));
            comment.setPublishDate(new Date());
            comment.setSign(1);
            comment.setUser(user);
            commentDAO.insertComment(comment);
            map.put("message",true);
        }
        return map;
    }

    @Override
    public void deleteByViewId(String id) {
        commentDAO.deleteByViewId(id);
    }


}
