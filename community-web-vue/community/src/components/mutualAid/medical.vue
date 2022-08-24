<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{path:'/home'}">首页</el-breadcrumb-item>
      <el-breadcrumb-item>医疗互助</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <el-row :gutter="20">
        <!--      搜索区域-->
        <el-col :span="8" v-if="this.token === '1'">
          <label>用户姓名：</label>
          <el-input placeholder="请输入用户姓名" v-model="queryInfo.username" clearable style="width: 70%; padding-right: 10px"/>
        </el-col>
        <el-col :span="8" v-if="this.token !== '2' && this.token !== '3'">
          <label>业务类型：</label>
          <el-select v-model="queryInfo.businessType" placeholder="请选择业务类型" clearable
                     filterable  style="width: 70%; padding-right: 10px">
            <el-option
                v-for="item in options"
                :key="item.businessType"
                :label="item.text"
                :value="item.businessType">
            </el-option>
          </el-select>
        </el-col>
        <el-col :span="8">
          <label>业务机构：</label>
          <el-input placeholder="请输入业务机构" v-model="queryInfo.businessOrganization" clearable style="width: 70%; padding-right: 10px"/>
        </el-col>
      </el-row>
      <el-row :gutter="20" style="margin-top: 15px">
        <el-col :span="8" v-if="this.token !== '3'">
          <label>业务状态：</label>
          <el-select v-model="queryInfo.businessStatus" placeholder="请选择业务状态" clearable
                     filterable  style="width: 70%; padding-right: 10px">
            <el-option
                v-for="item in statusList"
                :key="item.businessStatus"
                :label="item.text"
                :value="item.businessStatus">
            </el-option>
          </el-select>
        </el-col>
        <el-col :span="8">
          <el-button type="primary" icon="el-icon-search" @click="search">搜索</el-button>
          <el-button type="warning" icon="el-icon-s-shop" @click="$router.push({path:'/pharmacy'})" v-show="this.token !== '2' && this.token !== '3'">药店</el-button>
          <el-button type="success" icon="el-icon-s-finance" @click="$router.push({path:'/appointment'})" v-show="this.token !== '2' && this.token !== '3'">预约挂号</el-button>
        </el-col>
      </el-row>
      <el-table :data="medicalList" border stripe :default-sort = "{prop: 'createTime', order: 'ascending'}">
        <el-table-column label="索引" prop="id" align="center"></el-table-column><!--索引列-->
        <el-table-column label="业务编号" prop="businessNo" align="center"></el-table-column>
        <el-table-column label="用户姓名" prop="username" align="center"></el-table-column>
        <el-table-column label="业务类型" prop="businessType" align="center"></el-table-column>
        <el-table-column label="业务内容" prop="businessContent" align="center"></el-table-column>
        <el-table-column label="业务费" prop="price" align="center"></el-table-column>
        <el-table-column label="业务机构" prop="businessOrganization" align="center"></el-table-column>
        <el-table-column label="业务状态" prop="businessStatus" align="center"></el-table-column>
        <el-table-column label="业务时间" align="center" min-width="110px" sortable>
          <template v-slot="scope">
            <i class="el-icon-time"></i>
            <span style="margin-left: 15px">{{scope.row.createTime}}</span>
          </template>
        </el-table-column>
        <!--        自定义插槽-->
        <el-table-column label="操作" align="center" v-if="this.token !== '1'">
          <template v-slot ="scope">
            <!--修改-->
            <el-button type="primary" icon="el-icon-edit" size="mini" v-if="scope.row.businessType === '预约挂号'" @click="showMedicalInfo(scope.row.businessNo,scope.row.businessStatus)"></el-button>
            <el-button type="success" size="mini" @click="onAbandon(scope.row.businessNo,0)" v-else-if="token === '3'">配送完成</el-button>
            <el-button type="warning" size="mini" @click="onAbandon(scope.row.businessNo,2)" v-else>废</el-button>
            <!--删除-->
            <el-button type="danger" icon="el-icon-delete" size="mini" @click="deleteMedical(scope.row.id)" v-show="token !== '2' && token !== '3'">
            </el-button>
          </template>
        </el-table-column>
      </el-table>
      <!--      分页组件 @size-change每页最大变化 @current-change 当前最大变化layout功能组件-->
      <div>
        <el-pagination
            @size-change="handleSizeChange"
            @current-change = "handleCurrentChange"
            :current-page="queryInfo.pageNum"
            :page-sizes="[5,10,15,50]"
            :page-size="queryInfo.pageSize"
            layout="total,sizes,prev,pager,next,jumper"
            :total="total">
        </el-pagination>
      </div>
    </el-card>
    <el-dialog title="业务详情" :visible.sync="isMedical" width="50%" @close="addClosed">
      <el-form :model="medicalInfoForm" :rules="medicalInfoFormRules" ref="medicalInfoFormRef" label-width="160px">
        <el-form-item label="订单编号：" prop = "appointNo">
          <el-input v-model="medicalInfoForm.appointNo" size="medium" style="width: 70%" disabled></el-input>
        </el-form-item>
        <el-form-item label="医院名：" prop = "hospitalName">
          <el-input v-model="medicalInfoForm.hospitalName" size="medium" style="width: 70%" disabled></el-input>
        </el-form-item>
        <el-form-item label="医院的位置：" prop = "address">
          <el-input v-model="medicalInfoForm.address" size="medium" style="width: 70%" disabled></el-input>
        </el-form-item>
        <el-form-item label="科室:" prop="departmentId">
          <el-select v-model="medicalInfoForm.departmentId" clearable filterable placeholder="请选择" @change="getDoctorDrop(medicalInfoForm.departmentId)">
            <el-option
                v-for="item in departmentDrop"
                :key="item.departmentId"
                :label="item.departmentName"
                :value="item.departmentId">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="医生:" prop="doctorId">
          <el-select v-model="medicalInfoForm.doctorId" clearable filterable placeholder="请选择">
            <el-option
                v-for="item in doctorDrop"
                :key="item.doctorId"
                :label="item.doctor"
                :value="item.doctorId">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="预约时间：" prop = "registerTime">
          <el-date-picker
              v-model="medicalInfoForm.appointTime"
              type="datetime"
              placeholder="选择日期时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="门诊费：" prop = "address" >
          <el-input v-model="medicalInfoForm.price" size="medium" style="width: 70%" disabled><i slot="suffix" style="font-style: normal; margin-right: 10px"
          >元</i></el-input>
        </el-form-item>
      </el-form>
      <!-- 内容底部区域    -->
      <span slot="footer" class="dialog-footer" v-show="medicalInfoForm.businessStatus !== '完成'">
            <el-button @click="isMedical = false">取 消</el-button>
            <el-button type="danger" @click="onAbandon(medicalInfoForm.appointNo,2)" v-show="token !== '2'">废 弃</el-button>
            <el-button type="success" @click="onAbandon(medicalInfoForm.appointNo,0)" v-if="token === '2'">完 结</el-button>
            <el-button type="success" @click="onClickSave" v-else>保 存</el-button>
          </span>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "medical",
  data(){
    return{
      token:"",
      isMedical:false,
      pharmacyInfoForm:{},
      medicalInfoForm:{},
      queryInfo:{
        businessOrganization:"",
        businessType:"",
        username:""
      },
      total:0,
      medicalList:[],
      statusList:[{
        businessStatus:"0",
        text:"完成"
      },{
        businessStatus: "1",
        text:"进行中"
      },{
        businessStatus: "2",
        text:"废弃"
      }],
      options:[
        {
          businessType:"0",
          text:"买药"
        },
        {
          businessType: "1",
          text:"预约挂号"
        }],
      doctorDrop:[
        {
          doctorId:"",
          doctor:""
        }
      ],
      departmentDrop:[
        {
          departmentId:"",
          departmentName:""
        }
      ],
      medicalInfoFormRules:{
        appointTime:[
          {required: true,message:"请输入医院放号时间",trigger:"blur"},
        ],
        doctorId:[
          {required: true,message:"请选择医生",trigger:"blur"},
        ],
        departmentId:[
          {required: true,message:"请选择科室",trigger:"blur"},
        ]
      }
    }
  },
  created() {
    this.getMedicalList();
    this.getDepartmentDrop();
  },
  methods:{
    async getMedicalList(){
      this.token = window.sessionStorage.getItem("roleId")
      if(this.token === '4'){
        this.queryInfo.username = window.sessionStorage.getItem("workName")
      }
      if(this.token === '2'){
        this.queryInfo.businessType = "1"
        this.queryInfo.roleId = '2'
        this.queryInfo.doctor = window.sessionStorage.getItem("workName")
      }
      if(this.token === '3'){
        this.queryInfo.businessType = "0"
        //this.queryInfo.businessStatus = "1"
      }
      const{data:res} = await this.$http.get("/medical/list",{params:this.queryInfo})
      this.medicalList = res
      this.total = this.medicalList[0].total;
      for (let i = 0; i < this.medicalList.length; i++) {
        this.medicalList[i].createTime = this.$moment(this.medicalList[i].createTime).utc().format("YYYY/MM/DD HH:mm:ss")
        if(this.medicalList[i].businessType === '0'){
          this.medicalList[i].businessType = '买药'
        }else{
          this.medicalList[i].businessType = '预约挂号'
        }
        if(this.medicalList[i].businessStatus === '0'){
          this.medicalList[i].businessStatus = '完成'
        }else if(this.medicalList[i].businessStatus === '1'){
          this.medicalList[i].businessStatus = '进行中'
        }else{
          this.medicalList[i].businessStatus = '废弃'
        }
      }
    },
    async onAbandon(businessNo,businessStatus){
      const updateId = window.sessionStorage.getItem("id")
      const{data:res} = await this.$http.post("/medical/updateStatus?businessNo=" + businessNo + "&updateId=" + updateId + "&businessStatus=" + businessStatus)
      if(res !== "success"){
        return this.$message.error("状态修改失败！！！")
      }
      this.$message.success("状态修改成功！！！")
      this.isMedical = false
      await this.getMedicalList()
    },
    //搜索功能
    search(){
      this.queryInfo.pageNum = 1;
      this.getMedicalList();
    },
    handleSizeChange(newSize){
      this.queryInfo.pageSize = newSize;
      this.getMedicalList();
    },
    handleCurrentChange(newPage){
      this.queryInfo.pageNum = newPage;
      this.getMedicalList();
    },
    async getDepartmentDrop(){
      const{data:res} = await this.$http.get("/medical/departmentDrop")
      this.departmentDrop = res
    },
    async getDoctorDrop(departmentId){
      const{data:res} = await this.$http.get("/medical/doctorDrop?hospitalId=" + this.medicalInfoForm.hospitalId + "&departmentId=" + departmentId)
      this.doctorDrop = res
    },
    async showMedicalInfo(businessNo,businessStatus){
        this.isMedical = true
        const{data:res} = await this.$http.get("/medical/medicalInfo?appointNo="+businessNo)
        this.medicalInfoForm = res
        this.medicalInfoForm.businessStatus = businessStatus
        await this.getDoctorDrop(this.medicalInfoForm.departmentId)
    },
    onClickSave(){
      this.$refs.medicalInfoFormRef.validate(async valid =>{
        if(!valid) return;
        this.medicalInfoForm.updateId = window.sessionStorage.getItem("id")
        this.medicalInfoForm.appointTime = this.$moment(this.medicalInfoForm.appointTime).format("YYYY/MM/DD HH:mm:ss")
        const{data:res} = await this.$http.post("/medical/updateMedical",this.medicalInfoForm)
        if(res !== "success"){
          return this.$message.error("修改失败！！！")
        }
        this.$message.success("修改成功！！！")
        await this.getMedicalList()
        this.isMedical = false
      })
    },
    addClosed(){
      this.$refs.medicalInfoFormRef.resetFields();
    },
    async deleteMedical(id){
      const confirmResult = await this.$confirm('是否确定删除？','提示',{
        confirmButtonText:"确定",
        cancelButtonText:"取消",
        type:'warning'
      }).catch(err => err)
      if(confirmResult!=='confirm'){//取消
        return this.$message.info("已取消删除");
      }
      const updateId = window.sessionStorage.getItem("id");
      const {data:res} = await this.$http.post("/medical/deleteMedical?id="+id+"&updateId="+updateId)
      if(res !== "success"){
        return this.$message.error("删除失败！！");
      }
      await this.getMedicalList();
      this.$message.success("删除成功！！");
    }
  }
}
</script>

<style lang="less" scoped>
.el-breadcrumb{
  margin-bottom: 15px;
  font-size: 17px;
}
</style>
