<template>
<div>
  <el-breadcrumb separator-class="el-icon-arrow-right">
    <el-breadcrumb-item :to="{path:'/home'}">首页</el-breadcrumb-item>
    <el-breadcrumb-item>社区员工列表</el-breadcrumb-item>
  </el-breadcrumb>
  <el-card>
    <el-row :gutter="20">
      <el-col :span="8">
        <label>检索条件：</label>
        <el-input placeholder="请输入搜索内容(员工号/员工名称)" v-model="queryInfo.query" clearable @click="getWorkerList" style="width: 70%; padding-right: 10px"/>
      </el-col>
      <el-col :span="8">
        <div>
          <label>角色：</label>
          <el-select v-model="queryInfo.roleId" placeholder="请选择角色" clearable
                     filterable @click="getWorkerList" style="width: 70%; padding-right: 10px">
            <el-option
                v-for="item in options"
                :key="item.roleId"
                :label="item.role"
                :value="item.roleId">
            </el-option>
          </el-select>
        </div>
      </el-col>
      <el-col :span="8">
        <el-button type="primary" icon="el-icon-search" @click="search">搜索</el-button>
        <el-button type="primary" icon="el-icon-plus" @click="isPopupAdd = true">添加员工</el-button>
      </el-col>
    </el-row>
    <el-table :data="workerList" border stripe :default-sort = "{prop: 'updateTime', order: 'ascending'}">
      <el-table-column label="索引" prop="id" align="center"></el-table-column><!--索引列-->
      <el-table-column label="员工账号" prop="workNo" align="center"></el-table-column>
      <el-table-column label="员工名称" prop="workName" align="center"></el-table-column>
      <el-table-column label="性别" prop="sex" align="center"></el-table-column>
      <el-table-column label="员工电话" prop="phone" align="center"></el-table-column>
      <el-table-column label="角色" prop="role" align="center"></el-table-column>
      <el-table-column label="更新时间" align="center" min-width="110px" sortable>
        <template v-slot="scope">
          <i class="el-icon-time"></i>
          <span style="margin-left: 15px">{{scope.row.updateTime}}</span>
        </template>
      </el-table-column>
      <el-table-column label="状态" prop="state" align="center">
        <template v-slot="scope">
          <el-switch v-model = "scope.row.state" @change="StateChange(scope.row)"></el-switch>
        </template>
      </el-table-column>
      <!--        自定义插槽-->
      <el-table-column label="操作" align="center">
        <template v-slot ="scope">
          <!--修改-->
          <el-button type="primary" icon="el-icon-edit" size="mini" @click="showEditDialog(scope.row.id)">
          </el-button>
          <!--删除-->
          <el-button type="danger" icon="el-icon-delete" size="mini" @click="deleteWorker(scope.row.id)">
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

    <!-- 新增表单  -->
    <el-dialog title="添加员工" :visible.sync="isPopupAdd" width="50%" @close="insertClosed">
      <el-form :model="addForm" :rules="addFormRules" ref="addFormRef" label-width="160px">
        <el-form-item label="员工号：" prop="workNo">
          <el-input v-model="addForm.workNo"></el-input>
        </el-form-item>
        <el-form-item label="员工名称：" prop="workName">
          <el-input v-model="addForm.workName"></el-input>
        </el-form-item>
        <el-form-item label="密码：" prop="password">
          <el-input v-model="addForm.password"></el-input>
        </el-form-item>
        <el-form-item label="性别：" prop="sex">
          <el-radio v-model="addForm.sex" label="0">男</el-radio>
          <el-radio v-model="addForm.sex" label="1">女</el-radio>
        </el-form-item>
        <el-form-item label="电话号码：" prop="phone">
          <el-input v-model="addForm.phone"></el-input>
        </el-form-item>
        <el-form-item label="角色：" prop="roleId">
          <el-select v-model="addForm.roleId" filterable clearable placeholder="请选择">
            <el-option
                v-for="item in options"
                :key="item.roleId"
                :label="item.role"
                :value="item.roleId">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="医院：" prop="phone" v-show="addForm.roleId === '2'">
          <el-select v-model="addForm.hospitalId" filterable clearable placeholder="请选择">
            <el-option
                v-for="item in hospitalDrop"
                :key="item.hospitalId"
                :label="item.hospitalName"
                :value="item.hospitalId">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="科室：" prop="phone" v-show="addForm.roleId === '2'">
          <el-select v-model="addForm.departmentId" filterable clearable placeholder="请选择">
            <el-option
                v-for="item in departmentDrop"
                :key="item.departmentId"
                :label="item.departmentName"
                :value="item.departmentId">
            </el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <!-- 内容底部区域    -->
      <span slot="footer" class="dialog-footer">
            <el-button @click="isPopupAdd = false">取 消</el-button>
            <el-button type="primary" @click="addUser">确 认</el-button>
          </span>
    </el-dialog>

