package com.example.community.controller;

import com.example.community.bean.Healthy;
import com.example.community.bean.Internal;
import com.example.community.bean.Older;
import com.example.community.bean.Surgery;
import com.example.community.service.HealthyService;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.text.ParseException;
import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/12
 */
@RestController
@RequestMapping("/healthy")
public class HealthyController {
    @Resource
    private HealthyService healthyService;

    /**
     * 列表
     * @param healthy
     * @return
     */
    @GetMapping("/list")
    public List<Healthy> selectHealthyList( Healthy healthy) throws ParseException {
        return healthyService.selectHealthyList(healthy);
    }

    /**
     * 老人下拉框
     * @param healthy
     * @return
     */
    @GetMapping("/olderDrop")
    public List<Healthy> getOlderDrop(Healthy healthy){
        return healthyService.getOlderDrop(healthy);
    }

    /**
     * 医生下拉框
     * @param healthy
     * @return
     */
    @GetMapping("/workDrop")
    public List<Healthy> getWorkDrop(Healthy healthy){
        return healthyService.getWorkDrop(healthy);
    }


    /**
     * 删除
     * @param healthy
     * @return
     */
    @PostMapping("/deleteById")
    public String deleteHealthy(Healthy healthy){
        return healthyService.deleteHealthy(healthy);
    }

    /**
     * 健康档案基本信息
     * @param id
     * @return
     */
    @GetMapping("/healthyInfo")
    public Healthy getHealthyInfo(int id){
        return healthyService.getHealthyInfo(id);
    }

    /**
     * 获取外科信息
     * @param id
     * @return
     */
    @GetMapping("/surgeryInfo")
    public Surgery getSurgeryInfo(int id){
        return healthyService.getSurgeryInfo(id);
    }

    /**
     * 获取内科信息
     * @param id
     * @return
     */
    @GetMapping("/internalInfo")
    public Internal getInternalInfo(int id){
        return healthyService.getInternalInfo(id);
    }

    /**
     * 修改
     * @param healthy
     * @return
     */
    @PostMapping("/updateInfo")
    public String updateHealthy(@RequestBody Healthy healthy){
        return healthyService.updateHealthy(healthy);
    }

    /**
     * 添加
     * @param healthy
     * @return
     */
    @PostMapping("/insertInfo")
    public String insertHealthy(@RequestBody Healthy healthy){
        return healthyService.insertHealthy(healthy);
    }

    /**
     * 内科信息列表
     * @param internal
     * @return
     */
    @GetMapping("/internalList")
    public List<Internal> getInternalList(Internal internal) {
        return healthyService.getInternalList(internal);
    }
}
