package com.example.community.controller;

import com.example.community.bean.Stacked;
import com.example.community.bean.System;
import com.example.community.service.SystemService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/29
 */
@RestController
@RequestMapping("/System")
public class SystemController {
    @Resource
    private SystemService service;

    /**
     * 获取数量
     * @return
     */
    @GetMapping("/number")
    public System getCount() {
        return service.getCount();
    }

    /**
     * 添加留言
     * @param system
     * @return
     */
    @PostMapping("/news")
    public String insertNews(@RequestBody System system){
        return service.insertNews(system);
    }

    /**
     * 获取留言列表
     * @param system
     * @return
     */
    @GetMapping("/list")
    public List<System> getNewsList(System system){
        return service.getNewsList(system);
    }

    /**
     * 获取堆积图数据
     * @return
     */
    @GetMapping("/stackedList")
    public List<Stacked> getStackedList(){
        return service.getStackedList();
    }
}