<!--    修改-->
    <el-dialog title="修改员工信息" :visible.sync="editDialogVisible" width="60%" @close="editClosed">
      <el-form :model="editForm" :rules="addFormRules" ref="editFormRef" label-width="160px">
        <el-form-item label="员工号：" prop="workNo">
          <el-input v-model="editForm.workNo" disabled></el-input>
        </el-form-item>
        <el-form-item label="员工名称：" prop="workName">
          <el-input v-model="editForm.workName" disabled></el-input>
        </el-form-item>
        <el-form-item label="性别：" prop="sex">
          <el-radio v-model="editForm.sex" label="0" disabled>男</el-radio>
          <el-radio v-model="editForm.sex" label="1" disabled>女</el-radio>
        </el-form-item>
        <el-form-item label="电话号码：" prop="phone">
          <el-input v-model="editForm.phone"></el-input>
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
        <el-form-item label="医院：" prop="phone" v-show="editForm.roleId === '2'">
          <el-select v-model="editForm.hospitalId" filterable clearable placeholder="请选择">
            <el-option
                v-for="item in hospitalDrop"
                :key="item.hospitalId"
                :label="item.hospitalName"
                :value="item.hospitalId">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="科室：" prop="phone" v-show="editForm.roleId === '2'">
          <el-select v-model="editForm.departmentId" filterable clearable placeholder="请选择">
            <el-option
                v-for="item in departmentDrop"
                :key="item.departmentId"
                :label="item.departmentName"
                :value="item.departmentId">
            </el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <!-- 内容底部区域    -->
      <span slot="footer" class="dialog-footer">
            <el-button @click="editDialogVisible = false">取 消</el-button>
            <el-button type="primary" @click="editWorkerInfo">确 认</el-button>
          </span>
    </el-dialog>
  </el-card>
</div>
</template>

<script>

