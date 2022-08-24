package com.example.community.controller;

import com.example.community.bean.Community;
import com.example.community.service.CommunityService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/2
 */
@RestController
@RequestMapping("/community")
public class CommunityController {
    @Resource
    private CommunityService communityService;

    /**
     * 查询社区列表
     * @param community
     * @return
     */
    @GetMapping("/list")
    public List<Community> selectCommunity(Community community){
        return communityService.selectCommunity(community);
    }

    /**
     * 详情
     * @param id
     * @return
     */
    @GetMapping("/communityInfo")
    public Community getCommunityById(int id){
        return communityService.getCommunityById(id);
    }

    /**
     * 删除
     * @param community
     * @return
     */
    @PostMapping("/deleteById")
    public String deleteCommunity(Community community){
        return communityService.deleteCommunity(community);
    }

    /**
     * 修改
     * @param community
     * @return
     */
    @PostMapping("/updateInfo")
    public String updateCommunity(@RequestBody Community community){
        return communityService.updateCommunity(community);
    }

    /**
     * 添加
     * @param community
     * @return
     */
    @PostMapping("/addCommunity")
    public String insertCommunity(@RequestBody Community community){
        return communityService.insertCommunity(community);
    }

    /**
     * 修改状态
     * @param community
     * @return
     */
    @PostMapping("/updateState")
    public String updateState(Community community){
        return communityService.updateState(community);
    }
}
