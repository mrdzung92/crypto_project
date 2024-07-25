<template>
    <div class="defi">
        <van-nav-bar class="nav-title" :title="headerTitle" left-text="返回" left-arrow @click-left="$router.go(-1)">
            <template #right>
                <img @click="goPath('kefu')" src="@/assets/img/common/kefu.svg" alt="">
            </template>
        </van-nav-bar>
        <div class="banner">
            <img src="@/assets/img/defi/banner1.png" alt="">
        </div>
        <div class="content">
            <div class="minning_box">
                <div class="mining_header">
                    <img src="@/assets/img/defi/defi_icon.svg" alt="">
                    <b>ETH</b>
                </div>
                <div class="mining_content">
                    <div class="line line1">
                        <div class="left">
                            <p class="top fw-b">43562.53 ETH</p>
                            <p class="bot">总产出</p>
                        </div>
                        <div class="right">
                            <p class="top fw-b">936257.35 U</p>
                            <p class="bot">用户收益</p>
                        </div>
                    </div>
                    <div class="line line2">
                        <div class="left">
                            <p class="top">参与者</p>
                            <p class="bot fw-b">63958</p>
                        </div>
                        <div class="right">
                            <p class="top">有效节点</p>
                            <p class="bot fw-b">66152</p>
                        </div>
                    </div>
                    <div @click="joinMinning" class="mining_btn">参与</div>
                </div>
            </div>
            <div class="profit">
                <div class="head">
                    <p class="tip">当前收益比例</p>
                    <p @click="showIllustrate =true" class="rule">说明</p>
                    <van-popup class="illustrate"  v-model:show="showIllustrate" closeable close-icon="close" position="bottom"
                        :style="{ height: '50%' }">
                        <p class="title">说明</p>
                        <van-empty description="暂无数据" />
                    </van-popup>
                </div>
                <table>
                    <thead>
                        <tr>
                            <th>档位</th>
                            <th>数量</th>
                            <th>收益率</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="item in profit" :key="item.level">
                            <td>1</td>
                            <td>100-999</td>
                            <td>1.95%</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="output">
                <div class="tit">
                    用户输出
                </div>
                <div class="output_content">
                    <div class="output_content_title">
                        <p>地址</p>
                        <p>数量</p>
                    </div>
                    <van-swipe vertical class="notice-swipe" :autoplay="2000" :touchable="false" :height="50"
                        :show-indicators="false">
                        <van-swipe-item v-for="item, index in output" class="item">
                            <p>{{ item.address }}</p>
                            <p>{{ item.quantity }} ETH</p>
                        </van-swipe-item>
                    </van-swipe>
                </div>
            </div>
            <div class="process">
                <div class="tit">
                    合约审计机构
                </div>
                <div class="process-content">
                    <p> <img src="@/assets/img/defi/openzeppelin.png" alt=""></p>
                    <p> <img src="@/assets/img/defi/consensys.png" alt=""></p>
                </div>
            </div>
            <div class="partner">
                <div class="tit">
                    合作伙伴
                </div>
                <ul class="partner-content">
                    <li v-for="img, index in partner" :key="index">
                        <img :src="img" alt="">
                    </li>
                </ul>
            </div>
        </div>

    </div>
</template>

<script>

import banner1 from '@/assets/img/defi/trustwallet.png'
import banner2 from '@/assets/img/defi/imtoken.png'
import banner3 from '@/assets/img/defi/metamask.png'
import banner4 from '@/assets/img/defi/tokenpocket.png'
import banner5 from '@/assets/img/defi/defibox.png'
import banner6 from '@/assets/img/defi/coinbase.png'
import banner7 from '@/assets/img/defi/gate.png'
import banner8 from '@/assets/img/defi/bitkeep.png'
import banner9 from '@/assets/img/defi/debank.png'
import banner10 from '@/assets/img/defi/crypto.png'
import { showToast } from 'vant';
export default {
    data() {
        return {
            headerTitle: 'Defi 挖矿',
            showIllustrate:false,
            profit: [
                {
                    level: 1,
                    amount: '100-999',
                    rate: '1.95%'
                },
                {
                    level: 2,
                    amount: '1000-4999',
                    rate: '2.35%'
                },
                {
                    level: 3,
                    amount: '5000-9999',
                    rate: '2.55%'
                },
                {
                    level: 4,
                    amount: '10000-29999',
                    rate: '2.95%'
                },
                {
                    level: 5,
                    amount: '30000-49999',
                    rate: '3.05%'
                },
                {
                    level: 6,
                    amount: '50000-99999',
                    rate: '3.55%'
                },
                {
                    level: 7,
                    amount: '100000-299999',
                    rate: '3.85%'
                },
                {
                    level: 8,
                    amount: '300000-499999',
                    rate: '4.05%'
                },
                {
                    level: 9,
                    amount: '500000-1000000',
                    rate: '4.5%'
                },
            ],
            output: [
                {
                    address: '',
                    quantity: ''
                }
            ],
            partner: [banner1, banner2, banner3, banner4, banner5, banner6, banner7, banner8, banner9, banner10]
        }
    },
    created() {
        this.getOutput()
    },
    methods: {
        getOutput() {
            // 获取用户输出 目前使用循环展示，后续使用api获取
            this.output = [];
            const alpha = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
            for (let i = 0; i < 50; i++) {
                let item = {
                    address: 'ox',
                    quantity: ''
                }
                for (let j = 0; j < 4; j++) {
                    item.address += alpha[Math.floor(Math.random() * alpha.length)];
                }
                item.address += '*'.repeat(6);
                for (let j = 0; j < 6; j++) {
                    item.address += alpha[Math.floor(Math.random() * alpha.length)];
                }
                item.quantity = (Math.random() * 100).toFixed(Math.random() * (4 - 2) + 2);
                this.output.push(item)
            }

        },
        joinMinning() { // 参与挖矿接api
            showToast   ('授权失败')
        },
        goPath(path) {
            switch (path) {
                case 'kefu':

                    break;



                default:
                    this.$router.push(path);
                    break;
            }
        }

    }
}
</script>

