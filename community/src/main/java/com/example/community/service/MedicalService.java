package com.example.community.service;

import com.example.community.bean.*;

import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/5/5
 */
public interface MedicalService {
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
    public String deleteMedical(Medical medical);

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
    public String insertPharmacy(Pharmacy pharmacy);


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
    public String insertDrug(Drug drug);

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
    public String insertHospital(Hospital hospital);

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
     * 添加业务
     * @param appointment
     * @return
     */
    public String insertAppointment(Appointment appointment);

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
    public String updateAppointment(Appointment appointment);

    /**
     * 添加医疗互助业务
     * @param medical
     * @return
     */
    public String insertMedical(Medical medical);

    /**
     * 修改业务状态
     * @param medical
     * @return
     */
    public String updateStatus(Medical medical);


}
