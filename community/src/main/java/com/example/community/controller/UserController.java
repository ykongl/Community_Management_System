package com.example.community.controller;

import com.alibaba.fastjson.JSON;
import com.example.community.bean.User;
import com.example.community.service.UserService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/3/27
 */
@RestController
@RequestMapping("/User")
public class UserController {
    @Resource
    private UserService userService;

    /**
     * 获取用户列表
     * @param user
     * @return
     */

    @GetMapping("/list")
    public String getUserList(User user){
        int number = userService.getUserCounts(user);//用户数量
        List<User> allUser = userService.getAllUser(user);
        HashMap<String, Object> res = new HashMap<>();
        res.put("number",number);
        res.put("data",allUser);
        //转成String类型
        String s = JSON.toJSONString(res);
        return s;
    }

    /**
     * 修改用户状态
     * @param user
     * @return
     */
    @PostMapping("/updateState")
    public String UpdateState(User user){
        return userService.updateState(user);
    }

    /**
     * 添加用户
     * @param user
     * @return
     */
    @PostMapping("/insertUser")
    public String InsertUser(@RequestBody User user){
        return userService.insertUser(user);
    }

    /**
     * 删除用户
     * @param user
     * @return
     */
    @PostMapping("/deleteUser")
    public String DeleteUser(User user){
        return userService.deleteUser(user);
    }

    /**
     * 詳情
     * @param user
     * @return
     */
    @GetMapping("/userId")
    public User selectUserById(User user){
        return userService.selectUserById(user);
    }

    /**
     * 保存更新
     * @param user
     * @return
     */
    @PostMapping("/editUser")
    public String updateUser(@RequestBody User user){
        return userService.updateUser(user);
    }



    /**
     * 地址下拉框
     * @param user
     * @return
     */
    @GetMapping("/address")
    public List<User> selectAddress(User user){
        return userService.selectAddress(user);
    }
}
