package com.example.community.dao;

import com.example.community.bean.Active;
import com.example.community.bean.Join;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/22
 */
@Repository
public interface ActiveDao {

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
    public int deleteActive(Active active);

    /**
     * 修改
     * @param active
     * @return
     */
    public int updateActive(Active active);

    /**
     * 添加
     * @param active
     * @return
     */
    public int insertActive(Active active);

    /**
     * 添加参与者
     * @param join
     * @return
     */
    public int addJoinList(Join join);

    /**
     * 修改人数
     * @param id
     * @return
     */
    public int updateJoinNumber(int id,boolean flag);


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
    public int deleteJoins(Join join);



}
