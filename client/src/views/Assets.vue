<template>
    <div class="assets">
        <van-tabs v-model:active="activeTab" class="tabHeader" background="var(--color-bg)" swipeable
            @click-tab="changeTabs">
            <!-- 平台资产 -->
            <van-tab title="平台资产"> </van-tab>
            <!-- 理财资产 -->
            <van-tab title="理财资产"> </van-tab>
            <!-- 合约资产 -->
            <van-tab title="合约资产"> </van-tab>
        </van-tabs>
        <div class="content-box">

            <div class="user-money-info">
                <div class="user-money-info-box">
                    <p class="user-money-info-title">
                        <span>账户余额(USDT)</span>
                        <img class="icon" src="@/assets/img/common/yanjin-k.svg" alt="">
                        <img class="icon" src="@/assets/img/common/refresh.svg" alt="">
                    </p>
                    <p class="money">{{ sumCoin }}</p>
                </div>
                <ul class="quick-list">
                    <template v-if="activeTab === 0">
                        <li>
                            <router-link to="/" class="link">
                                <img src="@/assets/img/assets/chongbi.svg" alt="">
                                <span>充币</span>
                            </router-link>
                        </li>
                        <li>
                            <router-link to="/" class="link">
                                <img src="@/assets/img/assets/tibi.svg" alt="">
                                <span>提币</span>
                            </router-link>
                        </li>
                        <li>
                            <router-link to="/swap" class="link">
                                <img src="@/assets/img/assets/dui.svg" alt="">
                                <span>闪对</span>
                            </router-link>
                        </li>
                        <li>
                            <router-link to="/transfer" class="link">
                                <img src="@/assets/img/assets/huazhuan.svg" alt="">
                                <span>划转</span>
                            </router-link>
                        </li>
                    </template>
                    <template v-else>
                        <li>
                            <router-link to="/transfer" class="link">
                                <img src="@/assets/img/assets/huazhuan.svg" alt="">
                                <span>划转</span>
                            </router-link>
                        </li>
                        <li>
                            <router-link to="/" class="link">
                                <img src="@/assets/img/assets/daikuai.svg" alt="">
                                <span>助力贷</span>
                            </router-link>
                        </li>
                    </template>

                </ul>
                <van-loading v-if="loading"
                    style="text-align: center; border-top:1px solid var(--color-border2); padding-top: 20px;"
                    type="spinner" />
                <ul v-else class="wallet-list">
                    <li>
                        <p class="title">资金明细</p>
                        <p class="coin-title">
                            <img src="@/assets/img/common/usdt.svg" alt="">
                            <span>USDT</span>
                        </p>
                        <div class="coin-info">
                            <p class="first">
                                <span class="name">可用</span>
                                <span class="value">{{ primaryWalet.balance }}</span>
                            </p>
                            <p class="second">
                                <span class="name">占用</span>
                                <span class="value">{{ primaryWalet.occupancy }}</span>
                            </p>
                            <p class="thirst">
                                <span class="name">拆合</span>
                                <span class="value">{{ primaryWalet.disassembly }}</span>
                            </p>
                        </div>
                    </li>

                    <li v-if="activeTab ===0" v-for="item, index in coinList" :key="index">
                        <p class="coin-title">
                            <img :src="item.image" alt="">
                            <span>{{ item.code }}</span>
                        </p>
                        <div class="coin-info">
                            <p class="first">
                                <span class="name">可用</span>
                                <span class="value">{{ item.balance }}</span>
                            </p>
                            <p class="second">
                                <span class="name">占用</span>
                                <span class="value">{{ item.occupancy }}</span>
                            </p>
                            <p class="thirst">
                                <span class="name">拆合</span>
                                <span class="value">{{ item.disassembly }}</span>
                            </p>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
        <Navigator />
    </div>
</template>

<script>
import Navigator from '@/components/Navigator.vue'
export default {
    components: {
        Navigator,
    },
    data() {
        return {
            loading: false,
            coinList: [],
            activeTab: 0,
            params: {
                name: 0
            },
            primaryWalet: [],
            sumCoin: '0.00000'
        }
    },
    created() {
        this.getPrimaryWalet()
        this.getOtherWallet()
    },
    methods: {
        getPrimaryWalet() {
            this.loading = true
            this.$wedApi.get('Assets/getPlatformAssetMasterAccount', this.params).then(res => {
                this.loading = false
                if (res.data.code === 1) {
                    this.primaryWalet = res.data.data
                    this.calulateAllCoin()
                }
            })
        },
        changeTabs({ name }) {
            /*
            * name = 0 平台资产
            * name = 1 理财资产
            * name = 2 合约资产
            */
            this.params.name = name;
            if (name === 0) {
                this.getOtherWallet()
            }
            this.getPrimaryWalet()

        },
        getOtherWallet() {
            this.$wedApi.get('Assets/getOtherWallet').then(res => {
                if (res.data.code === 1) {
                    this.coinList = res.data.data
                    this.calulateAllCoin()
                }
            })
        },
        calulateAllCoin() {
            if(this.activeTab ===0){
                this.sumCoin = this.coinList.reduce((sum, coin) => sum + coin.disassembly, parseFloat(this.primaryWalet.disassembly));
            }else {
                this.sumCoin =this.primaryWalet.disassembly
            }
            
        }

    }
}
</script>

<style lang="scss" scoped>
.assets {
    .tabHeader {
        position: fixed;
        width: 100%;
        max-width: 540px;
    }

    .content-box {
        overflow-y: scroll;
        padding-top: 44px;
        padding-bottom: 48px;
    }

    .user-money-info {
        .user-money-info-box {
            padding: 3rem 1.5rem;

            .user-money-info-title {
                display: flex;
                margin-bottom: 2rem;
                align-items: center;
                color: var(--color-text2);

                .icon {
                    width: 1.4rem;
                    height: 1.4rem;

                    &:nth-child(2) {
                        margin: 0 1.5rem;
                    }
                }
            }

            .money {
                font-size: 3rem;
            }
        }

        .quick-list {
            display: grid;
            text-align: center;
            grid-template-columns: repeat(4, 1fr);



            li {
                margin-bottom: 2rem;

                .link {
                    display: flex;
                    flex-direction: column;
                    align-items: center;


                    img {
                        margin-bottom: .5rem;
                    }
                }


            }
        }

        .wallet-list {
            li {
                padding: 1.5rem;
                border-top: 1px solid var(--color-border2);

                p.title {
                    font-size: 1.6rem;
                    font-weight: bold;
                    margin-bottom: 1.5rem;
                }

                p.coin-title {
                    display: flex;
                    align-items: center;

                    img {
                        width: 2rem;
                        height: 2rem;
                        margin-right: 1rem;
                    }

                    span {
                        font-weight: bold;
                    }
                }

                .coin-info {
                    display: flex;
                    justify-content: space-between;

                    p {
                        display: flex;
                        flex-direction: column;

                        .name {
                            padding: 1.5rem 0;
                            color: var(--color-text2);
                            font-size: 1.2rem;
                        }

                        .value {
                            font-weight: bold;
                        }
                    }

                    p.second {
                        text-align: center;
                    }

                    p.thirst {
                        text-align: right;
                    }
                }
            }
        }
    }

}
</style>