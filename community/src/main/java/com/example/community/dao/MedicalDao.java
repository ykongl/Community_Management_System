package com.example.community.dao;

import com.example.community.bean.*;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/5/5
 */
@Repository
public interface MedicalDao {

    /**
     * 获取医疗互助列表
     * @param medical
     * @return
     */
    public List<Medical> getMedicalList(Medical medical);

    /**
     * 删除医疗互助信息
     * @param medical
     * @return
     */
    public int deleteMedical(Medical medical);


    /**
     * 获取药店列表
     * @param pharmacy
     * @return
     */
    public List<Pharmacy> getPharmacyList(Pharmacy pharmacy);


    /**
     * 添加药店
     * @param pharmacy
     * @return
     */
    public int insertPharmacy(Pharmacy pharmacy);


    /**
     * 药品列表
     * @param drug
     * @return
     */
    public List<Drug> getDrugList(Drug drug);

    /**
     * 获取药品所有分类
     * @return
     */
    public List<Drug> getDrugTypeList();

    /**
     * 添加
     * @param drug
     * @return
     */
    public int insertDrug(Drug drug);

    /**
     * 查询医院列表
     * @param hospital
     * @return
     */
    public List<Hospital> getHospitalList(Hospital hospital);

    /**
     * 添加医院
     * @param hospital
     * @return
     */
    public int insertHospital(Hospital hospital);


    /**
     * 获取科室下拉框
     * @return
     */
    public List<Department> getDepartmentDrop();

    /**
     * 获取医院下拉框
     * @return
     */
    public List<Hospital> getHospitalDrop();

    /**
     * 获取医生下拉框
     * @param doctor
     * @return
     */
    public List<Doctor> getDoctorDrop(Doctor doctor);

    /**
     * 获取医院信息
     * @param id
     * @return
     */
    public Hospital getHospitalInfo(int id);

    /**
     * 添加医疗互助业务
     * @param medical
     * @return
     */
    public int insertMedical(Medical medical);

    /**
     * 添加预约挂号
     * @param appointment
     * @return
     */
    public int insertAppointment(Appointment appointment);

    /**
     * 获取预约单详情
     * @param appointNo
     * @return
     */
    public Appointment getMedicalInfo(String appointNo);

    /**
     * 修改预约信息
     * @param appointment
     * @return
     */
    public int updateAppointment(Appointment appointment);

    /**
     * 修改医疗业务
     * @param medical
     * @return
     */
    public int updateMedical(Medical medical);

    /**
     * 添加买药业务
     * @param medical
     * @return
     */
    public int addMedical(Medical medical);

    /**
     * 修改业务状态
     * @param medical
     * @return
     */
    public int updateStatus(Medical medical);

}
