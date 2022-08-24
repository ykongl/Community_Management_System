package com.example.community.bean;

import lombok.Data;

import java.util.Date;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/12
 */
@Data
public class Healthy {
    private int id;
    private String olderId;
    private String userId;
    private String olderName;
    private String username;
    private String workName;
    private String olderAge;
    private String sex;
    private String height;
    private String weight;
    private String nation;
    private Date birthday;
    private String nativePlace;
    private String maritalStatus;
    private String workYear;
    private String educationLevel;
    private String career;
    private String address;
    private String files;
    private String photo;
    private String workId;
    private String communityCd;


    private int healthyId;
    private String skin;
    private String lymph;
    private String thyroid;
    private String spine;
    private String limb;
    private String joint;
    private String head;
    private String eye;
    private String ears;
    private String nose;
    private String oralCavity;
    private String throat;

    private String heartRate;
    private String bloodPressure;
    private String bloodSugar;
    private String bloodFat;
    private String pulse;
    private String liverFunction;
    private String renalFunction;
    private String bloodRoutine;
    private String urinalysis;

    private int createId;
    private String time;
    private Date createTime;
    private String updateId;
    private Date updateTime;
    private int pageNum = 1;//当前页
    private int pageSize = 10;//没页最大数
    private int pageStart;
    private int total;

}
