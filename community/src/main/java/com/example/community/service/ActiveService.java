package com.example.community.service;

import com.example.community.bean.Active;
import com.example.community.bean.Join;

import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/22
 */
public interface ActiveService {

    /**
     * 活动列表
     * @param active
     * @return
     */
    public List<Active> getActiveList(Active active);

    /**
     * 活动详情
     * @param id
     * @return
     */
    public Active getActiveInfo(int id);

    /**
     * 删除
     * @param active
     * @return
     */
    public String deleteActive(Active active);

    /**
     * 修改
     * @param active
     * @return
     */
    public String updateActive(Active active);

    /**
     * 添加
     * @param active
     * @return
     */
    public String insertActive(Active active);

    /**
     * 添加参与者
     * @param join
     * @return
     */
    public String addJoinList(Join join);

    /**
     * 获取参赛者名单
     * @param join
     * @return
     */
    public List<Join> getJoinList(Join join);

    /**
     * 删除参赛者
     * @param join
     * @return
     */
    public String deleteJoins(Join join);
}
