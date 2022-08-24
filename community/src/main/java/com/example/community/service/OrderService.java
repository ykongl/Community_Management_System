package com.example.community.service;

import com.example.community.bean.Customer;
import com.example.community.bean.Order;

import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/5/16
 */
public interface OrderService {
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
    public String deleteById(Order order);

    /**
     * 删除购买人
     * @param order
     * @return
     */
    public String deleteCustomer(Order order);

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
    public String insertOrders(Order order);

    /**
     * 修改订单状态
     * @param order
     * @return
     */
    public String updateStatus(Order order);

}