export default {
  name: "WorkerList.Vue",
  data(){
    return{
      hospitalDrop:[
        {
          hospitalId:'',
          hospitalName: ""
        }
      ],
      departmentDrop:[{
        departmentId: "",
        departmentName:""
      }],
      workerList:[],
      queryInfo:{
        query:"",
        updateId:"",
        pageNum: 1,//当前页
        pageSize: 10,//每页最大数
      },
      total:0,//总记录数
      addForm:{},
      editForm:{},
      editDialogVisible:false,
      isPopupAdd:false,
      options:[
        {
          roleId:'2',
          role:'医生',
        },
        {
          roleId:'3',
          role:'员工',
        }
      ],
      //表单校验
      addFormRules:{
        workNo:[
          {required: true,message:"请输入员工账号",trigger:"blur"},
          {min: 2,max: 12,message:"长度在 2 到 12 个字符串",trigger:"blur"},
        ],
        workName:[
          {required: true,message:"请输入员工名称",trigger:"blur"},
          {min: 2,max: 12,message:"长度在 2 到 12 个字符串",trigger:"blur"},
        ],
        password: [
          {required:true,message:"请输入密码",trigger:"blur"},
          {min:5,max:24,message:"长度在 5 到 24 个字符串",trigger:"blur"}
        ],
        sex:[
          {required: true,message: "请选择性别",trigger:"blur"}
        ],
        phone: [
          {required: true,message: "请输入电话号码",trigger:"blur"},
          {min: 8,max: 11,message: "长度在 8 到 11 个字符串",trigger:"blur"}
        ],
        roleId: [
          {required:true,message:"请選擇角色",trigger:"blur"},
        ]
      },
    }
  },
  created() {
    this.getWorkerList()
    this.getDepartmentDrop()
    this.getHospitalDrop()
  },
  methods:{
    async getHospitalDrop(){
      const{data:res} = await this.$http.get("/medical/hospitalDrop",)
      this.hospitalDrop = res
    },
    async getDepartmentDrop(){
      const{data:res} = await this.$http.get("/medical/departmentDrop")
      this.departmentDrop = res
    },
    // 用户状态修改
    async StateChange(workerInfo){
      workerInfo.updateId = window.sessionStorage.getItem("id");
      const {data:res} = await this.$http.post(`/Worker/updateState?id=${workerInfo.id}&state=${workerInfo.state}&updateId=${workerInfo.updateId}`);
      if(res !== "success"){
        workerInfo.id = !workerInfo.id;
        return this.$message.error("状态修改失败");
      }
      this.$message.success("状态修改成功");
      await this.getWorkerList();
    },

    //获取所有用户
    async getWorkerList(){
      this.queryInfo.loginRoleId = window.sessionStorage.getItem("roleId")
      this.queryInfo.updateId = window.sessionStorage.getItem("id");
      const {data:res} = await
          this.$http.get("/Worker/list",{params:this.queryInfo})
      this.workerList = res.data;//用户列表数据封装
      this.total = res.number;//总用户数封装
      for (let i = 0;i<this.workerList.length; i++){
        this.workerList[i].updateTime
            = this.$moment(new Date(
            parseInt(this.workerList[i].updateTime))).utc().format('YYYY/MM/DD HH:mm:ss')
      }
    },
    //搜索功能
    search(){
      this.queryInfo.pageNum = 1;
      this.getWorkerList();
    },
    handleSizeChange(newSize){
      this.queryInfo.pageSize = newSize;
      this.getWorkerList();
    },
    handleCurrentChange(newPage){
      this.queryInfo.pageNum = newPage;
      this.getWorkerList();
    },
    async showEditDialog(id){
      const {data:res} = await this.$http.get("/Worker/workInfo?id=" + id);
      this.editForm = res
      this.editDialogVisible = true;
    },
    async deleteWorker(id){
      const confirmResult = await this.$confirm('是否确定删除？','提示',{
        confirmButtonText:"确定",
        cancelButtonText:"取消",
        type:'warning'
      }).catch(err => err)
      if(confirmResult!=='confirm'){//取消
        return this.$message.info("已取消删除");
      }
      const updateId = window.sessionStorage.getItem("id");
      const{data:res} = await this.$http.post("/Worker/deleteId?id=" + id + "&updateId="+updateId);
      if(res !== "success"){
        return this.$message.error("删除失败！");
      }
      this.$message.success("删除成功");
      await this.getWorkerList();
    },
    editWorkerInfo(){
      //验证校验规则
      this.$refs.editFormRef.validate(async valid =>{
        if(!valid) return;
        //发起修改请求
        this.editForm.updateId = window.sessionStorage.getItem("id")
        const {data:res} = await this.$http.post("/Worker/updateWorker",this.editForm);
        if(res !== "success"){
          return this.$message.error("修改失败！！！");
        }
        this.$message.success("修改成功");
        //隐藏
        this.editDialogVisible = false;
        await this.getWorkerList();
      })
    },
    addUser(){
      this.$refs.addFormRef.validate(async valid =>{
            if(!valid) return;
            //发起修改请求
            this.addForm.updateId = window.sessionStorage.getItem("id");
            const{data:res} = await this.$http.post("/Worker/insertWorker",this.addForm)
            if(res!== "success"){
              return this.$message.error("添加失败！！！");
            }
            this.$message.success("添加成功！！！")
            await this.getWorkerList();
            this.isPopupAdd = false;
      })
    },
    //监听修改
    editClosed(){
      this.$refs.editFormRef.resetFields();//重置信息
    },
    //监听添加
    insertClosed() {
      this.$refs.editFormRef.resetFields();//重置信息
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
