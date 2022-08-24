<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{path:'/home'}">首页</el-breadcrumb-item>
      <el-breadcrumb-item :to="{path:'/food'}">餐饮互助</el-breadcrumb-item>
      <el-breadcrumb-item>餐厅</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <el-row :gutter="20">
        <el-col :span="6">
            <label>社区：</label>
            <el-select placeholder="请选择社区" v-model="queryInfo.communityCd" clearable
                       filterable style="width: 70%; padding-right: 10px" @change="selectRestaurant(queryInfo.communityCd)">
              <el-option
                  v-for="item in communities"
                  :key="item.communityCd"
                  :label="item.communityName"
                  :value="item.communityCd">
              </el-option>
            </el-select>
        </el-col>
        <el-col :span="6">
          <label>餐厅：</label>
          <el-select placeholder="请选择餐厅" v-model="queryInfo.restaurant" clearable
                     filterable style="width: 70%; padding-right: 10px" @change="getFoodList">
            <el-option
                v-for="item in restaurants"
                :key="item.restaurant"
                :label="item.restaurant"
                :value="item.restaurant">
            </el-option>
          </el-select>
        </el-col>
        <el-col :span="12">
          <el-button type="primary" icon="el-icon-plus" @click="isMenu = true" v-show="this.token === '1'">添加餐厅</el-button>
          <el-button type="warning" icon="el-icon-plus" @click="isAddFood = true" v-show="this.token === '1'">添加菜品</el-button>
          <el-button type="success" icon="el-icon-s-finance" @click="buyFood" v-show="this.token === '4'">购买</el-button>
