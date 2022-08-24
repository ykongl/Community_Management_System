package com.example.community.dao;
import com.example.community.bean.PassW;
import com.example.community.bean.User;
import com.example.community.bean.Worker;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/3/27
 */
@Repository
public interface LoginDao {
    /**
     * 登录(非用户)
     * @param workNo
     * @param password
     * @param roleId
     * @return
     */
    public Worker getUserByMassage(@Param("workNo") String workNo, @Param("password") String password,@Param("roleId") String roleId);

    /**
     * 登录（用户）
     * @param workNo
     * @param password
     * @param roleId
     * @return
     */
    public Worker getUserLogin(@Param("workNo") String workNo, @Param("password") String password, @Param("roleId") String roleId);

    /**
     * 修改密码
     * @param passW
     * @return
     */
    public int updatePassword(PassW passW);

    public int updateLoginTime(String workNo);

    public int updateUserLoginTime(String workNo);

}
