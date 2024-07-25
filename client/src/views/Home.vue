<template>
  <main class="home-page">
    <header>
      <div class="logo"><img src="@/assets/img/tmp/logo.png" alt=""></div>
      <div class="head-right">
        <div class="action" v-if="!$store.state.isLogin">
          <router-link :to="{ name: 'Auth', params: { task: 'login' } }">登录</router-link>
          <router-link :to="{ name: 'Auth', params: { task: 'register' } }">注册</router-link>
        </div>
        <img v-else @click="goPath('user')" src="@/assets/img/home/user.svg" alt=""
          style="width: 2.4rem; height: 2.4rem;">
        <UserInfo v-model:show="showUserInfo" />
      </div>
    </header>
    <div class="slider">
      <van-swipe class="my-swipe" :autoplay="3000" indicator-color="white">
        <van-swipe-item v-for="item, index in sliders" :key="index"><a :href="item.link"><img :src="item.image"
              :alt="item.name"></a></van-swipe-item>

      </van-swipe>
    </div>

    <div class="nav-menu">
      <ul class="top-coin">
        <li v-for="item, index in topCoin" @click="goTrade(item.symbol)">
          <router-link to="#">
            <p class="name">{{ item.symbol.replace('USDT', '/USDT') }}</p>
            <p class="percent" :class="{ red: parseFloat(item.priceChangePercent) <= 0 }">
              {{ parseFloat(item.priceChangePercent) < 0 ? parseFloat(item.priceChangePercent).toFixed(2) : '+' +
          parseFloat(item.priceChangePercent).toFixed(2) }}%</p>
                <p class="price" :class="{ red: parseFloat(item.priceChangePercent) <= 0 }">
                  {{ item.hasOwnProperty('curDayClose') ?
          parseFloat(item.curDayClose).toFixed(2) : parseFloat(item.openPrice).toFixed(2) }}</p>
          </router-link>
        </li>

      </ul>
      <ul class="menu">
        <li v-for="item, index in navs" :key="index">
          <router-link :to="item.link">
            <img :src="item.icon" alt="">
            <p>{{ item.name }}</p>
          </router-link>
        </li>
      </ul>
    </div>
    <div class="marquee">
      <van-notice-bar left-icon="volume-o" text="无论我们能活多久，我们能够享受的只有无法分割的此刻，此外别无其他。" />
    </div>
    <div class="quick-select">
      <div class="left">
        <p @click="goPath('/recharge')">
          <img src="@/assets/img/home/mengbanzu13.svg" alt="">
          <span>快速充币</span>
        </p>
        <p @click="goPath('/withdraw')">
          <img src="@/assets/img/home/zu29.svg" alt="">
          <span>快速提币</span>
        </p>
      </div>
      <div @click="goPath('kefu')" class="right">
        <img src="@/assets/img/home/zu447.svg" alt="">
        <span>在线客服</span>
      </div>
    </div>
    <CoinList />
    <Navigator />
  </main>
</template>

<script>

import banner from '@/assets/img/tmp/banner2.png'
import icon1 from '@/assets/img/home/defi.png'
import icon2 from '@/assets/img/home/mine.png'
import icon3 from '@/assets/img/home/loan.png'
import icon4 from '@/assets/img/home/convert.png'
import icon5 from '@/assets/img/home/promotion.png'
import icon6 from '@/assets/img/home/contract.png'
import icon7 from '@/assets/img/home/standard.png'
import icon8 from '@/assets/img/home/spot.png'
import icon9 from '@/assets/img/home/activiti.png'
import icon10 from '@/assets/img/home/buy.png'
import icon11 from '@/assets/img/home/planning.png'

