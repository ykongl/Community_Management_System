package com.example.community.controller;

import com.alibaba.fastjson.JSON;
import com.example.community.bean.Worker;
import com.example.community.service.WorkerService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/3/31
 */
@RestController
@RequestMapping("/Worker")
public class WorkerController {
    @Resource
    private WorkerService workerService;

    /**
     * 员工列表
     * @param worker
     * @return
     */
    @GetMapping("/list")
    public String selectWorker(Worker worker){
        int number = workerService.getCounts(worker);
        List<Worker> workers = workerService.selectWorker(worker);
        HashMap<String,Object> res = new HashMap<>();
        res.put("number",number);
        res.put("data",workers);
        String s = JSON.toJSONString(res);
        return s;
    }

    /**
     * 修改状态
     * @param worker
     * @return
     */
    @PostMapping("/updateState")
    public String updateState(Worker worker){
        return workerService.updateState(worker);
    }

    /**
     * 详情
     * @param id
     * @return
     */
    @GetMapping("/workInfo")
    public Worker getWorkerById(int id){
        return workerService.getWorkerById(id);
    }

    /**
     * 删除
     * @param worker
     * @return
     */
    @PostMapping("/deleteId")
    public String deleteWorkerById(Worker worker){
        return workerService.deleteWorkerById(worker);
    }

    /**
     * 修改
     * @param worker
     * @return
     */
    @PostMapping("/updateWorker")
    public String updateWorker(@RequestBody Worker worker){
        return workerService.updateWorker(worker);
    }

    /**
     * 添加
     * @param worker
     * @return
     */
    @PostMapping("/insertWorker")
    public String insertWorker(@RequestBody Worker worker){
        return workerService.insertWorker(worker);
    }


}
