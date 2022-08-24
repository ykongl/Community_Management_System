package com.example.community.service;

import com.example.community.bean.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/3/27
 */
public interface UserService {
    /**
     * 获取用户列表
     * @return
     */
    public List<User> getAllUser(User user);
    /**
     * 获取所有的用户个数
     */
    public int getUserCounts(User user);

    /**
     * 修改用户状态
     */
    public String updateState(User user);

    /**
     * 添加用户
     */
    public String insertUser(User user);


    /**
     * 删除用户
     */
    public String deleteUser(User user);

    /**
     * 获取用户详情
     */
    public User selectUserById(User user);

    /**
     * 修改用户
     */
    public String updateUser(User user);



    /**
     * 地址下拉框
     * @param user
     * @return
     */
    public List<User> selectAddress(User user);
}
