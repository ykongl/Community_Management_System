<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{path:'/home'}">首页</el-breadcrumb-item>
      <el-breadcrumb-item>健康知识列表</el-breadcrumb-item>
    </el-breadcrumb>
    <!--    用户列表主体（卡片）-->
    <el-card>
<!--      间隙属性-->
	  <el-row :gutter="20">
		  <el-col style="text-align: center;">
			  <el-button-group>
			      <el-button size="medium" @click="btnSubmit">已发布</el-button>
			      <el-button size="medium" @click="btnDraft">草稿箱</el-button>
			    </el-button-group>
		  </el-col>
	  </el-row>
      <el-row :gutter="20" style="margin-top: 20px;">
        <!--      搜索区域-->
        <el-col :span="8">
          <div>
			  <label>书名：</label>
			  <el-input placeholder="请输入书名" v-model="queryInfo.bookName" clearable style="width: 70%; padding-right: 10px" />
		  </div>
        </el-col>
        <el-col :span="8">
          <div>
          		<label>发布者名称：</label>
          		<el-input placeholder="请输入发布者名称" v-model="queryInfo.createName" clearable style="width: 70%; padding-right: 10px" />
          </div>
        </el-col>
        <el-col :span="6" style="text-align: right;">
          <!--        搜索按钮-->
          <el-button type="primary" icon="el-icon-search" @click="search">搜索</el-button>
          <el-button type="primary" icon="el-icon-plus" @click="btnInsert">添加</el-button>
        </el-col>
      </el-row>
<!--      用户列表 border边框 Stripe隔行变色-->
      <el-table :data="knowledgeList" border stripe :default-sort = "{prop: 'updateTime', order: 'ascending'}">
        <el-table-column label="索引" prop="id" align="center"></el-table-column><!--索引列-->
        <el-table-column label="书名" align="center" min-width="110px">
          <template v-slot="scope">
            <div slot="reference" class="name-wrapper">
              <el-tag size="medium" @click="readBook(scope.row.id,scope.row.style)">{{ scope.row.bookName }}</el-tag>
            </div>
          </template>
        </el-table-column>
        <el-table-column label="发布者" prop="createName" align="center"></el-table-column>
        <el-table-column label="简介" prop="introduction" align="center"></el-table-column>
        <el-table-column label="阅读量" prop="readNumber" align="center"></el-table-column>
        <el-table-column label="创建时间" align="center" min-width="110px" sortable>
          <template v-slot="scope">
            <i class="el-icon-time"></i>
            <span style="margin-left: 15px">{{scope.row.createTime}}</span>
          </template>
        </el-table-column>
