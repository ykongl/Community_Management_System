package com.example.community.service.impl;

import com.example.community.bean.Healthy;
import com.example.community.bean.Internal;
import com.example.community.bean.Surgery;
import com.example.community.dao.HealthyDao;
import com.example.community.service.HealthyService;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.text.ParseException;
import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/12
 */
@Service
public class HealthyServiceImpl implements HealthyService {

    @Resource
    private HealthyDao healthyDao;

    /**
     * 档案列表
     * @param healthy
     * @return
     */
    @Override
    public List<Healthy> selectHealthyList(Healthy healthy) throws ParseException {
        int pageStart = (healthy.getPageNum() - 1) * healthy.getPageSize();//分页
        healthy.setPageStart(pageStart);
//        healthy.setCreateTime(new SimpleDateFormat("yyyy-MM-dd").parse(healthy.getTime()));
        return healthyDao.selectHealthyList(healthy);
    }

    /**
     * 老人下拉框
     * @param healthy
     * @return
     */
    @Override
    public List<Healthy> getOlderDrop(Healthy healthy) {
        return healthyDao.getOlderDrop(healthy);
    }

    /**
     * 医生下拉框
     * @param healthy
     * @return
     */
    @Override
    public List<Healthy> getWorkDrop(Healthy healthy) {
        return healthyDao.getWorkDrop(healthy);
    }

    /**
     * 删除
     * @param healthy
     * @return
     */
    @Override
    public String deleteHealthy(Healthy healthy) {
        int i = healthyDao.deleteHealthy(healthy);
        return i > 0 ? "success" : "error";
    }

    /**
     * 获取健康档案基本信息
     * @param id
     * @return
     */
    @Override
    public Healthy getHealthyInfo(int id) {
        return healthyDao.getHealthyInfo(id);
    }

    /**
     * 获取外科信息
     * @param id
     * @return
     */
    @Override
    public Surgery getSurgeryInfo(int id) {
        return healthyDao.getSurgeryInfo(id);
    }

    /**
     * 获取内科信息
     * @param id
     * @return
     */
    @Override
    public Internal getInternalInfo(int id) {
        return healthyDao.getInternalInfo(id);
    }

    /**
     * 修改档案信息
     * @param healthy
     * @return
     */
    @Override
    public String updateHealthy(Healthy healthy) {
        int i = healthyDao.updateHealthy(healthy);
        return i > 0 ? "success" : "error";
    }

    /**
     * 添加
     * @param healthy
     * @return
     */
    @Override
    public String insertHealthy(Healthy healthy) {
        int i = healthyDao.insertHealthy(healthy);
        if(i > 0){
            healthy.setHealthyId(healthy.getId());
            healthyDao.insertSurgery(healthy);
            healthyDao.insertInternal(healthy);
            return "success";
        }
        return "error";
    }

    /**
     * 内科列表
     * @param internal
     * @return
     */
    @Override
    public List<Internal> getInternalList(Internal internal) {
        return healthyDao.getInternalList(internal);
    }
}
