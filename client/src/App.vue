<template>
  <div>
    <router-view></router-view>
  </div>
</template>

<script>
import { showDialog } from 'vant';

export default {
  data() {
    return {

    }
  },
  created() {
    const isLogin = JSON.parse(localStorage.getItem('isLogin'));
    if(isLogin) {
      this.$store.commit('login');
    }
  },
  mounted() {
    this.$socket.on('connect', () => {
      console.log('Connected to server');
      const isLogin = JSON.parse(localStorage.getItem('isLogin'));
      const userInfo = JSON.parse(localStorage.getItem('userInfo'));
      const token = localStorage.getItem('token');
      if (isLogin) {
        this.$socket.emit('updateUserInfo', { ...userInfo, token: token });
      }
    });

    this.$socket.on('notify', (data) => {
      if (data.type === 'loginError' && data.code == 100) {
        showDialog({
          title: '温馨提示',
          message: '账号在其他设备登录，请重新登录',
        }).then(() => {
          localStorage.removeItem('isLogin');
          localStorage.removeItem('token');
          this.$store.commit('logout');
        });
      }
    });
    // Lắng nghe sự kiện 'disconnect'
    this.$socket.on('disconnect', () => {
      console.log('Disconnected from server');
    });

  },
  beforeDestroy() {
    // this.$store.dispatch('closeWebSocket');
  },
  methods: {

  },
}
</script>

<style lang="scss" scoped></style>
