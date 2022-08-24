package com.example.community.service;

import com.example.community.bean.Community;

import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/2
 */
public interface CommunityService {
    /**
     * 查询社区列表
     * @param community
     * @return
     */
    public List<Community> selectCommunity(Community community);

    /**
     * 获取社区详情
     * @param id
     * @return
     */
    public Community getCommunityById(int id);

    /**
     * 删除
     * @param community
     * @return
     */
    public String deleteCommunity(Community community);

    /**
     * 添加
     * @param community
     * @return
     */
    public String insertCommunity(Community community);

    /**
     * 修改
     * @param community
     * @return
     */
    public String updateCommunity(Community community);

    /**
     * 修改状态
     * @param community
     * @return
     */
    public String updateState(Community community);
}
