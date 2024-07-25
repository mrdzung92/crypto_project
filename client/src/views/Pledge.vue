<template>
    <div class="pledge-page">

        <van-nav-bar class="header" :title="headerTitle" left-text="返回" left-arrow @click-left="$router.go(-1)">
            <template #right>
                <img @click.stop="goPath('guize')" src="@/assets/img/common/guize.svg" alt=""
                    style="width: 2.4rem; height: 2.4rem;">
                <img @click.stop="goPath('/PledgeOrder')" src="@/assets/img/common/jilu.svg" alt=""
                    style="width: 2.4rem; height: 2.4rem; margin-left: 1rem;">
            </template>
        </van-nav-bar>
        <div class="pledge-content">
            <van-popup class="illustrate" v-model:show="showIllustrate" closeable close-icon="close" position="bottom"
                :style="{ height: '50%' }">
                <p class="title">说明</p>
                <van-empty description="暂无数据" />
            </van-popup>
            <div class="banner">
                <img src="@/assets/img/pledge/zhiyabg.png" alt="">
            </div>
            <div class="user-account">
                <div class="title">
                    <img src="@/assets/img/pledge/usdt.png" alt="">
                    <p class="name">USDT</p>
                </div>
                <div class="fun">
                    <div class="top">
                        <p class="left">
                            <span class="num">10000.00</span>
                            <span class="title">正在托管</span>
                        </p>
                        <p class="right">
                            <span class="num">1</span>
                            <span class="title">委托订单</span>
                        </p>
                    </div>
                    <div class="bottom">
                        <p class="left">
                            <span class="num">500.00</span>
                            <span class="title">今日收益</span>
                        </p>
                        <p class="right">
                            <span class="num">4000.00</span>
                            <span class="title">累计收益</span>
                        </p>
                    </div>
                    <img src="@/assets/img/pledge/zhiyaimg.png" alt="">
                </div>
            </div>
            <ul class="project-list">
                <li class="project-item" v-for="item, index in list" :key="index">
                    <div class="project-head">
                        <p class="left">
                            <img src="@/assets/img/pledge/usdt.svg" alt="">
                            <span class="text">USDT</span>
                        </p>
                        <router-link class="right" :to="'/PledgeDetail/' + item.id">购买</router-link>
                    </div>
                    <div class="project-content">
                        <div class="content-left">
                            <p class="invest-detail">
                                <span class="title">限额</span>
                                <span class="value">{{ item.min_invest + '%' + `~` + item.max_invest + '%' }}</span>
                            </p>
                            <p class="invest-detail">
                                <span class="title">天数</span>
                                <span class="value">{{ item.day }}</span>
                            </p>
                            <p class="invest-detail">
                                <span class="title">可购</span>
                                <span class="value">{{ item.available }}</span>
                            </p>
                            <p class="invest-detail">
                                <span class="title">收益利</span>
                                <span class="value blue">{{ item.min_yield + '%' + `~` + item.max_yield + '%' }}</span>
                            </p>
                        </div>
                        <img src="@/assets/img/pledge/zhi.png" alt="">
                    </div>
                </li>
            </ul>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            headerTitle: '质押挖矿',
            list: [
                {
                    id:1,
                    min_invest: 2000,
                    max_invest: 15000,
                    day: 7,
                    available: 1,
                    min_yield: 2,
                    max_yield: 4.75,
                },
                {
                    id:2,
                    min_invest: 5000,
                    max_invest: 5000,
                    day: 30,
                    available: 1,
                    min_yield: 4,
                    max_yield: 4,
                },
                {
                    id:3,
                    min_invest: 10000,
                    max_invest: 10000,
                    day: 30,
                    available: 1,
                    min_yield: 5,
                    max_yield: 5,
                },
                {
                    id:4,
                    min_invest: 20000,
                    max_invest: 20000,
                    day: 30,
                    available: 1,
                    min_yield: 5.5,
                    max_yield: 5.5,
                },
                {
                    id:5,
                    min_invest: 50000,
                    max_invest: 50000,
                    day: 30,
                    available: 1,
                    min_yield: 8,
                    max_yield: 8,
                },
                {
                    id:6,
                    min_invest: 100000,
                    max_invest: 100000,
                    day: 30,
                    available: 1,
                    min_yield: 12,
                    max_yield: 12,
                },
            ],
            showIllustrate: false
        }
    },
    methods: {
        goPath(path) {
            switch (path) {
                case 'guize':
                    this.showIllustrate = true
                    break;
                default:
                    this.$router.push(path)
                    break
            }

        }
    }
}
</script>

