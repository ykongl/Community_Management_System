package com.example.community.service.impl;

import com.example.community.bean.User;
import com.example.community.dao.UserDao;
import com.example.community.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/3/27
 */
@Service
public class UserServiceImpl implements UserService {

    @Resource
    private UserDao userDao;

    /**
     * 列表
     * @param user
     * @return
     */
    @Override
    public List<User> getAllUser(User user) {
        int pageStart = (user.getPageNum() - 1) * user.getPageSize();//分页
        user.setPageStart(pageStart);
        List<User> users = userDao.getAllUser(user);
        users.stream().forEach(user1 -> {
            if(user1.getSex().equals("0")){
                user1.setSex("男");
            }else{
                user1.setSex("女");
            }
        });
       return users;
    }

    /**
     * 总数
     * @param user
     * @return
     */
    @Override
    public int getUserCounts(User user) {
        return userDao.getUserCounts(user);
    }

    /**
     * 修改状态
     * @param user
     * @return
     */
    @Override
    public String updateState(User user) {
        int i =  userDao.updateState(user);
        return i > 0 ? "success" : "error";
    }

    /**
     * 添加
     * @param user
     * @return
     */
    @Override
    public String insertUser(User user) {
        user.setState(true);
        int i = userDao.insertUser(user);
        return i > 0 ? "success" : "error";
    }

    /**
     * 删除
     * @param user
     * @return
     */
    @Override
    public String deleteUser(User user) {
        int i = userDao.deleteUser(user);
        return i > 0 ? "success" : "error";
    }

    /**
     * 详情
     * @param user
     * @return
     */
    @Override
    public User selectUserById(User user) {
        return userDao.selectUserById(user);
    }

    /**
     * 修改
     * @param user
     * @return
     */
    @Override
    public String updateUser(User user) {
        int i = userDao.updateUser(user);
        return i > 0 ? "success" : "error";
    }


    /**
     * 社区下拉框
     * @param user
     * @return
     */
    @Override
    public List<User> selectAddress(User user) {
        return userDao.selectAddress(user);
    }
}
