package com.example.community.service;

import com.example.community.bean.MainMenu;

import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/3/16
 */
public interface MenuService {
    public List<MainMenu> getMenus(String roleId);
}
