package com.example.community.bean;

import lombok.Data;

import java.util.Date;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/5/12
 */
@Data
public class ShopMall {
    private int id;
    private String goodsName;
    private String goodsImgUrl;
    private String goodsUnit;
    private String goodsPrice;
    private String shopName;
    private String qualityGuarantee;
    private String stock;
    private int createId;
    private int updateId;
    private Date createTime;
    private int total;
    private int pageNum = 1;//当前页
    private int pageSize = 10;//没页最大数
    private int pageStart;
}
