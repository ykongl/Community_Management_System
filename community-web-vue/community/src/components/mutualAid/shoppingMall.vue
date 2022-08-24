<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{path:'/home'}">首页</el-breadcrumb-item>
      <el-breadcrumb-item :to="{path:'/shop'}">代购互助</el-breadcrumb-item>
      <el-breadcrumb-item>商城</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <el-row :gutter="20">
        <!--      搜索区域-->
        <el-col :span="7">
          <label>商品名称：</label>
          <el-input placeholder="请输入商品名称" v-model="queryInfo.goodsName" clearable style="width: 70%; padding-right: 10px"/>
        </el-col>
        <el-col :span="7">
          <label>商家名称：</label>
          <el-input placeholder="请输入商家名称" v-model="queryInfo.shopName" clearable style="width: 70%; padding-right: 10px"/>
        </el-col>
        <el-col :span="10">
          <el-button type="primary" icon="el-icon-search" @click="search">搜索</el-button>
		  <el-button type="primary" icon="el-icon-plus" @click="isAddGoods = true" v-show="this.token === '1'">添加商品</el-button>
		  <el-button type="success" icon="el-icon-s-finance" @click="joinGroup" v-show="this.token === '4'">加入团购</el-button>
<!--		  <el-button type="danger" icon="el-icon-shopping-cart-full" @click="joinShoppingCart" v-show="this.token === '4'">加入购物车</el-button>-->
        </el-col>
      </el-row>
      <el-table :data="shoppingList" border stripe>
        <el-table-column label="选择" align="center">
          <template v-slot="scope">
            <el-checkbox v-model="scope.row.isCheck" @change="checkList(scope.row.isCheck,scope.row)"></el-checkbox>
          </template>
        </el-table-column>
        <el-table-column label="商品名称" prop="goodsName" align="center"></el-table-column>
        <el-table-column label="图片" align="center">
          <template v-slot="scope">
            <el-image style="width: 100%; height: 100px" :src="require('@/' + scope.row.goodsImgUrl)" alt=""></el-image>
          </template>
        </el-table-column>
        <el-table-column label="商品单位" prop="goodsUnit" align="center"></el-table-column>
        <el-table-column label="商品单价" prop="goodsPrice" align="center"></el-table-column>
        <el-table-column label="商家" prop="shopName" align="center"></el-table-column>
        <el-table-column label="商品保质期" prop="qualityGuarantee" align="center"></el-table-column>
        <el-table-column label="库存" prop="stock" align="center"></el-table-column>
        <el-table-column label="下单数量" prop="number" align="center">
          <template v-slot="scope">
            <el-input v-model="scope.row.number"></el-input>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" v-if="this.token === '1'">
          <template v-slot ="scope">
<!--            <div style="float: left;margin-top: 10px">-->
<!--                <el-badge :value="scope.row.checkNumber">-->
<!--                  <el-button type="success" icon="el-icon-plus" size="mini" @change="addGoodsNumber(scope.row)">-->
<!--                  </el-button>-->
<!--                </el-badge>-->
<!--            </div>-->
            <div style="margin-top: 10px">
              <el-button type="danger" icon="el-icon-delete" size="mini" @click="deleteGoods(scope.row.id)">
              </el-button>
            </div>
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

      <el-dialog title="添加商品信息" :visible.sync="isAddGoods" width="50%" @close="insertClosed">
        <el-form :model="addGoodsForm" :rules="addGoodsFormRules" ref="addGoodsFormRef" label-width="160px">
          <el-form-item label="商品图片：">
            <el-upload
                class="avatar-uploader"
                action="https://jsonplaceholder.typicode.com/posts/"
                :show-file-list="false"
                :on-success="handleAvatarSuccess"
                :before-upload="beforeAvatarUpload">
              <img v-if="imgUrl" :src="imgUrl" class="avatar" alt="">
              <i v-else class="el-icon-plus avatar-uploader-icon"></i>
            </el-upload>
          </el-form-item>
          <el-form-item label="商品名称" prop="goodsName">
            <el-input v-model="addGoodsForm.goodsName" style="width: 80%"></el-input>
          </el-form-item>
          <el-form-item label="商品单位" prop="goodsUnit">
            <el-input v-model="addGoodsForm.goodsUnit" style="width: 80%"></el-input>
          </el-form-item>
          <el-form-item label="商品单价" prop="goodsPrice">
            <el-input v-model="addGoodsForm.goodsPrice" style="width: 80%">
              <i slot="suffix" style="font-style: normal; margin-right: 10px">元</i>
            </el-input>
          </el-form-item>
          <el-form-item label="商家" prop="shopName">
            <el-input v-model="addGoodsForm.shopName" style="width: 80%"></el-input>
          </el-form-item>
          <el-form-item label="保质期" prop="qualityGuarantee">
            <el-input v-model="addGoodsForm.qualityGuarantee" style="width: 80%"></el-input>
          </el-form-item>
          <el-form-item label="存量" prop="stock">
            <el-input v-model="addGoodsForm.stock" style="width: 80%"></el-input>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click = "isAddGoods = false">取消</el-button>
          <el-button type="primary" @click = "addGoods">确定</el-button>
        </span>
      </el-dialog>
    </el-card>
  </div>
