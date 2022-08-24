package com.example.community.dao;

import com.example.community.bean.Healthy;
import com.example.community.bean.Internal;
import com.example.community.bean.Older;
import com.example.community.bean.Surgery;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/12
 */
@Repository
public interface HealthyDao {

    /**
     * 健康档案列表
     * @param healthy
     * @return
     */
    public List<Healthy> selectHealthyList(Healthy healthy);

    /**
     * 老人下拉框
     * @param healthy
     * @return
     */
    public List<Healthy> getOlderDrop(Healthy healthy);

    /**
     * 医生下拉框
     * @param healthy
     * @return
     */
    public List<Healthy> getWorkDrop(Healthy healthy);

    /**
     * 删除
     * @param healthy
     * @return
     */
    public int deleteHealthy(Healthy healthy);

    /**
     * 获取健康档案基本信息
     * @param id
     * @return
     */
    public Healthy getHealthyInfo(int id);

    /**
     * 获取外科信息
     * @param id
     * @return
     */
    public Surgery getSurgeryInfo(int id);

    /**
     * 获取内科信息
     * @param id
     * @return
     */
    public Internal getInternalInfo(int id);

    /**
     * 修改档案信息
     * @param healthy
     * @return
     */
    public int updateHealthy(Healthy healthy);

    /**
     * 添加
     * @param healthy
     * @return
     */
    public int insertHealthy(Healthy healthy);

    public int insertSurgery(Healthy healthy);

    public int insertInternal(Healthy healthy);

    /**
     * 查找内科信息列表
     * @param internal
     * @return
     */
    public List<Internal> getInternalList(Internal internal);

}
