package com.example.community.bean;


import lombok.Data;

import java.util.Date;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/3/27
 *
 * 用户实体
 */
 @Data
public class User {
    private int id;
    private String username;//用户名
    private String password;//密码
    private String sex;//性别
    private String phone;//电话号码
    private String role;//角色
    private boolean state;//状态
    private String roleId;
    private String createId;
    private String updateId;
    private String communityCd;
    private String communityName;
    private Date updateTime;
    private int pageNum = 1;//当前页
    private int pageSize = 10;//没页最大数
    private int pageStart;

}
