package com.example.community.bean;

import lombok.Data;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/5/21
 */
@Data
public class Food {
    private int id;
    private String communityCd;
    private String restaurant;
    private String foodName;
    private String foodImgUrl;
    private String foodPrice;
    private int total;
    private String createId;
}
