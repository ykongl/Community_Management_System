<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{path:'/home'}">首页</el-breadcrumb-item>
      <el-breadcrumb-item :to="{path:'/files'}">健康档案管理</el-breadcrumb-item>
      <el-breadcrumb-item >健康档案信息</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <el-collapse v-model="activeName">
        <el-collapse-item title="基本信息" name="1">
          <el-container style="width: 100%;margin: 0">
            <el-form ref="HealthyFormRef" :model="HealthyForm" label-width="80px" :inline="true" class="demo-form-inline"
                     style="width: 80%">
              <el-form-item label="姓名:">
                <el-select placeholder="请选择老人" v-model="HealthyForm.olderId" @change="getOlderInfo(HealthyForm.olderId)"
                           clearable filterable :disabled="isEdit">
                  <el-option
                      v-for="item in olderDrop"
                      :key="item.olderId"
                      :label="item.olderName"
                      :value="item.olderId">
                  </el-option>
                </el-select>
              </el-form-item>
              <el-form-item label="监护人:">
                <el-select v-model="HealthyForm.userId" filterable clearable disabled>
                  <el-option
                      v-for="item in userList"
                      :key="item.userId"
                      :label="item.username"
                      :value="item.userId">
                  </el-option>
                </el-select>
              </el-form-item>
              <el-form-item label="身高:">
                <el-input v-model="HealthyForm.height" size="medium" clearable :disabled="isDisable">
                  <i slot="suffix" style="font-style: normal; margin-right: 10px"
                  >m</i>
                </el-input>
              </el-form-item>
              <el-form-item label="体重:">
                <el-input v-model="HealthyForm.weight" size="medium" clearable :disabled="isDisable">
                  <i slot="suffix" style="font-style: normal; margin-right: 10px"
                  >kg</i>
                </el-input>
              </el-form-item>
              <el-form-item label="出生日期:">
                <el-date-picker
                    v-model="HealthyForm.birthday"
                    type="date"
                    placeholder="选择日期" disabled>
                </el-date-picker>
              </el-form-item>
              <el-form-item label="年龄:" prop = "olderAge">
                <el-input v-model="HealthyForm.olderAge" size="medium" clearable disabled></el-input>
              </el-form-item>
              <el-form-item label="性别:" prop="sex" style="width: 32%">
                <el-radio v-model="HealthyForm.sex" label="0" disabled>男</el-radio>
                <el-radio v-model="HealthyForm.sex" label="1" disabled>女</el-radio>
              </el-form-item>
              <el-form-item label="名族:" prop = "nation">
                <el-input v-model="HealthyForm.nation" size="medium" clearable :disabled="isEdit"></el-input>
              </el-form-item>
              <el-form-item label="籍贯:" prop = "nativePlace">
                <el-input v-model="HealthyForm.nativePlace" size="medium" clearable :disabled="isEdit"></el-input>
              </el-form-item>
              <el-form-item label="婚姻情况:">
                <el-select v-model="HealthyForm.maritalStatus" filterable clearable :disabled="isDisable">
                  <el-option
                      v-for="item in maritalList"
                      :key="item.maritalStatus"
                      :label="item.marital"
                      :value="item.maritalStatus">
                  </el-option>
                </el-select>
              </el-form-item>
              <el-form-item label="文化水平:">
                <el-select v-model="HealthyForm.educationLevel" filterable clearable :disabled="isEdit">
                  <el-option
                      v-for="item in educationList"
                      :key="item.educationLevel"
                      :label="item.education"
                      :value="item.educationLevel">
                  </el-option>
                </el-select>
              </el-form-item>
              <el-form-item label="职业:">
                <el-input v-model="HealthyForm.career" size="medium" clearable :disabled="isDisable"></el-input>
              </el-form-item>
              <el-form-item label="工作年限:">
                <el-input v-model="HealthyForm.workYear" size="medium" clearable :disabled="isDisable"></el-input>
              </el-form-item>
              <el-form-item label="档案说明:">
                <el-input v-model="HealthyForm.files" size="medium" clearable :disabled="isDisable"></el-input>
              </el-form-item>
              <el-form-item label="家庭住址:">
                <el-input v-model="HealthyForm.address" size="medium" clearable disabled style="width: 400px;"></el-input>
              </el-form-item>
            </el-form>
            <img :src="HealthyForm.photo" style="height: 300px; width: 250px;" alt="">
          </el-container>
        </el-collapse-item>
        <el-collapse-item title="外科检查" name="2">
          <el-container style="width: 100%;margin: 0">
            <el-form ref="surgeryFormRef" :model="surgeryForm" label-width="80px" :inline="true" class="demo-form-inline"
                     style="width: 80%">
              <el-form-item label="皮肤:">
                <el-input v-model="surgeryForm.skin" size="medium" clearable :disabled="isDisable"></el-input>
              </el-form-item>
              <el-form-item label="淋巴:">
                <el-input v-model="surgeryForm.lymph" size="medium" clearable :disabled="isDisable"></el-input>
              </el-form-item>
              <el-form-item label="甲状腺:">
                <el-input v-model="surgeryForm.thyroid" size="medium" clearable :disabled="isDisable"></el-input>
              </el-form-item>
              <el-form-item label="脊柱:">
                <el-input v-model="surgeryForm.spine" size="medium" clearable :disabled="isDisable"></el-input>
              </el-form-item>
              <el-form-item label="四肢:">
                <el-input v-model="surgeryForm.limb" size="medium" clearable :disabled="isDisable"></el-input>
              </el-form-item>
              <el-form-item label="关节:">
                <el-input v-model="surgeryForm.joint" size="medium" clearable :disabled="isDisable"></el-input>
              </el-form-item>
              <el-form-item label="头部:">
                <el-input v-model="surgeryForm.head" size="medium" clearable :disabled="isDisable"></el-input>
              </el-form-item>
              <el-form-item label="眼睛:">
                <el-input v-model="surgeryForm.eye" size="medium" clearable :disabled="isDisable"></el-input>
              </el-form-item>
              <el-form-item label="耳朵:">
                <el-input v-model="surgeryForm.ears" size="medium" clearable :disabled="isDisable"></el-input>
              </el-form-item>
              <el-form-item label="鼻子:">
                <el-input v-model="surgeryForm.nose" size="medium" clearable :disabled="isDisable"></el-input>
              </el-form-item>
              <el-form-item label="口腔:">
                <el-input v-model="surgeryForm.oralCavity" size="medium" clearable :disabled="isDisable"></el-input>
              </el-form-item>
              <el-form-item label="咽喉:">
                <el-input v-model="surgeryForm.throat" size="medium" clearable :disabled="isDisable"></el-input>
              </el-form-item>
              <el-form-item label="外科医生:">
                <el-select placeholder="请选择医生" v-model="surgeryForm.workId"
                           clearable filterable :disabled="isDisable">
                  <el-option
                      v-for="item in workDrop"
                      :key="item.workId"
                      :label="item.workName"
                      :value="item.workId">
                  </el-option>
                </el-select>
