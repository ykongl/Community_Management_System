package com.example.community.bean;

import lombok.Data;


import java.util.Date;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/2
 */
@Data
public class Community {
    private int id;
    private String communityCd;
    private String communityName;
    private String communityPlace;
    private String communityArea;
    private int peopleNumber;
    private int oldNumber;
    private int total;
    private boolean state;//状态
    private String updateId;
    private Date updateTime;
    private int pageNum = 1;//当前页
    private int pageSize = 10;//没页最大数
    private int pageStart;
}
