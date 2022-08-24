<template>
	<div>
	  <el-breadcrumb separator-class="el-icon-arrow-right">
	    <el-breadcrumb-item :to="{path:'/home'}">首页</el-breadcrumb-item>
	    <el-breadcrumb-item>健康数据检测</el-breadcrumb-item>
	  </el-breadcrumb>
  <el-card style="height: 100%">
    <el-row>
      <el-col style="width: 50%;height: 300px;">
        <label>老人姓名：</label>
        <el-select placeholder="请选择老人" v-model="queryInfo.olderId" @change="getInternalList"
                   clearable filterable style="width: 50%; padding-right: 10px">
          <el-option
              v-for="item in olderDrop"
              :key="item.olderId"
              :label="item.olderName"
              :value="item.olderId">
          </el-option>
        </el-select>
        <el-image :src="img" style="height: 300px;width: 400px;margin-top: 20px"></el-image>
      </el-col>
      <el-col id="drawLine" style="width: 50%;height: 400px;"></el-col>
    </el-row>
    <el-row style="margin-top: 100px;">
      <el-col id="line" style="width: 50%;height: 400px;"></el-col>
      <el-col id="id" style="width: 50%;height: 400px;"></el-col>
    </el-row>
  </el-card>
  </div>
</template>
<script>

