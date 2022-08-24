package com.example.community.service.impl;

import com.example.community.bean.MainMenu;
import com.example.community.dao.MenuDao;
import com.example.community.service.MenuService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/3/16
 */
@Service
public class MenuServiceImpl implements MenuService {
    @Resource
    private MenuDao menuDao;
    @Override
    public List<MainMenu> getMenus(String roleId) {
        return menuDao.getMenus(roleId);
    }
}
