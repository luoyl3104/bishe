package com.zzu.service.impl;

import com.zzu.dao.CommentDAO;
import com.zzu.entity.Comment;
import com.zzu.service.CommentService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional
public class CommentServiceImpl implements CommentService {

    @Resource
    private CommentDAO commentDAO;

    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public List<Comment> findByPage(Integer start, Integer rows) {
        return commentDAO.selectByPage(start,rows);
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


}
