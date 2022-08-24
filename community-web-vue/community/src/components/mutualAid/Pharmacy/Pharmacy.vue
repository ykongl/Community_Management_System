<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{path:'/home'}">首页</el-breadcrumb-item>
      <el-breadcrumb-item :to="{path:'/medicine'}">医疗互助</el-breadcrumb-item>
      <el-breadcrumb-item>药店列表</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card style="margin-right: 20px;margin-bottom: 20px">
      <el-row :gutter="20">
        <!--      搜索区域-->
        <el-col :span="8">
          <label>药店名称：</label>
          <el-input placeholder="请输入药店名称" v-model="queryInfo.name" clearable style="width: 70%; padding-right: 10px"/>
        </el-col>
        <el-col :span="8">
          <el-button type="primary" icon="el-icon-search" @click="search">搜索</el-button>
          <el-button type="primary" icon="el-icon-plus" @click="isAddPharmacy = true" v-show="this.token === '1'">添加药店</el-button>
        </el-col>
      </el-row>
    </el-card>
      <div v-for="item in pharmacyList" style="width: 50%;float: left" @click="$router.push({path:'/pharmacyInfo',query:{id: item.id,name: item.name}})">
        <el-card style="margin-right: 20px;margin-bottom: 20px;">
          <el-form :model="item" :inline="true" class="demo-form-inline">
            <el-form-item style="width: 20%;height: 100px;margin-right: 10px">
              <img :src="require('@/' + item.photo)" style="width: 115px;height: 115px">
            </el-form-item>
            <el-form-item style="width: 70%;height: 100px">
              <span style="font-size: 24px">{{item.name}}</span>
              <span style="margin-left: 10px;font-size: 16px">({{item.address}})</span>
              <el-rate
                  v-model="item.value"
                  disabled
                  show-score
                  text-color="#ff9900"
                  score-template="{value}">
              </el-rate>
              <span>月售：{{item.monthlySale}} </span>
              起送 <span style="color: #ffd400">¥{{item.startDelivery}}</span>
              <span style="color: red;margin-left: 10px">{{item.delivery}}</span>
              <span style="margin-left: 210px"> 距您{{item.distance}}km  {{item.deliveryTime}}分钟</span>
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
<!--    添加药店-->
    <el-dialog title="添加药店" :visible.sync="isAddPharmacy" width="50%" @close="addClosed">
      <el-form :model="addPharmacyForm" :rules="addPharmacyFormRules" ref="addPharmacyFormRef" label-width="160px">
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
        <el-form-item label="店名：" prop = "name">
          <el-input v-model="addPharmacyForm.name" size="medium" style="width: 70%"></el-input>
        </el-form-item>
        <el-form-item label="店的位置：" prop = "address">
          <el-input v-model="addPharmacyForm.address" size="medium" style="width: 70%"></el-input>
        </el-form-item>
        <el-form-item label="起送费：" prop = "startDelivery">
          <el-input v-model="addPharmacyForm.startDelivery" size="medium" style="width: 70%">
            <i slot="suffix" style="font-style: normal; margin-right: 10px"
            >¥</i>
          </el-input>
        </el-form-item>
        <el-form-item label="配送费：" prop = "delivery">
          <el-input v-model="addPharmacyForm.delivery" size="medium" style="width: 70%"></el-input>
        </el-form-item>
      </el-form>
      <!-- 内容底部区域    -->
      <span slot="footer" class="dialog-footer">
            <el-button @click="isAddPharmacy = false">取 消</el-button>
            <el-button type="primary" @click="addPharmacy">确 认</el-button>
          </span>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "Pharmacy.vue",
  data(){
    return{
      isAddPharmacy:false,
      isShowPharmacy:false,
      addPharmacyForm:{},
      queryInfo:{
      },
      imgUrl:"",
      total:0,
      token:"",
      pharmacyList:[{
        photo: "",
        name: "",
        address: "",
        value: 3.8,
        monthlySale: 1750,
        startDelivery: "",
        delivery: "",
        distance: "",
        deliveryTime: ""
      }
      ],
      addPharmacyFormRules:{
        name:[
          {required: true,message:"请输入药店名称",trigger:"blur"},
        ],
        address:[
          {required: true,message:"请输入药店位置",trigger:"blur"},
        ],
        startDelivery:[
          {required: true,message:"请输入起送费",trigger:"blur"},
        ],
        delivery:[
          {required: true,message:"请输入配送费",trigger:"blur"},
        ]
      }
    }
  },
  created() {
    this.getPharmacyList();
  },
  methods:{
    async getPharmacyList(){
      this.token = window.sessionStorage.getItem("roleId")
      const{data:res} = await this.$http.get("/medical/pharmacyList",{params:this.queryInfo})
      this.pharmacyList = res;
      this.total = this.pharmacyList[0].total
    },
    search(){
      this.queryInfo.pageNum = 1
      this.getPharmacyList();
    },
    handleSizeChange(newSize){
      this.queryInfo.pageSize = newSize;
      this.getPharmacyList();
    },
    handleCurrentChange(newPage){
      this.queryInfo.pageNum = newPage;
      this.getPharmacyList();
    },
    addClosed(){
      this.$refs.addPharmacyFormRef.resetFields();
    },
    addPharmacy(){
      this.$refs.addPharmacyFormRef.validate(async valid => {
        if (!valid) return;
        this.addPharmacyForm.createId = window.sessionStorage.getItem("id")
        const{data:res} =  await this.$http.post("/medical/insertPharmacy",this.addPharmacyForm)
        if(res !== "success"){
          return this.$message.error("添加失败！！！")
        }
        this.$message.success("添加成功！！！")
        await this.getPharmacyList();
        this.isAddPharmacy = false;
      })
    },

    handleAvatarSuccess(res, file) {
      let newFile = new FormData();
      newFile.append("imgUrl",file.raw.name)
      console.log(newFile.get("imgUrl"))
      this.addPharmacyForm.photo = 'assets/' + newFile.get("imgUrl")
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
