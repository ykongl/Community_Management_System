<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{path:'/home'}">首页</el-breadcrumb-item>
      <el-breadcrumb-item>社区列表</el-breadcrumb-item>
    </el-breadcrumb>
      <el-card>
        <el-row :gutter="20">
          <!--      搜索区域-->
          <el-col :span="6">
            <div>
              <label>社区：</label>
              <el-select placeholder="请选择社区" v-model="queryInfo.communityCd" clearable
                         filterable @click="getCommunityList" style="width: 70%; padding-right: 10px">
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
            <el-button type="primary" icon="el-icon-plus" @click="isInsert = true" v-show="this.token === '1'">添加社区</el-button>
          </el-col>
        </el-row>
        <!--      用户列表 border边框 Stripe隔行变色-->
        <el-table :data="communityList" border stripe :default-sort = "{prop: 'updateTime', order: 'ascending'}">
          <el-table-column type="expand">
            <template v-slot="scope">
              <el-form label-position="center" inline class="demo-table-expand">
                <el-form-item label="社区编号："><span>{{scope.row.communityCd}}</span></el-form-item>
                <el-form-item label="社区名称："><span>{{scope.row.communityName}}</span></el-form-item>
                <el-form-item label="社区位置："><span>{{scope.row.communityPlace}}</span></el-form-item>
                <el-form-item label="社区面积："><span>{{scope.row.communityArea + ' m²'}}</span></el-form-item>
                <el-form-item label="社区人数："><span>{{scope.row.peopleNumber}}</span></el-form-item>
                <el-form-item label="老年人数：">
                  <span>{{scope.row.oldNumber}}</span>
                  <el-button style = "margin-left: 320px" type="primary" icon="el-icon-edit" size="mini" @click="showInfo(scope.row.id)" v-show="token==='1'">
                  </el-button>
                </el-form-item>
              </el-form>
            </template>
          </el-table-column>
          <el-table-column label="索引" prop="id" align="center"></el-table-column><!--索引列-->
          <el-table-column label="社区名称" prop="communityName" align="center"></el-table-column><!--索引列-->
          <el-table-column label="更新时间" prop="updateTime" align="center" min-width="100px" sortable></el-table-column>
          <el-table-column label="状态" prop="state" align="center">
            <!--          作用域插槽 scope.row存储了当前行的信息-->
            <template v-slot="scope">
              <el-switch v-model = "scope.row.state" @change="StateChange(scope.row)" :disabled="isDisabled"></el-switch>
            </template>
          </el-table-column>
          <el-table-column label="操作" align="center" v-if="this.token === '1'">
            <template v-slot ="scope">
              <!--删除-->
              <el-button type="danger" icon="el-icon-delete" size="mini" @click="deleteCommunity(scope.row.id)">
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
<!--    修改-->
    <el-dialog title="修改社区信息" :visible.sync="isShowInfo" width="50%" @close="editClosed">
      <el-form :model="communityForm" :rules="editFormRules" ref="editFormRef" label-width="160px">
        <el-form-item label="社区编号" prop="communityCd">
          <el-input v-model="communityForm.communityCd" disabled style="width: 80%"></el-input>
        </el-form-item>
        <el-form-item label="社区名称" prop="communityName">
          <el-input v-model="communityForm.communityName" disabled style="width: 80%"></el-input>
        </el-form-item>
        <el-form-item label="社区位置" prop="communityPlace">
          <el-input v-model="communityForm.communityPlace" disabled style="width: 80%"></el-input>
        </el-form-item>
        <el-form-item label="社区面积" prop="communityArea">
          <el-input v-model="communityForm.communityArea" style="width: 80%"></el-input>
        </el-form-item>
        <el-form-item label="社区人数" prop="peopleNumber">
          <el-input v-model="communityForm.peopleNumber" style="width: 80%"></el-input>
        </el-form-item>
        <el-form-item label="老人数量" prop="oldNumber">
          <el-input v-model="communityForm.oldNumber" style="width: 80%"></el-input>
        </el-form-item>
      </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click = "isShowInfo = false">取消</el-button>
          <el-button type="primary" @click = "editCommunity">确定</el-button>
        </span>
    </el-dialog>

