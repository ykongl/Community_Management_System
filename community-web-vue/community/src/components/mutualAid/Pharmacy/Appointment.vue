<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{path:'/home'}">首页</el-breadcrumb-item>
      <el-breadcrumb-item :to="{path:'/medicine'}">医疗互助</el-breadcrumb-item>
      <el-breadcrumb-item>医院</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card style="margin-right: 20px;margin-bottom: 20px">
      <el-row :gutter="20">
        <!--      搜索区域-->
        <el-col :span="8">
          <label>医院名称：</label>
          <el-input placeholder="请输入医院名称" v-model="queryInfo.hospitalName" clearable style="width: 70%; padding-right: 10px"/>
        </el-col>
        <el-col :span="8">
          <label>地址：</label>
          <el-input placeholder="请输入医院地址" v-model="queryInfo.address" clearable style="width: 70%; padding-right: 10px"/>
        </el-col>
        <el-col :span="8">
          <el-button type="primary" icon="el-icon-search" @click="search">搜索</el-button>
          <el-button type="primary" icon="el-icon-plus" @click="isAddHospital = true" v-show="this.token === '1'">添加医院</el-button>
        </el-col>
      </el-row>
    </el-card>
    <div v-for="item in hospitalList" style="width: 50%;float: left" @click="showInfo(item.id)">
      <el-card shadow="hover" style="margin-right: 20px;margin-bottom: 20px;">
        <el-form :model="item" :inline="true" class="demo-form-inline">
          <el-form-item style="width: 20%;height: 100px;margin-right: 10px">
            <img :src="require('@/' + item.logo)" style="width: 115px;height: 115px">
          </el-form-item>
          <el-form-item style="width: 70%;height: 100px">
            <span style="font-size: 24px">{{item.hospitalName}}</span>
            <span style="margin-left: 10px;font-size: 16px">({{item.address}})</span>
            <br>
            <br>
            <i class="el-icon-s-data" style="color: grey"></i>
            <span style="color: grey;margin-right: 100px;margin-left: 10px">{{item.grade}}</span>
            <i class="el-icon-time"></i>
            <span style="color: grey;margin-left: 10px">每天{{item.registerTime}}放号</span>
          </el-form-item>
        </el-form>
      </el-card>
    </div>
    <el-card style="margin-right: 20px;width: 100%">
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
<!--    添加医院-->
    <el-dialog title="添加医院" :visible.sync="isAddHospital" width="50%" @close="addClosed">
      <el-form :model="addHospitalForm" :rules="addHospitalFormRules" ref="addHospitalFormRef" label-width="160px">
        <el-form-item label="照片：">
          <el-upload
              class="avatar-uploader"
              action="https://jsonplaceholder.typicode.com/posts/"
              :show-file-list="false"
              :on-success="handleAvatarSuccess"
              :before-upload="beforeAvatarUpload">
            <img v-if="imgUrl" :src="imgUrl" class="avatar">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
        </el-form-item>
        <el-form-item label="医院名：" prop = "hospitalName">
          <el-input v-model="addHospitalForm.hospitalName" size="medium" style="width: 70%"></el-input>
        </el-form-item>
        <el-form-item label="医院的位置：" prop = "address">
          <el-input v-model="addHospitalForm.address" size="medium" style="width: 70%"></el-input>
        </el-form-item>
        <el-form-item label="医院级别：" prop = "grade">
          <el-input v-model="addHospitalForm.grade" size="medium" style="width: 70%">
          </el-input>
        </el-form-item>
        <el-form-item label="医院放号时间：" prop = "registerTime">
          <el-time-select
              v-model="addHospitalForm.registerTime"
              :picker-options="{start: '06:00',step: '00:15',end: '18:30'}"
              placeholder="选择时间">
          </el-time-select>
        </el-form-item>
      </el-form>
      <!-- 内容底部区域    -->
      <span slot="footer" class="dialog-footer">
            <el-button @click="isAddHospital = false">取 消</el-button>
            <el-button type="primary" @click="onClickOk">确 认</el-button>
          </span>
    </el-dialog>
    <el-dialog title="预约挂号" :visible.sync="isAppoint" width="50%" @close="addClosed">
      <el-form :model="addAppointForm" :rules="addHospitalFormRules" ref="addAppointFormRef" label-width="160px">
        <el-form-item label="医院名：" prop = "hospitalName">
          <el-input v-model="addAppointForm.hospitalName" size="medium" style="width: 70%" disabled></el-input>
        </el-form-item>
        <el-form-item label="医院的位置：" prop = "address">
          <el-input v-model="addAppointForm.address" size="medium" style="width: 70%"></el-input>
        </el-form-item>
        <el-form-item label="科室:" prop="departmentId">
          <el-select v-model="addAppointForm.departmentId" clearable filterable placeholder="请选择" @change="getDoctorDrop(addAppointForm.departmentId)">
            <el-option
                v-for="item in departmentDrop"
                :key="item.departmentId"
                :label="item.departmentName"
                :value="item.departmentId">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="医生:" prop="doctorId">
          <el-select v-model="addAppointForm.doctorId" clearable filterable placeholder="请选择">
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
              v-model="addAppointForm.weekdays"
              type="date"
              placeholder="选择日期时间"
              :picker-options="pickerOptions">
          </el-date-picker>
          <el-time-select
              v-model="addAppointForm.registerTime"
              :picker-options="{start: addAppointForm.registerTime,step: '00:15',end: '18:30'}"
              placeholder="选择时间">
          </el-time-select>
        </el-form-item>
        <el-form-item label="门诊费：" prop = "address">
          <span style="font-size: 30px;color: red">{{addAppointForm.price}}元</span>
        </el-form-item>
      </el-form>
      <!-- 内容底部区域    -->
      <span slot="footer" class="dialog-footer">
            <el-button @click="isAppoint = false">取 消</el-button>
            <el-button type="success" @click="onClickAppoint">预约</el-button>
          </span>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "Appointment",
  data(){
    return{
      pickerOptions: {
        disabledDate: (time) => {
          return  time.getTime() < new Date().getTime()-8.64e7 || time.getTime() > new Date(this.timeEnd).getTime()
        }
      },
      timeEnd:"",
      hospitalId:"",
      queryInfo:{},
      isAddHospital:false,
      isAppoint:false,
      hospitalList:[],
      total:0,
      token:"",
      addHospitalForm:{},
      addAppointForm:{},
      imgUrl:"",
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
      addHospitalFormRules:{
        hospitalName:[
          {required: true,message:"请输入医院名称",trigger:"blur"},
        ],
        address:[
          {required: true,message:"请输入医院位置",trigger:"blur"},
        ],
        grade:[
          {required: true,message:"请输入医院级别",trigger:"blur"},
        ],
        registerTime:[
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
    this.getHospitalList()
    this.getDepartmentDrop()

  },
  methods:{
    TimeLimit(){
      let date1 = new Date()
      let date2 = new Date(date1)
      date2.setDate(date1.getDate() + 6);
      this.timeEnd = date2.getFullYear()+"-"+(date2.getMonth()+1)+"-"+date2.getDate();
    },

    search(){
      this.queryInfo.pageNum = 1
      this.getHospitalList()
    },
    handleSizeChange(newSize){
      this.queryInfo.pageSize = newSize;
      this.getHospitalList()
    },
    handleCurrentChange(newPage){
      this.queryInfo.pageNum = newPage;
      this.getHospitalList()
    },
    async getDepartmentDrop(){
      const{data:res} = await this.$http.get("/medical/departmentDrop")
      this.departmentDrop = res
    },
    async getDoctorDrop(departmentId){
      const{data:res} = await this.$http.get("/medical/doctorDrop?hospitalId=" + this.hospitalId + "&departmentId=" + departmentId)
      this.doctorDrop = res
    },
    async showInfo(id){
      this.TimeLimit()
      this.isAppoint = true
      this.hospitalId = id
      const{data:res} = await this.$http.get("/medical/hospitalInfo?id=" + id)
      this.addAppointForm = res
      this.addAppointForm.price = 12
    },
    onClickAppoint(){
      this.$refs.addAppointFormRef.validate(async valid => {
        if (!valid) return;
        this.addAppointForm.appointNo = "YY"+ Math.floor(Math.random() * 100000000)
        this.addAppointForm.createId = window.sessionStorage.getItem("id")
        this.addAppointForm.weekdays = this.$moment(this.addAppointForm.weekdays).format("YYYY/MM/DD")
        const{data:res} = await this.$http.post("/medical/insertAppointment",this.addAppointForm)
        if(res !== "success"){
          return this.$message.error("预约失败！！！")
        }
        this.$message.success("预约成功！！！")
        this.isAppoint = false
        await this.$router.push({path: "/medicine"})
      })
    },
    addClosed(){
      this.$refs.addHospitalFormRef.resetFields();
    },
    async getHospitalList(){
      this.token = window.sessionStorage.getItem("roleId")
      const{data:res} = await this.$http.get("/medical/hospitalList",{params:this.queryInfo})
      this.hospitalList = res
      this.total = this.hospitalList[0].total
    },
    onClickOk(){
      this.$refs.addHospitalFormRef.validate(async valid => {
        if (!valid) return;
        this.addHospitalForm.createId = window.sessionStorage.getItem("id")
        const{data:res} = await this.$http.post("/medical/insertHospital",this.addHospitalForm)
        if(res !== "success"){
          return this.$message.error("添加失败！！！")
        }
        this.$message.success("添加成功！！！")
        await this.getHospitalList()
        this.isAddHospital = false
      })
    },
    handleAvatarSuccess(res, file) {
      let newFile = new FormData();
      newFile.append("imgUrl",file.raw.name)
      console.log(newFile.get("imgUrl"))
      this.addHospitalForm.logo = 'assets/' + newFile.get("imgUrl")
      //console.log(URL.createObjectURL(file.raw))
    },
    beforeAvatarUpload(file) {
      const isJPG = file.type === 'image/jpeg';
      const isLt2M = file.size / 1024 / 1024 < 2;

      if (!isJPG) {
        this.$message.error('上传头像图片只能是 JPG 格式!');
      }
      if (!isLt2M) {
        this.$message.error('上传头像图片大小不能超过 2MB!');
      }
      return isJPG && isLt2M;
    }
  }
}
</script>

<style lang="less" scoped>
.el-breadcrumb{
  margin-bottom: 15px;
  font-size: 17px;
}
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}
.avatar {
  width: 178px;
  height: 178px;
  display: block;
}
</style>
