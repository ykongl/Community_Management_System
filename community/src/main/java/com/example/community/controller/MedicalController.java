package com.example.community.controller;

import com.example.community.bean.*;
import com.example.community.service.MedicalService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author minjunyue
 * @version 1.0
 * @date 2022/5/5
 */
@RestController
@RequestMapping("/medical")
public class MedicalController {
    @Resource
    private MedicalService medicalService;

    /**
     * 获取医疗互助列表
     * @param medical
     * @return
     */
    @GetMapping("/list")
    public List<Medical> getMedicalList(Medical medical){
        return medicalService.getMedicalList(medical);
    }

    /**
     * 获取药店列表
     * @param pharmacy
     * @return
     */
    @GetMapping("/pharmacyList")
    public List<Pharmacy> getPharmacyList(Pharmacy pharmacy){
        return medicalService.getPharmacyList(pharmacy);
    }

    /**
     * 删除医疗互助信息
     * @param medical
     * @return
     */
    @PostMapping("/deleteMedical")
    public String deleteMedical(Medical medical){
        return medicalService.deleteMedical(medical);
    }

    /**
     * 添加药店
     * @param pharmacy
     * @return
     */
    @PostMapping("/insertPharmacy")
    public String insertPharmacy(@RequestBody Pharmacy pharmacy){
        return medicalService.insertPharmacy(pharmacy);
    }

    /**
     * 药品列表
     * @param drug
     * @return
     */
    @GetMapping("/drugList")
    public List<Drug> getDrugList(Drug drug){
        return medicalService.getDrugList(drug);
    }

    /**
     * 获取药品所有分类
     * @return
     */
    @GetMapping("/typeList")
    public List<Drug> getDrugTypeList(){
        return medicalService.getDrugTypeList();
    }

    /**
     * 添加
     * @param drug
     * @return
     */
    @PostMapping("/insertDrug")
    public String insertDrug(@RequestBody Drug drug){
        return medicalService.insertDrug(drug);
    }

    /**
     * 查询医院列表
     * @param hospital
     * @return
     */
    @GetMapping("/hospitalList")
    public List<Hospital> getHospitalList(Hospital hospital){
        return medicalService.getHospitalList(hospital);
    }

    /**
     * 添加医院
     * @param hospital
     * @return
     */
    @PostMapping("/insertHospital")
    public String insertHospital(@RequestBody Hospital hospital){
        return medicalService.insertHospital(hospital);
    }

    /**
     * 获取下拉框
     * @return
     */
    @GetMapping("/departmentDrop")
    public List<Department> getDepartmentDrop(){
        return medicalService.getDepartmentDrop();
    }

    /**
     * 获取医院下拉框
     * @return
     */
    @GetMapping("/hospitalDrop")
    public List<Hospital> getHospitalDrop(){
        return medicalService.getHospitalDrop();
    }

    /**
     * 获取医生下拉框
     * @param doctor
     * @return
     */
    @GetMapping("/doctorDrop")
    public List<Doctor> getDoctorDrop(Doctor doctor){
        return medicalService.getDoctorDrop(doctor);
    }

    /**
     * 获取医院信息
     * @param id
     * @return
     */
    @GetMapping("/hospitalInfo")
    public Hospital getHospitalInfo(int id){
        return medicalService.getHospitalInfo(id);
    }

    /**
     * 添加预约单
     * @param appointment
     * @return
     */
    @PostMapping("/insertAppointment")
    public String insertAppointment(@RequestBody Appointment appointment) {
        return medicalService.insertAppointment(appointment);
    }

    /**
     * 获取医疗互助详情
     * @param appointNo
     * @return
     */
    @GetMapping("/medicalInfo")
    public Appointment getMedicalInfo(String appointNo){
        return medicalService.getMedicalInfo(appointNo);
    }

    /**
     * 修改预约信息
     * @param appointment
     * @return
     */
    @PostMapping("/updateMedical")
    public String updateAppointment(@RequestBody Appointment appointment){
        return medicalService.updateAppointment(appointment);
    }

    /**
     * 添加医疗互助业务
     * @param medical
     * @return
     */
    @PostMapping("/insertMedical")
    public String insertMedical(@RequestBody Medical medical) {
        return medicalService.insertMedical(medical);
    }

    /**
     * 修改业务状态
     * @param medical
     * @return
     */
    @PostMapping("/updateStatus")
    public String updateStatus(Medical medical) {
        return medicalService.updateStatus(medical);
    }


}
