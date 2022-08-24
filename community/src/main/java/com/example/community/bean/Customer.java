package com.example.community.bean;

import lombok.Data;

import java.util.Date;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/5/12
 */
@Data
public class Customer {
    private int id;
    private String orderNo;
    private String userId;
    private String orderCustomer;
    private Date orderTime;
    private int number;
    private boolean flag;
}