<!--        自定义插槽-->
        <el-table-column label="操作" align="center">
          <template v-slot ="scope">
            <!--修改-->
            <el-button type="primary" icon="el-icon-edit" size="mini" @click="showEditDialog(scope.row)" v-if="scope.row.style === '0'">
            </el-button>
            <!--删除-->
            <el-button type="danger" icon="el-icon-delete" size="mini" @click="deleteKnowledge(scope.row)">
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

      <el-dialog title="添加文章" :visible.sync="insert" width="70%" @close="insertClosed">
        <el-form :model="addKnowledgeForm" :rules="addKnowledgeFormRules" ref="addKnowledgeFormRef" label-width="100px">
			<el-form-item label="文章名称:" prop="bookName">
				<el-input v-model="addKnowledgeForm.bookName" size="medium" style="width: 50%"></el-input>
			</el-form-item>
			<el-form-item label="作者:" prop="createName">
				<el-input v-model="addKnowledgeForm.createName" size="medium" style="width: 50%"></el-input>
			</el-form-item>
			<el-form-item label="简介:" prop="introduction">
				<el-input v-model="addKnowledgeForm.introduction" size="medium" type="textarea"></el-input>
			</el-form-item>
			<el-form-item label="正文:" prop="content">
				<qul-editor></qul-editor>
			</el-form-item>
        </el-form>
        <!-- 内容底部区域    -->
        <span slot="footer" class="dialog-footer">
            <el-button @click="insert = false">取 消</el-button>
            <el-button type="primary" @click="addPublish">发布</el-button>
            <el-button type="danger" @click="addDraft">草稿箱</el-button>
          </span>
      </el-dialog>

      <div class="dialog_diy">
        <el-dialog :visible.sync="isReading" width="70%" style="padding: 0">
          <div slot="title" class="header-title" style="background-color: #4A5064;color: white;text-align: center;padding-top: 0">
            <div style="padding:15px 20px;margin-top: 0">阅读健康知识</div>
          </div>
          <el-form :model="editKnowledgeForm">
            <el-row :gutter="20" style="margin-top: 20px">
              <el-col :span="24" style="text-align: center">
                <span style="font-size: 35px">{{editKnowledgeForm.bookName}}</span>
              </el-col>
            </el-row>
            <el-row :gutter="20" style="margin-top: 20px">
              <el-col :span="8" style="text-align: center">
                <label style="font-size: 18px">发布者：</label>
                <span style="font-size: 20px">{{editKnowledgeForm.createName}}</span>
              </el-col>
              <el-col :span="8" style="text-align: center">
                <label style="font-size: 18px">发布时间：</label>
                <span style="font-size: 20px">{{editKnowledgeForm.createTime}}</span>
              </el-col>
              <el-col :span="8" style="text-align: center">
                <label style="font-size: 18px">阅读量：</label>
                <span style="font-size: 20px">{{editKnowledgeForm.readNumber}}</span>
              </el-col>
            </el-row>
            <el-row style="margin-top: 20px">
                <span style="font-size: 15px;font-family: 宋体">{{editKnowledgeForm.content}}</span>
            </el-row>
          </el-form>
          <span style="margin-bottom: 20px"></span>
        </el-dialog>
      </div>


      <el-dialog title="修改文章信息" :visible.sync="editDialogVisible" width="60%" @close="editClosed">
        <el-form :model="editKnowledgeForm" :rules="addKnowledgeFormRules" ref="editKnowledgeFormRef" label-width="160px">
          <el-form-item label="文章名称:" prop="bookName">
            <el-input v-model="editKnowledgeForm.bookName" size="medium" style="width: 50%"></el-input>
          </el-form-item>
          <el-form-item label="作者:" prop="createName">
            <el-input v-model="editKnowledgeForm.createName" size="medium" style="width: 50%" disabled></el-input>
          </el-form-item>
          <el-form-item label="简介:" prop="introduction">
            <el-input v-model="editKnowledgeForm.introduction" size="medium" type="textarea"></el-input>
          </el-form-item>
          <el-form-item label="正文:" prop="content">
            <qul-editor></qul-editor>
          </el-form-item>
        </el-form>
        <!-- 内容底部区域    -->
        <span slot="footer" class="dialog-footer">
            <el-button @click="submitCancle">取 消</el-button>
            <el-button type="primary" @click="submitOk">发布</el-button>
          </span>
      </el-dialog>
    </el-card>
  </div>

</template>

