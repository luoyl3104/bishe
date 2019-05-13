package com.zzu.service.impl;

import com.zzu.dao.ViewDAO;
import com.zzu.entity.User;
import com.zzu.entity.View;
import com.zzu.service.ViewService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class ViewServiceImpl implements ViewService {

    @Resource
    private ViewDAO viewDAO;

    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public List<View> findByPage(Integer start, Integer rows,View view) {
        try {
            List<View> views = viewDAO.selectByPage(start, rows,view);
            return views;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }

    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public Long findTotals() {
        return Long.valueOf(viewDAO.selectCount(new View()));
    }

    @Override
    public View findOne(String id) {
        return viewDAO.findOne(id);
    }

    @Override
    public void addView(View view) {
        view.setId(UUID.randomUUID().toString());
        view.setUploadDate(new Date());
        view.setType("开放");
        viewDAO.insert(view);
    }

    @Override
    public void removeView(String id) {
        viewDAO.deleteByPrimaryKey(id);
    }

    @Override
    public void updateType(View view) {
        viewDAO.updateByPrimaryKeySelective(view);
    }

    @Override
    public List<View> findByUser(Integer start,Integer rows) {
        HttpSession session = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest().getSession();
        User user = (User) session.getAttribute("user");
        return viewDAO.selectByUsername(start,rows,user.getUsername());
    }
}
