<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{path:'/home'}">首页</el-breadcrumb-item>
      <el-breadcrumb-item>个人中心</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <el-form :model="personalForm" :rules="passwordRules" label-width="160px">
        <el-form-item label="员工号：" prop="workNo" v-show="personalForm.roleId !== '4'">
          <el-input v-model="personalForm.workNo" style="width: 360px" disabled></el-input>
        </el-form-item>
        <el-form-item label="用户名：" prop="username">
          <el-input v-model="personalForm.username" style="width: 360px"></el-input>
        </el-form-item>
        <el-form-item label="性别：" prop="sex">
          <el-radio v-model="personalForm.sex" label="0" disabled>男</el-radio>
          <el-radio v-model="personalForm.sex" label="1" disabled>女</el-radio>
        </el-form-item>
        <el-form-item label="电话号码：" prop="phone">
          <el-input v-model="personalForm.phone" style="width: 360px"></el-input>
        </el-form-item>
        <el-form-item label="社区：" prop="communityCd" v-show="personalForm.roleId === '4'">
          <el-select v-model="personalForm.communityCd" filterable clearable>
            <el-option
                v-for="item in communities"
                :key="item.communityCd"
                :label="item.communityName"
                :value="item.communityCd">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="角色：" prop="roleId">
          <el-select v-model="personalForm.roleId" filterable clearable disabled>
            <el-option
                v-for="item in options"
                :key="item.roleId"
                :label="item.role"
                :value="item.roleId">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="医院：" prop="phone" v-show="personalForm.roleId === '2'">
          <el-select v-model="personalForm.hospitalId" filterable clearable placeholder="请选择">
            <el-option
                v-for="item in hospitalDrop"
                :key="item.hospitalId"
                :label="item.hospitalName"
                :value="item.hospitalId">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="科室：" prop="phone" v-show="personalForm.roleId === '2'">
          <el-select v-model="personalForm.departmentId" filterable clearable placeholder="请选择">
            <el-option
                v-for="item in departmentDrop"
                :key="item.departmentId"
                :label="item.departmentName"
                :value="item.departmentId">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="密码：" prop="password">
          <el-input v-model="personalForm.password" show-password style="width: 360px" disabled></el-input>
          <el-button type="info" style="margin-left: 20px" @click="isEditPwd = true">修改密码</el-button>
        </el-form-item>
        <el-form-item label="新密码：" prop="newPassword" v-show="isEditPwd">
          <el-input v-model="personalForm.newPassword" show-password style="width: 360px"></el-input>
        </el-form-item>
        <el-form-item label="确认密码：" prop="passwordConfirm" v-show="isEditPwd">
          <el-input v-model="personalForm.passwordConfirm" show-password style="width: 360px"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="editInfo" style="float: right">保 存</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>
<script>
export default {
  name: "Personal",
  data(){
    const validatePass = (rule ,value, callback) =>{
      if(value === ''){
        callback(new Error('请再次输入密码！'));
      }else if (value !== this.personalForm.newPassword){
        callback(new Error('两次输入密码不一致！'));
      }else{
        callback();
      }
    }
    return{
      personalForm:{},
      options: [
        {
          roleId: '1',
          role: '管理员'
        },
        {
          roleId:'2',
          role:'医生',
        },
        {
          roleId:'3',
          role:'员工',
        },
        {
          roleId:'4',
          role:'监护人',
        },
      ],
      communities:[],
      departmentDrop:[],
      isEditPwd:false,
      hospitalDrop:[],
      passwordRules:{
        password: [
          {required:true,message:"请输入旧密码",trigger:"blur"},
          {min:5,max:24,message:"长度在 5 到 24 个字符串",trigger:"blur"}
        ],
        newPassword: [
          {required:true,message:"请输入新密码",trigger:"blur"},
          {min:5,max:24,message:"长度在 5 到 24 个字符串",trigger:"blur"}
        ],
        passwordConfirm: [
          {required:true,message:"请输入新密码",trigger:"blur"},
          {min:5,max:24,message:"长度在 5 到 24 个字符串",trigger:"blur"},
          {validator:validatePass,trigger: "blur",required: true}
        ]
      },
    }
  },
  created() {
    this.showEditDialog()
    this.getDepartmentDrop()
    this.getHospitalDrop()
    this.selectAddress()
  },
  methods:{
    async selectAddress(){
      const {data:res} = await this.$http.get("/User/address");
      this.communities = res;
    },
    async getHospitalDrop(){
      const{data:res} = await this.$http.get("/medical/hospitalDrop",)
      this.hospitalDrop = res
    },
    async getDepartmentDrop(){
      const{data:res} = await this.$http.get("/medical/departmentDrop")
      this.departmentDrop = res
    },
    // 显示对话框
    async showEditDialog(){
      const id = window.sessionStorage.getItem("id")
      if(window.sessionStorage.getItem("roleId") === "4"){
        const {data:res} = await this.$http.get("/User/userId?id="+id);
        this.personalForm = res;//查询出用户信息反填回编辑表单
      }else{
        const {data:res} = await this.$http.get("/Worker/workInfo?id=" + id);
        this.personalForm = res;
        this.personalForm.username = res.workName
      }

    },
    async editInfo(){
      if(window.sessionStorage.getItem("roleId") === "4"){
        this.personalForm.updateId = window.sessionStorage.getItem("id")
        const {data:res} = await this.$http.post("/User/editUser",this.personalForm);
        if(res !== "success"){
          return this.$message.error("修改失败！！！");
        }
        this.$message.success("修改成功");
      }else{
        this.personalForm.updateId = window.sessionStorage.getItem("id")
        const {data:res} = await this.$http.post("/Worker/updateWorker",this.personalForm);
        if(res !== "success"){
          return this.$message.error("修改失败！！！");
        }
        this.$message.success("修改成功");
      }
      if(this.personalForm.newPassword !== "" && this.personalForm.newPassword !== null){
        const {data:res}= await this.$http.post("/Worker/updatePassword",this.personalForm)
        if(res === "success"){
          window.sessionStorage.clear();//清除session
          window.localStorage.clear();
          await this.$router.push("/login");//回到首页
          return this.$message.success("密码修改成功！！！");
        }
        return this.$message.error("密码修改失败！！！");
      }
    }
  }
}
</script>

<style scoped>
.el-breadcrumb{
  margin-bottom: 15px;
  font-size: 17px;
}
</style>
