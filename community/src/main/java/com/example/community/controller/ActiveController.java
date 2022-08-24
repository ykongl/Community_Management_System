package com.example.community.controller;

import com.example.community.bean.Active;
import com.example.community.bean.Join;
import com.example.community.service.ActiveService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/22
 */
@RestController
@RequestMapping("/active")
public class ActiveController {

    @Resource
    private ActiveService activeService;
    /**
     * 活动列表
     * @param active
     * @return
     */
    @GetMapping("/list")
    public List<Active> getActiveList(Active active){
        return activeService.getActiveList(active);
    }

    /**
     * 活动详情
     * @param id
     * @return
     */
    @GetMapping("/info")
    public Active getActiveInfo(int id){
        return activeService.getActiveInfo(id);
    }

    /**
     * 删除
     * @param active
     * @return
     */
    @PostMapping("/deleteById")
    public String deleteActive(Active active){
        return activeService.deleteActive(active);
    }

    /**
     * 修改
     * @param active
     * @return
     */
    @PostMapping("/updateInfo")
    public String updateActive(@RequestBody Active active){
        return activeService.updateActive(active);
    }

    /**
     * 添加
     * @param active
     * @return
     */
    @PostMapping("/insertActive")
    public String insertActive(@RequestBody Active active){
        return activeService.insertActive(active);
    }

    /**
     * 添加参与者
     * @param join
     * @return
     */
    @PostMapping("/join")
    public String addJoinList(@RequestBody Join join){
        return activeService.addJoinList(join);
    }

    /**
     * 参赛者名单
     * @param join
     * @return
     */
    @GetMapping("/joinList")
    public List<Join> getJoinList(Join join){
        return activeService.getJoinList(join);
    }

    /**
     * 删除参赛者
     * @param join
     * @return
     */
    @PostMapping("/deleteJoins")
    public String deleteJoins(Join join){
        return activeService.deleteJoins(join);
    }
}
