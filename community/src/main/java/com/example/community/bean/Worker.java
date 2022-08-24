package com.example.community.bean;

import lombok.Data;

import java.util.Date;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/3/27
 */
@Data
public class Worker {
    private int id;
    private String workNo;
    private String workName;
    private String password;
    private String phone;
    private String role;
    private String sex;
    private String loginRoleId;
    private boolean state;
    private String query;
    private String roleId;
    private String isAssess;
    private String hospitalId;
    private String departmentId;
    private String createId;
    private Date createTime;
    private String updateId;
    private Date updateTime;
    private int pageNum = 1;//当前页
    private int pageSize = 10;//没页最大数
    private int pageStart;
}
