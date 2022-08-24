<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{path:'/home'}">首页</el-breadcrumb-item>
      <el-breadcrumb-item>健康档案管理</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <el-row :gutter="25">
        <el-col :span="8">
          <label>老人姓名：</label>
          <el-select placeholder="请选择老人" v-model="queryInfo.olderId" @click="getHealthyList"
                     clearable filterable style="width: 70%; padding-right: 10px">
            <el-option
                v-for="item in olderDrop"
                :key="item.olderId"
                :label="item.olderName"
                :value="item.olderId">
            </el-option>
          </el-select>
        </el-col>
        <el-col :span="8">
          <label>档案日期：</label>
          <el-date-picker
              v-model="queryInfo.time"
              type="month"
              placeholder="选择月">
          </el-date-picker>
        </el-col>
        <el-col :span="6">
          <!--        搜索按钮-->
          <el-button type="primary" icon="el-icon-search" @click="search" size="medium">搜索</el-button>
          <el-button type="primary" icon="el-icon-plus" @click="showAddForm" size="medium" v-show="this.token === '2'">添加档案</el-button>
        </el-col>
      </el-row>
      <el-table :data="healthyList" border stripe :default-sort = "{prop: 'createTime', order: 'ascending'}">
        <el-table-column label="索引" prop="id" align="center"></el-table-column><!--索引列-->
        <el-table-column label="名称" align="center">
          <template v-slot="scope">
            <div slot="reference" class="name-wrapper">
              <el-tag size="medium" @click="showHealthyInfo(scope.row.id)">{{ scope.row.olderName }}</el-tag>
            </div>
          </template>
        </el-table-column>
        <el-table-column label="档案描述" prop="files" align="center"></el-table-column>
        <el-table-column label="创建人" prop="workName" align="center"></el-table-column>
        <el-table-column label="创建时间" align="center" min-width="110px" sortable>
          <template v-slot="scope">
            <i class="el-icon-time"></i>
            <span style="margin-left: 15px">{{scope.row.createTime}}</span>
          </template>
        </el-table-column>
        <!--        自定义插槽-->
        <el-table-column label="操作" align="center" v-if="this.token === '2'">
          <template v-slot ="scope">
            <!--删除-->
            <el-button type="danger" icon="el-icon-delete" size="mini" @click="deleteHealthy(scope.row.id)">
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
  </div>
</template>

<script>
export default {
  name: "Healthiness",
  data() {
    return {
      queryInfo:{
		  pageNum: 1,//当前页
		  pageSize: 10,//每页最大数
		  olderId:"",
      },
      healthyList:[{
        id:0,
        olderId:"",
        olderName:"",
      }],
      total:0,
      olderDrop:[],
      token:""
    }
  },
  created() {
    this.getHealthyList();
    this.selectOlderDrop();
  },
  methods:{

    async selectOlderDrop(){
      if(this.token === '4'){
        this.queryInfo.userId = window.sessionStorage.getItem("id")
      }else{
        this.queryInfo.userId = ''
      }
      const{data:res} = await this.$http.get("/healthy/olderDrop?userId=" + this.queryInfo.userId);
      this.olderDrop = res;
    },
    //最大数
    handleSizeChange(newSize){
      this.queryInfo.pageSize = newSize;
      this.getHealthyList();
    },
    //pageNum的触发动作
    handleCurrentChange(newPage){
      this.queryInfo.pageNum = newPage;
      this.getHealthyList();
    },

    async getHealthyList(){
      this.token = window.sessionStorage.getItem("roleId")
      if(this.token === '4'){
        this.queryInfo.userId = window.sessionStorage.getItem("id")
      }
      const{data:res} = await this.$http.get("/healthy/list",{params:this.queryInfo})
      this.healthyList = res;
      this.total = this.healthyList[0].total
      for (let i = 0; i < this.healthyList.length; i++) {
        this.healthyList[i].createTime =
            this.$moment(this.healthyList[i].createTime).format('YYYY/MM/DD')
      }
    },
    search(){
      this.queryInfo.pageNum = 1;
      if(this.queryInfo.time !== '' && this.queryInfo.time !== null){
        this.queryInfo.time = this.$moment(this.queryInfo.time).format('YYYY-MM')
      }
      this.getHealthyList()
    },
    async deleteHealthy(id){
      const confirmResult = await this.$confirm('是否确定删除？','提示',{
        confirmButtonText:"确定",
        cancelButtonText:"取消",
        type:'warning'
      }).catch(err => err)
      if(confirmResult!=='confirm'){//取消
        return this.$message.info("已取消删除");
      }
      const updateId = window.sessionStorage.getItem("id");
      const{data:res} = await this.$http.post("/healthy/deleteById?id=" + id + "&updateId=" + updateId)
      if(res !== "success"){
        return this.$message.error("删除失败！！");
      }
      this.$message.success("删除成功！！");
      await this.getHealthyList();

    },
    showHealthyInfo(id){
      this.$router.push({path:"/healthyInfo",query: { id: id ,isAdd: 'true'}})
    },
	  showAddForm(){
	  this.$router.push({path:'/healthyInfo',query:{isAdd: 'false'}})
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
