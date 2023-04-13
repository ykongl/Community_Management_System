package com.example.community.bean;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


import java.util.List;

/**
 * @author minjy@vastio.com
 * @version: 2023/4/13 10:23
 */
@Data
@NoArgsConstructor
@AllArgsConstructor

public class Result {
    private int code;
    private String status;
    private String message;
    private int total;
    private Object data;

    private static final String SUCCESS = "success";
    private static final String ERROR = "error";

    public static Result ok(){
        return new Result(200,SUCCESS,null,0,null);
    }

    public static Result ok(Object data){
        return new Result(200,SUCCESS,null,0,data);
    }

    public static Result ok(List<?> data,int total){
        return new Result(200,SUCCESS,null, total,data);
    }

    public static Result error(String message){
        return new Result(400,ERROR,message,0,null);
    }
}
