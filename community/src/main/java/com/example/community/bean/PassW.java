package com.example.community.bean;

import lombok.Data;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/1
 */
@Data
public class PassW {
    private int id;
    private String oldPassword;
    private String newPassword;
    private String passwordConfirm;
}
