package com.example.community.bean;

import lombok.Data;

import java.util.Date;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/6/5
 */
@Data
public class Stacked {
    private int userCount;
    private int orderCount;
    private int newsCount;
    private Date loginTime;
}
