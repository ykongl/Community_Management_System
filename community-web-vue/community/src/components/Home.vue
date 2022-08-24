<template>
	<!-- 引入布局 -->
	<el-container class="home-container" v-loading="loading">
		<!-- 头部 -->
	  <el-header>
		  <div class="clickPop">
			  <img src="../assets/sportlogo.jpg" alt/>
			  <span class="span-font">社区老人健康管理及互助平台</span>
		  </div>
        <el-dropdown class="clickPop">
          <el-avatar src="https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png" style="margin-right: 10px"></el-avatar>
          <span class="el-dropdown-link">
    {{getUsername()}}<i class="el-icon-arrow-down el-icon--right"></i>
        </span>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item><span @click="Main">首页</span></el-dropdown-item>
<!--            <el-dropdown-item><el-badge :value="12"><span @click="">购物车</span></el-badge></el-dropdown-item>-->
            <el-dropdown-item><span @click="$router.push({path:'/personal'})">个人中心</span></el-dropdown-item>
            <el-dropdown-item><span type="info" @click="quit">安全退出</span></el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>

	  </el-header>
	  <!-- 主体 -->
	  <el-container>
		  <!-- 侧边栏 -->
	    <el-aside :width="width">
			  <el-menu background-color="#545c64" text-color="#fff" active-text-color="#00a3f4"
        unique-opened :collapse="isCollapse" :collapse-transition="false" :router="true"
        :default-active="activePath">
          <div class="toggle-button" @click="toggleCollapase">|||</div>
				  <!-- 一级菜单 -->
			      <el-submenu :index="item.id + ''" v-for="item in menuList" :key="item.id">
			        <template slot="title">
			          <i :class="iconsObject[item.id]"></i>
			          <span style="margin-left: 7px">{{item.title}}</span>
			        </template>
					<!-- 二级菜单 -->
					<el-menu-item :index="it.path + ''" v-for="it in item.sList" :key="it.id" @click="saveNavState()">
						<template slot="title">
						  <i :class="iconsObject[it.id]"></i>
						  <span style="margin-left: 7px">{{it.title}}</span>
						</template>
					</el-menu-item>
			      </el-submenu>
			    </el-menu>
		</el-aside>
		<!-- 主体内容 -->
      <el-main>
			  <router-view></router-view>
		  </el-main>
      <el-dialog title="用户评价" :visible.sync="isDialog" width="40%">
        <el-col :span="7" style="margin-top: 15px"><el-rate v-model="assessForm.assess" show-text></el-rate></el-col>
        <!-- 内容底部区域    -->
        <span slot="footer" class="dialog-footer">
            <el-button @click="isDialog = false">取 消</el-button>
            <el-button type="primary" @click="logout">确 认</el-button>
        </span>
      </el-dialog>
	  </el-container>
	</el-container>