<!--                <el-input v-model="surgeryForm.surgeon" size="medium" clearable :disabled="isDisable"></el-input>-->
              </el-form-item>
            </el-form>
          </el-container>
        </el-collapse-item>
        <el-collapse-item title="内科检查" name="3">
          <el-container style="width: 100%;margin: 0">
            <el-form ref="internalFormRef" :model="internalForm" label-width="80px" :inline="true" class="demo-form-inline"
                     style="width: 80%">
              <el-form-item label="心率:">
                <el-input v-model="internalForm.heartRate" size="medium" clearable :disabled="isDisable">
                  <i slot="suffix" style="font-style: normal; margin-right: 10px">BPM</i>
                </el-input>
              </el-form-item>
              <el-form-item label="血压:">
                <el-input v-model="internalForm.bloodPressure" size="medium" clearable :disabled="isDisable">
                  <i slot="suffix" style="font-style: normal; margin-right: 10px">mmhg</i>
                </el-input>
              </el-form-item>
              <el-form-item label="血糖:">
                <el-input v-model="internalForm.bloodSugar" size="medium" clearable :disabled="isDisable">
                  <i slot="suffix" style="font-style: normal; margin-right: 10px">mmol/L</i>
                </el-input>
              </el-form-item>
              <el-form-item label="血脂:">
                <el-input v-model="internalForm.bloodFat" size="medium" clearable :disabled="isDisable">
                  <i slot="suffix" style="font-style: normal; margin-right: 10px">mmol/L</i>
                </el-input>
              </el-form-item>
              <el-form-item label="脉搏:">
                <el-input v-model="internalForm.pulse" size="medium" clearable :disabled="isDisable">
                  <i slot="suffix" style="font-style: normal; margin-right: 10px">BPM</i>
                </el-input>
              </el-form-item>
              <el-form-item label="肝功能:">
                <el-input v-model="internalForm.liverFunction" size="medium" clearable :disabled="isDisable"></el-input>
              </el-form-item>
              <el-form-item label="肾功能:">
                <el-input v-model="internalForm.renalFunction" size="medium" clearable :disabled="isDisable"></el-input>
              </el-form-item>
              <el-form-item label="血常规:">
                <el-input v-model="internalForm.bloodRoutine" size="medium" clearable :disabled="isDisable">
                  <i slot="suffix" style="font-style: normal; margin-right: 10px">g/L</i>
                </el-input>
              </el-form-item>
              <el-form-item label="尿常规:">
                <el-input v-model="internalForm.urinalysis" size="medium" clearable :disabled="isDisable">
                  <i slot="suffix" style="font-style: normal; margin-right: 10px">umol/L</i>
                </el-input>
              </el-form-item>
              <el-form-item label="内科医生:">
                <el-select placeholder="请选择医生" v-model="internalForm.workId"
                           clearable filterable :disabled="isDisable">
                  <el-option
                      v-for="item in workDrop"
                      :key="item.workId"
                      :label="item.workName"
                      :value="item.workId">
                  </el-option>
                </el-select>
