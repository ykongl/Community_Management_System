package com.example.community.bean;

import lombok.Data;

import java.util.Date;
/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/21
 */
@Data
public class Knowledge {
    private int id;
    private String bookName;
    private String introduction;
    private String createId;
    private String createName;
    private String content;
    private String roleId;
    private int total;
    private Date createTime;
    private int readNumber;
    private String style;
    private int updateId;
    private Date updateTime;
    private int pageNum = 1;//当前页
    private int pageSize = 10;//没页最大数
    private int pageStart;
}