<!--    添加-->
    <el-dialog title="添加社区信息" :visible.sync="isInsert" width="50%" @close="insertClosed">
      <el-form :model="addForm" :rules="editFormRules" ref="insertFormRef" label-width="160px">
        <el-form-item label="社区编号" prop="communityCd">
          <el-input v-model="addForm.communityCd" style="width: 80%"></el-input>
        </el-form-item>
        <el-form-item label="社区名称" prop="communityName">
          <el-input v-model="addForm.communityName" style="width: 80%"></el-input>
        </el-form-item>
        <el-form-item label="社区位置" prop="communityPlace">
          <el-input v-model="addForm.communityPlace" style="width: 80%"></el-input>
        </el-form-item>
        <el-form-item label="社区面积" prop="communityArea">
          <el-input v-model="addForm.communityArea" style="width: 80%"></el-input>
        </el-form-item>
        <el-form-item label="社区人数" prop="peopleNumber">
          <el-input v-model="addForm.peopleNumber" style="width: 80%"></el-input>
        </el-form-item>
        <el-form-item label="老人数量" prop="oldNumber">
          <el-input v-model="addForm.oldNumber" style="width: 80%"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
          <el-button @click = "isInsert = false">取消</el-button>
          <el-button type="primary" @click = "addCommunity">确定</el-button>
        </span>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "communityList",
  data(){
    const validatePass = (rule ,value, callback) =>{
      if (value > this.addForm.peopleNumber || value > this.communityForm.peopleNumber){
        callback(new Error('社区老人数量不能超过社区人数！！'));
      }else{
        callback();
      }
    }
    return{
      communities:[{
        id:0,
        communityCd:'',
        communityName:'',
        communityPlace:'',
        communityArea:'',
        peopleNumber:0,
        oldNumber:0,
        updateTime:'',
      }],
      communityList:[],
      // 查询信息实体
      queryInfo:{
        pageNum: 1,//当前页
        pageSize: 10,//每页最大数
      },
      total:0,
      token:"",
      isDisabled:false,
      isInsert:false,//对话框状态
      isShowInfo:false,
      communityForm:{},
      addForm:{},
      editFormRules:{
        communityCd:[
          {required: true,message:"请输入社区编号",trigger:"blur"},
          {min: 3,max: 12,message:"长度在 3 到 12 个字符串",trigger:"blur"},
        ],
        communityName:[
          {required: true,message:"请输入社区名称",trigger:"blur"},
        ],
        communityPlace:[
          {required: true,message:"请输入社区位置",trigger:"blur"},
        ],
        communityArea:[
          {required:true,message:"请输入社区面积",trigger:"blur"},
        ],
        peopleNumber:[
          {required:true,message:"请输入社区人数",trigger:"blur"},
        ],
        oldNumber:[
          {required:true,message:"请输入社区老年人数",trigger:"blur"},
          {validator:validatePass,trigger: "blur",required: true}
        ]
      }
    }
  },
  created() {
    this.getCommunityList();
    this.selectAddress();
  },
  methods:{
    async getCommunityList(){
        const {data:res} = await this.$http.get("/community/list",{params:this.queryInfo});
        this.communityList = res;
        this.total = this.communityList[0].total;
        for (let i = 0;i<this.communityList.length; i++){
        this.communityList[i].updateTime
            = this.$moment(this.communityList[i].updateTime).utc().format('YYYY/MM/DD HH:mm:ss')
      }
      this.token = window.sessionStorage.getItem("roleId")
      if(this.token === '1'){
        this.isDisabled = false
      }else{
        this.isDisabled = true
      }
    },
    search(){
      this.queryInfo.pageNum = 1;
      this.getCommunityList();
    },
    //最大数
    handleSizeChange(newSize){
      this.queryInfo.pageSize = newSize;
      this.getCommunityList();
    },
    //pageNum的触发动作
    handleCurrentChange(newPage){
      this.queryInfo.pageNum = newPage;
      this.getCommunityList();
    },
    async selectAddress(){
      const {data:res} = await this.$http.get("/User/address");
      this.communities = res;
    },
    async showInfo(id){
        this.isShowInfo = true;
        const{data:res} = await this.$http.get("/community/communityInfo?id=" + id);
        this.communityForm = res;
    },
    async deleteCommunity(id){
      const confirmResult = await this.$confirm('是否确定删除？','提示',{
        confirmButtonText:"确定",
        cancelButtonText:"取消",
        type:'warning'
      }).catch(err => err)
      if(confirmResult !== 'confirm'){//取消
        return this.$message.info("已取消删除");
      }
      const updateId = window.sessionStorage.getItem("id");
      const{data:res} = await this.$http.post("/community/deleteById?id="+ id + "&updateId="+updateId)
      if(res !== "success"){
        return this.$message.error("删除失败！！")
      }
      await this.getCommunityList();
      this.$message.success("删除成功！！")
    },
    editCommunity(){
      //验证校验规则
      this.$refs.editFormRef.validate(async valid =>{
        if(!valid) return;
        this.communityForm.updateId = window.sessionStorage.getItem("id")
        const {data:res} = await this.$http.post("/community/updateInfo",this.communityForm);
        if(res !== "success"){
          return this.$message.error("修改失败！！！")
        }
        await this.getCommunityList();
        this.isShowInfo = false;
        this.$message.success("修改成功！！")
      })
    },
    // 关闭窗口
    editClosed(){
      this.$refs.editFormRef.resetFields();//重置信息
    },
    insertClosed(){
      this.$refs.insertFormRef.resetFields();
    },
    addCommunity(){
      this.$refs.insertFormRef.validate(async valid=>{
        if(!valid) return;
        this.addForm.id = window.sessionStorage.getItem("id");
        const {data:res} = await this.$http.post("/community/addCommunity",this.addForm);
        if(res != "success"){
          return this.$message.error("添加失败！！！");
        }
        this.$message.success("添加成功！！！");
        this.isInsert = false;
        await this.getCommunityList();
      })
    },
    async StateChange(communityInfo){
      communityInfo.updateId = window.sessionStorage.getItem("id");
      const{data:res} = await this.$http.post(`/community/updateState?id=${communityInfo.id}&updateId=${communityInfo.updateId}&state=${communityInfo.state}`);
      if(res != "success"){
        communityInfo.id = !communityInfo.id;
        return this.$message.error("状态修改失败！！！");
      }
      this.$message.success("状态修改成功！！！");
      await this.getCommunityList();
      await this.selectAddress();
    }
  }
}
</script>

<style scoped>
.el-breadcrumb {
  margin-bottom: 15px;
  font-size: 17px;
}
.demo-table-expand {
  font-size: 0;
}
.demo-table-expand .el-form-item {
  margin-bottom: 0;
  margin-left: 50px;
  min-width: 45%;

}
</style>