</template>

<script>
export default {
  name:"shoppingMall",
  data(){
    return{
      imgUrl:"",
      token:'',
      addGoodsForm:{},
      queryInfo:{
        shopName:"",
        goodsName:""
      },
      imgList:[],
	    addOrderForm:{},
      goodsList:[],
      shoppingList:[],
	    isAddGoods:false,
      total:0,
      addGoodsFormRules:{
        goodsName:[
          {required: true,message:"请输入商品名称",trigger:"blur"},
        ],
        goodsUnit:[
          {required: true,message:"请输入商品单位",trigger:"blur"},
        ],
        goodsPrice:[
          {required: true,message:"请输入商品单价",trigger:"blur"},
        ],
        shopName:[
          {required: true,message:"请输入商家名称",trigger:"blur"},
        ],
        qualityGuarantee:[
          {required: true,message:"请输入商品保质期",trigger:"blur"},
        ],
        stock:[
          {required: true,message:"请输入商品库存",trigger:"blur"},
        ]
      }
    }
  },
  created() {
    this.getGoodsList()
  },
  methods:{
    async getGoodsList(){
      const{data:res} = await this.$http.get("/shop/list",{params:this.queryInfo})
      this.shoppingList = res
      this.total = this.shoppingList[0].total
      for (let i = 0; i < this.shoppingList.length; i++) {
        this.shoppingList[i].checkNumber = 0
        // this.imgList.push(this.shoppingList[i].goodsImgUrl)
        //this.shoppingList[i].goodsImgUrl = require("@/" + this.shoppingList[i].goodsImgUrl)
      }
      this.token = window.sessionStorage.getItem("roleId")
    },
    search(){
      this.queryInfo.pageNum = 1;
      this.getGoodsList()
    },
    //最大数
    handleSizeChange(newSize){
      this.queryInfo.pageSize = newSize;
      this.getGoodsList()
    },
    //pageNum的触发动作
    handleCurrentChange(newPage){
      this.queryInfo.pageNum = newPage;
      this.getGoodsList()
    },
    addGoods(){
      this.$refs.addGoodsFormRef.validate(async valid => {
        if (!valid) return;
        this.addGoodsForm.createId = window.sessionStorage.getItem("id")
        const{data:res} = await this.$http.post("/shop/addGoods",this.addGoodsForm)
        if(res !== "success"){
          return this.$message.error("添加失败！！！")
        }
        this.$message.success("添加成功！！！")
        await this.getGoodsList();
        this.isAddGoods = false
      })
    },
    async deleteGoods(id){
      const confirmResult = await this.$confirm('是否确定删除？','提示',{
        confirmButtonText:"确定",
        cancelButtonText:"取消",
        type:'warning'
      }).catch(err => err)
      if(confirmResult!=='confirm'){//取消
        return this.$message.info("已取消删除");
      }
      const updateId = window.sessionStorage.getItem("id");
      const{data:res} = await this.$http.post("/shop/deleteById?id=" + id + "&updateId=" + updateId)
      if(res !== "success"){
        return this.$message.error("删除失败！！！")
      }
      this.$message.success("删除成功！！！")
      await this.getGoodsList()
    },
    insertClosed(){
      return this.$refs.addGoodsFormRef.resetFields();
    },
    async joinGroup(){
      if(this.goodsList === undefined || this.goodsList.length <= 0){
        return this.$message.warning("请选择商品！！！");
      }
      this.addOrderForm.userId = window.sessionStorage.getItem("id")
      this.addOrderForm.createId = window.sessionStorage.getItem("id")
      this.addOrderForm.orderCustomer = window.sessionStorage.getItem("workName")
      for (let i = 0; i < this.goodsList.length; i++) {
		this.addOrderForm.number = this.goodsList[i].number
        this.addOrderForm.goodsId = this.goodsList[i].id
        this.addOrderForm.orderNo = "SP" + Math.floor(Math.random() * 100000000)
        this.addOrderForm.shopName = this.goodsList[i].shopName
        this.addOrderForm.imgUrl = this.goodsList[i].goodsImgUrl
        this.addOrderForm.goodsName = this.goodsList[i].goodsName
        this.addOrderForm.orderPrice = (this.goodsList[i].goodsPrice - 0)*(this.goodsList[i].number)
        this.addOrderForm.orderStatus = "进行中"
        const{data:res} = await this.$http.post("/order/insertOrder",this.addOrderForm)
        if(res !== "success"){
          return this.$message.error("加入失败！！！")
        }
        this.$message.success("加入成功！！！")
      }
      this.addOrderForm = {}
      await this.$router.push({path:"/shop"})
    },
    checkList(isCheck,row){
      let index = -1
      if(isCheck === true) {
        index = index + 1
        this.goodsList.push(row)
      }else{
        this.goodsList.splice(index,1)
        index = index - 1
      }
    },
    joinShoppingCart(){

    },
    handleAvatarSuccess(res, file) {
      let newFile = new FormData();
      newFile.append("imgUrl",file.raw.name)
      //console.log(file.raw)
      this.addGoodsForm.goodsImgUrl = 'assets/' + newFile.get("imgUrl")
      console.log(this.addGoodsForm.goodsImgUrl)
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
