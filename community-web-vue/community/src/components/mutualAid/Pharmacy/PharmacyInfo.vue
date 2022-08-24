<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{path:'/home'}">首页</el-breadcrumb-item>
      <el-breadcrumb-item :to="{path:'/medicine'}">医疗互助</el-breadcrumb-item>
      <el-breadcrumb-item :to="{path:'/pharmacy'}">药店列表</el-breadcrumb-item>
      <el-breadcrumb-item>{{this.$route.query.name}}</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <el-row :gutter="20">
        <el-col :span="8">
            <label>药名：</label>
            <el-input placeholder="请输入药名" v-model="queryInfo.drugName" clearable style="width: 60%; padding-right: 10px"/>
        </el-col>
        <el-col :span="12">
          <el-button type="primary" icon="el-icon-search" @click="search">搜索</el-button>
          <el-button type="primary" icon="el-icon-plus" @click="isAddDrug = true" v-show="this.token === '1'">添加药品</el-button>
          <el-button type="success" icon="el-icon-s-finance" @click="onPurchase" v-show="this.token === '4'">立即购买</el-button>
        </el-col>
      </el-row>
      <template>
        <el-tabs v-model="editableTabsValue" type="card" style="margin-top: 20px" @tab-click="getDrugList(editableTabsValue)">
          <el-tab-pane v-for="item in tabList" :key="item.drugType" :label="item.drugType" :name="item.drugType">
            <el-table :data="drugList" border stripe>
              <el-table-column label="选择" align="center">
                <template v-slot="scope">
                  <el-checkbox v-model="scope.row.isCheck" @change="checkDrug(scope.row.isCheck,scope.row)"></el-checkbox>
                </template>
              </el-table-column>
              <el-table-column label="药名" prop="drugName" align="center"></el-table-column>
              <el-table-column label="图片" align="center">
                <template v-slot="scope">
                  <el-image style="width: 100%; height: 100px" :src="scope.row.photo" alt=""></el-image>
                </template>
              </el-table-column>
              <el-table-column label="存量" prop="drugNumber" align="center"></el-table-column>
              <el-table-column label="单位" prop="unit" align="center"></el-table-column>
              <el-table-column label="单价" prop="price" align="center"></el-table-column>
              <el-table-column label="有效期" prop="termOfValidity" align="center"></el-table-column>
              <el-table-column label="说明" prop="explain" align="center"></el-table-column>
              <el-table-column label="下单数量" prop="orderNumber" align="center">
                <template v-slot="scope">
                  <el-input v-model="scope.row.orderNumber"></el-input>
                </template>
              </el-table-column>
