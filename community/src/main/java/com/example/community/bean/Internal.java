package com.example.community.bean;

import lombok.Data;

import java.util.Date;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/17
 */
@Data
public class Internal {
    private int id;
    private int healthyId;
    private String olderId;
    private String heartRate;
    private String bloodPressure;
    private String bloodSugar;
    private String bloodFat;
    private String pulse;
    private String liverFunction;
    private String renalFunction;
    private String bloodRoutine;
    private String urinalysis;
    private String photo;
    private String workId;
    private int createId;
    private String createTime;
    private int updateId;
    private Date updateTime;

}