<!--          <el-button type="danger" icon="el-icon-shopping-cart-full" @click="" v-show="this.token === '4'">加入购物车</el-button>-->
        </el-col>
      </el-row>

      <el-table :data="foodList" border stripe>
        <el-table-column label="选择" align="center">
          <template v-slot="scope">
            <el-checkbox v-model="scope.row.isCheck" @change="checkFoodList(scope.row.isCheck,scope.row)"></el-checkbox>
          </template>
        </el-table-column>
        <el-table-column label="菜名" prop="foodName" align="center"></el-table-column>
        <el-table-column label="图片" align="center">
          <template v-slot="scope">
            <el-image style="width: 100%; height: 100px" :src="scope.row.foodImgUrl" alt=""></el-image>
          </template>
        </el-table-column>
        <el-table-column label="价格" prop="foodPrice" align="center"></el-table-column>
        <el-table-column label="下单数量" align="center">
          <template v-slot="scope">
            <el-input v-model="scope.row.foodNumber"></el-input>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" v-if="this.token === '1'">
          <template v-slot ="scope">
            <!--删除-->
            <el-button type="danger" icon="el-icon-delete" size="mini" @click="deleteById(scope.row.id)">
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
    <el-dialog title="添加餐厅信息" :visible.sync="isMenu" width="50%" @close="addMenuClosed">
      <el-form :model="addMenuForm" :rules="addMenuFormRules" ref="addMenuFormRef" label-width="160px">
        <el-form-item label="社区编号" prop="communityCd">
          <el-select placeholder="请选择社区" v-model="addMenuForm.communityCd" clearable
                     filterable style="width: 70%; padding-right: 10px">
            <el-option
                v-for="item in communities"
                :key="item.communityCd"
                :label="item.communityName"
                :value="item.communityCd">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="餐厅名称" prop="restaurant">
          <el-input v-model="addMenuForm.restaurant" style="width: 70%"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
          <el-button @click = "isMenu = false">取消</el-button>
          <el-button type="primary" @click = "addMenu">确定</el-button>
        </span>
    </el-dialog>

    <el-dialog title="添加菜品信息" :visible.sync="isAddFood" width="50%" @close="addFoodFormClosed">
      <el-form :model="addFoodForm" :rules="addFoodFormRules" ref="addFoodFormRef" label-width="160px">
        <el-form-item label="社区编号" prop="communityCd">
          <el-select placeholder="请选择社区" v-model="addFoodForm.communityCd" clearable
                     filterable style="width: 70%; padding-right: 10px" @change="selectRestaurant(addFoodForm.communityCd)">
            <el-option
                v-for="item in communities"
                :key="item.communityCd"
                :label="item.communityName"
                :value="item.communityCd">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="餐厅名称" prop="restaurant">
          <el-select placeholder="请选择餐厅" v-model="addFoodForm.restaurant" clearable
                     filterable style="width: 70%; padding-right: 10px">
            <el-option
                v-for="item in restaurants"
                :key="item.restaurant"
                :label="item.restaurant"
                :value="item.restaurant">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="菜品名称" prop="foodName">
          <el-input v-model="addFoodForm.foodName" style="width: 70%"></el-input>
        </el-form-item>
        <el-form-item label="价格" prop="foodPrice">
          <el-input v-model="addFoodForm.foodPrice" style="width: 70%">
            <i slot="suffix" style="font-style: normal; margin-right: 10px">元</i>
          </el-input>
        </el-form-item>
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

      </el-form>
      <span slot="footer" class="dialog-footer">
          <el-button @click = "isAddFood = false">取消</el-button>
          <el-button type="primary" @click = "addFood">确定</el-button>
        </span>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "foodBusiness.vue",
  data(){
    return{
      imgUrl:"",
      queryInfo:{},
      addFoodOrderForm:{
        foodNumber:0,
        foodPrice: ""
      },
      checkFoods:[],
      communities:[],
      restaurants:[],
      foodList:[],
      isMenu:false,
      isAddFood:false,
      addMenuForm:{},
      total:0,
      token:"",
      addFoodForm:{},
      addMenuFormRules:{
        communityCd:[
          {required: true,message:"请输入社区编号",trigger:"blur"}
        ],
        restaurant:[
          {required: true,message:"请输入餐厅名称",trigger:"blur"}
        ]
      },
      addFoodFormRules:{
        communityCd:[
          {required: true,message:"请输入社区编号",trigger:"blur"}
        ],
        restaurant:[
          {required: true,message:"请输入餐厅名称",trigger:"blur"}
        ],
        foodName:[
          {required: true,message:"请输入菜的名称",trigger:"blur"}
        ],
        foodPrice:[
          {required: true,message:"请输入菜的价格",trigger:"blur"}
        ]
      }
    }
  },
  created() {
    this.selectAddress();
  },
  methods:{
    async getFoodList(){
      const{data:res} = await this.$http.get("/foodOrder/foodList",{params:this.queryInfo})
      this.foodList = res
      this.total = this.foodList[0].total
      for (let i = 0; i < this.foodList.length; i++) {
        this.foodList[i].foodImgUrl = require('@/' + this.foodList[i].foodImgUrl)
      }
    },
    checkFoodList(isCheck,row){
      let index = -1
      if(isCheck === true) {
        index = index + 1
        this.checkFoods.push(row)
      }else{
        this.checkFoods.splice(index,1)
        index = index - 1
      }
      for (let i = 0; i < this.communities.length; i++) {
        if(this.queryInfo.communityCd === this.communities[i].communityCd){
          this.addFoodOrderForm.address = this.communities[i].communityName
        }
      }
    },
    async deleteById(id){
      const confirmResult = await this.$confirm('是否确定删除？','提示',{
        confirmButtonText:"确定",
        cancelButtonText:"取消",
        type:'warning'
      }).catch(err => err)
      if(confirmResult!=='confirm'){//取消
        return this.$message.info("已取消删除");
      }
      const updateId = window.sessionStorage.getItem("id");
      const {data:res} = await this.$http.post("/foodOrder/deleteFoodById?id="+id+"&updateId="+updateId);
      if(res !== "success"){
        return this.$message.error("删除失败！");
      }
      this.$message.success("删除成功");
      await this.getFoodList()

    },
    addMenu(){
      this.$refs.addMenuFormRef.validate(async valid => {
            if (!valid) return;
        this.addMenuForm.createId = window.sessionStorage.getItem("id")
        const{data:res} = await this.$http.post("/foodOrder/insertRestaurant",this.addMenuForm)
        if(res !== "success"){
          return this.$message.error("添加失败！！！")
        }
        this.$message.success("添加成功！！！")
        this.isMenu = false
      })
    },
    async selectRestaurant(communityCd){
      const{data:res} = await this.$http.get("/foodOrder/restaurantDrop?communityCd=" + communityCd)
      this.restaurants = res
    },
    addMenuClosed(){
      this.$refs.addMenuFormRef.resetFields()
    },
    async selectAddress(){
      this.token = window.sessionStorage.getItem('roleId')
      const {data:res} = await this.$http.get("/User/address");
      this.communities = res;
    },
    handleSizeChange(newSize){
      this.queryInfo.pageSize = newSize;
      this.getFoodList()
    },
    handleCurrentChange(newPage){
      this.queryInfo.pageNum = newPage;
      this.getFoodList()
    },
    addFoodFormClosed(){
      this.$refs.addFoodFormRef.resetFields()
    },
    addFood(){
      this.$refs.addFoodFormRef.validate(async valid => {
        if (!valid) return;
        this.addFoodForm.createId = window.sessionStorage.getItem("id")
        const{data:res} = await this.$http.post("/foodOrder/insertFood",this.addFoodForm)
        if(res !== "success"){
          return this.$message.error("添加失败！！！")
        }
        this.$message.success("添加成功！！！")
        this.isAddFood = false
      })
    },
    async buyFood(){
      this.addFoodOrderForm.foodNames = ''
      if(this.checkFoods === undefined || this.checkFoods.length <= 0){
        return this.$message.warning("请选择商品！！！");
      }
      this.addFoodOrderForm.createId = window.sessionStorage.getItem("id")
      this.addFoodOrderForm.foodOrderNo = "CY" + Math.floor(Math.random() * 100000000)
      this.addFoodOrderForm.contactNumber = window.sessionStorage.getItem("phone")
      this.addFoodOrderForm.orderPerson = window.sessionStorage.getItem("workName")
      this.addFoodOrderForm.communityRestaurant = this.queryInfo.restaurant
      for (let i = 0; i < this.checkFoods.length; i++) {
        this.addFoodOrderForm.foodNames = this.addFoodOrderForm.foodNames + this.checkFoods[i].foodNumber + "份" + this.checkFoods[i].foodName
        this.addFoodOrderForm.foodPrice = (this.addFoodOrderForm.foodPrice - 0) + ((this.checkFoods[i].foodPrice - 0) * (this.checkFoods[i].foodNumber))
      }
      console.log(this.addFoodOrderForm.foodPrice)
      this.addFoodOrderForm.orderStatus = "进行中"
      const {data:res} = await this.$http.post("/foodOrder/insertFoodOrder",this.addFoodOrderForm)
      if(res !== "success"){
        return this.$message.error("购买失败！！！")
      }
      this.$message.success("购买成功！！！")
      await this.$router.push({path:"/food"})
    },
    handleAvatarSuccess(res, file) {
      let newFile = new FormData();
      newFile.append("imgUrl",file.raw.name)
      //console.log(file.raw)
      this.addFoodForm.foodImgUrl = 'assets/' + newFile.get("imgUrl")
      console.log(this.addFoodForm.foodImgUrl)
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
