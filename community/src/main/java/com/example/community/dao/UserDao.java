package com.example.community.dao;

import com.example.community.bean.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author ykongl
 * @version 1.0
 */
@Repository
public interface UserDao {

    /**
     * 获取用户列表
     */
    public List<User> getAllUser(User user);
    /**
     * 获取所有的用户个数
     */
    public int getUserCounts(User user);

    /**
     * 修改用户状态
     */
    public int updateState(User user);

    /**
     * 添加用户
     */
    public int insertUser(User user);


    /**
     * 删除用户
     */
    public int deleteUser(User user);

    /**
     * 获取用户详情
     */
    public User selectUserById(User user);

    /**
     * 修改用户
     */
    public int updateUser(User user);



    /**
     * 地址下拉框
     * @param user
     * @return
     */
    public List<User> selectAddress(User user);
}
