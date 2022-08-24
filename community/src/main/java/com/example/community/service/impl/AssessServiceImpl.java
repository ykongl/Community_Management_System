package com.example.community.service.impl;

import com.example.community.bean.Assess;
import com.example.community.dao.AssessDao;
import com.example.community.service.AssessService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/29
 */
@Service
public class AssessServiceImpl implements AssessService {

    @Resource
    private AssessDao assessDao;
    /**
     * 添加评价
     * @param assess
     * @return
     */
    public String insertAssess(Assess assess){
        if(assess.getRoleId().equals("4")){
            assessDao.updateUserAssess(assess.getWorkId());
        }
        assessDao.updateWorkerAssess(assess.getWorkId());
        int i = assessDao.insertAssess(assess);
        return i > 0 ? "success" : "error";
    }

    /**
     * 获取数量
     * @return
     */
    @Override
    public Assess getCount() {
        return assessDao.getCount();
    }
}
