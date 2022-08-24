<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{path:'/home'}">首页</el-breadcrumb-item>
      <el-breadcrumb-item>监护人列表</el-breadcrumb-item>
    </el-breadcrumb>
    <!--    用户列表主体（卡片）-->
    <el-card>
<!--      间隙属性-->
      <el-row :gutter="20">
        <!--      搜索区域-->
        <el-col :span="6">
          <div>
            <label>用户名：</label>
            <el-input placeholder="请输入用户名" v-model="queryInfo.username" clearable @click="getUserList" style="width: 70%; padding-right: 10px" />
          </div>
        </el-col>
        <el-col :span="6">
          <div>
            <label>社区：</label>
            <el-select placeholder="请输入社区名称" v-model="queryInfo.communityCd" clearable
                       filterable @click="getUserList" style="width: 70%; padding-right: 10px">
              <el-option
                  v-for="item in communities"
                  :key="item.communityCd"
                  :label="item.communityName"
                  :value="item.communityCd">
              </el-option>
            </el-select>
          </div>
        </el-col>
        <el-col :span="6">
          <!--        搜索按钮-->
          <el-button type="primary" icon="el-icon-search" @click="search">搜索</el-button>
          <el-button type="primary" icon="el-icon-plus" @click="insertUser = true" v-show="this.token === '1'">添加用户</el-button>
        </el-col>
      </el-row>
<!--      用户列表 border边框 Stripe隔行变色-->
      <el-table :data="userList" border stripe :default-sort = "{prop: 'updateTime', order: 'ascending'}">
        <el-table-column label="索引" prop="id" align="center"></el-table-column><!--索引列-->
        <el-table-column label="用户名" prop="username" align="center"></el-table-column>
        <el-table-column label="性别" prop="sex" align="center"></el-table-column>
        <el-table-column label="电话号码" prop="phone" align="center"></el-table-column>
        <el-table-column label="所属社区名称" prop="communityName" align="center"></el-table-column>
        <el-table-column label="角色" prop="role" align="center"></el-table-column>
        <el-table-column label="更新时间" align="center" min-width="110px" sortable>
          <template v-slot="scope">
            <i class="el-icon-time"></i>
            <span style="margin-left: 15px">{{scope.row.updateTime}}</span>
          </template>
        </el-table-column>
        <el-table-column label="状态" prop="state" align="center">
<!--          作用域插槽 scope.row存储了当前行的信息-->
          <template v-slot="scope">
<!--            每一行封存的数据-->
              <el-switch v-model = "scope.row.state" @change="StateChange(scope.row)" :disabled="isDisabled"></el-switch>
          </template>
        </el-table-column>
<!--        自定义插槽-->
        <el-table-column label="操作" align="center" v-if="this.token === '1'">
          <template v-slot ="scope">
            <!--修改-->
            <el-button type="primary" icon="el-icon-edit" size="mini" @click="showEditDialog(scope.row.id)">
            </el-button>
            <!--删除-->
            <el-button type="danger" icon="el-icon-delete" size="mini" @click="deleteUser(scope.row.id)">
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

<!-- 新增用户表单  -->
      <el-dialog title="添加用户" :visible.sync="insertUser" width="50%" @close="insertClosed">
        <el-form :model="addForm" :rules="addFormRules" ref="addFormRef" label-width="160px">
          <el-form-item label="用户名：" prop="username">
            <el-input v-model="addForm.username"></el-input>
          </el-form-item>
          <el-form-item label="密码：" prop="password">
            <el-input v-model="addForm.password" show-password></el-input>
          </el-form-item>
          <el-form-item label="性别：" prop="sex">
            <el-radio v-model="addForm.sex" label="0">男</el-radio>
            <el-radio v-model="addForm.sex" label="1">女</el-radio>
          </el-form-item>
          <el-form-item label="电话号码：" prop="phone">
            <el-input v-model="addForm.phone"></el-input>
          </el-form-item>
          <el-form-item label="社区：" prop="communityCd">
            <el-select v-model="addForm.communityCd" clearable filterable placeholder="请选择">
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
            <el-button @click="insertUser = false">取 消</el-button>
            <el-button type="primary" @click="addUser">确 认</el-button>
          </span>
      </el-dialog>

<!--      修改用户对话框-->
      <el-dialog title="修改用户信息" :visible.sync="editDialogVisible" width="60%" @close="editClosed">
        <el-form :model="editForm" :rules="addFormRules" ref="editFormRef" label-width="160px">
          <el-form-item label="用户名：" prop="username">
            <el-input v-model="editForm.username" disabled></el-input>
          </el-form-item>
          <el-form-item label="性别：" prop="sex">
            <el-radio v-model="editForm.sex" label="0" disabled>男</el-radio>
            <el-radio v-model="editForm.sex" label="1" disabled>女</el-radio>
          </el-form-item>
          <el-form-item label="电话号码：" prop="phone">
            <el-input v-model="editForm.phone"></el-input>
          </el-form-item>
          <el-form-item label="社区：" prop="communityCd">
            <el-select v-model="editForm.communityCd" filterable clearable>
              <el-option
                  v-for="item in communities"
                  :key="item.communityCd"
                  :label="item.communityName"
                  :value="item.communityCd">
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="角色：" prop="roleId">
            <el-select v-model="editForm.roleId" filterable clearable disabled>
              <el-option
                  v-for="item in options"
                  :key="item.roleId"
                  :label="item.role"
                  :value="item.roleId">
              </el-option>
            </el-select>
          </el-form-item>
        </el-form>
        <!-- 内容底部区域    -->
        <span slot="footer" class="dialog-footer">
            <el-button @click="editDialogVisible = false">取 消</el-button>
            <el-button type="primary" @click="editUserInfo">确 认</el-button>
          </span>
      </el-dialog>
    </el-card>
  </div>

