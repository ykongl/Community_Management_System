package com.example.community.controller;

import com.example.community.bean.Knowledge;
import com.example.community.service.KnowledgeService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/21
 */
@RestController
@RequestMapping("/knowledge")
public class KnowledgeController {
    @Resource
    private KnowledgeService knowledgeService;

    /**
     * 列表
     * @param knowledge
     * @return
     */
    @GetMapping("/list")
    public List<Knowledge> getKnowledgeList(Knowledge knowledge){
        return knowledgeService.getKnowledgeList(knowledge);
    }

    /**
     * 详情
     * @param id
     * @param style
     * @return
     */
    @GetMapping("/info")
    public Knowledge getKnowledgeInfo(int id,String style){
        return knowledgeService.getKnowledgeInfo(id,style);
    }

    /**
     * 删除
     * @param knowledge
     * @return
     */
    @PostMapping("/deleteById")
    public String deleteKnowledgeById(Knowledge knowledge){
       return knowledgeService.deleteKnowledgeById(knowledge);
    }

    /**
     * 修改
     * @param knowledge
     * @return
     */
    @PostMapping("/updateInfo")
    public String updateKnowledge(@RequestBody Knowledge knowledge){
        return knowledgeService.updateKnowledge(knowledge);
    }

    /**
     * 新增
     * @param knowledge
     * @return
     */
    @PostMapping("/insertKnowledge")
    public String insertKnowledge(@RequestBody Knowledge knowledge){
        return knowledgeService.insertKnowledge(knowledge);
    }


}
