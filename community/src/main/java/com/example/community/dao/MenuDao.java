package com.example.community.dao;

import com.example.community.bean.MainMenu;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/3/16
 */
@Repository
public interface MenuDao {
    public List<MainMenu> getMenus(String roleId);

}