export default {
  name: 'HealthyData',
  data() {
    return {
      queryInfo: {
        orderId: "",
      },
      olderDrop: [{
        orderId:"",
        orderName:""
      }],
      internalList: [{
        heartRate: "",
        bloodPressure: "",
        bloodSugar: "",
        bloodFat: "",
        pulse: "",
        liverFunction: "",
        renalFunction: "",
        bloodRoutine: "",
        urinalysis: "",
        CDultrasound: "",
        physician: "",
        photo:""
      }],
      dataX: [],
      dataY: [],
      dataHeightY: [],
      dataLowY: [],
      dataFatY:[],
      dataSugarY:[],
      img:"",
      token:""
    }
  },
  created() {
    this.selectOlderDrop();
  },
  methods: {
    //获取内科信息
    async getInternalList() {
      this.dataX = [];
      this.dataY = [];
      this.dataHeightY = [];
      this.dataLowY = [];
      const {data: res} = await this.$http.get("/healthy/internalList?olderId=" + this.queryInfo.olderId)
      this.internalList = res;
      this.img = require('@/' + this.internalList[0].photo)
      for (let i = 0; i < this.internalList.length; i++) {
        this.dataX.push(this.$moment(this.internalList[i].createTime).format('YYYY/MM'))
        this.dataY.push(this.internalList[i].heartRate)
        this.dataHeightY.push(this.internalList[i].bloodPressure.split("/")[0])
        this.dataLowY.push(this.internalList[i].bloodPressure.split("/")[1])
        this.dataFatY.push(this.internalList[i].bloodFat)
        this.dataSugarY.push(this.internalList[i].bloodSugar)
      }
      this.myLine();
      this.myEcharts();
      this.drawLine();
    },
    async selectOlderDrop() {
      this.token = window.sessionStorage.getItem("roleId")
      if(this.token === '4'){
        this.queryInfo.userId = window.sessionStorage.getItem("id")
      }else{
        this.queryInfo.userId = ''
      }
      const {data: res} = await this.$http.get("/healthy/olderDrop?userId=" + this.queryInfo.userId);
      this.olderDrop = res;
      this.queryInfo.olderId = this.olderDrop[0].olderId
      await this.getInternalList()
    },
    drawLine() {
      // 基于准备好的dom，初始化echarts实例
      const myChart = this.$echarts.init(document.getElementById('drawLine'));
      // 指定图表的配置项和数据
      const option = {
        title: {
          text: '血糖，血脂变化图'
        },
        toolbox: {
          feature: {
            saveAsImage: {}
          }
        },
        tooltip: {},
        legend: {
          data: ['血糖','血脂']
        },
        xAxis: {
          boundaryGap: false,
          data: this.dataX,
          name: '日期'
        },
        yAxis: {
          name: 'mmol/L'
        },
        visualMap: [{
          show: false,
          dimension: 1,
          seriesIndex:0,
          pieces: [{gte: 4.1, lte: 6.1, color: '#2a5caa'}],
          outOfRange: {
            color: 'red'
          }
          },
          {
            show: false,
            dimension: 1,
            seriesIndex:1,
            pieces: [{gte: 2.6, lte: 3.9, color: '#7fb80e'}],
            outOfRange: {
              color: 'red'
            }
          }
          ],
        series: [{
          name: '血糖',
          type: 'line',
          data: this.dataSugarY,
        },
          {
            name: '血脂',
            type: 'line',
            data: this.dataFatY,
          }
        ]
      };
      // 使用刚指定的配置项和数据显示图表。
      myChart.setOption(option, true);
      window.onresize = function(){
        myChart.resize()
      }
    },


    myEcharts() {
      // 基于准备好的dom，初始化echarts实例
      const myChart = this.$echarts.init(document.getElementById('id'));

      // 指定图表的配置项和数据
      const option = {
        title: {
          text: '血压变化趋势图'
        },
        tooltip: {
          trigger: 'axis'
        },
        legend: {},
        toolbox: {
          show: true,
          feature: {
            dataZoom: {
              yAxisIndex: 'none'
            },
            dataView: {readOnly: false},
            magicType: {type: ['line', 'bar']},
            restore: {},
            saveAsImage: {}
          }
        },
        xAxis: {
          type: 'category',
          boundaryGap: false,
          data: this.dataX,
          name: "日期"
        },
        yAxis: {
          type: 'value',
          name: 'mmhg'
        },
        series: [
          {
            name: '收缩压',
            type: 'line',
            data: this.dataHeightY,
            markPoint: {
              data: [
                {type: 'max', name: 'Max'},
                {type: 'min', name: 'Min'}
              ]
            },
            markLine: {
              data: [{type: 'average', name: 'Avg'}]
            },
            itemStyle: {
              color: "#f47920"
            },
          },
          {
            name: '舒张压',
            type: 'line',
            data: this.dataLowY,
            markPoint: {
              data: [
                {type: 'max', name: 'Max'},
                {type: 'min', name: 'Min'}]
            },
            markLine: {
              data: [
                {type: 'average', name: 'Avg'},
                [
                  {
                    symbol: 'none',
                    x: '90%',
                    yAxis: 'max'
                  },
                  {
                    symbol: 'circle',
                    label: {
                      position: 'start',
                      formatter: 'Max'
                    },
                    type: 'max',
                    name: '最高点'
                  }
                ]
              ]
            },
            itemStyle: {
              color: '#90d7ec'
            },
          }
        ]
      };
      // 使用刚指定的配置项和数据显示图表。
      myChart.setOption(option);
      window.onresize = function(){
        myChart.resize()
      }
    },

    myLine() {
      // 基于准备好的dom，初始化echarts实例
      const myChart = this.$echarts.init(document.getElementById('line'));
      // 指定图表的配置项和数据
      const option = {
        title: {
          text: '心率变化图'
        },
        toolbox: {
          feature: {
            saveAsImage: {}
          }
        },
        tooltip: {},
        legend: {
          data: ['心率']
        },
        xAxis: {
          boundaryGap: false,
          data: this.dataX,
          name: '日期'
        },
        yAxis: {
          name: 'BPM'
        },
        visualMap: {
          show: false,
          dimension: 1,
          pieces: [{gte: 70, lte: 150, color: 'green'}],
          outOfRange: {
            color: 'red'
          }
        },
        series: [{
          name: '心率',
          type: 'line',
          data: this.dataY,
          smooth:true,
          markArea:{
            itemStyle:{
              color:'rgba(255, 173, 177, 0.4)'
            },
            data:[
              [
                {
                  name: '正常范围',
                  yAxis: '70'
                },
                {
                  yAxis: '150'
                }
              ]
            ]
          }

        }
        ]
      };
      // 使用刚指定的配置项和数据显示图表。
      myChart.setOption(option, true);
      window.onresize = function(){
        myChart.resize()
      }
    },
  },

  //调用
  mounted() {
    this.$nextTick(function () {
      this.drawLine();
      this.myEcharts()
      this.myLine()
    })
  }
}
</script>
<style lang="less" scoped>
.el-breadcrumb{
	margin-bottom: 15px;
	font-size: 17px;
}
* {
  margin: 0;
  padding: 0;
  list-style: none;
}
.el-header, .el-footer {
  background-color: #B3C0D1;
  color: #333;
  text-align: center;
  line-height: 60px;
}

.el-aside {
  background-color: #D3DCE6;
  color: #333;
  text-align: center;
  line-height: 200px;
}

.el-main {
  background-color: #E9EEF3;
  color: #333;
  text-align: center;
  line-height: 160px;
}

body > .el-container {
  margin-bottom: 40px;
}

.el-container:nth-child(5) .el-aside,
.el-container:nth-child(6) .el-aside {
  line-height: 260px;
}

.el-container:nth-child(7) .el-aside {
  line-height: 320px;
}
</style>
