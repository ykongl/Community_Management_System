package com.example.community.service;

import com.example.community.bean.Assess;

import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/29
 */
public interface AssessService {
    /**
     * 添加评价
     * @param assess
     * @return
     */
    public String insertAssess(Assess assess);

    /**
     * 获取数量
     * @return
     */
    public Assess getCount();
}