<!--                <el-input v-model="internalForm.physician" size="medium" clearable :disabled="isDisable"></el-input>-->
              </el-form-item>
            </el-form>
          </el-container>
        </el-collapse-item>
      </el-collapse>
      <div style="margin-top: 15px;text-align: right" v-if="token === '2'">
        <el-button type="primary" @click="isDisable = false" v-if="isDisable">编辑</el-button>
        <el-button type="primary" @click="addHealthy" v-else-if="isDisable === false && isEdit === false">添加</el-button>
        <el-button type="primary" @click="updateHealthy" v-else>保存</el-button>
      </div>
      <div style="margin-top: 15px;text-align: right" v-else>
        <el-button type="info" @click="Back">返回</el-button>
      </div>

    </el-card>
  </div>
</template>
<script>


export default {
  name: 'HealthyInfo',
  data() {
    return {
      token:"",
      HealthyForm:{
        id:0,
		    photo:"",
		    olderId:"",
		    olderName:"",
		    userId:"",
		    height:"",
		    weight:"",
		    birthday:"",
		    olderAge:"",
		    sex:"",
        nation:"",
        nativePlace:"",
        maritalStatus:"",
        educationLevel:"",
        career:"",
        workYear:"",
        address:"",
        workName:"",
        workId:"",
        communityName:"",
        communityCd:"",
      },
      surgeryForm:{
        skin:"",
        lymph:"",
        thyroid:"",
        spine:"",
        limb:"",
        joint:"",
        head:"",
        eye:"",
        ears:"",
        nose:"",
        oralCavity:"",
        throat:"",
        surgeon:""
      },
      internalForm:{
        heartRate:"",
        bloodPressure:"",
        bloodSugar:"",
        bloodFat:"",
        pulse:"",
        liverFunction:"",
        renalFunction:"",
        bloodRoutine:"",
        urinalysis:"",
        CDultrasound:"",
        physician:""
      },
      activeName:'1',
      userList:[],
      olderDrop:[],
      maritalList:[
        {maritalStatus:'0', marital:'未婚'},
        {maritalStatus:'1', marital:'已婚'},
        {maritalStatus:'2', marital:'离异'},
      ],
      educationList:[
        {educationLevel:"0",education:"文盲"},
        {educationLevel:"1",education:"小学"},
        {educationLevel:"2",education:"中学"},
        {educationLevel:"3",education:"大学"},
        {educationLevel:"4",education:"硕士"},
        {educationLevel:"5",education:"博士"},
      ],
      olderList:[],
      workDrop:[],
      isDisable:false,
      isEdit:false,
    }
  },
  created() {
    this.selectWorkDrop();
    this.selectOlderDrop();
    this.selectUserList();
    this.getHealthyInfo();
    this.getSurgeryInfo();
	  this.getInternalInfo();
    this.changeIsDisabled();
  },
  methods:{
    async getOlderInfo(id){
      const {data:res} = await this.$http.get("/older/olderInfo?id="+ id);
      this.HealthyForm.userId = res.userId;
      this.HealthyForm.sex = res.sex;
      this.HealthyForm.olderAge = res.olderAge;
      this.HealthyForm.address = res.address + ',' + res.communityName;
      this.HealthyForm.birthday = res.birthday;
      this.HealthyForm.photo = require("@/" + res.photo);
    },
    async selectOlderDrop(){
      const{data:res} = await this.$http.get("/healthy/olderDrop");
      this.olderDrop = res;
    },

    async selectWorkDrop(){
      const{data:res} = await this.$http.get("/healthy/workDrop");
      this.workDrop = res;
    },

    changeIsDisabled(){
      this.token = window.sessionStorage.getItem("roleId")
      if(this.$route.query.isAdd === 'false'){
        this.isDisable = false;
        this.isEdit = false;
      }else{
        this.isDisable = true;
        this.isEdit = true;
      }

    },
    //获取健康档案基本信息
    async getHealthyInfo(){
        const{data:res} = await this.$http.get("/healthy/healthyInfo?id=" + this.$route.query.id);
        this.HealthyForm.olderId = res.olderId;
        this.HealthyForm.userId = res.userId;
        this.HealthyForm.height = res.height;
        this.HealthyForm.weight = res.weight;
        this.HealthyForm.birthday = res.birthday;
        this.HealthyForm.olderAge = res.olderAge;
        this.HealthyForm.sex = res.sex;
        this.HealthyForm.nation = res.nation;
        this.HealthyForm.nativePlace = res.nativePlace;
        this.HealthyForm.maritalStatus = res.maritalStatus;
        this.HealthyForm.educationLevel = res.educationLevel;
        this.HealthyForm.career = res.career;
        this.HealthyForm.workYear = res.workYear;
        this.HealthyForm.address = res.address;
        this.HealthyForm.files = res.files;
		    this.HealthyForm.photo = require("@/" + res.photo);
		//this.HealthyForm = res;
    },
    //获取外科信息
    async getSurgeryInfo(){
      const{data:res} = await this.$http.get("/healthy/surgeryInfo?id=" + this.$route.query.id)
      this.surgeryForm = res;
    },

	//获取内科信息
	async getInternalInfo(){
		const{data:res} = await this.$http.get("/healthy/internalInfo?id="  + this.$route.query.id)
		this.internalForm = res;
	},
    Back(){
      this.$router.push({path:'/files'})
    },
	//监护人下拉框
    async selectUserList(){
      const {data:res} = await this.$http.get("/older/userList")
      this.userList = res;
    },

	//修改信息
	async updateHealthy(){
		const paramForm = Object.assign(this.HealthyForm,this.surgeryForm,this.internalForm);
    paramForm.id = window.sessionStorage.getItem("id")
		const {data:res} = await this.$http.post("/healthy/updateInfo",paramForm)
		if(res !== "success"){
			return this.$message.error("修改失败！！！");
		}
		this.$message.success("修改成功！！！");
		await this.getHealthyInfo();
		await this.getSurgeryInfo();
		await this.getInternalInfo();
		this.isDisable = !this.isDisable;
	  },
    //添加
    async addHealthy(){
      const paramForm = Object.assign(this.HealthyForm,this.surgeryForm,this.internalForm);
      paramForm.createId = window.sessionStorage.getItem("id")
      const {data:res} = await this.$http.post("/healthy/insertInfo",paramForm)
      if(res !== "success"){
        return this.$message.error("添加失败！！！");
      }
      this.$message.success("添加成功！！！");
      await this.$router.push("/files");
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
