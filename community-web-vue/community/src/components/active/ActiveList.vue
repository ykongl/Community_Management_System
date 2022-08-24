<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{path:'/home'}">首页</el-breadcrumb-item>
      <el-breadcrumb-item>活动列表</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <el-row :gutter="20">
        <el-col :span="8">
          <label>活动名称：</label>
          <el-input placeholder="请输入活动名称" v-model="queryInfo.activeName" clearable  style="width: 70%; padding-right: 10px"/>
        </el-col>
        <el-col :span="8">
          <label>活动区域：</label>
          <el-input placeholder="请输入活动区域" v-model="queryInfo.activeArea" clearable  style="width: 70%; padding-right: 10px"/>
        </el-col>
        <el-col :span="8">
          <el-button type="primary" icon="el-icon-search" @click="search">搜索</el-button>
          <el-button type="success" icon="el-icon-search" @click="searchOwn" v-show="this.token === '4'">已参加</el-button>
          <el-button type="primary" icon="el-icon-plus" @click="isActive = true" v-show="this.token === '1'">添加活动</el-button>
        </el-col>
      </el-row>
      <el-table :data="activeList" border stripe>
        <el-table-column type="expand">
          <template v-slot="scope">
            <el-form label-position="center" inline class="demo-table-expand">
              <el-form-item label="参赛名单："><el-tag closable v-for="item in scope.row.joinList" @close="deleteJoins(item)">{{item.joinName}}</el-tag></el-form-item>
            </el-form>
          </template>
        </el-table-column>
        <el-table-column label="索引" prop="id" align="center"></el-table-column><!--索引列-->
        <el-table-column label="活动名称" prop="activeName" align="center"></el-table-column>
        <el-table-column label="活动开始时间" prop="activeTime" align="center" min-width="110px"></el-table-column>
        <el-table-column label="活动时长" prop="duration" align="center"></el-table-column>
        <el-table-column label="活动地点" prop="activeArea" align="center"></el-table-column>
        <el-table-column label="活动形式" prop="activeStyle" align="center"></el-table-column>
        <el-table-column label="活动发起人" prop="createName" align="center"></el-table-column>
        <el-table-column label="活动人数" prop="activeNumber" align="center"></el-table-column>
        <!--        自定义插槽-->
        <el-table-column label="操作" align="center" width="150px">
          <template v-slot ="scope">
            <el-button type="success" icon="el-icon-finished" size="mini" @click="joinActive(scope.row.id)" v-show="token === '4'">
            </el-button>
            <!--修改-->
            <el-button type="primary" icon="el-icon-edit" size="mini" v-show="token === '1'" @click="showEditDialog(scope.row.id)">
            </el-button>
            <!--删除-->
            <el-button type="danger" icon="el-icon-delete" size="mini" v-show="token === '1'" @click="deleteActive(scope.row.id)">
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
      <el-dialog title="添加活动" :visible.sync="isActive" width="50%" @close="insertClosed">
        <el-form :model="addActiveForm" :rules="addActiveFormRules" ref="addActiveFormRef" label-width="160px">
          <el-form-item label="活动名称" prop="activeName">
            <el-input v-model="addActiveForm.activeName"></el-input>
          </el-form-item>
          <el-form-item label="活动区域" prop="activeArea">
            <el-input v-model="addActiveForm.activeArea"></el-input>
          </el-form-item>
          <el-form-item label="活动时间" prop="activeTime">
            <el-date-picker
                v-model="addActiveForm.activeTime"
                type="datetime"
                placeholder="选择日期时间">
            </el-date-picker>
          </el-form-item>
          <el-form-item label="活动时长" prop="duration">
            <el-input v-model="addActiveForm.duration">
              <i slot="suffix" style="font-style: normal; margin-right: 10px">小时</i>
            </el-input>
          </el-form-item>
          <el-form-item label="活动形式" prop="activeStyle">
            <el-input v-model="addActiveForm.activeStyle" type="textarea"></el-input>
          </el-form-item>
        </el-form>
        <!-- 内容底部区域    -->
        <span slot="footer" class="dialog-footer">
            <el-button @click="isActive = false">取 消</el-button>
            <el-button type="primary" @click="addActive">确 认</el-button>
          </span>
      </el-dialog>

      <el-dialog title="活动信息" :visible.sync="isEditActive" width="50%" @close="editClosed">
        <el-form :model="editActiveForm" :rules="addActiveFormRules" ref="editActiveFormRef" label-width="160px">
          <el-form-item label="活动名称" prop="activeName">
            <el-input v-model="editActiveForm.activeName"></el-input>
          </el-form-item>
          <el-form-item label="活动区域" prop="activeArea">
            <el-input v-model="editActiveForm.activeArea"></el-input>
          </el-form-item>
          <el-form-item label="活动时间" prop="activeTime">
            <el-date-picker
                v-model="editActiveForm.activeTime"
                type="datetime"
                placeholder="选择日期时间">
            </el-date-picker>

          </el-form-item>
          <el-form-item label="活动时长" prop="duration">
            <el-input v-model="editActiveForm.duration">
              <i slot="suffix" style="font-style: normal; margin-right: 10px">小时</i>
            </el-input>
          </el-form-item>
          <el-form-item label="参加的人数" prop="activeNumber">
          <el-input v-model="editActiveForm.activeNumber" disabled></el-input>
          </el-form-item>
          <el-form-item label="活动形式" prop="activeStyle">
            <el-input v-model="editActiveForm.activeStyle" type="textarea"></el-input>
          </el-form-item>

        </el-form>
        <!-- 内容底部区域    -->
        <span slot="footer" class="dialog-footer">
            <el-button @click="isEditActive = false">取 消</el-button>
            <el-button type="primary" @click="editActive">修改</el-button>
          </span>
      </el-dialog>
    </el-card>
  </div>

