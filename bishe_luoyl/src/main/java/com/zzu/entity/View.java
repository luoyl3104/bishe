package com.zzu.entity;


import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Id;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class View implements Serializable {

    @Id
    private String id;

    private String name;

    private String picture;

    private String score;

    private String path;

    private String des;

    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    private Date uploadDate;

    private String type;

    private User user;

    private Province province;

    private List<Comment> comments;

}