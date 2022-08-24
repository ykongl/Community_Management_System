package com.example.community.service;

import com.example.community.bean.ShopMall;

import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/5/12
 */
public interface ShopMallService {

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
    public String addGoods(ShopMall shopMall);

    /**
     * 删除商品
     * @param shopMall
     * @return
     */
    public String deleteGoodsById(ShopMall shopMall);
}