<style lang="scss" scoped>
.pledge-page {


    .header {
        position: fixed;
        margin: 0 auto;
        width: 100%;
        max-width: 540px;
    }

    .pledge-content {
        padding-top: 4.6rem;
        padding-bottom: 4rem;

        .banner {
            height: 29rem;

            img {
                width: 100%;
                height: 100%;
            }
        }

        .user-account {
            padding: 0 1.5rem;

            div.title {
                padding: 2rem 0;
                display: flex;
                align-items: center;

                img {
                    width: 3.4rem;
                    height: 3.4rem;
                    margin-right: 1rem;
                }

                p.name {
                    font-size: 2.4rem;
                    font-weight: bold;
                }
            }

            .fun {
                border: 1px solid var(--color-border);
                border-radius: .8rem;
                position: relative;

                img {
                    position: absolute;
                    top: 50%;
                    left: 50%;
                    transform: translate(-50%, -50%);
                    width: 5rem;
                    height: 5rem;
                }

                div {
                    display: flex;
                    justify-content: space-between;

                    p {
                        padding: 2.5rem 1.5rem;
                        display: flex;
                        flex-direction: column;
                        flex: 1;

                        .num {
                            font-size: 1.8rem;
                            font-weight: bold;
                            margin-bottom: 1rem;
                        }

                        &:nth-child(2) {
                            text-align: right;

                        }
                    }

                    .left {
                        border-right: 1px solid var(--color-border);
                    }
                }

                div.top {
                    border-bottom: 1px solid var(--color-border);

                }

                div.bottom {
                    .num {
                        color: var(--color-icon);
                    }


                }
            }


        }

        .project-list {
            margin-top: 1rem;
            padding: 0 1.5rem;

            .project-item {
                padding: 2rem 1rem;
                border: 1px solid var(--color-border);
                margin-bottom: 1rem;
                border-radius: .8rem;
                box-shadow: 0 0 0.0rem 0.04rem var(--color-icon);

                .project-head {
                    display: flex;
                    justify-content: space-between;
                    padding-bottom: 2rem;
                    align-items: center;
                    border-bottom: 1px solid var(--color-icon);

                    .left {
                        display: flex;
                        align-items: center;

                        img {
                            width: 2rem;
                            height: 2rem;
                            margin-right: 1rem;
                        }

                        .text {
                            font-weight: bold;
                        }
                    }

                    .right {
                        padding: 0rem 1rem;
                        background: var(--color-icon);
                        min-width: 10rem;
                        text-align: center;
                        color: var(--color-text4);
                        border-radius: .4rem;
                        line-height: 3.2rem;
                    }
                }

                .project-content {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    padding-top: 2rem;

                    .content-left {
                        .invest-detail {
                            line-height: 3rem;

                            .title {

                                font-size: 1.2rem;
                                color: var(--color-text3);
                            }

                            .value {
                                font-weight: bold;
                                color: var(--color-text);
                                font-size: 1.6rem;
                                margin-left: 2rem;
                                &.blue {
                                    color: var(--color-icon);
                                }
                            }
                        }
                    }

                    img {
                        width: 12rem;
                        height: 12rem;
                    }
                }
            }
        }
    }
}
</style>