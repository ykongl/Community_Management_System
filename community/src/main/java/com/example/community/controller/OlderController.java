package com.example.community.controller;

import com.example.community.bean.Older;
import com.example.community.service.OlderService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/7
 */
@RestController
@RequestMapping("/older")
public class OlderController {
    @Resource
    private OlderService olderService;

    /**
     * 获取列表
     * @param older
     * @return
     */
    @GetMapping("/list")
    public List<Older> getAllOlderList(Older older){
        return olderService.getAllOlderList(older);
    }

    /**
     * 详情
     * @param id
     * @return
     */
    @GetMapping("/olderInfo")
    public Older getOlderById(int id){
        return olderService.getOlderById(id);
    }


    /**
     * 修改状态
     * @param older
     * @return
     */
    @PostMapping("/updateState")
    public String updateState(Older older){
        return olderService.updateState(older);
    }

    /**
     * 删除
     * @param older
     * @return
     */
    @PostMapping("/deleteById")
    public String deleteOlder(Older older){
        return olderService.deleteOlder(older);
    }

    /**
     * 监护人下拉框
     * @param older
     * @return
     */
    @GetMapping("/userList")
    public List<Older> selectUserList(Older older){
        return olderService.selectUserList(older);
    }

    /**
     * 修改
     * @param older
     * @return
     */
    @PostMapping("/updateOlder")
    public String updateOlder(@RequestBody Older older){
        return olderService.updateOlder(older);
    }

    /**
     * 添加
     * @param older
     * @return
     */
    @PostMapping("/insertOlder")
    public String addOlder(@RequestBody Older older){
        return olderService.addOlder(older);
    }

    @PostMapping("/addImg")
    public int addImg(String imgUrl){
        return olderService.addImg(imgUrl);
    }
}
