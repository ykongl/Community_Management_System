package com.example.community.bean;

import lombok.Data;

import java.util.Date;


/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/29
 */
@Data
public class Assess {
    private int id;
    private String assess;
    private String createName;
    private Date createTime;
    private String workId;
    private String roleId;
    private String veryPoor;
    private String disappointed;
    private String generally;
    private String satisfy;
    private String surprise;
}
