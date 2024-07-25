<template>
    <div class="pledge-detail">
        <van-nav-bar :title="headerTitle" left-text="返回" left-arrow @click-left="$router.go(-1)" />
        <div class="pledge-detail-content">
            <div class="content1">
                <div class="top">
                    <p>
                        <span>申请金额</span>
                        <span class="curency">(USDT)</span>
                    </p>
                    <router-link class="link" to="/Recharge">存入金额</router-link>
                </div>


                <div class="ipt">
                    <input type="text" placeholder="购买金额" v-model="amount">
                    <p @click="investAll">最大</p>
                </div>
                <div class="shouyi">
                    <p class="detail">
                        <span class="name">限额</span>
                        <span class="value">{{ `${shouyi.min_invest}~${shouyi.max_invest}` }}</span>
                    </p>
                    <p class="detail">
                        <span class="name">日收益率</span>
                        <span class="value">{{ `${shouyi.min_yield}%~${shouyi.max_yield}%` }}</span>
                    </p>
                    <p class="detail">
                        <span class="name">周期(天数)</span>
                        <span class="value">{{ shouyi.day }}</span>
                    </p>
                </div>
            </div>
            <div class="content2">
                <p class="detail">
                    <span class="name">可用余额</span>
                    <span class="value">{{ userCoin }} USDT</span>
                </p>
                <p class="detail">
                    <span class="name">可购次数</span>
                    <span class="value">{{ shouyi.available }}</span>
                </p>
                <div @click="buyPledge" v-if="!loadding" class="buy-btn">
                    确定
                </div>
                <div v-else class="buy-btn loading">
                    <van-loading size="18" color="#fff" />
                    确定
                </div>

            </div>
        </div>
    </div>
</template>

<script>

import { showToast } from 'vant';
export default {
    data() {
        return {
            headerTitle: '详情',
            userCoin: 167169.84,
            amount: '',
            loadding: false,
            shouyi: {
                id: 1,
                min_invest: 2000,
                max_invest: 15000,
                day: 7,
                available: 1,
                min_yield: 2,
                max_yield: 4.75,
            }
        }
    },
    created() {
        this.getDetail()
    },
    methods: {
        getDetail() {
            // this.$axios.get('/api/pledge/detail', {
            //     params: {
            //         id: this.shouyi.id
            //     }
            // }).then(res => {
            //     this.shouyi = res.data
            // })


        }
        , buyPledge() {
            const params = {
                id: this.shouyi.id,
                amount: this.amount
            }
            this.loadding = true
            // this.$axios.post('/api/pledge/buy', {
            //     id: this.shouyi.id,
            //     amount: this.amount
            // }).then(res => {
            //     this.$router.push('/Pledge')
            // })
        },
        investAll() {
            if (this.userCoin < this.shouyi.min_invest) {
                this.amount = 0
                return
            } else if (this.userCoin > this.shouyi.max_invest) {
                this.amount = this.shouyi.max_invest

            }
            else {
                this.amount = this.userCoin
            }

        }
    }
}
</script>

<style lang="scss" scoped>
.pledge-detail {
    .pledge-detail-content {
        padding: 2rem 1.5rem;

        .content1 {
            padding-bottom: 2rem;
            border-bottom: .2rem solid var(--color-border);

            .top,
            .ipt {
                display: flex;
                justify-content: space-between;

            }

            .link,
            .ipt p {
                color: var(--color-icon);

            }

            .ipt {
                margin: 1rem 0;
                padding: 1rem 1.5rem;
                border: 1px solid var(--color-border);

                input {
                    border: none;
                    outline: none;
                }
            }

            .shouyi {
                display: flex;
                justify-content: space-between;
                padding-top: 2rem;

                .detail {
                    display: flex;
                    flex-direction: column;
                    text-align: left;

                    .name {
                        margin-bottom: 1rem;
                        color: var(--color-text3);
                    }

                    &:last-child {
                        text-align: right;
                    }

                }
            }
        }

        .content2 {
            padding-top: 2rem;

            .detail {
                margin-bottom: 3rem;
                display: flex;
                justify-content: space-between;

                .name {
                    color: var(--color-text3);
                }
            }

            .buy-btn {
                background: var(--color-icon);
                color: var(--color-text4);
                text-align: center;
                line-height: 4rem;
                border-radius: .4rem;
                &.loading {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                }
            }
        }
    }
}
</style>