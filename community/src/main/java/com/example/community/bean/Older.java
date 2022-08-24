package com.example.community.bean;

import lombok.Data;

import java.util.Date;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/7
 */
@Data
public class Older {
    private int id;
    private String userId;
    private String olderName;
    private String sex;
    private String olderAge;
    private String username;
    private String communityCd;
    private String communityName;
    private String medicalHistory;
    private String imgUrl;
    private Date birthday;
    private String photo;
    private String address;
    private boolean state;
    private String updateId;
    private Date updateTime;
    private int total;
    private int pageNum = 1;//当前页
    private int pageSize = 10;//没页最大数
    private int pageStart;
}
