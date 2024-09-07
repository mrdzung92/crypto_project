<template>
    <div class="transfer">
        <van-nav-bar :title="headerTitle" left-text="返回" left-arrow @click-left="$router.go(-1)" />
        <div class="content">
            <p class="title">
                划转
            </p>
            <div class="card-one">
                <div class="left">
                    <div class="left-top">
                        <span class="text">从</span>
                        <van-dropdown-menu class="transer-drop-down">
                            <van-dropdown-item v-model="value1" :options="filteredOption1" />
                        </van-dropdown-menu>

                    </div>
                    <div class="left-bottom">
                        <span class="text">到</span>
                        <van-dropdown-menu class="transer-drop-down">
                            <van-dropdown-item v-model="value2" :options="filteredOption2" />
                        </van-dropdown-menu>

                    </div>
                </div>
                <div class="right"><img @click="handleTransfer()" src="@/assets/img/common/huazhuanbtn.svg"
                        class="icon huazhuanbtn"></div>
            </div>
            <div class="card-two">
                <div class="top">划转金额</div>
                <div class="bottom">
                    <input type="number" v-model="coin" placeholder="最少1USDT" @input="handleInput">
                    <span @click="selectAll()">全部</span><i>|</i>
                    <p>USDT</p>
                </div>
            </div>
            <div class="available">
                <span class="keyong">可用余额:</span>
                <span class="money">{{ balance['value' + value1] }} USDT</span>
            </div>
            <p v-if="!isLoading" @click="transferSubmit" class="btn">
                确认划转
            </p>
            <p v-else class="btn"><van-loading /></p>

        </div>

    </div>
</template>

<script>

import { showSuccessToast, showFailToast } from 'vant';
export default {
    data() {
        return {
            headerTitle: '划转',
            value1: 1,
            value2: 2,
            coin: '',
            isLoading: false,
            option: [
                { text: '平台资产', value: 1 },
                { text: '合约资产', value: 2 },
                { text: '理财资产', value: 3 },
            ],
            balance: {}


        }
    },
    created() {
        this.getBalance()
    },

    computed: {
        filteredOption1() {
            // Loại trừ value2 khỏi option1
            return this.option.filter(option => option.value !== this.value2);
        },
        filteredOption2() {
            // Loại trừ value1 khỏi option2
            return this.option.filter(option => option.value !== this.value1);
        },
    },

    methods: {
        transferSubmit() {
            const params = {
                from: this.value1,
                to: this.value2,
                transfer: this.coin
            }
            const balance = this.balance['value' + this.value1];
            if (this.coin <= 0) {
                showFailToast('转换金额不能小于或等于0');
            } else if (parseFloat(this.coin) > parseFloat(balance)) {
                showFailToast('转换金额不能大于账户余额');
            } else {
                this.isLoading = true
                this.$wedApi.get('Transfer/startTransfer', params).then(res => {
                    this.isLoading = false
                    if (res.data.code === 1) {
                        showSuccessToast(res.data.info)
                        this.getBalance()
                        this.coin =''
                    } else {
                        showFailToast(res.data.info);
                    }

                })
            }


        },
        selectAll() {
            this.coin = this.balance['value' + this.value1]
        },
        handleInput(e) {
            let value = e.target.value
            if (parseFloat(value) > parseFloat(this.balance['value' + this.value1])) {
                e.target.value = this.balance['value' + this.value1]
            }
        },
        handleTransfer() {
            const tmpValue = this.value1
            this.value1 = this.value2
            this.value2 = tmpValue
        },
        getBalance() {
            this.$wedApi.get('Transfer/getBalance').then(res => {
                if (res.data.code === 1) {
                    this.balance = res.data.data
                }
            })
        }

    }
}
</script>

<style lang="scss" scoped>
.transfer {

    .content {
        padding: 0 1.5rem;

        .title {
            margin: 3rem 0;
            font-size: 3rem;
            font-weight: bold;
        }

        .card-one,
        .card-two {
            padding: 1.5rem;
            background: var(--color-bg3);
            border-radius: 1rem;
        }

        .card-one {
            display: flex;
            align-items: center;
            padding: 0 1.5rem;
            justify-content: space-between;

            .left {
                flex: 1;

                .left-top,
                .left-bottom {
                    display: flex;
                    align-items: center;
                    margin-right: 1.5rem;

                    span.text {
                        margin-right: 1rem;

                    }
                }

                .left-top {
                    border-bottom: 1px dotted var(--color-text3);
                    // position: relative;

                    // &::after {

                    //     content: '';
                    //     position: absolute;
                    //     bottom: 0;
                    //     left: 0;
                    //     width: 100%;
                    //     height: 0.5px;
                    //     /* Chiều cao của đường viền */
                    //     background: repeating-linear-gradient(to right,
                    //             var(--color-text3) 0,
                    //             var(--color-text3) 4px,
                    //             transparent 1px,
                    //             transparent 10px);
                    // }
                }
            }
        }

        .card-two {
            margin-top: 1.5rem;

            .top {
                margin-bottom: 1.5rem;
            }

            .bottom {
                display: flex;
                border-bottom: 1px dotted var(--color-text3);

                input {
                    flex: 1;
                    border: none;
                    outline: none;
                    background: transparent;
                    padding-bottom: 1rem;
                    margin-right: 1rem;
                }

                i {
                    padding: 0 1rem;
                }

                span {
                    color: var(--color-icon);
                }
            }
        }

        .available {
            margin-top: 1rem;

            .keyong {
                margin-right: 1rem;
            }

            .money {
                font-weight: bold;
            }
        }

        .btn {
            background: var(--color-icon);
            color: #fff;
            border-radius: .5rem;
            text-align: center;
            line-height: 5rem;
            margin-top: 5rem;
        }
    }

}
</style>