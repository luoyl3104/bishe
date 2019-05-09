package com.baizhi.service;


import com.baizhi.entity.Emp;

import java.util.List;

public interface EmpService {

    List<Emp> findAll(Integer pageNum, Integer pageSize);

   List<Emp> findAll();
}