<style lang="scss" scoped>
.defi {
    .tit {
        font-weight: bold;
        font-size: 1.6rem;
        margin-bottom: 1rem;
    }

    padding-top: 4.6rem;

    .nav-title {
        position: fixed;
        max-width: 540px;
        top: 0;
        width: 100%;

        img {
            width: 2.4rem;
            height: 2.4rem;
        }
    }

    .banner {
        height: 14.5rem;
        padding: 1.5rem;

        img {
            width: 100%;
            height: 100%;
        }
    }

    .content {
        padding: 0 1.5rem 0;

        .minning_box {
            padding-bottom: 2rem;

            .mining_header {
                padding-bottom: 2rem;
                display: flex;
                align-items: center;

                img {
                    width: 3.5rem;
                    height: 3.5rem;
                    margin-right: 1rem;

                }

                b {
                    font-weight: bold;
                    font-size: 1.6rem;
                }
            }

            .mining_content {
                position: relative;
                border: .1rem solid var(--color-border2);
                border-radius: 1rem;

                .line {
                    display: flex;

                    .left {
                        border-right: 1px solid var(--color-border2);
                    }

                    div {

                        flex: 1;
                        padding: 2rem 1rem;

                        .fw-b {

                            font-size: 2rem;
                        }

                        .top {
                            margin-bottom: 1.5rem;

                        }
                    }

                    div.right {
                        text-align: right;
                    }

                }

                .line1 {
                    border-bottom: 1px solid var(--color-border2);

                    .left,
                    .right {
                        .top {
                            color: var(--color-icon);
                        }

                        .bot {
                            color: var(--color-text2);
                        }
                    }
                }

                .line2 {
                    .top {
                        color: var(--color-text2);
                    }
                }

                .mining_btn {
                    position: absolute;
                    width: 10rem;
                    height: 10rem;
                    border-radius: 50%;
                    background: linear-gradient(-30deg, var(--color-icon), #72dbb1);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    color: var(--color-text4);
                    font-size: 1.6rem;
                    box-shadow: 0 0 .02 .08rem #0000001a;
                    border: 2px solid var(--color-border2);
                    left: 50%;
                    top: 50%;
                    transform: translate(-50%, -50%);
                }

            }
        }

        .profit {
            .head {
                display: flex;
                justify-content: space-between;
                margin-bottom: .8rem;

                .tip {
                    font-size: 1.6rem;
                    font-weight: bold;
                }

                .rule {
                    color: var(--color-icon);
                    text-decoration: underline;
                }
               
            }

            table {
                width: 100%;
                border-collapse: collapse;
                text-align: center;
                border: 1px solid var(--color-border2);
                font-size: 1.2rem;

                th,
                td {
                    padding: 1rem 0;
                    border: 1px solid var(--color-border2);
                }
            }
        }

        .output {
            padding-top: 3rem;


            .tit {
                font-weight: bold;
                font-size: 1.6rem;
                margin-bottom: 1rem;
            }

            .output_content {
                border: 1px solid var(--color-border2);

                .output_content_title {
                    padding: 1.5rem;
                    display: flex;
                    justify-content: space-between;
                    border-bottom: 1px solid var(--color-border2);
                }


                .notice-swipe {
                    height: 25rem;

                    .van-swipe-item.item {
                        width: 100%;
                        padding: 0 1.5rem;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                    }

                    // background: none;
                }
            }

        }

        .process {
            padding-top: 2rem;

            .process-content {
                display: flex;
                justify-content: space-between;
                gap: 1rem;

                p {
                    background: #f0f0f0;
                    padding: .8rem 1.5rem;
                    height: 5.6rem;
                    border-radius: .8rem;

                    img {
                        width: 100%;
                        height: 100%;
                    }
                }
            }
        }

        .partner {
            padding-top: 2rem;
            .partner-content {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 1.5rem;

                li {
                    padding: .5rem .8rem;
                    background: #f0f0f0;
                    border-radius: .4rem;

                    img {
                        width: 100%;
                        height: 100%;
                    }
                }
            }
        }

    }
}
</style>