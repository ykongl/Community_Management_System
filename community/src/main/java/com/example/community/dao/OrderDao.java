package com.example.community.dao;

import com.example.community.bean.Customer;
import com.example.community.bean.Order;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/5/16
 */
@Repository
public interface OrderDao {
    /**
     * 代购单列表
     * @param order
     * @return
     */
    public List<Order> getOrderList(Order order);

    /**
     * 删除订单
     * @param order
     * @return
     */
    public int deleteById(Order order);


    /**
     * 删除购买人
     * @param order
     * @return
     */
    public int deleteCustomer(Order order);

    /**
     * 获取团购名单
     * @param customer
     * @return
     */
    public List<Customer> getCustomerList(Customer customer);

    /**
     * 添加订单信息
     * @param order
     * @return
     */
    public int insertOrders(Order order);

    /**
     * 添加顾客信息
     * @param customer
     * @return
     */
    public int insertCustomer(Customer customer);

    /**
     * 修改商品库存
     * @param orderNumber
     * @param goodsId
     * @return
     */
    public int updateShopNumber(int orderNumber,String goodsId);

    /**
     * 修改团购数量
     * @param number
     * @param goodsId
     * @param orderNo
     * @return
     */
    public int updateOrderNumber(int number,String goodsId,String orderNo);

    /**
     * 修改订单状态
     * @param order
     * @return
     */
    public int updateStatus(Order order);

}
