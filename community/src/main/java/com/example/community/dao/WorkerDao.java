package com.example.community.dao;

import com.example.community.bean.Doctor;
import com.example.community.bean.Worker;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/3/31
 */
@Repository
public interface WorkerDao {

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
    public int insertWorker(Worker worker);

    /**
     * 删除
     * @param worker
     * @return
     */
    public int deleteWorkerById(Worker worker);

    /**
     * 修改
     * @param worker
     * @return
     */
    public int updateWorker(Worker worker);


    /**
     * 修改状态
     * @param worker
     * @return
     */
    public int updateState(Worker worker);


    /**
     * 添加医生单位信息
     * @param hospitalId
     * @param departmentId
     * @return
     */
    public int insertDoctor(String workName,String hospitalId,String departmentId);

    /**
     * 修改医生单位信息
     * @param hospitalId
     * @param departmentId
     * @return
     */
    public int updateDoctor(String workName,String hospitalId,String departmentId);


}
