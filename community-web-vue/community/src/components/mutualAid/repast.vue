<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{path:'/home'}">首页</el-breadcrumb-item>
      <el-breadcrumb-item>餐饮互助</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <el-row :gutter="20">
        <!--      搜索区域-->
        <el-col :span="8">
          <label>订单编号：</label>
          <el-input placeholder="请输入订单编号" v-model="queryInfo.foodOrderNo" clearable style="width: 70%; padding-right: 10px"/>
        </el-col>
        <el-col :span="8">
          <el-button type="primary" icon="el-icon-search" @click="search">搜索</el-button>
          <el-button type="warning" icon="el-icon-s-shop" @click="$router.push({path:'/foodBusiness'})" v-show="this.token !== '3'">餐厅</el-button>
        </el-col>
      </el-row>
      <el-table :data="foodOrderList" border stripe>
        <el-table-column label="订单编号" prop="foodOrderNo" align="center"></el-table-column>
        <el-table-column label="下单人" prop="orderPerson" align="center"></el-table-column>
        <el-table-column label="联系方式" prop="contactNumber" align="center"></el-table-column>
        <el-table-column label="地址" prop="address" align="center"></el-table-column>
        <el-table-column label="餐厅" prop="communityRestaurant" align="center"></el-table-column>
        <el-table-column label="订单内容" prop="foodNames" align="center"></el-table-column>
        <el-table-column label="订单价格" prop="foodPrice" align="center"></el-table-column>
        <el-table-column label="订单状态" prop="orderStatus" align="center"></el-table-column>
        <el-table-column label="创建时间" align="center" width="165px">
          <template v-slot="scope">
            <i class="el-icon-time"></i>
            <span style="margin-left: 10px">{{scope.row.createTime}}</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" v-if="this.token === '4' || this.token === '3'" width="180px">
          <template v-slot ="scope">
            <el-button type="success" size="mini" @click="updateStatus(scope.row.foodOrderNo,0)" v-show="token === '3'">配送完成</el-button>
            <!--修改-->
            <el-button type="warning" icon="" size="mini" @click="updateStatus(scope.row.foodOrderNo,2)" v-show="token === '4' && scope.row.orderStatus === '进行中'">废</el-button>
            <!--删除-->
            <el-button type="danger" icon="el-icon-delete" size="mini" @click="deleteFoodOrder(scope.row.id)" v-show="token === '4'">
            </el-button>
          </template>
        </el-table-column>
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
    </el-card>
  </div>
</template>

<script>
export default {
  name: "repast",
  data(){
    return{
      queryInfo:{
        foodOrderNo:""
      },
      foodOrderList:[],
      total:0,
      token:""
    }
  },
  created() {
    this.getFoodOrderList();
  },
  methods:{
    async updateStatus(foodOrderNo,orderStatus){
      const {data:res} = await this.$http.post("/foodOrder/updateStatus?foodOrderNo=" + foodOrderNo + "&orderStatus=" + orderStatus)
      if(res !== "success"){
        return this.$message.error("状态修改失败！！！")
      }
      await this.getFoodOrderList();
      return this.$message.success("状态修改成功！！！")
    },
    async getFoodOrderList(){
      this.token = window.sessionStorage.getItem("roleId")
      if(this.token === '4'){
        this.queryInfo.orderPerson = window.sessionStorage.getItem("workName")
      }
      const{data:res} = await this.$http.get("/foodOrder/list",{params:this.queryInfo})
      this.foodOrderList = res
      this.total = this.foodOrderList[0].total
      for (let i = 0; i < this.foodOrderList.length; i++) {
        this.foodOrderList[i].createTime = this.$moment(this.foodOrderList[i].createTime).utc().format("YYYY/MM/DD HH:mm:ss")
        if(this.foodOrderList[i].orderStatus === '0'){
          this.foodOrderList[i].orderStatus = '完成'
        }else if(this.foodOrderList[i].orderStatus === '1'){
          this.foodOrderList[i].orderStatus = '进行中'
        }else{
          this.foodOrderList[i].orderStatus = '废弃'
        }
      }
    },
    //搜索功能
    search(){
      this.queryInfo.pageNum = 1;
      this.getFoodOrderList()
    },
    handleSizeChange(newSize){
      this.queryInfo.pageSize = newSize;
      this.getFoodOrderList()
    },
    handleCurrentChange(newPage){
      this.queryInfo.pageNum = newPage;
      this.getFoodOrderList()
    },
    async deleteFoodOrder(id){
      const confirmResult = await this.$confirm('是否确定删除？','提示',{
        confirmButtonText:"确定",
        cancelButtonText:"取消",
        type:'warning'
      }).catch(err => err)
      if(confirmResult!=='confirm'){//取消
        return this.$message.info("已取消删除");
      }
      const updateId = window.sessionStorage.getItem("id");
      const {data:res} = await this.$http.post("/foodOrder/deleteFoodOrderById?id="+id+"&updateId="+updateId);
      if(res !== "success"){
        return this.$message.error("删除失败！");
      }
      this.$message.success("删除成功");
      await this.getFoodOrderList()
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