</template>

<script>

export default {
  name: "UserList",
  data(){
    return{
      token:"",
      isDisabled:false,
      communities:[{
        communityCd:'',
        communityName:''
      }],
      options: [{
        roleId: '4',
        role: '监护人'
      }],
      // 查询信息实体
      queryInfo:{
        pageNum: 1,//当前页
        pageSize: 10,//每页最大数
      },
      userList:[],//用户列表
      total:0,//总记录数
      insertUser:false,//对话框状态

      //修改用户信息
      editForm:{
      },
      //显示、隐藏修改用户栏
      editDialogVisible:false,

      //新增表单信息
      addForm:{
      },
      //表单校验
      addFormRules:{
        username:[
          {required: true,message:"请输入用户名",trigger:"blur"},
          {min: 2,max: 12,message:"长度在 2 到 12 个字符串",trigger:"blur"},
        ],
        password: [
          {required:true,message:"请输入密码",trigger:"blur"},
          {min:6,max:24,message:"长度在 6 到 24 个字符串",trigger:"blur"}
        ],
        sex:[
          {required: true,message: "请选择性别",trigger:"blur"}
        ],
        phone: [
          {required: true,message: "请输入电话号码",trigger:"blur"},
          {min: 8,max: 11,message: "长度在 8 到 11 个字符串",trigger:"blur"}
        ],
        communityCd: [
          {required: true,message: "请输入地址",trigger: "blur"},
        ],
        roleId: [
          {required:true,message:"请選擇角色",trigger:"blur"},
        ]
      },

      //修改表单验证（看新增的）
    }
  },
  created() {
      this.getUserList();
      this.selectAddress();
  },
  methods:{
    //获取所有用户
    async getUserList(){
      const {data:res} = await
      this.$http.get("/User/list",{params:this.queryInfo})
      this.userList = res.data;//用户列表数据封装
      this.total = res.number;//总用户数封装
      for (let i = 0;i<this.userList.length; i++){
        this.userList[i].updateTime
            = this.$moment(new Date(
            parseInt(this.userList[i].updateTime))).utc().format('YYYY/MM/DD HH:mm:ss')
      }
      this.token = window.sessionStorage.getItem("roleId")
      if(this.token === '1'){
        this.isDisabled = false
      }else{
        this.isDisabled = true
      }
    },
    //搜索功能
    search(){
      this.queryInfo.pageNum = 1;
      this.getUserList();
    },
    //最大数
    handleSizeChange(newSize){
      this.queryInfo.pageSize = newSize;
      this.getUserList();
    },
    //pageNum的触发动作
    handleCurrentChange(newPage){
      this.queryInfo.pageNum = newPage;
      this.getUserList();
    },

    // 用户状态修改
    async StateChange(userInfo){
     userInfo.updateId = window.sessionStorage.getItem("id");
      const {data:res} = await this.$http.post(`/User/updateState?id=${userInfo.id}&state=${userInfo.state}&updateId=${userInfo.updateId}`);
      if(res!=="success"){
        userInfo.id = !userInfo.id;
        return this.$message.error("状态修改失败");
      }
      this.$message.success("状态修改成功");
      await this.getUserList();
    },
    async selectAddress(){
      const {data:res} = await this.$http.get("/User/address");
      this.communities = res;
    },
    // 监听添加用户
    insertClosed(){
      this.$refs.addFormRef.resetFields();
    },
    addUser(){
      this.$refs.addFormRef.validate(async valid =>{
        if(!valid) return;
        this.addForm.id = window.sessionStorage.getItem("id")
        const {data:res} = await this.$http.post("/User/insertUser",this.addForm);
        if(res!=="success"){
          return this.$message.error("添加失败！！！");
        }
        this.$message.success("添加成功！！！");
        this.insertUser = false;
        await this.getUserList();
      });

    },
    //根据主键删除用户
    async deleteUser(id){
     const confirmResult = await this.$confirm('是否确定删除？','提示',{
        confirmButtonText:"确定",
        cancelButtonText:"取消",
        type:'warning'
      }).catch(err => err)
      if(confirmResult!=='confirm'){//取消
        return this.$message.info("已取消删除");
      }
      const updateId = window.sessionStorage.getItem("id");
      const {data:res} = await this.$http.post("/User/deleteUser?id="+id+"&updateId="+updateId);
      if(res !== "success"){
        return this.$message.error("删除失败！");
      }
      this.$message.success("删除成功");
      await this.getUserList();
    },

   // 显示对话框
   async showEditDialog(id){
      const {data:res} = await this.$http.get("/User/userId?id="+id);
      this.editForm = res;//查询出用户信息反填回编辑表单
      this.editDialogVisible = true;//开启编辑对话框
    },
   // 关闭窗口
    editClosed(){
      this.$refs.editFormRef.resetFields();//重置信息
    },
   // 确认修改
    editUserInfo(){
      this.$refs.editFormRef.validate(async valid =>{
        if(!valid) return;
        //发起修改请求
        this.editForm.updateId = window.sessionStorage.getItem("id")
		    console.log(this.editForm);
        const {data:res} = await this.$http.post("/User/editUser",this.editForm);
        if(res !== "success"){
         return this.$message.error("修改失败！！！");
        }
       this.$message.success("修改成功");
       //隐藏
        this.editDialogVisible = false;
       await this.getUserList();
      })
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
