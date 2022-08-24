<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{path:'/home'}">首页</el-breadcrumb-item>
      <el-breadcrumb-item>老人列表</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <el-row :gutter="25">
        <el-col :span="6">
          <label>老人姓名：</label>
          <el-input placeholder="请输入老人姓名" v-model="queryInfo.olderName" clearable @click="getOlderList" style="width: 60%; padding-right: 10px"/>
        </el-col>
        <el-col :span="6" v-if="this.token !== '4'">
          <label>监护人：</label>
          <el-select placeholder="请选择监护人" v-model="queryInfo.userId"
                     clearable filterable @click="getOlderList" style="width: 70%; padding-right: 10px">
            <el-option
                v-for="item in userList"
                :key="item.userId"
                :label="item.username"
                :value="item.userId">
            </el-option>
          </el-select>
        </el-col>
        <el-col :span="7">
          <div>
            <label>所属社区：</label>
            <el-select placeholder="请输入所属社区" v-model="queryInfo.communityCd" clearable
                       filterable @click="getOlderList" style="width: 70%; padding-right: 10px">
              <el-option
                  v-for="item in communities"
                  :key="item.communityCd"
                  :label="item.communityName"
                  :value="item.communityCd">
              </el-option>
            </el-select>
          </div>
        </el-col>
        <el-col :span="5">
          <el-button type="primary" icon="el-icon-search" @click="search">搜索</el-button>
          <el-button type="primary" icon="el-icon-plus" @click="insertOlder = true" v-show="this.token === '1' || this.token === '4'">添加老人</el-button>
        </el-col>
      </el-row>
      <el-table :data="olderList" border stripe>
        <el-table-column label="索引" prop="id" align="center"></el-table-column><!--索引列-->
        <el-table-column label="老人姓名" align="center">
          <template v-slot="scope">
            <el-popover trigger="hover" placement="top">
              <p>姓名: {{ scope.row.olderName }}</p>
              <p>年龄: {{scope.row.olderAge}}</p>
              <p>住址: {{ scope.row.address }}</p>
              <div slot="reference" class="name-wrapper">
                <el-tag size="medium" @click="showEditDialog(scope.row.id)">{{ scope.row.olderName }}</el-tag>
              </div>
            </el-popover>
          </template>
        </el-table-column>
        <el-table-column label="照片" align="center">
          <template v-slot="scope">
            <el-image style="width: 100%; height: 100px" :src="scope.row.photo" alt=""></el-image>
          </template>
        </el-table-column>
        <el-table-column label="性别" prop="sex" align="center"></el-table-column>
        <el-table-column label="监护人" prop="username" align="center"></el-table-column>
        <el-table-column label="所属小区名称" prop="communityName" align="center"></el-table-column>
        <el-table-column label="病史" prop="medicalHistory" align="center"></el-table-column>
        <el-table-column label="更新时间" align="center" min-width="130px" sortable>
          <template v-slot="scope">
            <i class="el-icon-time"></i>
            <span style="margin-left: 15px">{{scope.row.updateTime}}</span>
          </template>
        </el-table-column>
        <el-table-column label="状态" prop="state" align="center">
          <template v-slot="scope">
            <el-switch v-model = "scope.row.state" @change="changeState(scope.row)" :disabled="isDisabled"></el-switch>
          </template>
        </el-table-column>
        <!--        自定义插槽-->
        <el-table-column label="操作" align="center" v-if="this.token === '1' || this.token === '4'">
          <template v-slot ="scope">
            <!--删除-->
            <el-button type="danger" icon="el-icon-delete" size="mini" @click="deleteOlder(scope.row.id)">
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
      <!--      修改用户对话框-->
      <el-dialog title="修改老人信息" :visible.sync="editDialogVisible" width="60%" @close="editClosed">
        <el-form :model="editOlderForm" :rules="addFormRules" ref="editFormRef" label-width="160px">
          <el-form-item label="照片：" prop="photo">
            <img :src="editOlderForm.photo" style="width: 100px; height: 100px" alt="">
          </el-form-item>
          <el-form-item label="老人姓名：" prop="olderName">
            <el-input v-model="editOlderForm.olderName" disabled></el-input>
          </el-form-item>
          <el-form-item label="性别：" prop="sex">
            <el-radio v-model="editOlderForm.sex" label="0" disabled>男</el-radio>
            <el-radio v-model="editOlderForm.sex" label="1" disabled>女</el-radio>
          </el-form-item>
          <el-form-item label="监护人：" prop="userId">
            <el-select v-model="editOlderForm.userId" filterable clearable :disabled="isDisabled">
              <el-option
                  v-for="item in userList"
                  :key="item.userId"
                  :label="item.username"
                  :value="item.userId">
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="地址：" prop = "address">
            <el-input v-model="editOlderForm.address" disabled></el-input>
          </el-form-item>
          <el-form-item label="病史：" prop = "medicalHistory">
            <el-input v-model="editOlderForm.medicalHistory" :disabled="isDisabled"></el-input>
          </el-form-item>
          <el-form-item label="所属小区名称：" prop="communityCd">
            <el-select v-model="editOlderForm.communityCd" filterable clearable :disabled="isDisabled">
              <el-option
                  v-for="item in communities"
                  :key="item.communityCd"
                  :label="item.communityName"
                  :value="item.communityCd">
              </el-option>
            </el-select>
          </el-form-item>
        </el-form>
        <!-- 内容底部区域    -->
        <span slot="footer" class="dialog-footer">
            <el-button @click="editDialogVisible = false">取 消</el-button>
            <el-button type="primary" @click="editOlderInfo" :disabled="isDisabled">确 认</el-button>
          </span>
      </el-dialog>

      <!--     添加老人对话框-->
      <el-dialog title="添加老人信息" :visible.sync="insertOlder" width="60%" @close="insertClosed">
        <el-form :model="addOlderForm" :rules="addFormRules" ref="addFormRef" label-width="160px">
          <el-form-item label="照片：" prop="photo">
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
          <el-form-item label="老人姓名：" prop="olderName">
            <el-input v-model="addOlderForm.olderName"></el-input>
          </el-form-item>
          <el-form-item label="性别：" prop="sex">
            <el-radio v-model="addOlderForm.sex" label="0">男</el-radio>
            <el-radio v-model="addOlderForm.sex" label="1">女</el-radio>
          </el-form-item>
          <el-form-item label="监护人：" prop="userId">
            <el-select v-model="addOlderForm.userId" filterable clearable>
              <el-option
                  v-for="item in userList"
                  :key="item.userId"
                  :label="item.username"
                  :value="item.userId">
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="出生日期：" prop = "olderAge">
            <el-date-picker
                v-model="addOlderForm.birthday"
                type="date"
                placeholder="选择日期时间">
            </el-date-picker>
          </el-form-item>
          <el-form-item label="病史：" prop = "medicalHistory">
            <el-input v-model="addOlderForm.medicalHistory"></el-input>
          </el-form-item>
          <el-form-item label="所属小区名称：" prop="communityCd">
            <el-select v-model="addOlderForm.communityCd" filterable clearable>
              <el-option
                  v-for="item in communities"
                  :key="item.communityCd"
                  :label="item.communityName"
                  :value="item.communityCd">
              </el-option>
            </el-select>
          </el-form-item>
        </el-form>
        <!-- 内容底部区域    -->
        <span slot="footer" class="dialog-footer">
            <el-button @click="insertOlder = false">取 消</el-button>
            <el-button type="primary" @click="addOlder">确 认</el-button>
          </span>
      </el-dialog>
    </el-card>
  </div>
