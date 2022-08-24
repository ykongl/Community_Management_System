package com.example.community.service.impl;

import com.example.community.bean.Active;
import com.example.community.bean.Join;
import com.example.community.dao.ActiveDao;
import com.example.community.service.ActiveService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/22
 */
@Service
public class ActiveServiceImpl implements ActiveService {

    @Resource
    private ActiveDao activeDao;

    /**
     * 活动列表
     * @param active
     * @return
     */
    @Override
    public List<Active> getActiveList(Active active) {
        int pageStart = (active.getPageNum() - 1) * active.getPageSize();//分页
        active.setPageStart(pageStart);
        return activeDao.getActiveList(active);
    }

    /**
     * 活动详情
     * @param id
     * @return
     */
    @Override
    public Active getActiveInfo(int id) {
        return activeDao.getActiveInfo(id);
    }

    /**
     * 删除
     * @param active
     * @return
     */
    @Override
    public String deleteActive(Active active) {
        int i = activeDao.deleteActive(active);
        return i > 0 ? "success" : "error";
    }

    /**
     * 修改
     * @param active
     * @return
     */
    @Override
    public String updateActive(Active active) {
        int i = activeDao.updateActive(active);
        return i > 0 ? "success" : "error";
    }

    /**
     * 新增
     * @param active
     * @return
     */
    @Override
    public String insertActive(Active active) {
        int i = activeDao.insertActive(active);
        return i > 0 ? "success" : "error";
    }

    /**
     * 添加参与者
     * @param join
     * @return
     */
    @Override
    public String addJoinList(Join join) {
        List<Join> lists = activeDao.getJoinList(join);
        for (int i = 0; i < lists.size(); i++) {
            if(join.getJoinId().equals(lists.get(i).getJoinId()) && join.getJoinName().equals(lists.get(i).getJoinName())){
                return "已报名";
            }
        }
        join.setFlag(true);
        activeDao.updateJoinNumber(join.getActiveId(), join.isFlag());
        int i = activeDao.addJoinList(join);
        return i > 0 ? "success" : "error";
    }

    /**
     * 获取参赛者名单
     * @param join
     * @return
     */
    @Override
    public List<Join> getJoinList(Join join) {
        return activeDao.getJoinList(join);
    }

    /**
     * 删除参赛者
     * @param join
     * @return
     */
    @Override
    public String deleteJoins(Join join) {
        join.setFlag(false);
        activeDao.updateJoinNumber(join.getActiveId(), join.isFlag());
        int i = activeDao.deleteJoins(join);
        return i > 0 ? "success" : "error";
    }
}
