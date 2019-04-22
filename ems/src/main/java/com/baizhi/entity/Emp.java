package com.baizhi.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class Emp {
    private String id;

    private String name;

    private Integer age;

    private Date bir;

    private String status;

    }