<script>
import qulEditor from "../util/quEditor.vue";//富文本编辑器组件的路径
export default {
  name: "Knowledge",
  components:{qulEditor},
  data(){
    return{
      // 查询信息实体
      queryInfo:{
        pageNum: 1,//当前页
        pageSize: 10,//每页最大数
      },
	    knowledgeList:[],
      addKnowledgeForm:{
        readNumber:""
      },
      editKnowledgeForm:{},
      total:0,//总记录数
	    insert:false,
      isReading:false,
      editDialogVisible:false,
	    addKnowledgeFormRules:{
		  bookName:[
		    {required: true,message:"请输入书名",trigger:"blur"},
		  ],
		  createName:[
		    {required: true,message:"请输入发布者",trigger:"blur"},
		  ],
		  introduction:[
		    {required: true,message:"请输入简介",trigger:"blur"},
		  ],
	  }
    }
  },
  created() {
	  this.queryInfo.style = "1";
    this.getKnowledgeList();

  },
  methods:{
	async getKnowledgeList(){
		const{data:res} = await this.$http.get("/knowledge/list",{params:this.queryInfo})
		this.knowledgeList = res;
		this.total = this.knowledgeList[0].total;
		for (let i = 0; i < this.knowledgeList.length; i++) {
		  this.knowledgeList[i].createTime =
		      this.$moment(this.knowledgeList[i].createTime).utc().format('YYYY/MM/DD HH:mm:ss')
		}
	},
	async deleteKnowledge(row){
    if(row.createId !== window.sessionStorage.getItem("id") || row.roleId !== window.sessionStorage.getItem("roleId")
        || row.createName !== window.sessionStorage.getItem("workName")){
      return this.$message.error("没有权限操作！！！")
    }
		const confirmResult = await this.$confirm('是否确定删除？','提示',{
		  confirmButtonText:"确定",
		  cancelButtonText:"取消",
		  type:'warning'
		}).catch(err => err)
		if(confirmResult!=='confirm'){//取消
		  return this.$message.info("已取消删除");
		}
		const updateId = window.sessionStorage.getItem("id");
		const{data:res} = await this.$http.post("/knowledge/deleteById?id=" + row.id + "&updateId=" + updateId + "&style=" + row.style);
		if(res !== "success"){
			return this.$message.error("删除失败！！！")
		}
		this.$message.success("删除成功！！！")
		await this.getKnowledgeList();
	},
	btnInsert(){
		this.insert = true;
		this.addKnowledgeForm.createName = window.sessionStorage.getItem("workName");
	},
	search(){
		this.queryInfo.pageNum = 1;
    this.queryInfo.createId = '';
    this.queryInfo.roleId = '';
    this.queryInfo.createName = '';
		this.getKnowledgeList();
	},
    //最大数
    handleSizeChange(newSize){
      this.queryInfo.pageSize = newSize;
      this.getKnowledgeList();
    },
    //pageNum的触发动作
    handleCurrentChange(newPage){
      this.queryInfo.pageNum = newPage;
      this.getKnowledgeList();
    },
    btnSubmit(){
      this.queryInfo.style = 1;
      this.queryInfo.createId = '';
      this.queryInfo.roleId = '';
      this.queryInfo.createName = '';
      this.getKnowledgeList();
    },
	btnDraft(){
		this.queryInfo.style = 0;
    this.queryInfo.createId = window.sessionStorage.getItem("id");
    this.queryInfo.roleId = window.sessionStorage.getItem("roleId");
    this.queryInfo.createName = window.sessionStorage.getItem("workName");
		this.getKnowledgeList();
	},
	addPublish(){
		  this.$refs.addKnowledgeFormRef.validate(async valid =>{
		  if(!valid) return;
		  this.addKnowledgeForm.content = window.sessionStorage.getItem("content")
		  this.addKnowledgeForm.createId = window.sessionStorage.getItem("id");
      this.addKnowledgeForm.roleId = window.sessionStorage.getItem("roleId")
		  this.addKnowledgeForm.style = "1";
		  const{data:res} = await this.$http.post("/knowledge/insertKnowledge",this.addKnowledgeForm);
		  if(res !== "success"){
			  return this.$message.error("发布失败！！！")
		  }
      this.queryInfo.style = "1"
		  this.$message.success("发布成功！！！")
		  await this.getKnowledgeList();
		  this.insert = false;
		  })
	},

	addDraft(){
		this.$refs.addKnowledgeFormRef.validate(async valid =>{
		if(!valid) return;
		this.addKnowledgeForm.content = window.sessionStorage.getItem("content")
		this.addKnowledgeForm.createId = window.sessionStorage.getItem("id");
		this.addKnowledgeForm.style = "0";
		const{data:res} = await this.$http.post("/knowledge/insertKnowledge",this.addKnowledgeForm);
		if(res !== "success"){
			return this.$message.error("草稿箱保存失败！！！")
		}
		this.$message.success("草稿箱保存成功！！！")
		this.queryInfo.style = "0";
		await this.getKnowledgeList();
		this.insert = false;
		})

	},
	
	insertClosed(){
	  this.$refs.addKnowledgeFormRef.resetFields();
	},
	// 关闭窗口
	editClosed(){
	  this.$refs.editKnowledgeFormRef.resetFields();//重置信息
	},
   async readBook(id,style){
    const{data:res} = await this.$http.get("/knowledge/info?id=" + id + "&style=" + style);
    this.editKnowledgeForm = res;
     this.editKnowledgeForm.createTime =
         this.$moment(this.editKnowledgeForm.createTime).utc().format('YYYY/MM/DD HH:mm:ss')
    this.isReading = true;
     await this.getKnowledgeList();
    },
    async showEditDialog(row){
      if(row.createId !== window.sessionStorage.getItem("id") || row.roleId !== window.sessionStorage.getItem("roleId")
          || row.createName !== window.sessionStorage.getItem("workName")){
        return this.$message.error("没有权限操作！！！")
      }
      const{data:res} = await this.$http.get("/knowledge/info?id=" + row.id + "&style=" + row.style);
      this.editKnowledgeForm = res;
      this.editKnowledgeForm.createTime =
          this.$moment(this.editKnowledgeForm.createTime).utc().format('YYYY/MM/DD HH:mm:ss')
      window.sessionStorage.setItem("content",this.editKnowledgeForm.content);
      this.editDialogVisible = true;
    },

    submitCancle(){
      this.$refs.editKnowledgeFormRef.validate(async valid =>{
            if(!valid) return;
            this.editKnowledgeForm.updateId = window.sessionStorage.getItem("id");
            this.editKnowledgeForm.content = window.sessionStorage.getItem("content");
            this.editKnowledgeForm.style = "0"
            this.editKnowledgeForm.createTime = new Date();
            const {data:res} = await this.$http.post("/knowledge/updateInfo",this.editKnowledgeForm)
            if(res !== "success"){
              return this.message.error("退出失败！！！");
            }
            this.$message.success("退出成功！！！");
            await this.getKnowledgeList();
            this.editDialogVisible = false;
      })
    },
    submitOk(){
      this.$refs.editKnowledgeFormRef.validate(async valid =>{
        if(!valid) return;
        this.editKnowledgeForm.updateId = window.sessionStorage.getItem("id");
        this.editKnowledgeForm.content = window.sessionStorage.getItem("content");
        this.editKnowledgeForm.style = "1"
        this.editKnowledgeForm.createTime = new Date();
        const {data:res} = await this.$http.post("/knowledge/updateInfo",this.editKnowledgeForm)
        if(res !== "success"){
          return this.message.error("发布失败！！！");
        }
        this.$message.success("发布成功！！！");
        this.queryInfo.style = "1"
        await this.getKnowledgeList();
        this.editDialogVisible = false;
      })
    }

  }
}
</script>

<style lang="less" scoped>
.el-breadcrumb{
  margin-bottom: 15px;
  font-size: 17px;
}
.dialog_diy{
  ::v-deep .el-dialog__wrapper { // eslint-disable-line
    .el-dialog {
      .el-dialog__body{
        padding: 0px;
      }
      .el-dialog__header{
        padding: 0px;
      }
      .el-dialog__headerbtn {
        top: 5px;
        right: 5px;
        padding-top: 10px;
      }
      .el-dialog__headerbtn .el-dialog__close {
        color: #fff;
        height: 30px;
        width: 35px;
      }
      .el-dialog__headerbtn .el-dialog__close:hover {
        color: gray;
      }
    }
  }
}
</style>
