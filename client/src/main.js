
import 'vant/lib/index.css'
import './assets/base.css'

import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import Vant from 'vant'
import io from 'socket.io-client'
const socket = io('http://localhost:3000')
import apiService from './services/api/apiService'
async function appInitallySetting() {
    await apiService.get('Guest/getConfig').then(res => {
        if (res.data.code === 1) {
            sessionStorage.setItem('config',JSON.stringify(res.data.data))
            const app = createApp(App)
            app.config.globalProperties.$socket = socket
            app.config.globalProperties.$wedApi = apiService
            app.use(router)
            app.use(store)
            app.use(Vant)
            app.mount('#app')
        } else {
            alert('加载系统配置错误请刷新重试')
        }
    })


}
appInitallySetting()
