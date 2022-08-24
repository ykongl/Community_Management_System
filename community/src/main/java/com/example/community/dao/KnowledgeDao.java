package com.example.community.dao;

import com.example.community.bean.Knowledge;
import org.springframework.stereotype.Repository;

import java.util.List;
/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/21
 */
@Repository
public interface KnowledgeDao {

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
    public int deleteKnowledgeById(Knowledge knowledge);

    /**
     * 修改
     * @param knowledge
     * @return
     */
    public int updateKnowledge(Knowledge knowledge);

    /**
     * 添加
     * @param knowledge
     * @return
     */
    public int insertKnowledge(Knowledge knowledge);

    /**
     * 修改阅读量
     * @param id
     * @param style
     * @return
     */
    public int updateNumber(int id,String style);
}