</template>
<script>
export default{
	  data(){
		  return{
			  //菜单列表
        loading:true,
        width:"200px",
			  menuList:[],
        isCollapse:false,
        sList:[],
        assessForm:{
			  assess:""
        },
        isPopup:false,
        isDialog:false,
        percentage:0,
        customColors:"",
        token:"",
        editPassword:{
          id:"",
          username:"",
          oldPassword:"",
          newPassword:"",
          passwordConfirm:""
        },
        iconsObject:{
			    '100':'iconfont icon-yonghu',
			    '200':'iconfont icon-shequ',
				  '300':'iconfont icon-jiankangdanganx',
				  '400':'iconfont icon-huzhu',
				  '500':'iconfont icon-2jiankangzhishi',
				  '600':'iconfont icon-huodong1',
			    '101':'iconfont icon-guanliyuan1',
			    '102':'iconfont icon-yonghu',
				  '103':'iconfont icon-menu_lrkh',
			    '201':'iconfont icon-shequ',
			    '301':'iconfont icon-jiankangdanganx',
			    '302':'iconfont icon-shujujiance',
				  '401':'iconfont icon-yiliaohuzhu',
				  '402':'iconfont icon-gouwuche',
			    '403':'iconfont icon-canyinguanli',
			    '501':'iconfont icon-2jiankangzhishi',
			    '601':'iconfont icon-huodong1',
        },
        activePath:"/welcome",// 默认路径
		  }
	  },
  // onload事件
	  created() {
      //查询menuList
      this.getUsername();
      this.getMenuList();
      this.activePath = window.sessionStorage.getItem('activePath');//取出session里的path动态修改
      this.loading = false;
    },
	  methods:{
      quit(){
        if(window.sessionStorage.getItem("isAssess") === "1"){
          return this.logout()
        }
        this.isDialog = true
      },
      Main(){
        this.$router.push("/welcome");
      },
      getUsername(){
        this.editPassword.id = window.sessionStorage.getItem("id");
        this.editPassword.username = window.sessionStorage.getItem("workName");
        return this.editPassword.username;
      },
		  //安全退出
	  async logout(){
      if(this.assessForm.assess !== '' && this.assessForm.assess !== null && this.assessForm.assess !== 0)
      {
        this.assessForm.workId = window.sessionStorage.getItem("id")
        this.assessForm.createName = window.sessionStorage.getItem("workName")
        this.assessForm.roleId = window.sessionStorage.getItem("roleId")
        const{data:res} = await this.$http.post("/assess/addAssess",this.assessForm)
        if(res !== "success"){
          return this.$message.error("评价失败！！！")
        }
        this.$message.success("评价成功！！！")
      }
      const confirmResult = await this.$confirm('是否确定退出？','提示',{
        confirmButtonText:"确定",
        cancelButtonText:"取消",
        type:'warning'
      }).catch(err => err)
      if(confirmResult!=='confirm'){//取消
        return this.$message.info("已取消退出");
      }
      window.sessionStorage.clear();//清除session
      window.localStorage.clear();
      await this.$router.push("/login");//回到首页
		  },
		  //获取导航菜单
		 async getMenuList(){
       let token
       if(window.sessionStorage.getItem("roleId") === '' || window.sessionStorage.getItem("roleId") === null)
       {
         token = this.$route.query.roleId
       }else{
         token = window.sessionStorage.getItem("roleId")
       }
			 const {data:res} = await this.$http.get("menus?roleId=" + token);
			 console.log(res);
			 if(res.flag !== 200)
				 return this.$message.error("获取列表失败!!!");//访问失败的错误信息
			 this.menuList = res.menus;//返回数据
		},

      //控制伸缩
     toggleCollapase(){
        this.isCollapse = !this.isCollapse;
        if(this.isCollapse === true){
          this.width = "64px";
        }else{
          this.width = "200px";
        }
     },
      //保存路径
      saveNavState(activePath){
		    window.sessionStorage.setItem('activePath',activePath);//存放在session里
		    this.activePath = activePath;
      }
	}
  }
</script>

<style lang="less" scoped>
	// 全局样式
	.home-container{
		height: 100%;
	}
	//头部样式
	.el-header{
		background-color: #373d41;
		display: flex;
		align-items: center;
		justify-content: space-between; //左右贴边
		padding-left: 0%;//左边界
		color:#fff;
		font-size:20px;
	}
  .clickPop{
    display: flex;
    align-items: center;
    cursor: pointer;//显示小手
  }
  .span-font{
    margin-left: 10px;
    font-family: 隶书;
  }
	//侧边栏样式
	.el-aside{
		background-color: #333744;
    .el-menu{
      border-right: none;
    }
	}
	//主体样式
	.el-main{
		background-color: #eaedf1;
	}
	img{
		width: 55px;
		height: 55px;
	}
  // |||按钮样式
  .toggle-button{
    background-color: #4A5064;
    font-size: 10px;
    line-height: 24px;
    color: #fff;
    text-align: center;
    letter-spacing: 0.2rem;
    cursor: pointer;//显示小手
  }
  .el-dropdown-link {
    cursor: pointer;
    color: #fffdef;
  }
  .el-icon-arrow-down {
    font-size: 12px;
  }

</style>

