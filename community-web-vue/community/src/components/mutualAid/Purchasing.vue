<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{path:'/home'}">首页</el-breadcrumb-item>
      <el-breadcrumb-item>代购互助</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <el-row :gutter="20">
        <!--      搜索区域-->
        <el-col :span="8">
          <label>订单编号：</label>
          <el-input placeholder="请输入订单编号" v-model="queryInfo.orderNo" clearable style="width: 70%; padding-right: 10px"/>
        </el-col>
        <el-col :span="8">
          <label>购买人名称：</label>
          <el-input placeholder="请输入购买人名称" v-model="queryInfo.orderCustomer" clearable style="width: 70%; padding-right: 10px"/>
        </el-col>
        <el-col :span="8">
          <el-button type="primary" icon="el-icon-search" @click="search">搜索</el-button>
          <el-button type="success" icon="el-icon-s-shop" @click="$router.push({path:'/shoppingMall'})" v-show="this.token !== '3'">商城</el-button>
        </el-col>
      </el-row>
      <el-table :data="shopList" border stripe>
        <el-table-column type="expand">
          <template v-slot="scope">
            <el-form label-position="center" inline class="demo-table-expand">
              <el-form-item label="团购名单："><el-tag closable v-for="item in scope.row.tag" @close="deleteCustomer(item)">{{item.orderCustomer}}</el-tag></el-form-item>
            </el-form>
          </template>
        </el-table-column>
        <el-table-column label="订单编号" prop="orderNo" align="center"></el-table-column>
        <el-table-column label="商家" prop="shopName" align="center"></el-table-column>
        <el-table-column label="商品名称" prop="goodsName" align="center"></el-table-column>
        <el-table-column label="图片" align="center">
          <template v-slot="scope">
            <el-image style="width: 100%; height: 100px" :src="require('@/'+ scope.row.imgUrl)" alt=""></el-image>
          </template>
        </el-table-column>
        <el-table-column label="单价" prop="orderPrice" align="center"></el-table-column>
        <el-table-column label="订单数量" prop="orderNumber" align="center"></el-table-column>
        <el-table-column label="订单状态" prop="orderStatus" align="center"></el-table-column>
        <el-table-column label="创建时间" prop="createTime" align="center" min-width="100px" sortable></el-table-column>
        <el-table-column label="操作" align="center" v-if="this.token === '3'">
          <template v-slot ="scope">
            <el-button type="success" size="mini" @click="updateStatus(scope.row.orderNo,0)">配送完成</el-button>
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
  name: "Purchasing",
  data(){
    return{
      queryInfo:{
        pageNum:1,
        pageSize:10
      },
      token:"",
      total:0,
      shopList:[],
    }
  },
  created() {
    this.getOrderList()
  },
  methods:{
    async updateStatus(orderNo,orderStatus){
      const{data:res} = await this.$http.post("/order/updateStatus?orderNo=" + orderNo + "&orderStatus=" + orderStatus)
      if(res !=="success"){
        return this.$message.error("状态修改失败！！！")
      }
      await this.getOrderList()
      return this.$message.success("配送成功！！！")


    },
    async getOrderList(){
      this.token = window.sessionStorage.getItem('roleId')
      if(this.token === '4'){
        this.queryInfo.userId = window.sessionStorage.getItem('id')
      }
      const{data:res} = await this.$http.get("/order/list",{params:this.queryInfo})
      this.shopList = res
      this.total = this.shopList[0].total
      for (let i = 0; i < this.shopList.length; i++) {
        this.shopList[i].tag = await this.getCustomer(this.shopList[i].orderNo)
        this.shopList[i].createTime = this.$moment(this.shopList[i].createTime).utc().format('YYYY/MM/DD HH:mm:ss')
        if(this.shopList[i].orderStatus === '0'){
          this.shopList[i].orderStatus = '完成'
        }else if(this.shopList[i].orderStatus === '1'){
          this.shopList[i].orderStatus = '进行中'
        }else{
          this.shopList[i].orderStatus = '废弃'
        }
        //this.shopList[i].imgUrl = require('@/' + this.shopList[i].imgUrl)
      }
    },
	async getCustomer(orderNo){
		const{data:res} = await this.$http.get("/order/customerList?orderNo=" + orderNo)
		return res
	},
    search(){
      this.queryInfo.pageNum = 1;
      this.getOrderList()

    },
    //最大数
    handleSizeChange(newSize){
      this.queryInfo.pageSize = newSize;
      this.getOrderList()
    },
    //pageNum的触发动作
    handleCurrentChange(newPage){
      this.queryInfo.pageNum = newPage;
      this.getOrderList()
    },
    async deleteOrder(id){
      const confirmResult = await this.$confirm('是否确定删除？','提示',{
        confirmButtonText:"确定",
        cancelButtonText:"取消",
        type:'warning'
      }).catch(err => err)
      if(confirmResult !== 'confirm'){//取消
        return this.$message.info("已取消删除");
      }
      const updateId = window.sessionStorage.getItem("id");
      const{data:res} = await this.$http.post("/order/deleteById?id="+ id + "&updateId="+updateId)
      if(res !== "success"){
        return this.$message.error("删除失败！！")
      }
      await this.getOrderList()
      this.$message.success("删除成功！！")
    },
    async deleteCustomer(item){
      if(window.sessionStorage.getItem("roleId") !== '4'){
        return this.$message.error("权限不够，不能操作！！！")
      }
      if(item.userId !== window.sessionStorage.getItem("id")){
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
      const{data:res} = await this.$http.post("/order/deleteCustomer?orderCustomer="+ item.orderCustomer + "&orderNo=" + item.orderNo + "&userId=" + item.userId)
      if(res !== "success"){
        return this.$message.error("删除失败！！")
      }
      await this.getOrderList()
      this.$message.success("删除成功！！")
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