import CoinList from '@/components/CoinList.vue'
import Navigator from '@/components/Navigator.vue'
import UserInfo from '@/components/UserInfo.vue'
export default {
  components: {
    CoinList,
    Navigator,
    UserInfo
  },
  data() {
    return {
      socket: null,
      isLogin: false,
      showUserInfo: false,
      sliders: [
        {
          image: banner,
          link: '#',
          coin: 'banner'
        },
        {
          image: banner,
          link: '#',
          coin: 'banner'
        },
        {
          image: banner,
          link: '#',
          coin: 'banner'
        },
        {
          image: banner,
          link: '#',
          coin: 'banner'
        },
        {
          image: banner,
          link: '#',
          coin: 'banner'
        },
        {
          image: banner,
          link: '#',
          coin: 'banner'
        },
      ],
      navs: [
        {
          link: '/defi',
          name: 'DeFi挖矿',
          icon: icon1
        },
        {
          link: '/pledge',
          name: '质押挖矿',
          icon: icon2
        },
        {
          link: '/loan',
          name: '助力贷',
          icon: icon3
        },
        {
          link: '#',
          name: '闪兑',
          icon: icon4
        },
        {
          link: '/agentCenter',
          name: '推广中心',
          icon: icon5
        },
        {
          link: '/tradeSecond',
          name: '秒合约',
          icon: icon6
        },
        {
          link: '#',
          name: 'U本拉合约',
          icon: icon7
        },
        {
          link: '#',
          name: '币币交易',
          icon: icon8
        },
        {
          link: '#',
          name: '福利活动',
          icon: icon9
        },
        {
          link: '#',
          name: '申购',
          icon: icon10
        },
        {
          link: '/productPlan',
          name: '产品规则',
          icon: icon11
        },



      ],
      topCoin: [
        {
          symbol: 'BTCUSDT',
          curDayClose: 3387.97,
          priceChangePercent: 1.12
        },
        {
          symbol: 'ETHUSDT',
          curDayClose: 61556.11,
          priceChangePercent: 1.12
        },
        {
          symbol: 'LTCUSDT',
          curDayClose: 71.12,
          priceChangePercent: 0.70
        }
      ]

    }
  },
  watch: {
    showUserInfo(val) {
      this.checkLogin()
    }
  },
  created() {
    this.renderTopCoin()
    this.checkLogin()

  }
  , methods: {
    checkLogin() {
      const isLogin = JSON.parse(localStorage.getItem('isLogin'));
      if (isLogin) {
        this.$store.commit('login');
      } else {
        this.$store.commit('logout');
      }
      this.isLogin = this.$store.state.isLogin;
    },
    async renderTopCoin() {
      try {
        const res = await this.$wedApi.get('/Guest/HomeTopCoin');
        if (res.data.code === 1) {
          this.topCoin = res.data.data;
        } else {
          console.error('Failed to fetch coin list:', res.info);
        }
      } catch (error) {
        console.error('API request failed:', error);
      }
      this.$socket.on('ticker', (ticker) => {
        const index = this.topCoin.findIndex(t => t.symbol === ticker.symbol);
        if (index !== -1) {
          this.topCoin.splice(index, 1, ticker);
        }
      });
    },
    goTrade(symbol) {
      this.$store.commit('setCoinSymbolDefault', symbol)
      this.$router.push(`/trade/${symbol}`);
    },
    // setupWebSocket() {
    //   this.closeWebSocket();
    //   this.socket = new WebSocket('ws://localhost:3000');
    //   this.socket.onmessage = (event) => {
    //     const ticker = JSON.parse(event.data);
    //     const index = this.coinList.findIndex(t => t.symbol === ticker.symbol);
    //     if (index !== -1) {
    //       this.coinList.splice(index, 1, ticker);
    //     } else {
    //       this.coinList.push(ticker);
    //     }
    //     const topIndex = this.topCoin.findIndex(t => t.symbol === ticker.symbol);
    //     if (topIndex !== -1) {
    //       this.topCoin.splice(topIndex, 1, ticker);
    //     }
    //   };

    //   this.socket.onclose = () => {
    //     console.log('WebSocket connection closed');
    //     setTimeout(() => {
    //       this.setupWebSocket();
    //     }, 5000);
    //   };
    //   this.socket.onerror = (error) => {
    //     console.error('WebSocket error:', error);
    //     this.closeWebSocket();
    //   };
    // },
    // closeWebSocket() {
    //   if (this.socket) {
    //     this.socket.close();
    //     this.socket = null;
    //   }
    // },
    goPath(path) {
      switch (path) {
        case 'kefu':

          break;

        case 'user':
          this.showUserInfo = !this.showUserInfo;
          break;
        default:
          this.$router.push(path)
          break;
      }

    },
  },

  beforeDestroy() {
    // this.closeWebSocket();
  },
}
</script>

<style lang="scss" scoped>
.home-page {
  padding-bottom: 5.2rem;

  header {
    height: 4.4rem;
    background-color: var(--color-bg);
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: .4rem .8rem;

    .logo {
      width: 12rem;
      height: 4rem;

      img {
        display: block;
        width: 100%;
        height: 100%;
        object-fit: contain;
      }
    }

    .head-right {
      display: flex;
      align-items: center;

      .action {
        display: flex;

        a {
          background-color: var(--color-buy);
          color: var(--color-text4);
          border-radius: 0.4rem;
          padding: .2rem .6rem;
          margin-right: .4rem;
          display: block;
        }
      }

      .mode {
        line-height: 2.2rem;
        margin-left: .8rem;

        .icon {
          margin-top: .2rem;
          font-size: 2.2rem;
        }
      }

    }
  }

  .slider {
    .my-swipe .van-swipe-item {
      height: 8%;
      overflow: hidden;

      img {
        width: 100%;
        height: 100%;
        object-fit: cover;
      }
    }
  }

  .nav-menu {
    // position: relative;
    // padding-top: 6rem;

    .top-coin {
      // position: absolute;
      display: flex;
      padding: 1rem 0;
      justify-content: space-around;
      width: calc(100% - 4rem);
      margin: 0 auto;
      // top: 0;
      // left: 50%;
      // transform: translate(-50%, -50%);
      background-color: var(--color-defaultbg);
      border-radius: 1rem;
      box-shadow: 0 0 .2rem .1rem #0000001a;

      li {
        padding: 0 1rem;

        a {
          text-align: center;

          p {
            color: var(--color-buy);

            &:first-child {
              color: var(--color-text);

            }

            &:last-child {
              font-weight: bold;
            }

            &.red {
              color: var(--color-sell);
            }

          }

        }
      }
    }

    .menu {
      display: grid;
      grid-template-columns: repeat(4, 1fr);

      li {
        padding: 1rem;

        a {
          display: flex;
          flex-direction: column;
          font-size: 1.4rem;
          align-items: center;

          img {
            width: 2.1rem;
            height: 2.1rem;
          }

          p {
            margin-top: .5rem;
          }
        }

      }
    }
  }

  .marquee {
    font-size: 1.6rem;
  }

  .quick-select {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 2rem 1.5rem;

    .left {
      flex: 1;
      display: flex;

      p {
        flex: 1;
        display: flex;
        align-items: center;
        justify-content: center;
        border: .1rem solid var(--color-border);
        padding: 1rem;
        margin-right: 1rem;
        border-radius: .5rem;

        img {
          margin-right: 1rem;
        }
      }
    }

    .right {
      display: flex;
      flex-direction: column;
      align-items: center;

      span {
        font-size: 1.2rem;
      }
    }
  }


}
</style>
