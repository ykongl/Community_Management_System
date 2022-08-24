<template>
	<div>
		<div class="login_container">
			<!-- 登录块 -->
			<div class="login_box">
				<!-- logo头像 -->
				<div class="avatar_box">
					<img src="../assets/sportlogo.jpg" />
				</div>
				<!-- 表单区域 -->
				<el-form ref="loginFormRef" :rules="loginRules" :model="loginForm" label-width="0" class="login_form">
					<!-- 用户名 -->
					<el-form-item prop="workNo">
						<el-input v-model="loginForm.workNo" prefix-icon="iconfont icon-denglu" placeholder="用戶账号"></el-input>
					</el-form-item>
					<!-- 密码 -->
					<el-form-item prop="password">
						<el-input v-model="loginForm.password" prefix-icon="iconfont icon-mima" show-password placeholder="密碼"></el-input>
					</el-form-item>
		    <!-- 角色 -->
		    <el-form-item prop="roleId">
		      <el-select v-model="loginForm.roleId" clearable placeholder="请选择角色">
		        <el-option
		            v-for="item in options"
		            :key="item.roleId"
		            :label="item.role"
		            :value="item.roleId">
		        </el-option>
		      </el-select>
		    </el-form-item>
					<!-- 按钮 -->
					<el-form-item class="btns">
		      <el-link @click="isRegister = true" style="margin-right: 10px; color: #409EFF" :underline="false">没有账号，注册</el-link>
		      <el-button type="primary" @click="login()">登录</el-button>
			  <el-button type="infor" @click="resetLoginForm()">重置</el-button>
					</el-form-item>
				</el-form>
			</div>
		</div>
		<el-dialog
			title="注册页面"
		  :visible.sync="isRegister"
		  :with-header="false" width="50%" @close="editClosed">
			  <el-form :model="addForm" :rules="addFormRules" ref="addFormRef" label-width="100px">
			    <el-form-item label="姓名：" prop="username">
			      <el-input v-model="addForm.username" size="medium" style="width: 60%;"></el-input>
			    </el-form-item>
			    <el-form-item label="密码：" prop="password">
			      <el-input v-model="addForm.password" show-password size="medium" style="width: 60%;"></el-input>
			    </el-form-item>
			    <el-form-item label="性别：" prop="sex">
			      <el-radio v-model="addForm.sex" label="0">男</el-radio>
			      <el-radio v-model="addForm.sex" label="1">女</el-radio>
			    </el-form-item>
			    <el-form-item label="电话号码：" prop="phone" >
			      <el-input v-model="addForm.phone"  size="medium" style="width: 60%;"></el-input>
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
			    <!-- <el-form-item label="角色：" prop="roleId">
			      <el-select v-model="addForm.roleId" clearable filterable placeholder="请选择">
			        <el-option
			            v-for="item in options"
			            :key="item.roleId"
			            :label="item.role"
			            :value="item.roleId">
			        </el-option>
			      </el-select>
			    </el-form-item> -->
			  </el-form>
			  <span slot="footer" class="dialog-footer">
			     <el-button @click="isRegister = false">取 消</el-button>
			     <el-button type="primary" @click="addUser">注 册</el-button>
			    </span>
		</el-dialog>

	</div>
</template>
<script>
	export default{
		data(){
			return{
        addForm:{},
        isAssess:"",
        isRegister:false,
				// 表单数据
				loginForm:{
          id:"",
          workName:""
				},
		    communities:[],
        options: [
          {
            roleId: '1',
            role: '管理员'
          },
          {
            roleId:'2',
            role:'医生',
          },
          {
            roleId:'3',
            role:'员工',
          },
          {
            roleId:'4',
            role:'监护人',
          },
        ],
				// 验证对象
				loginRules:{
					// 校验
          workNo:[
						{required:true,message:"请输入用户账号",trigger:'blur'},//必须向验证
						{min: 3, max: 15,message: '长度在 3 到 15 个字符',trigger:'blur'}//长度验证
						],
					password:[
						{required:true,message:"用户密码必须填写",trigger:'blur'},//必须向验证
						{min: 5, max: 12,message: '长度在 5 到 12 个字符',trigger:'blur'}
					],
          roleId:[
            {required:true,message:"请選擇角色",trigger:"blur"},
          ]
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
			};
		},
		created(){
			this.selectAddress();
		},
    methods:{
		addUser(){
		  this.$refs.addFormRef.validate(async valid =>{
		    if(!valid) return;
			this.addForm.roleId = "4"
		    const {data:res} = await this.$http.post("/User/insertUser",this.addForm);
		    if(res!=="success"){
		      return this.$message.error("注册失败！！！");
		    }
		    this.$message.success("注册成功！！！");
		    this.isRegister = false;
		  });

		},
			async selectAddress(){
			  const {data:res} = await this.$http.get("/User/address");
			  this.communities = res;
			},
			editClosed(){
			  this.$refs.addFormRef.resetFields();//重置信息
			},

      //重置表单内容
			resetLoginForm(){
				this.$refs.loginFormRef.resetFields();
			},
			// 登录方法
			login(){
				// 验证是否成功 成功(true) 失败(false)
				// this.$refs.loginFormRef.validate(valid =>{
				// 	console.log(valid);
				// })
				// 验证校验规则
				this.$refs.loginFormRef.validate(async valid =>{
					if(!valid) return;//验证失败
					const {data:res} = await this.$http.post("/Worker/login",this.loginForm);//访问后台
					if(res.flag === "ok"){
						this.$message.success("登录成功！！！");//信息提示
						await this.$router.push({path:"/home",query:{roleId: res.worker.roleId}});// 页面路由跳转
            window.sessionStorage.setItem("workName",res.worker.workName)
            if(res.worker.roleId === '4'){
              window.sessionStorage.setItem("phone",res.worker.workNo)
            }
            window.sessionStorage.setItem("id",res.worker.id)
			      window.sessionStorage.setItem("roleId",res.worker.roleId)
			      window.sessionStorage.setItem("isAssess",res.worker.isAssess)
					}else{
						this.$message.error("登录失败！！！");// 错误提示
					}
				})
			},
		}

	}
</script>

<style lang="less" scoped>

.dialogImg{
	background: url(../assets/register.jpg) no-repeat;
	/**添加以下css */
	height: 100%; //大小设置为100%
	width: 100%; //大小设置为100%
	//position: fixed;
	background-size: 100% 100%;
}
.login_container{
  background: url("../common/community.jpg") no-repeat;
  /**添加以下css */
  height: 100%; //大小设置为100%
  width: 100%; //大小设置为100%
  position: fixed;
  background-size: 100% 100%;
}
.login_box {
  width: 450px;
  height: 350px;
  background-color: #fff;
  border-radius: 4px;
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%,-50%);
  .avatar_box{
    width: 130px;
    height: 130px;
    border: 1px solid #eee;
    border-radius: 50%;
    padding: 10px;
    box-shadow: 0 0 2px #ddd;
    position: absolute;
    left: 50%;
    transform: translate(-50%,-50%);
    background-color: #eee;
    img{
      width: 100%;
      height: 100%;
      border-radius: 50%;
      background-color: #eee;
    }

  }
}
.btns{
  display: flex;
  justify-content: flex-end;
}
.login_form{
  position: absolute;
  bottom: 0%;
  width: 100%;
  padding: 0 10px;
  box-sizing: border-box;
}
</style>
