import Vue from 'vue'
import App from './App.vue'
import router from './router'
import './plugins/element.js'
import './assets/css/global.css'
import md5 from 'md5.js'
//引入iconfont
import './assets/font/iconfont.css'
// 导入axios
import axios from 'axios'
import moment from "moment"
import echarts from 'echarts'
Vue.prototype.$echarts = echarts
//时间转化
Vue.prototype.$moment = moment;
// 挂载axios 到Vue的原型prototype的$http
Vue.prototype.$http = axios
// 设置请求的根路径
axios.defaults.baseURL = "http://localhost:9001"
Vue.config.productionTip = false
//md5加密
Vue.prototype.$md5 = md5;



new Vue({
  router,
  render: h => h(App)
}).$mount('#app')

