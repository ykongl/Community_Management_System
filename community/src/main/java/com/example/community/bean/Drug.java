package com.example.community.bean;

import lombok.Data;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/5/9
 */
@Data
public class Drug {
    private int id;
    private int pharmacyId;
    private String drugName;
    private String photo;
    private int drugNumber;
    private String unit;
    private String price;
    private String termOfValidity;
    private String explain;
    private String drugType;
    private String drugTypeId;
    private String createId;
    private String updateId;
    private int total;
    private int pageNum = 1;//当前页
    private int pageSize = 6;//没页最大数
    private int pageStart;
}
