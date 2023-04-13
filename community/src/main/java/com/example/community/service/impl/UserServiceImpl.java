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
        //分页
        int pageStart = (user.getPageNum() - 1) * user.getPageSize();
        user.setPageStart(pageStart);
        List<User> users = userDao.getAllUser(user);
        users.stream().forEach(user1 -> {
            if("0".equals(user1.getSex())){
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
    public int updateState(User user) {
        return userDao.updateState(user);
    }

    /**
     * 添加
     * @param user
     * @return
     */
    @Override
    public int insertUser(User user) {
        user.setState(true);
        return userDao.insertUser(user);
    }

    /**
     * 删除
     * @param user
     * @return
     */
    @Override
    public int deleteUser(User user) {
        return userDao.deleteUser(user);
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
    public int updateUser(User user) {
        return userDao.updateUser(user);
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
