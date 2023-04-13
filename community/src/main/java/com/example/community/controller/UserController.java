package com.example.community.controller;

import com.example.community.bean.Result;
import com.example.community.bean.User;
import com.example.community.service.UserService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

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
     */
    @GetMapping("/list")
    public Result getUserList(User user){
        int number = userService.getUserCounts(user);
        //用户数量
        List<User> allUser = userService.getAllUser(user);
        return Result.ok(allUser,number);
    }

    /**
     * 修改用户状态
     * @param user
     * @return
     */
    @PostMapping("/updateState")
    public Result updateState(User user){
        userService.updateState(user);
        return Result.ok();
    }

    /**
     * 添加用户
     * @param user
     * @return
     */
    @PostMapping("/insertUser")
    public Result insertUser(@RequestBody User user){
         userService.insertUser(user);
         return Result.ok();
    }

    /**
     * 删除用户
     * @param user
     * @return
     */
    @PostMapping("/deleteUser")
    public Result deleteUser(User user){
        userService.deleteUser(user);
        return Result.ok();
    }

    /**
     * 詳情
     * @param user
     * @return
     */
    @GetMapping("/userId")
    public Result selectUserById(User user){
        User user1 = userService.selectUserById(user);
        if (user1 == null) {
            return Result.error("");
        }
        return Result.ok(user1);
    }

    /**
     * 保存更新
     * @param user
     * @return
     */
    @PostMapping("/editUser")
    public Result updateUser(@RequestBody User user){
        userService.updateUser(user);
        return Result.ok();
    }



    /**
     * 地址下拉框
     * @param user
     * @return
     */
    @GetMapping("/address")
    public Result selectAddress(User user){
        List<User> users = userService.selectAddress(user);
        return Result.ok(users, users.size());
    }
}
