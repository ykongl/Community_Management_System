package com.example.community.bean;

import lombok.Data;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/5/18
 */
@Data
public class Join {
    private int id;
    private String joinId;
    private String joinName;
    private String joinTime;
    private int activeId;
    private boolean flag;
}
