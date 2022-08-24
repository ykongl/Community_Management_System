package com.example.community.service.impl;

import com.example.community.bean.*;
import com.example.community.dao.MedicalDao;
import com.example.community.service.MedicalService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.lang.System;
import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/5/5
 */
@Service
public class MedicalServiceImpl implements MedicalService {
    @Resource
    private MedicalDao medicalDao;

    /**
     * 获取医疗互助列表
     * @param medical
     * @return
     */
    @Override
    public List<Medical> getMedicalList(Medical medical) {
        int pageStart = (medical.getPageNum() - 1) * medical.getPageSize();//分页
        medical.setPageStart(pageStart);
        return medicalDao.getMedicalList(medical);
    }


    /**
     * 删除医疗互助信息
     * @param medical
     * @return
     */
    @Override
    public String deleteMedical(Medical medical){
        int i = medicalDao.deleteMedical(medical);
        return i > 0 ? "success" : "error";
    }

    /**
     * 获取药店列表
     * @param pharmacy
     * @return
     */
    @Override
    public List<Pharmacy> getPharmacyList(Pharmacy pharmacy){
        int pageStart = (pharmacy.getPageNum() - 1) * pharmacy.getPageSize();//分页
        pharmacy.setPageStart(pageStart);
        return medicalDao.getPharmacyList(pharmacy);
    }


    /**
     * 添加药店
     * @param pharmacy
     * @return
     */
    @Override
    public String insertPharmacy(Pharmacy pharmacy) {
        pharmacy.setValue("5");
        pharmacy.setDistance("3.6");
        pharmacy.setDeliveryTime("30");
        int i = medicalDao.insertPharmacy(pharmacy);
        return i > 0 ? "success" : "error";
    }

    /**
     * 药品列表
     * @param drug
     * @return
     */
    @Override
    public List<Drug> getDrugList(Drug drug){
        int pageStart = (drug.getPageNum() - 1) * drug.getPageSize();//分页
        drug.setPageStart(pageStart);
        return medicalDao.getDrugList(drug);
    }

    /**
     * 获取药品所有分类
     * @return
     */
    @Override
    public List<Drug> getDrugTypeList(){
        return medicalDao.getDrugTypeList();
    }


    /**
     * 添加
     * @param drug
     * @return
     */
    @Override
    public String insertDrug(Drug drug){
        int i = medicalDao.insertDrug(drug);
        return i > 0 ? "success" : "error";
    }

    /**
     * 获取医院列表
     * @param hospital
     * @return
     */
    @Override
    public List<Hospital> getHospitalList(Hospital hospital) {
        int pageStart = (hospital.getPageNum() - 1) * hospital.getPageSize();//分页
        hospital.setPageStart(pageStart);
        return medicalDao.getHospitalList(hospital);
    }

    /**
     * 添加医院
     * @param hospital
     * @return
     */
    @Override
    public String insertHospital(Hospital hospital) {
        int i = medicalDao.insertHospital(hospital);
        return i > 0 ? "success" : "error";
    }

    /**
     * 获取科室下拉框
     * @return
     */
    @Override
    public List<Department> getDepartmentDrop(){
        return medicalDao.getDepartmentDrop();
    }


    /**
     * 获取医院下拉框
     * @return
     */
    @Override
    public List<Hospital> getHospitalDrop(){
        return medicalDao.getHospitalDrop();
    }

    /**
     * 获取医生下拉框
     * @param doctor
     * @return
     */
    @Override
    public List<Doctor> getDoctorDrop(Doctor doctor){
        return medicalDao.getDoctorDrop(doctor);
    }

    /**
     * 获取医院信息
     * @param id
     * @return
     */
    @Override
    public Hospital getHospitalInfo(int id){
        return medicalDao.getHospitalInfo(id);
    }

    /**
     * 添加业务
     * @param appointment
     * @return
     */
    @Override
    public String insertAppointment(Appointment appointment) {
        appointment.setAppointTime(appointment.getWeekdays() + " " + appointment.getRegisterTime());
        Medical medical = new Medical();
        medical.setBusinessNo(appointment.getAppointNo());
        medical.setBusinessType("1");
        medical.setBusinessOrganization(appointment.getHospitalName());
        medical.setBusinessStatus("1");
        medical.setBusinessContent(appointment.toString());
        medical.setCreateId(appointment.getCreateId());
        medical.setPrice(appointment.getPrice());
        medicalDao.insertMedical(medical);
        int i = medicalDao.insertAppointment(appointment);
        return i > 0 ? "success" : "error";
    }
    /**
     * 获取预约单详情
     * @param appointNo
     * @return
     */
    @Override
    public Appointment getMedicalInfo(String appointNo){
        return medicalDao.getMedicalInfo(appointNo);
    }

    /**
     * 修改预约信息
     * @param appointment
     * @return
     */
    public String updateAppointment(Appointment appointment){
        Medical medical = new Medical();
        medical.setBusinessContent(appointment.toString());
        medical.setBusinessNo(appointment.getAppointNo());
        medical.setBusinessOrganization(appointment.getHospitalName());
        medical.setUpdateId(appointment.getUpdateId());
        medicalDao.updateMedical(medical);
        int i = medicalDao.updateAppointment(appointment);
        return i > 0 ? "success" : "error";
    }

    /**
     * 添加医疗互助业务
     * @param medical
     * @return
     */
    @Override
    public String insertMedical(Medical medical) {
         int i = medicalDao.insertMedical(medical);
         return i > 0 ? "success" : "error";
    }

    /**
     * 修改业务状态
     * @param medical
     * @return
     */
    @Override
    public String updateStatus(Medical medical) {
        int i = medicalDao.updateStatus(medical);
        return i > 0 ? "success" : "error";
    }

}
