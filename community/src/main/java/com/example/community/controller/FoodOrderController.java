package com.example.community.controller;

import com.example.community.bean.CommunityRestaurant;
import com.example.community.bean.Food;
import com.example.community.bean.FoodOrder;
import com.example.community.service.FoodOrderService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/5/21
 */
@RestController
@RequestMapping("/foodOrder")
public class FoodOrderController {

    @Resource
    private FoodOrderService foodOrderService;

    /**
     * 获取餐饮订单
     * @param foodOrder
     * @return
     */
    @GetMapping("/list")
    public List<FoodOrder> getFoodOrderList(FoodOrder foodOrder){
        return foodOrderService.getFoodOrderList(foodOrder);
    }

    /**
     * 添加餐厅
     * @param communityRestaurant
     * @return
     */
    @PostMapping("/insertRestaurant")
    public String insertRestaurant(@RequestBody CommunityRestaurant communityRestaurant){
        return foodOrderService.insertRestaurant(communityRestaurant);
    }

    /**
     * 获取餐厅下拉框
     * @param communityRestaurant
     * @return
     */
    @GetMapping("/restaurantDrop")
    public List<CommunityRestaurant> getRestaurants(CommunityRestaurant communityRestaurant){
        return foodOrderService.getRestaurants(communityRestaurant);
    }

    /**
     * 添加菜品
     * @param food
     * @return
     */
    @PostMapping("/insertFood")
    public String insertFood(@RequestBody Food food){
        return foodOrderService.insertFood(food);
    }

    /**
     * 菜品列表
     * @param food
     * @return
     */
    @GetMapping("/foodList")
    public List<Food> getFoodList(Food food){
        return foodOrderService.getFoodList(food);
    }


    /**
     * 添加餐饮订单
     * @param foodOrder
     * @return
     */
    @PostMapping("/insertFoodOrder")
    public String insertFoodOrder(@RequestBody FoodOrder foodOrder){
        return foodOrderService.insertFoodOrder(foodOrder);
    }

    /**
     * 删除菜品订单
     * @param foodOrder
     * @return
     */
    @PostMapping("/deleteFoodOrderById")
    public String deleteFoodOrderById(FoodOrder foodOrder){
        return foodOrderService.deleteFoodOrderById(foodOrder);
    }

    /**
     * 删除菜
     * @param food
     * @return
     */
    @PostMapping("/deleteFoodById")
    public String deleteFoodById(Food food){
        return foodOrderService.deleteFoodById(food);
    }

    /**
     * 修改状态
     * @param foodOrder
     * @return
     */
    @PostMapping("/updateStatus")
    public String updateStatus(FoodOrder foodOrder){
        return foodOrderService.updateStatus(foodOrder);
    }
}
