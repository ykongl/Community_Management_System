package com.example.community.service.impl;

import com.example.community.bean.ShopMall;
import com.example.community.dao.ShopMallDao;
import com.example.community.service.ShopMallService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/5/12
 */
@Service
public class ShopMallServiceImpl implements ShopMallService {
    @Resource
    private ShopMallDao shopMallDao;

    /**
     * 获取商品列表
     * @param shopMall
     * @return
     */
    @Override
    public List<ShopMall> getGoodsList(ShopMall shopMall) {
        int pageStart = (shopMall.getPageNum() - 1) * shopMall.getPageSize();//分页
        shopMall.setPageStart(pageStart);
        return shopMallDao.getGoodsList(shopMall);
    }

    /**
     * 添加商品
     * @param shopMall
     * @return
     */
    @Override
    public String addGoods(ShopMall shopMall) {
        int i = shopMallDao.addGoods(shopMall);
        return i > 0 ? "success" : "error";
    }

    /**
     * 删除商品
     * @param shopMall
     * @return
     */
    @Override
    public String deleteGoodsById(ShopMall shopMall) {
        int i = shopMallDao.deleteGoodsById(shopMall);
        return i > 0 ? "success" : "error";
    }
}
