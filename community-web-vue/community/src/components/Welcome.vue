<template>
  <div style="height: 100%">
    <el-row :gutter="25" style="margin-left: 5px;">
      <el-col :span="6">
        <el-card style="height: 102px;">
			<el-col :span="6" style="height: 60px;padding: 0;">
				<i class="iconfont icon-fangwenliang" style="font-size: 60px;color: #0086B3;"></i>
			</el-col>
			<el-col :span="12" style="text-align: right;height: 55px;padding: 0;">
				<el-row>
					<span style="font-size: 30px; color: #0086B3;">{{userNumber}}</span>
				</el-row>
				<el-row>
					<span style="font-weight: 200;font-size: 15px; font-family: 楷体;">用户数量</span>
				</el-row>
			</el-col>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card style="height: 102px;">
			<el-col :span="6" style="height: 60px;padding: 0;">
				<i class="iconfont icon-duzheliuyan" style="font-size: 60px;color:cyan;"></i>
			</el-col>
			<el-col :span="12" style="text-align: right;height: 55px;padding: 0;">
				<el-row>
					<span style="font-size: 30px; color: cyan;">{{newsNumber}}</span>
				</el-row>
				<el-row>
					<span style="font-weight: 200;font-size: 15px; font-family: 楷体;">系统消息</span>
				</el-row>
			</el-col>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card>
			<el-col :span="6" style="height: 80px;padding: 0;">
				<i class="iconfont icon-xiaoqushu" style="font-size: 50px;color:#55A532;"></i>
			</el-col>
			<el-col :span="12" style="text-align: right;height: 55px;padding: 0;">
				<el-row>
					<span style="font-size: 30px; color: #55A532;">{{communityNumber}}</span>
				</el-row>
				<el-row>
					<span style="font-weight: 200;font-size: 15px; font-family: 楷体;">社区数量</span>
				</el-row>
			</el-col>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card>
			<el-col :span="6" style="height: 80px;padding: 0;">
				<i class="iconfont icon-gouwuche" style="font-size: 50px;color:#FF0000;"></i>
			</el-col>
			<el-col :span="12" style="text-align: right;height: 55px;padding: 0;">
				<el-row>
					<span style="font-size: 30px; color: #FF0000;">{{orderNumber}}</span>
				</el-row>
				<el-row>
					<span style="font-weight: 200;font-size: 15px; font-family: 楷体;">订单数量</span>
				</el-row>
			</el-col>
        </el-card>
      </el-col>
    </el-row>
    <el-row :gutter="25" style="margin-top: 20px;margin-left: 5px;">
      <el-col :span="16">
        <el-card id="container" style="height: 500px;padding-top: 15px">
        </el-card>
      </el-col>
      <el-col :span = "8">
        <el-card id = "pie" style="height: 500px;padding-top: 15px"></el-card>
      </el-col>
    </el-row>
    <el-row :gutter="25" style="margin-top: 20px;margin-left: 5px;">
      <el-col :span="12">
        <el-card>
          <el-row :gutter="5">
            <el-col :span="6" style="font-size: 30px;font-family: 楷体;">用户评价:</el-col>
            <!-- <el-col :span="7" style="margin-top: 15px"><el-rate v-model="value" show-text></el-rate></el-col> -->
          </el-row>
          <el-row :gutter="5">
            <el-col :span="17" id="bar" style="height: 225px"></el-col>
            <el-col :span="7" style="text-align: right">
              <el-rate v-model="value1" disabled show-text text-color="#dcdcdc"></el-rate>
              <el-rate v-model="value2" disabled show-text text-color="#dd1d"></el-rate>
              <el-rate v-model="value3" disabled show-text text-color="#dddd11"></el-rate>
              <el-rate v-model="value4" disabled show-text text-color="coral"></el-rate>
              <el-rate v-model="value5" disabled show-text text-color="red"></el-rate>
            </el-col>
          </el-row>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card>
			<el-row :gutter="5">
				<el-col :span="6" style="font-size: 30px;font-family: 楷体;">留言区:</el-col>
				<el-col :span="18" class = "marquee-wrap">
					<ul class="marquee-list" :class="{'animate-up': animateUp}">
					      <li v-for="(item, index) in listData" :key="index">{{item.createTime}} {{item.username}}: {{item.news}}</li>
					</ul>
				</el-col>
			</el-row>
			<el-row :gutter="5" style="margin-top: 20px;">
				<el-col :span="15">
					<el-input placeholder="请留言" v-model="newsForm.news" clearable maxlength="255" show-word-limit></el-input>
				</el-col>
				<el-col :span="6" style="text-align: right;">
					<el-button type="primary" size="medium" @click="submit">发布</el-button>
				</el-col>
			</el-row>
        </el-card>
      </el-col>
    </el-row>
  </div>

