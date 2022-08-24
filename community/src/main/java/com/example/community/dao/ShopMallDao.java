package com.example.community.dao;

import com.example.community.bean.ShopMall;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/5/12
 */
@Repository
public interface ShopMallDao {

    /**
     * 获取商品列表
     * @param shopMall
     * @return
     */
    public List<ShopMall> getGoodsList(ShopMall shopMall);

    /**
     * 添加商品
     * @param shopMall
     * @return
     */
    public int addGoods(ShopMall shopMall);

    /**
     * 删除商品
     * @param shopMall
     * @return
     */
    public int deleteGoodsById(ShopMall shopMall);
}
