package com.zzu.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zzu.dao.ViewDAO;
import com.zzu.entity.View;
import com.zzu.service.ViewService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
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
    public List<View> findByPage(Integer start, Integer rows) {
        PageHelper.startPage(start,rows);
        List<View> views = viewDAO.selectByPage(start, rows);
        PageInfo<View> viewPageInfo = new PageInfo<>(views);
        return views;

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
}
