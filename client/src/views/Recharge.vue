<template>
    <div class="recharge">
        <van-nav-bar :title="headerTitle" left-text="返回" left-arrow @click-left="$router.go(-1)" />
        <div class="recharge-content">
            <div class="title">币种列表</div>
            <ul class="recharge-list">
                <li @click="goPath(coin.id)" v-for="coin, index in list" :key="index">
                    <p class="left">
                        <img :src="coinImg[coin.symbol]" alt="">
                        <span>{{ coin.name }}</span>
                    </p>
                    <van-icon name="arrow" />
                </li>
            </ul>
        </div>

    </div>
</template>

<script>
import BTC from '@/assets/img/coin/BTC.png'
import ETH from '@/assets/img/coin/ETH.png'
import XRP from '@/assets/img/coin/XRP.png'
import LTC from '@/assets/img/coin/LTC.png'
import BNB from '@/assets/img/coin/BNB.png'
import MATIC from '@/assets/img/coin/MATIC.png'
import SOL from '@/assets/img/coin/SOL.png'
import DOGE from '@/assets/img/coin/DOGE.png'
import TRX from '@/assets/img/coin/TRX.png'
import BLZ from '@/assets/img/coin/BLZ.png'
import USDC from '@/assets/img/coin/USDC.png'
import LEVER from '@/assets/img/coin/LEVER.jpeg'
import USDT from '@/assets/img/coin/usdt.svg'

export default {
    data() {
        return {
            headerTitle: '快捷充币',
            coinImg: { BTC, ETH, XRP, LTC, BNB, MATIC, SOL, DOGE, TRX, BLZ, USDC, LEVER, USDT },
            list: [
                {
                    name: 'USDT-TRC20',
                    symbol: 'USDT',
                    id: 1,
                },
                {
                    name: 'USDT-ERC20',
                    symbol: 'USDT',
                    id: 2,
                },
                {
                    name: 'USDT-BS20',
                    symbol: 'USDT',
                    id: 3,
                },
                {
                    name: 'USDC-ERC20',
                    symbol: 'USDC',
                    id: 4,
                },
                {
                    name: 'USDC-BSC20',
                    symbol: 'USDC',
                    id: 5,
                },
                {
                    name: 'USDC-TRC20',
                    symbol: 'USDC',
                    id: 6,
                },
                {
                    name: 'ETH',
                    symbol: 'ETH',
                    id: 7,
                },
                {
                    name: 'BTC',
                    symbol: 'BTC',
                    id: 8,
                },
                {
                    name: 'TRX',
                    symbol: 'TRX',
                    id: 9,
                },

            ],
        }
    },
    methods: {
        goPath(id) {
            this.$router.push(`/rechargeApply/${id}`)
        }
    }
}
</script>

<style lang="scss" scoped>
.recharge {
    .recharge-content {
        padding: 2rem 1.5rem 0;

        .title {
            margin-bottom: 2rem;
        }

        .recharge-list {
            li {
                display: flex;
                justify-content: space-between;
                margin-bottom: 1rem;
                padding: 1rem 0;
                .left {
                    display: flex;
                    align-items: center;
                    img {
                        width: 2rem;
                        height: 2rem;
                        margin-right: 1rem;
                    }
                }
            }
        }

    }
}
</style>