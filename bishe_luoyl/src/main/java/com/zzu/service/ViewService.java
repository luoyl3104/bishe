package com.zzu.service;

import com.zzu.entity.View;

import java.util.List;

public interface ViewService {

    public List<View> findByPage(Integer start,Integer rows);

    public Long findTotals();

    public View findOne(String id);

    public void addView(View view);

    public void removeView(String id);

    public void updateType(View view);

}
