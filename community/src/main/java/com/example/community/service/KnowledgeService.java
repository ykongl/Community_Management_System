package com.example.community.service;

import com.example.community.bean.Knowledge;

import java.util.List;
/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/21
 */
public interface KnowledgeService {
    /**
     * 列表
     * @param knowledge
     * @return
     */
    public List<Knowledge> getKnowledgeList(Knowledge knowledge);

    /**
     * 详情
     * @param id
     * @param style
     * @return
     */
    public Knowledge getKnowledgeInfo(int id,String style);

    /**
     * 删除
     * @param knowledge
     * @return
     */
    public String deleteKnowledgeById(Knowledge knowledge);

    /**
     * 修改
     * @param knowledge
     * @return
     */
    public String updateKnowledge(Knowledge knowledge);

    /**
     * 添加
     * @param knowledge
     * @return
     */
    public String insertKnowledge(Knowledge knowledge);
}
