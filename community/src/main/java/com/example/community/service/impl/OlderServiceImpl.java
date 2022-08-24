package com.example.community.service.impl;

import com.example.community.bean.Older;
import com.example.community.dao.OlderDao;
import com.example.community.service.OlderService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.time.Year;
import java.util.Calendar;
import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/4/7
 */
@Service
public class OlderServiceImpl implements OlderService {
    @Resource
    private OlderDao olderDao;

    /**
     * 查询列表
     * @param older
     * @return
     */
    @Override
    public List<Older> getAllOlderList(Older older) {
        int pageStart = (older.getPageNum() - 1) * older.getPageSize();//分页
        older.setPageStart(pageStart);
        List<Older> olderList = olderDao.getAllOlderList(older);
        for (int i = 0; i < olderList.size(); i++) {
            if(olderList.get(i).getSex().equals("0")){
                olderList.get(i).setSex("男");
            }else{
                olderList.get(i).setSex("女");
            }
        }
        return olderList;
    }

    /**
     * 详情
     * @param id
     * @return
     */
    @Override
    public Older getOlderById(int id) {
        return olderDao.getOlderById(id);
    }



    /**
     * 删除
     * @param older
     * @return
     */
    @Override
    public String deleteOlder(Older older) {
        int i = olderDao.deleteOlder(older);
        return i > 0 ? "success" : "error";
    }

    /**
     * 修改
     * @param older
     * @return
     */
    @Override
    public String updateOlder(Older older) {
        int i = olderDao.updateOlder(older);
        return i > 0 ? "success" : "error";
    }

    /**
     * 修改状态
     * @param older
     * @return
     */
    @Override
    public String updateState(Older older) {
        int i = olderDao.updateState(older);
        return i > 0 ? "success" : "error";
    }

    /**
     * 监护人下拉框
     * @param older
     * @return
     */
    public List<Older> selectUserList(Older older){
        return olderDao.selectUserList(older);
    }

    /**
     * 添加
     * @param older
     * @return
     */
    @Override
    public String addOlder(Older older) {
        Calendar c = Calendar.getInstance();
        c.setTime(older.getBirthday());
        int birthYear = c.get(Calendar.YEAR);
        int now = Year.now().getValue();
        older.setOlderAge(Integer.toString(now-birthYear));
        int i = olderDao.addOlder(older);
        return i > 0 ? "success" : "error";
    }

    @Override
    public int addImg(String imgUrl) {
        return olderDao.addImg(imgUrl);
    }
}
