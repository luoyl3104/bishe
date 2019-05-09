package com.zzu.entity;


import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Id;
import java.util.Date;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {

    @Id
    private String id;

    private String username;

    private String password;

    private String sex;

    private String type;

    private String avatar;

    private String phone;

    private String email;

    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    private Date registDate;

    private Province province;

    private List<View> views;


}