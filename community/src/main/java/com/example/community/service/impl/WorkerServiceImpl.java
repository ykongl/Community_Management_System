package com.example.community.service.impl;

import com.example.community.bean.Worker;
import com.example.community.dao.WorkerDao;
import com.example.community.service.WorkerService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/3/31
 */
@Service
public class WorkerServiceImpl implements WorkerService {
    @Resource
    private WorkerDao workerDao;

    /**
     * 查询员工
     * @param worker
     * @return
     */
    @Override
    public List<Worker> selectWorker(Worker worker) {
        int pageStart = (worker.getPageNum() - 1) * worker.getPageSize();//分页
        worker.setPageStart(pageStart);
        if(worker.getLoginRoleId().equals("4")){
            worker.setUpdateId("");
        }
        List<Worker> workerList = workerDao.selectWorker(worker);
        for (int i = 0; i < workerList.size(); i++) {
            if(workerList.get(i).getSex().equals("0")){
                workerList.get(i).setSex("男");
            }else{
                workerList.get(i).setSex("女");
            }
        }
        return workerList;
    }

    /**
     * 获取员工数量
     * @param worker
     * @return
     */
    @Override
    public int getCounts(Worker worker) {
        return workerDao.getCounts(worker);
    }

    /**
     * 获取详情
     * @param id
     * @return
     */
    @Override
    public Worker getWorkerById(int id) {
        return workerDao.getWorkerById(id);
    }

    /**
     * 添加
     * @param worker
     * @return
     */
    @Override
    public String insertWorker(Worker worker) {
        if(worker.getRoleId().equals("2")){
            workerDao.insertDoctor(worker.getWorkName(),worker.getHospitalId(),worker.getDepartmentId());
        }
        int i = workerDao.insertWorker(worker);
        return i > 0 ? "success" : "error";
    }
    /**
     * 删除
     * @param worker
     * @return
     */
    @Override
    public String deleteWorkerById(Worker worker) {
        int i = workerDao.deleteWorkerById(worker);
        return i > 0 ? "success" : "error";
    }
    /**
     * 修改
     * @param worker
     * @return
     */
    @Override
    public String updateWorker(Worker worker) {
        if(worker.getRoleId().equals("2")){
            workerDao.updateDoctor(worker.getWorkName(),worker.getHospitalId(),worker.getDepartmentId());
        }
        int i = workerDao.updateWorker(worker);
        return i > 0 ? "success" : "error";
    }

    /**
     * 修改状态
     * @param worker
     * @return
     */
    @Override
    public String updateState(Worker worker) {
        int i = workerDao.updateState(worker);
        return i > 0 ? "success" : "error";
    }


}
