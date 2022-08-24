package com.example.community.bean;

import lombok.Data;

import java.util.Date;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/29
 */
@Data
public class System {
    private int userNumber = 0;
    private int newsNumber = 0;
    private int communityNumber = 0;
    private int orderNumber = 0;
    private int id;
    private String username;
    private String news;
    private Date createTime;
}
