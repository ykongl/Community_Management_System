package com.example.community.service;

import com.example.community.bean.CommunityRestaurant;
import com.example.community.bean.Food;
import com.example.community.bean.FoodOrder;

import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/5/21
 */
public interface FoodOrderService {
    /**
     * 获取餐饮订单
     * @param foodOrder
     * @return
     */
    public List<FoodOrder> getFoodOrderList(FoodOrder foodOrder);

    /**
     * 添加餐厅
     * @param communityRestaurant
     * @return
     */
    public String insertRestaurant(CommunityRestaurant communityRestaurant);

    /**
     * 获取餐厅下拉框
     * @param communityRestaurant
     * @return
     */
    public List<CommunityRestaurant> getRestaurants(CommunityRestaurant communityRestaurant);

    /**
     * 添加菜品
     * @param food
     * @return
     */
    public String insertFood(Food food);

    /**
     * 菜品列表
     * @param food
     * @return
     */
    public List<Food> getFoodList(Food food);

    /**
     * 添加餐饮订单
     * @param foodOrder
     * @return
     */
    public String insertFoodOrder(FoodOrder foodOrder);

    /**
     * 删除菜品订单
     * @param foodOrder
     * @return
     */
    public String deleteFoodOrderById(FoodOrder foodOrder);

    /**
     * 删除菜
     * @param food
     * @return
     */
    public String deleteFoodById(Food food);

    /**
     * 修改订单状态
     * @param foodOrder
     * @return
     */
    public String updateStatus(FoodOrder foodOrder);
}
