package com.example.community.service.impl;

import com.example.community.bean.Stacked;
import com.example.community.bean.System;
import com.example.community.dao.SystemDao;
import com.example.community.service.SystemService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/29
 */
@Service
public class SystemServiceImpl implements SystemService {
    @Resource
    private SystemDao systemDao;

    /**
     * 获取数量
     * @return
     */
    @Override
    public System getCount() {
        return systemDao.getCount();
    }

    /**
     * 添加留言
     * @param system
     * @return
     */
    @Override
    public String insertNews(System system) {
        int i = systemDao.insertNews(system);
        return i > 0 ? "success" : "error";
    }

    /**
     * 获取留言列表
     * @param system
     * @return
     */
    public List<System> getNewsList(System system){
        return systemDao.getNewsList(system);
    }

    /**
     * 获取堆积图数据
     * @return
     */
    @Override
    public List<Stacked> getStackedList(){
        return systemDao.getStackedList();
    }
}
