package com.example.community.controller;

import com.example.community.bean.Pie;
import com.example.community.service.PieService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/29
 */
@RestController
@RequestMapping("/Pie")
public class PieController {
    @Resource
    private PieService pieService;

    /**
     * 获取数量
     * @return
     */
    @GetMapping("count")
    public Pie getCount(){
        return pieService.getCount();
    }

}
