package com.example.community.service;

import com.example.community.bean.Worker;

import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/3/31
 */
public interface WorkerService {
    /**
     * 查询员工
     * @param worker
     * @return
     */
    public List<Worker> selectWorker(Worker worker);

    /**
     * 获取员工数量
     * @param worker
     * @return
     */
    public int getCounts(Worker worker);

    /**
     * 获取详情
     * @param id
     * @return
     */
    public Worker getWorkerById(int id);

    /**
     * 添加
     * @param worker
     * @return
     */
    public String insertWorker(Worker worker);

    /**
     * 删除
     * @param worker
     * @return
     */
    public String deleteWorkerById(Worker worker);

    /**
     * 修改
     * @param worker
     * @return
     */
    public String updateWorker(Worker worker);


    /**
     * 修改状态
     * @param worker
     * @return
     */
    public String updateState(Worker worker);


}
