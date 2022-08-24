package com.example.community.bean;

import lombok.Data;
/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/5/10
 */
@Data
public class Pharmacy {
    private int id;
    private String name;
    private String photo;
    private String address;
    private String value;
    private String monthlySale;
    private String startDelivery;
    private String delivery;
    private String distance;
    private String deliveryTime;
    private String createId;
    private int total;
    private int pageNum = 1;//当前页
    private int pageSize = 6;//没页最大数
    private int pageStart;

}
