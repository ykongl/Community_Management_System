package com.example.community.controller;

import com.example.community.bean.ShopMall;
import com.example.community.service.ShopMallService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/5/12
 */
@RestController
@RequestMapping("/shop")
public class ShopMallController {

    @Resource
    private ShopMallService shopMallService;

    /**
     * 获取商品列表
     * @param shopMall
     * @return
     */
    @GetMapping("/list")
    public List<ShopMall> getGoodsList(ShopMall shopMall){
        return shopMallService.getGoodsList(shopMall);
    }

    /**
     * 添加商品
     * @param shopMall
     * @return
     */
    @PostMapping("/addGoods")
    public String addGoods(@RequestBody ShopMall shopMall){
        return shopMallService.addGoods(shopMall);
    }


    /**
     * 删除商品
     * @param shopMall
     * @return
     */
    @PostMapping("/deleteById")
    public String deleteGoodsById(ShopMall shopMall){
        return shopMallService.deleteGoodsById(shopMall);
    }


}