<!--              <el-table-column label="操作" align="center">-->
<!--                <template v-slot ="scope">-->
<!--                  <el-button type="success" icon="el-icon-plus" size="mini" @click="addDrugNumber(scope.row.isCheck,scope.row)">-->
<!--                  </el-button>-->
<!--                </template>-->
<!--              </el-table-column>-->
            </el-table>
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
          </el-tab-pane>
        </el-tabs>
      </template>
    </el-card>

    <el-dialog title="添加药品" :visible.sync="isAddDrug" width="50%" @close="addClosed">
      <el-form :model="addDrugForm" :rules="addDrugFormRules" ref="addDrugFormRef" label-width="160px">
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
        <el-form-item label="药名：" prop="drugName">
          <el-input v-model="addDrugForm.drugName" size="medium" style="width: 70%"></el-input>
        </el-form-item>
        <el-form-item label="药的种类：" prop="communityCd">
          <el-select v-model="addDrugForm.drugTypeId" filterable clearable>
            <el-option
                v-for="item in tabList"
                :key="item.drugTypeId"
                :label="item.drugType"
                :value="item.drugTypeId">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="药的数量：" prop = "drugNumber">
          <el-input v-model="addDrugForm.drugNumber" size="medium" style="width: 70%"></el-input>
        </el-form-item>
        <el-form-item label="单位：" prop = "unit">
          <el-input v-model="addDrugForm.unit" size="medium" style="width: 70%"></el-input>
        </el-form-item>
        <el-form-item label="单价：" prop = "price">
          <el-input v-model="addDrugForm.price" size="medium" style="width: 70%">
            <i slot="suffix" style="font-style: normal; margin-right: 10px"
            >¥</i>
          </el-input>
        </el-form-item>
        <el-form-item label="有效期：" prop = "termOfValidity">
          <el-input v-model="addDrugForm.termOfValidity" size="medium" style="width: 70%"></el-input>
        </el-form-item>
        <el-form-item label="说明：" prop = "explain">
          <el-input v-model="addDrugForm.explain" size="medium" style="width: 70%"></el-input>
        </el-form-item>
      </el-form>
      <!-- 内容底部区域    -->
      <span slot="footer" class="dialog-footer">
            <el-button @click="isAddDrug = false">取 消</el-button>
            <el-button type="primary" @click="onConfirm">确 认</el-button>
          </span>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "PharmacyInfo",
  data(){
    return{
      checkList:[],
      drugList:[{
        isCheck:false,
        photo:"",
        price:0
      }],
      isAddDrug:false,
      queryInfo:{},
      total:0,
      token:"",
      editableTabsValue:"感冒药",
      tabList:[],
      addDrugForm:{
        drugName:"",
        photo:"",
        drugTypeId:"",
        drugNumber:"",
        unit:"",
        price:0,
        termOfValidity:"",
        explain:""
      },
      addMedicineForm:{
        businessNo:"",
        businessType:"",
        businessContent:"",
        businessOrganization:"",
        businessStatus:"",
        price:""
      },
      imgUrl:"",
      addDrugFormRules:{}
    }
  },
  created(){
    this.getDrugTypeList()
    this.getDrugList("感冒药")
  },
  methods:{
    async onPurchase(){
	  if(this.checkList.length <= 0 || this.checkList === undefined){
		  return this.$message.warning("请选择商品！！！");
	  }
      this.addMedicineForm.businessStatus = "1"
      this.addMedicineForm.businessType = "0"
      this.addMedicineForm.businessOrganization = this.$route.query.name
      this.addMedicineForm.businessNo = "MY" + Math.floor(Math.random() * 100000000)
      let count = 0
      for (let i = 0; i < this.checkList.length; i++) {
        this.addMedicineForm.price = (this.addMedicineForm.price - 0) + ((this.checkList[i].price - 0) * (this.checkList[i].orderNumber))
        if(count === this.checkList.length){
          this.addMedicineForm.businessContent = this.addMedicineForm.businessContent + this.checkList[i].drugName + ','
        }else{
          this.addMedicineForm.businessContent = this.addMedicineForm.businessContent + this.checkList[i].drugName
        }
        count = count + 1
      }
      this.addMedicineForm.businessContent = window.sessionStorage.getItem("workName") + "在"
      + this.addMedicineForm.businessOrganization + "买了" + this.addMedicineForm.businessContent
      this.addMedicineForm.createId = window.sessionStorage.getItem("id")
      const{data:res} = await this.$http.post("/medical/insertMedical",this.addMedicineForm)
      if(res !== "success"){
        return this.$message.error("购买失败！！！")
      }
      this.$message.success("购买成功！！！")
      this.checkList = []
      await this.$router.push({path: "/medicine"})
    },
    checkDrug(isCheck,row){
      let index = -1
      if(isCheck === true) {
        index = index + 1
        this.checkList.push(row)
      }else{
        this.checkList.splice(index,1)
        index = index - 1
      }
    },
	addDrugNumber(){

	},
    async getDrugList(editableTabsValue){
      this.drugList = []
      this.total = 0
      this.queryInfo.drugType = editableTabsValue
      this.queryInfo.pharmacyId = this.$route.query.id
      const{data:res} = await this.$http.get("/medical/drugList",{params:this.queryInfo})
      this.drugList = res;
      this.total = this.drugList[0].total
      for (let i = 0; i < this.drugList.length; i++) {
        this.drugList[i].photo = require("@/" + this.drugList[i].photo)
      }
    },
    async getDrugTypeList(){
      this.token = window.sessionStorage.getItem("roleId")
      const {data:res} = await this.$http.get("/medical/typeList")
      this.tabList = res
    },
    //搜索功能
    search(){
      this.queryInfo.pageNum = 1;
      this.getDrugList(this.editableTabsValue)

    },
    handleSizeChange(newSize){
      this.queryInfo.pageSize = newSize;
      this.getDrugList(this.editableTabsValue)

    },
    handleCurrentChange(newPage){
      this.queryInfo.pageNum = newPage;
      this.getDrugList(this.editableTabsValue)
    },

    addClosed(){
      this.$refs.addDrugFormRef.resetFields();
    },
    onConfirm(){
      this.$refs.addDrugFormRef.validate(async valid => {
        if (!valid) return;
        this.addDrugForm.pharmacyId = this.$route.query.id
        this.addDrugForm.createId = window.sessionStorage.getItem("id")
        const{data:res} = await this.$http.post("/medical/insertDrug",this.addDrugForm)
        if(res !== "success"){
          return this.$message.error("添加失败！！！")
        }
        this.$message.success("添加成功！！！")
        for (let i = 0; i < this.tabList.length; i++) {
          if(this.tabList[i].drugTypeId === this.addDrugForm.drugTypeId){
            this.editableTabsValue = this.tabList[i].drugType
          }
        }
        await this.getDrugList(this.editableTabsValue)
        this.isAddDrug = false;
      })
    },
    handleAvatarSuccess(res, file) {
      let newFile = new FormData();
      newFile.append("imgUrl",file.raw.name)
      //console.log(file.raw)
      this.addDrugForm.photo = 'assets/' + newFile.get("imgUrl")
      console.log(this.addDrugForm.photo)
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
