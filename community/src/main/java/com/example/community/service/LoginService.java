package com.example.community.service;

import com.example.community.bean.PassW;
import com.example.community.bean.Worker;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/3/27
 */
public interface LoginService {
    /**
     * 登录
     * @param workNo
     * @param password
     * @param roleId
     * @return
     */
    public Worker getUserByMassage(@Param("workNo") String workNo, @Param("password") String password,@Param("roleId") String roleId);


    /**
     * 修改密码
     * @param passW
     * @return
     */
    public String updatePassword(PassW passW);


}
