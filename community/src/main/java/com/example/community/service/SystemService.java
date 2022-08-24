package com.example.community.service;

import com.example.community.bean.Stacked;
import com.example.community.bean.System;

import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/29
 */
public interface SystemService {

    /**
     * 获取数量
     * @return
     */
    public System getCount();


    /**
     * 添加留言
     * @param system
     * @return
     */
    public String insertNews(System system);

    /**
     * 获取留言列表
     * @param system
     * @return
     */
    public List<System> getNewsList(System system);

    /**
     * 获取堆积图数据
     * @return
     */
    public List<Stacked> getStackedList();

}