</template>

<script>
export default {
  name: "OlderList",
  data(){
    return{
      olderList:[],
      queryInfo:{
        olderName:"",
        userId:"",
        communityCd:"",
        pageNum: 1,//当前页
        pageSize: 10,//每页最大数
      },
      imgUrl:"",
      isDisabled:false,
      communities:[{
        communityCd:"",
        communityName:""
      }],
      userList:[{
        userId:"",
        username:""
      }],
      token:"",
      total:0,//总记录数
      insertOlder:false,
      editOlderForm:{
        photo:"",
      },
      addOlderForm:{olderAge:""},
      editDialogVisible: false,
      addFormRules:{
        photo:[
          {required: true,message: "请选择照片",trigger:"blur"}
        ],
        olderName:[
          {required: true,message:"请输入老人姓名",trigger:"blur"},
          {min: 2,max: 12,message:"长度在 2 到 12 个字符串",trigger:"blur"}
        ],
        sex:[
          {required: true,message: "请选择性别",trigger:"blur"}
        ],
        birthday:[
          {required: true,message:"请选择出生日期",trigger:"blur"},
        ],
        communityCd: [
          {required: true,message: "请选择地址",trigger: "blur"},
        ],
        userId:[
          {required: true,message: "请选择监护人",trigger: "blur"}
        ],
        medicalHistory:[
          {required: true,message: "请输入病史",trigger: "blur"}
        ]
      }
    }
  },
  created(){
    this.getOlderList();
    this.selectAddress();
    this.selectUserList();
  },
  methods:{
    async getOlderList(){
      this.token = window.sessionStorage.getItem("roleId")
      if(this.token === '1' || this.token === '4'){
        this.isDisabled = false
      }else{
        this.isDisabled = true
      }
      if(this.token === '4'){
        this.queryInfo.userId = window.sessionStorage.getItem("id")
      }
      const{data:res} = await this.$http.get("/older/list",{params:this.queryInfo})
      this.olderList = res;
      this.total = this.olderList[0].total;
      for (let i = 0; i < this.olderList.length; i++) {
        this.olderList[i].updateTime =
            this.$moment(this.olderList[i].updateTime).utc().format('YYYY/MM/DD HH:mm:ss')
            this.olderList[i].photo = require('@/'+ this.olderList[i].photo)
      }

    },
    async selectAddress(){
      const {data:res} = await this.$http.get("/User/address");
      this.communities = res;
    },
    async selectUserList(){
      const {data:res} = await this.$http.get("/older/userList")
      this.userList = res;
    },
    search(){
      this.queryInfo.pageNum = 1;
      this.getOlderList();
    },
    handleSizeChange(newSize){
      this.queryInfo.pageSize = newSize;
      this.getOlderList();
    },
    handleCurrentChange(newPage){
      this.queryInfo.pageNum = newPage;
      this.getOlderList();
    },
    async showEditDialog(id){
      this.editDialogVisible = true;
      const {data:res} = await this.$http.get("/older/olderInfo?id="+ id);
      this.editOlderForm = res
      this.editOlderForm.photo = require('@/'+ this.editOlderForm.photo)
    },
    addOlder(){
      this.$refs.addFormRef.validate(async valid =>{
        if(!valid) return;
        this.addOlderForm.id = window.sessionStorage.getItem("id")
        const{data:res} = await this.$http.post("/older/insertOlder",this.addOlderForm);
        if(res !== "success"){
          return this.$message.error("添加失败！！");
        }
        this.$message.success("添加成功！！");
        this.insertOlder = false;
        await this.getOlderList();
      })
    },
    // 监听添加用户
    insertClosed(){
      this.$refs.addFormRef.resetFields();
    },
    editOlderInfo(){
      this.$refs.editFormRef.validate(async valid =>{
        if(!valid) return;
        this.editOlderForm.id = window.sessionStorage.getItem("id")
        const {data:res} = await this.$http.post("/older/updateOlder",this.editOlderForm);
        if(res !== "success"){
          return this.$message.error("修改失败！！！");
        }
        this.$message.success("修改成功！！！");
        this.editDialogVisible = false;
        await this.getOlderList();
      })
    },
    // 关闭窗口
    editClosed(){
      this.$refs.editFormRef.resetFields();//重置信息
    },

    async changeState(OlderInfo){
      OlderInfo.updateId = window.sessionStorage.getItem("id");
      const {data:res} = await this.$http.post(`/older/updateState?id=${OlderInfo.id}&updateId=${OlderInfo.updateId}&state=${OlderInfo.state}`);
      if(res !== "success"){
        OlderInfo.id = !OlderInfo.id;
        return this.$message.error("状态修改失败！！");
      }
      this.$message.success("状态修改成功！！");
      await this.getOlderList();
    },
    async deleteOlder(id){
      const confirmResult = await this.$confirm('是否确定删除？','提示',{
        confirmButtonText:"确定",
        cancelButtonText:"取消",
        type:'warning'
      }).catch(err => err)
      if(confirmResult!=='confirm'){//取消
        return this.$message.info("已取消删除");
      }
      const updateId = window.sessionStorage.getItem("id");
      const {data:res} = await this.$http.post("/older/deleteById?id=" + id + "&updateId = " + updateId);
      if(res !== "success"){
        return this.$message.error("删除失败！！");
      }
      this.$message.success("删除成功！！");
      await this.getOlderList();
    },
    handleAvatarSuccess(res, file) {
      let newFile = new FormData();
      newFile.append("imgUrl",file.raw.name)
      //console.log(file.raw)
      this.addOlderForm.photo = 'assets/' + newFile.get("imgUrl")
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
