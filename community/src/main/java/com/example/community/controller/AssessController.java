package com.example.community.controller;

import com.example.community.bean.Assess;
import com.example.community.service.AssessService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/29
 */
@RestController
@RequestMapping("/assess")
public class AssessController {
    @Resource
    private AssessService assessService;

    /**
     * 添加评价
     * @param assess
     * @return
     */
    @PostMapping("/addAssess")
    public String insertAssess(@RequestBody Assess assess){
        return assessService.insertAssess(assess);
    }

    /**
     * 获取数量
     * @return
     */
    @GetMapping("/count")
    public Assess getCount(){
        return assessService.getCount();
    }
}