</template>

<script>

export default {
  name: '',
  data(){
    return{
      value:null,
      value1:1,
      value2:2,
      value3:3,
      value4:4,
      value5:5,
	    animateUp: false,
	    listData: [],
	    listNews:[],
	    timer:null,
	    userNumber:0,
	    newsNumber:0,
	    communityNumber:0,
      orderNumber:0,
	    newsForm:{
        username:"",
        news:""
      },
	    male:0,
	    female:0,
	    user:0,
	    worker:0,
	    admin:0,
	    older:0,
	    doctor:0,
      barList:{
        veryPoor:"",
        disappointed:"",
        generally:"",
        satisfy:"",
        surprise:""
      },
      dataX:[],
      dataUserY:[],
      dataNewsY:[],
      dataOrderY:[],
      stackList:[{
        loginTime:"",
        newsCount:0,
        orderCount:0,
        userCount:0
      }],
    }
  },
  created() {
  	this.getNumber()
	this.getNewsList()
	this.getPieCount()
	this.getBarCount()
    this.getStackedList()
  },
  methods:{

    async getStackedList(){
      this.dataX = []
      const{data:res} = await this.$http.get("/System/stackedList")
      this.stackList = res;
      for (let i = 0; i < this.stackList.length; i++) {
        this.dataX.push(this.$moment(this.stackList[i].loginTime).format('YYYY/MM/DD'))
        this.dataNewsY.push(this.stackList[i].newsCount)
        this.dataOrderY.push(this.stackList[i].orderCount)
        this.dataUserY.push(this.stackList[i].userCount)
      }
      this.stackCharts();
    },

	  async getBarCount(){
		  const{data:res} = await this.$http.get("/assess/count")
      this.barList.veryPoor = res.veryPoor;
      this.barList.disappointed = res.disappointed;
      this.barList.generally = res.generally
      this.barList.satisfy = res.satisfy
      this.barList.surprise = res.surprise
      this.barCharts();
	  },
	  async getPieCount(){
		const{data:res} = await this.$http.get("/Pie/count")
		this.male = res.male
		this.female = res.female
		this.user = res.user
		this.worker = res.worker
		this.admin = res.admin
		this.older = res.older
		this.doctor = res.doctor
		this.pieChart()
	  },
	  async getNumber(){
		 const{data:res} = await this.$http.get("/System/number")
		 this.userNumber = res.userNumber;
		 this.communityNumber = res.communityNumber;
		 this.newsNumber = res.newsNumber;
     this.orderNumber = res.orderNumber;
	  },
	  async submit(){
		if(this.newsForm.news ===''||this.newsForm.news === null){
			return this.$message.error("留言不能为空！！！")
		}
		this.newsForm.username = window.sessionStorage.getItem("workName");
		const{data:res} = await this.$http.post("/System/news",this.newsForm)
		if(res !== "success"){
			return this.$message.error("发布失败！！！")
		}
		this.$message.success("发布成功！！！")
		await this.getNumber()
		await this.getNewsList()
		await this.getStackedList()
		this.newsForm.news = null;
	  },
	  async getNewsList(){
		const{data:res} = await this.$http.get("/System/list")
		this.listData = res;
		for(let i = 0;i<this.listData.length;i++){
			this.listData[i].createTime = this.$moment(this.listData[i].createTime).utc().format("YYYY/MM/DD HH:mm:ss")
		}

	  },
	  //滚动评论区
	  scrollAnimate(){
		  this.animateUp = true
		  setTimeout(() =>{
			  this.listData.push(this.listData[0])
			  this.listData.shift()
			  this.animateUp = false
		  },500)
	  },
	  destroyed(){
		  clearInterval(this.timer)
	  },
	  //饼状图区
    pieChart(){
      const chart = this.$echarts.init(document.getElementById("pie"));
      const option = {
        tooltip: {
          trigger: 'item',
          formatter: '{a} <br/>{b}: {c} ({d}%)'
        },
        legend: {
          data: [
            '男',
            '女',
            '用户',
            '员工',
            '医生',
            '老人',
            '管理员'
          ]
        },
        series: [
          {
            name:'性别',
            type: 'pie',
            selectedMode: 'single',
            radius: [0, '30%'],
            label: {
              position: 'inner',
              fontSize: 14
            },
            labelLine: {
              show: false
            },
            data: [
              { value: this.male, name: '男' },
              { value: this.female, name: '女', selected: true }
            ]
          },
          {
            name: '用户类别',
            type: 'pie',
            radius: ['45%', '60%'],
            labelLine: {
              length: 30
            },
            data: [
              { value: this.user, name: '用户'},
              { value: this.older, name: '老人' },
              { value: this.worker, name: '员工' },
              { value: this.doctor, name: '医生' },
              { value: this.admin, name: '管理员' },
            ]
          }
        ]
      };
      if(option && typeof option === 'object'){
        chart.setOption(option)
      }
      window.onresize = function(){
		  chart.resize()
	  }
    },
    stackCharts(){
      const charts = this.$echarts.init(document.getElementById("container"));
      const option =  {
        title: {
        },
        tooltip: {
          trigger: 'axis',
          axisPointer: {
            type: 'cross',
            label: {
              backgroundColor: '#6a7985'
            }
          }
        },
        legend: {
          data: ['用户', '留言', '订单']
        },
        toolbox: {
          feature: {
            saveAsImage: {}
          }
        },
        grid: {
          left: '3%',
          right: '4%',
          bottom: '3%',
          containLabel: true
        },
        xAxis: [
          {
            type: 'category',
            boundaryGap: false,
            data: this.dataX,
          }
        ],
        yAxis: [
          {
            type: 'value'
          }
        ],
        series: [
          {
            name: '订单',
            type: 'line',
            stack: 'Total',
            areaStyle: {},
			smooth: true,
            emphasis: {
              focus: 'series'
            },
            data: this.dataOrderY
          },
          {
            name: '留言',
            type: 'line',
            stack: 'Total',
            areaStyle: {},
			smooth: true,
            emphasis: {
              focus: 'series'
            },
            data: this.dataNewsY
          },
          {
            name: '用户',
            type: 'line',
            stack: 'Total',
			smooth: true,
            label: {
              show: true,
              position: 'top'
            },
            areaStyle: {},
            emphasis: {
              focus: 'series'
            },
            data: this.dataUserY
          }
        ]
      };
      if (option && typeof option === 'object') {
        charts.setOption(option);
      }
      window.onresize = function(){
	  		  charts.resize()
	  }
    },
    barCharts(){
      // 基于准备好的dom，初始化echarts实例
      const myChart = this.$echarts.init(document.getElementById('bar'));

      // 指定图表的配置项和数据
      const option = {
        title: {
        },
        tooltip: {},
        legend: {
          data:['人数'],
        },
        xAxis: {
          data: ["极差","失望","一般","满意","惊喜"]
        },
        yAxis: {},
        series: [{
          name: '人数',
          type: 'bar',
		  itemStyle:{
			  color: 'cornflowerblue'
		  },
          data: [this.barList.veryPoor,this.barList.disappointed,this.barList.generally,this.barList.satisfy,this.barList.surprise]
        }]
      };
      // 使用刚指定的配置项和数据显示图表。
      myChart.setOption(option);
	    window.onresize = function(){
        myChart.resize()
      }
    }

  },
  mounted(){
    this.$nextTick(function() {
	  this.timer = setInterval(this.scrollAnimate, 1500);
    this.stackCharts();
    this.pieChart();
    this.barCharts();
    })
  }
}
</script>

<style lang="less" scoped>
.marquee-wrap  {
  height: 200px;
  border-radius: 0px;
  background:antiquewhite;
  margin: 0 0;
  overflow: hidden;
  .marquee-list {
    li {
      width: 100%;
      height: 100%;
      text-overflow: ellipsis;
      overflow: hidden;
      white-space: nowrap;
      padding: 0 0px;
      list-style: none;
      line-height: 30px;
      text-align: left;
      color: #0086B3;
      font-size: 18px;
      font-weight: 300;
    }
  }
  .animate-up {
    transition: all 0.5s ease-in-out;
    transform: translateY(-40px);
  }
}



</style>
