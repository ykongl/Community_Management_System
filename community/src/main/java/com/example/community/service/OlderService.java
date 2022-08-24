package com.example.community.service;

import com.example.community.bean.Older;

import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/7
 */
public interface OlderService {
    /**
     * 获取老人列表
     * @param older
     * @return
     */
    public List<Older> getAllOlderList(Older older);

    /**
     * 获取详情
     * @param id
     * @return
     */
    public Older getOlderById(int id);


    /**
     * 删除
     * @param older
     * @return
     */
    public String deleteOlder(Older older);

    /**
     * 修改信息
     * @param older
     * @return
     */
    public String updateOlder(Older older);

    /**
     * 修改状态
     * @param older
     * @return
     */
    public String updateState(Older older);

    /**
     * 监护人下拉框
     * @param older
     * @return
     */
    public List<Older> selectUserList(Older older);

    /**
     * 添加
     * @param older
     * @return
     */
    public String addOlder(Older older);

    public int addImg(String imgUrl);
}