</template>

<script>

export default {
  name: "ActiveList",
  data(){
    return{
      activeList:[{
        joinList:[]
      }],
      isActive:false,
      addActiveForm:{},
      editActiveForm:{
        activeNumber:""
      },
      queryInfo:{},
      total:0,
      isEditActive:false,
      token:"",
      joinForm:{},
      addActiveFormRules:{
        activeName:[
            {required: true,message:"请输入活动名称",trigger:"blur"}
        ],
        activeArea:[
          {required: true,message:"请输入活动地址",trigger:"blur"}
        ],
        activeTime:[
          {required: true,message:"请输入活动时间",trigger:"blur"}
        ],
        duration:[
          {required: true,message:"请输入活动时长",trigger:"blur"}
        ],
        activeStyle:[
          {required: true,message:"请输入活动形式",trigger:"blur"}
        ]
      }
    }
  },
  created() {
    this.getActiveList();
  },
  methods:{
    async getJoinList(activeId){
      const{data:res} = await this.$http.get("/active/joinList?activeId="+ activeId)
      return res
    },
    async getActiveList(){
      this.token = window.sessionStorage.getItem("roleId")
      if(this.token === '1'){
        this.isDisabled = false
      }else{
        this.isDisabled = true
      }
      const{data:res} = await this.$http.get("/active/list",{params:this.queryInfo})
      this.activeList = res;
      this.total = this.activeList[0].total;
      for (let i = 0; i < this.activeList.length; i++) {
        this.activeList[i].joinList = await this.getJoinList(this.activeList[i].id)
      }
    },
    searchOwn(){
      this.queryInfo.joinId = window.sessionStorage.getItem("id")
      this.getActiveList()
      this.queryInfo.joinId = ''
    },
    //搜索功能
    search(){
      this.queryInfo.pageNum = 1;
      this.getActiveList();
    },
    //最大数
    handleSizeChange(newSize){
      this.queryInfo.pageSize = newSize;
      this.getActiveList();
    },
    //pageNum的触发动作
    handleCurrentChange(newPage){
      this.queryInfo.pageNum = newPage;
      this.getActiveList();
    },
    async showEditDialog(id){
      const{data:res} = await this.$http.get("/active/info?id="+ id);
      this.editActiveForm = res;
      this.isEditActive = true;
    },
    addActive(){
      this.$refs.addActiveFormRef.validate(async valid =>{
        if(!valid) return;
        this.addActiveForm.createName = window.sessionStorage.getItem("workName")
        this.addActiveForm.createId = window.sessionStorage.getItem("id")
        this.addActiveForm.activeTime = this.$moment(this.addActiveForm.activeTime).format("YYYY/MM/DD HH:mm:ss")
        const {data:res} = await this.$http.post("/active/insertActive",this.addActiveForm)
        if(res !=="success"){
          return this.$message.error("添加失败！！！")
        }
        this.$message.success("添加成功！！！")
        await this.getActiveList();
        this.isActive = false;
      })
    },
    async deleteJoins(item){
      if(window.sessionStorage.getItem("roleId") !== '4'){
        return this.$message.error("权限不够，不能操作！！！")
      }
      if(item.joinId !== window.sessionStorage.getItem("id")){
        return this.$message.error("不能操作其他人！！！")
      }
      const confirmResult = await this.$confirm('是否确定删除？','提示',{
        confirmButtonText:"确定",
        cancelButtonText:"取消",
        type:'warning'
      }).catch(err => err)
      if(confirmResult!=='confirm'){//取消
        return this.$message.info("已取消删除");
      }
      const{data:res} = await this.$http.post("/active/deleteJoins?joinId=" + item.joinId + "&activeId=" + item.activeId
          + "&joinName=" + item.joinName)
      if(res !== "success"){
        return this.$message.error("删除失败！！！")
      }
      this.$message.success("删除成功！！！")
      await this.getActiveList()

    },
    async joinActive(id){
      this.activeList.id = id
      this.joinForm.activeId = id
      this.joinForm.joinId = window.sessionStorage.getItem("id")
      this.joinForm.joinName = window.sessionStorage.getItem("workName")
      const{data:res} = await this.$http.post("/active/join",this.joinForm)
      if(res === "success"){
        this.$message.success("报名成功！！！")
        await this.getActiveList()
      }else if(res === "error"){
        return this.$message.error("报名失败！！！")
      }else{
        return this.$message.warning(res)
      }
    },
    editActive(){
      this.$refs.editActiveFormRef.validate(async valid =>{
        if(!valid) return;
        this.editActiveForm.updateId = window.sessionStorage.getItem("id")
        this.editActiveForm.activeTime = this.$moment(this.editActiveForm.activeTime).format("YYYY/MM/DD HH:mm:ss")
        const{data:res} = await this.$http.post("/active/updateInfo",this.editActiveForm)
        if(res !=="success"){
          return this.$message.error("修改失败！！！")
        }
        this.$message.success("修改成功！！！")
        await this.getActiveList();
        this.isEditActive = false;
      })
    },
    // 关闭窗口
    editClosed(){
      this.$refs.editActiveFormRef.resetFields();//重置信息
    },
    insertClosed(){
      this.$refs.addActiveFormRef.resetFields();
    },
    async deleteActive(id){
      const confirmResult = await this.$confirm('是否确定删除？','提示',{
        confirmButtonText:"确定",
        cancelButtonText:"取消",
        type:'warning'
      }).catch(err => err)
      if(confirmResult!=='confirm'){//取消
        return this.$message.info("已取消删除");
      }
      const updateId = window.sessionStorage.getItem("id");
      const{data:res} = await this.$http.post("/active/deleteById?id=" + id + "&updateId=" + updateId);
      if(res !=="success"){
        return this.$message.error("删除失败！！！");
      }
      this.$message.success("删除成功！！！");
      await this.getActiveList();
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
