package com.example.community.service.impl;

import com.example.community.bean.PassW;
import com.example.community.bean.Worker;
import com.example.community.dao.LoginDao;
import com.example.community.service.LoginService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/3/27
 */
@Service
public class LoginServiceImpl implements LoginService {
    @Resource
    private LoginDao loginDao;

    /**
     * 登录
     * @param workNo
     * @param password
     * @param roleId
     * @return
     */
    @Override
    public Worker getUserByMassage(String workNo, String password, String roleId){
        if(roleId.equals("4")){
            loginDao.updateUserLoginTime(workNo);
            return loginDao.getUserLogin(workNo,password,roleId);
        }
        loginDao.updateLoginTime(workNo);
        return loginDao.getUserByMassage(workNo,password,roleId);
    }

    /**
     * 修改密码
     * @param passW
     * @return
     */
    @Override
    public String updatePassword(PassW passW) {
        int i = loginDao.updatePassword(passW);
        return i > 0 ? "success" : "error";
    }


}
