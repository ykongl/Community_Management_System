package com.example.community.service.impl;

import com.example.community.bean.Community;
import com.example.community.dao.CommunityDao;
import com.example.community.service.CommunityService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/2
 */
@Service
public class CommunityServiceImpl implements CommunityService {

    @Resource
    private CommunityDao communityDao;

    /**
     * 查询社区列表
     * @param community
     * @return
     */
    @Override
    public List<Community> selectCommunity(Community community) {
        int pageStart = (community.getPageNum() - 1) * community.getPageSize();//分页
        community.setPageStart(pageStart);
        return communityDao.selectCommunity(community);
    }

    /**
     * 社区详情
     * @param id
     * @return
     */
    @Override
    public Community getCommunityById(int id) {
        return communityDao.getCommunityById(id);
    }

    /**
     * 删除
     * @param community
     * @return
     */
    @Override
    public String deleteCommunity(Community community) {
        int i = communityDao.deleteCommunity(community);
        return i > 0 ? "success" : "error";
    }


    /**
     * 添加
     * @param community
     * @return
     */
    @Override
    public String insertCommunity(Community community) {
        int i = communityDao.insertCommunity(community);
        return i > 0 ? "success" : "error";
    }

    /**
     * 修改
     * @param community
     * @return
     */
    @Override
    public String updateCommunity(Community community) {
        int i = communityDao.updateCommunity(community);
        return i > 0 ? "success" : "error";
    }

    /**
     * 修改状态
     * @param community
     * @return
     */
    @Override
    public String updateState(Community community) {
        int i = communityDao.updateState(community);
        return i > 0 ? "success" : "error";
    }
}
