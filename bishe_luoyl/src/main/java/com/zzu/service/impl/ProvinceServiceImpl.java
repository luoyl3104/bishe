package com.zzu.service.impl;

import com.zzu.dao.ProvinceDAO;
import com.zzu.entity.Province;
import com.zzu.service.ProvinceService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional
public class ProvinceServiceImpl implements ProvinceService {

    @Resource
    private ProvinceDAO provinceDAO;


    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public List<Province> findAll() {
        return provinceDAO.selectAll();
    }


}
