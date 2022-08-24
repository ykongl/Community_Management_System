package com.example.community.service.impl;

import com.example.community.bean.Pie;
import com.example.community.dao.PieDao;
import com.example.community.service.PieService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/29
 */
@Service
public class PieServiceImpl implements PieService {
    @Resource
    private PieDao pieDao;

    /**
     * 获取数量
     * @return
     */
    public Pie getCount(){
        return pieDao.getCount();
    }
}
