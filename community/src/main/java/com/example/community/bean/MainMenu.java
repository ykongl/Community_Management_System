package com.example.community.bean;

import lombok.Data;

import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/3/16
 * 主导航
 */
@Data
public class MainMenu {
    private int id;
    private String title;//标题
    private String path;
    private String roleId;
    private List<SubMenu> sList;//分支导航

}
