import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from '../components/Login.vue'
import Home from '../components/Home.vue'
import Welcome from "../components/Welcome.vue"
import UserList from "../components/User/UserList.vue"
import WorkerList from "@/components/admin/WorkerList"
import CommunityList from "@/components/community/CommunityList"
import HealthyData from "@/components/healthfiles/HealthyData"
import Healthiness from "@/components/healthfiles/Healthiness";
import OlderInfoList from "@/components/User/OlderInfoList";
import HealthyInfo from "@/components/healthfiles/HealthyInfo";
import Knowledge from "../components/knowledge/Knowledge.vue";
import ActiveList from "@/components/active/ActiveList";
import medical from "@/components/mutualAid/medical";
import Purchasing from "@/components/mutualAid/Purchasing";
import repast from "@/components/mutualAid/repast";
import Pharmacy from "@/components/mutualAid/Pharmacy/Pharmacy";
import PharmacyInfo from "@/components/mutualAid/Pharmacy/PharmacyInfo";
import Appointment from "@/components/mutualAid/Pharmacy/Appointment";
import ShoppingMall from "@/components/mutualAid/shoppingMall";
import foodBusiness from "@/components/mutualAid/Food/foodBusiness";
import Personal from "@/components/Personal";
Vue.use(VueRouter)

const routes = [
  {
    path:"/",
    redirect:'/login',
  },
  {
    path:"/login",
    component: Login,

  },
  {
    path:"/home",
    component:Home,
    redirect: "/welcome",
    children:[
      {
        path:"/welcome",
        component: Welcome,
      },
      {
        path:"/user",
        component: UserList,
      },
      {
        path:"/worker",
        component: WorkerList,
      },
      {
        path:"/older",
        component: OlderInfoList,
      },
      {
        path:"/community",
        component: CommunityList,
      },
      {
        path:"/healthyData",
        component: HealthyData,
      },
      {
        path:"/files",
        component: Healthiness,
      },
      {
        path:"/healthyInfo",
        component: HealthyInfo,
      },
	  {
        path:"/knowledge",
        component: Knowledge,
	  },
      {
        path:"/active",
        component: ActiveList,
      },
      {
        path:"/medicine",
        component: medical,
      },
      {
        path:"/shop",
        component: Purchasing,
      },
      {
        path:"/food",
        component: repast,
      },
      {
        path:"/pharmacy",
        component: Pharmacy,
      },
      {
        path:"/pharmacyInfo",
        component: PharmacyInfo,
      },
      {
        path:"/appointment",
        component: Appointment,
      },
      {
        path:"/shoppingMall",
        component: ShoppingMall,
      },
      {
        path: "/foodBusiness",
        component: foodBusiness,
      },
      {
        path:"/personal",
        component: Personal,
      }
    ]
  },
]


const router = new VueRouter({
  routes
})

// router.beforeEach((to,from,next)=>{
//   const role = window.sessionStorage.getItem("roleId")
//   if(to.meta.isLogin){ //判断页面是否需要登录才可操作
//       if(to.meta.roles.includes(role)){//判断登录用户的权限是否满足meta对象中的roles的要求
//         next()
//       }else {
//         alert('您没有权限进入页面！')
//         this.router.push('/login')
//       }
//     }else {
//       alert('请登录之后再操作！')
//       this.router.push('/login')
//     }
// })


//出现问题时使用
const originalPush = VueRouter.prototype.push
VueRouter.prototype.push = function push(location, onResolve,onReject){
  if(onResolve || onReject) return originalPush.call(this,location,onResolve,onReject)
  return originalPush.call(this,location).catch(err => err)
}

export default router
