package com.example.community.dao;

import com.example.community.bean.Community;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/2
 */
@Repository
public interface CommunityDao {

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
    public int deleteCommunity(Community community);

    /**
     * 添加
     * @param community
     * @return
     */
    public int insertCommunity(Community community);

    /**
     * 修改
     * @param community
     * @return
     */
    public int updateCommunity(Community community);

    /**
     * 修改状态
     * @param community
     * @return
     */
    public int updateState(Community community);
}
