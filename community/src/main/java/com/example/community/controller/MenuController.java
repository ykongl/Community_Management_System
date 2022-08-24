package com.example.community.controller;

import com.alibaba.fastjson.JSON;
import com.example.community.bean.MainMenu;
import com.example.community.service.MenuService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/3/16
 */

@RestController
public class MenuController {
    @Resource
    private MenuService menuService;

    @RequestMapping("/menus")
    public String getAllMenus(String roleId){
        HashMap<String,Object> data = new HashMap<>();
        List<MainMenu> menus = menuService.getMenus(roleId);
        if(menus!=null){
            data.put("menus",menus);
            data.put("flag",200);//成功
        }else{
            data.put("flag",404);//失败
        }
        String s = JSON.toJSONString(data);
        return s;

    }
}
