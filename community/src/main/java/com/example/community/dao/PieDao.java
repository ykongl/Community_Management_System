package com.example.community.dao;

import com.example.community.bean.Pie;
import org.springframework.stereotype.Repository;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/29
 */
@Repository
public interface PieDao {
    /**
     * 获取数量
     * @return
     */
    public Pie getCount();
}
