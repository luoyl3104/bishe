package com.zzu.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserEcharts implements Serializable {

    private String name;

    private Integer value;

    private String sex;
}
