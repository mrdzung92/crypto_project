<template>
    <div class="swap">
        <van-nav-bar :title="headerTitle" left-text="返回" left-arrow @click-left="$router.go(-1)" />
        <div class="coin">
            <p>{{ params.from.balance }}</p>
            <span>可用余额(USDT)</span>
        </div>
        <div class="exchange">
            <div class="from">
                <div class="left">
                    <input type="text" placeholder="请输入">
                </div>
                <div class="right">
                    <p class="all">全部</p>
                    <p>|</p>
                    <p @click="displayPopup('from')" class="coin-name">
                        <span>{{ params.from.code }}</span>
                        <img :src="params.from.image" alt="">
                    </p>
                </div>
            </div>
            <div class="exchange-btn">
                <img src="@/assets/img/common/duihuan.svg" alt="">
            </div>
            <div class="to">
                <p class="left">0.00</p>
                <p @click="displayPopup('to')" class="right">
                    <span>{{ params.to.code }}</span>
                    <img :src="params.to.image" alt="">
                </p>
            </div>
            <div class="infomation">
                <span class="text">今日汇率:</span>
                <span>1USDT&nbsp;≈&nbsp;7.36377025TRX</span>
            </div>
            <div class="btn">
                <p>确定</p>
            </div>
        </div>
        <van-popup v-model:show="showPopup" position="bottom" round :style="{ height: '40%' }">
            <ul class="pop-list">
                <li @click="selectItem(index)" :class="{ first: index === 0 }" v-for="item, index in popUpList"
                    :key="index">
                    <p>
                        <img :src="item.image" alt="">
                        <span>{{ item.code }}</span>
                    </p>
                </li>
            </ul>
        </van-popup>

    </div>
</template>

<script>
import usdtImg from '@/assets/img/common/usdt.svg'
export default {
    data() {
        return {
            headerTitle: '闪对',
            showPopup: false,
            coinList: [],
            popUpList: [],
            params: {
                from: {
                    code: "USDT",
                    image: usdtImg,
                    balance: "0.00000"
                },
                to: {
                    code: "BTC",
                    image: usdtImg,
                    balance: "0.00000"
                }
            },
            popUpPosition: 'from',
            coin: 5876.07
        }
    },
    created() {
        this.getCoinInfo()
    },
    methods: {
        getCoinInfo() {
            this.$wedApi.get('Swap/getCoinInfo').then(res => {
                if (res.data.code === 1) {
                    this.coinList = res.data.data
                    this.popUpList = res.data.data
                    this.params.from = this.coinList[0];
                    this.params.from.image = usdtImg
                    this.params.to = this.coinList[1];
                    this.getCoinPairPrice()
                }
            })
        },
        selectItem(index) {
            console.log(this.popUpPosition)
            if (this.popUpPosition === 'from') {
                this.params.from = this.popUpList[index]
                if (this.params.from.code === 'USDT') {
                    this.params.from.image = usdtImg
                }

            } else {
                this.params.to = this.popUpList[index]
                if (this.params.to.code === 'USDT') {
                    this.params.to.image = usdtImg
                }
            }
            this.showPopup = false
            this.getCoinPairPrice()

        },
        getCoinPairPrice() {
            const params = {
                from:this.params.from.code,
                to:this.params.to.code
            }
                
            
         
            this.$wedApi.get('Swap/getCoinPairPrice', params).then(res => {
                console.log(res.data.data)
            })
        },
        displayPopup(position) {
            if (position === 'from') {
                this.popUpList = this.coinList.filter((element) => {
                    return element.code !== this.params.to.code
                })
            } else {
                this.popUpList = this.coinList.filter((element) => {
                    return element.code !== this.params.from.code
                })
            }
            this.popUpPosition = position
            this.showPopup = true

        }

    }

}
</script>

<style lang="scss" scoped>
.swap {
    .coin {
        border-top: 1px solid var(--color-border2);
        border-bottom: 1px solid var(--color-border2);
        padding: 5rem 0;
        text-align: center;

        p {
            font-size: 5rem;
            font-weight: 600;
        }

        span {
            font-size: 1.6rem;
            color: var(--color-text2);
        }
    }

    .exchange {
        padding: 3rem 1.5rem;

        .from,
        .to {
            padding: 1.5rem 1rem;
            display: flex;
            border: 1px solid var(--color-border2);
            border-radius: 5px;

            .left {
                flex: 1;

                input {
                    width: 100%;
                    border: none;
                    outline: none;
                }
            }

            .right {
                display: flex;
                align-items: center;

                p {
                    &:first-child {
                        color: var(--color-icon);
                    }

                    &:nth-child(2) {
                        margin: 0 1rem;
                        font-size: 1.2rem;
                        color: var(--color-text2);
                    }
                }

                .coin-name {
                    display: flex;
                    align-items: center;

                    span {
                        margin-right: 0.5rem;
                    }

                    img {
                        width: 2rem;
                        height: 2rem;
                    }
                }

            }
        }

        .exchange-btn {
            text-align: center;
            padding: 4rem 0;
        }

        .to {
            .right {

                span {
                    margin-right: 0.5rem;
                }

                img {
                    width: 2rem;
                    height: 2rem;
                }
            }
        }

        .infomation {
            margin-top: 2rem;

            .text {
                color: var(--color-text2);
                margin-right: 1rem;
            }
        }
    }

    div.btn {
        text-align: center;
        padding: 2rem 1rem;

        p {
            background: var(--color-icon);
            color: #fff;
            border-radius: .5rem;
            line-height: 4.5rem;
        }
    }

    .pop-list {
        width: 100%;
        display: flex;
        flex-direction: column;
        align-items: center;

        li {

            display: flex;
            align-items: center;
            padding: 1.5rem 0;
            width: 100%;
            justify-content: center;

            p {

                min-width: 8rem;

                img {
                    width: 1.6rem;
                    height: 1.6rem;
                    margin-right: 1.5rem;

                }
            }
        }

        .first {
            img {
                width: 3rem;
                height: 3rem;
                margin-right: 1.5rem;
            }

            span {
                font-size: 1.6rem;
            }
        }

    }


}
</style>