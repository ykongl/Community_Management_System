package com.example.community.controller;

import com.alibaba.fastjson.JSON;
import com.example.community.bean.PassW;
import com.example.community.bean.Worker;
import com.example.community.service.LoginService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;


/**
 * @author ykongl
 * @version 1.0
 */
@RestController
@RequestMapping("/Worker")
public class LoginController {
    @Resource
    private LoginService loginService;

    /**
     * 登录
     * @param worker
     * @return
     */
    @RequestMapping("/login")
    public String login(@RequestBody Worker worker){
        String flag = "error";
        Worker wk = loginService.getUserByMassage(worker.getWorkNo(),worker.getPassword(),worker.getRoleId());
        HashMap<String,Object> res = new HashMap<>();
        if (wk!=null){
            flag = "ok";
        }
        res.put("flag",flag);
        res.put("worker",wk);
        String res_json = JSON.toJSONString(res);
        return res_json;
    }


    /**
     * 修改密码
     * @param passW
     * @return
     */
    @PostMapping("/updatePassword")
    public String updatePassword(@RequestBody PassW passW){
        return loginService.updatePassword(passW);
    }

}
