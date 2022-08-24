package com.example.community.bean;

import lombok.Data;

import java.util.Date;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/16
 */
@Data
public class Surgery {
    private int id;
    private int healthyId;
    private int olderId;
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
    private String workId;
    private int createId;
    private Date createTime;
    private int updateId;
    private Date updateTime;
}
