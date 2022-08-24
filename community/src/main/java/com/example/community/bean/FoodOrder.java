package com.example.community.bean;

import lombok.Data;

import java.util.Date;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/5/21
 */
@Data
public class FoodOrder {
    private int id;
    private String foodOrderNo;
    private String orderPerson;
    private String contactNumber;
    private String address;
    private String communityRestaurant;
    private String communityId;
    private String foodNames;
    private double foodPrice;
    private String orderStatus;
    private String createId;
    private Date createTime;
    private String updateId;
    private int total;
    private int pageNum = 1;//当前页
    private int pageSize = 10;//没页最大数
    private int pageStart;
}
