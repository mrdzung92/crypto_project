<template>
    <ul class="fun-list">
        <li v-for="item,index in list" class="fun-item">
            <div class="head">
                <p class="name">{{ item.title }}</p>
                <div class="head-top">
                    <p class="left">
                        <img :src="item.icon" alt="">
                        <span>{{ item.percent }}%</span>
                    </p>
                    <img src="@/assets/img/financial/shang.png" alt="">
                </div>
            </div>
            <ul class="info">
                <li class="info-item">
                    <p class="title">
                        <span class="mark"></span>
                        <span class="name">起投金额:</span>
                    </p>
                    <p class="value">{{ item.min_invest }} USDT</p>
                </li>
                <li class="info-item">
                    <p class="title">
                        <span class="mark"></span>
                        <span class="name">限额投注:</span>
                    </p>
                    <p class="value">{{ item.limits_invest }} USDT</p>
                </li>
                <li class="info-item">
                    <p class="title">
                        <span class="mark"></span>
                        <span class="name">锁仓天数:</span>
                    </p>
                    <p class="value">{{ item.lock_up_days }} 天</p>
                </li>
            </ul>
            <div class="progress-bar">
                <p class="percent"></p>
            </div>
            <div class="bottom">
                <p class="progress">
                    <span>项目进度:</span>
                    <span>{{ item.progress }}</span>
                </p>
                <p class="button">立即投注</p>
            </div>
        </li>
    </ul>
</template>

<script>
import icon1 from '@/assets/img/financial/icon1.png'


    export default {
            data(){
                return {
                    list: [
                        {
                            icon: icon1,
                            title: 'USDTSmart contract',
                            percent: '0.75',
                            progress: '75%',
                            min_invest: '500',
                            limits_invest: '200000',
                            lock_up_days: '15',
                        },
                        {
                            icon: icon1,
                            title: 'USDTSmart contract',
                            percent: '3',
                            progress: '75%',
                            min_invest: '10000',
                            limits_invest: '500000',
                            lock_up_days: '30',
                        },
                        {
                            icon: icon1,
                            title: 'USDTSmart contract',
                            percent: '5',
                            progress: '75%',
                            min_invest: '50000',
                            limits_invest: '1000000',
                            lock_up_days: '60',
                        },
                        {
                            icon: icon1,
                            title: 'USDTSmart contract',
                            percent: '7',
                            progress: '75%',
                            min_invest: '1000000',
                            limits_invest: '2000000',
                            lock_up_days: '120',
                        },
                    ]
                }
            }
    }
</script>

<style lang="scss" scoped>
    .fun-list {
        li.fun-item {
            padding: 1.5rem 1rem;
            box-shadow:0 0 0.0rem 0.04rem var(--color-icon);
            margin-bottom: 1.5rem;
            border-radius: 1rem;
            .head {
                .name {
                    font-weight: bold;
                    font-size: 1.6rem;
                    margin-bottom: .8rem;
                }
                .head-top {
                    display: flex;
                    justify-content: space-between;
                    p.left {
                        display: flex;
                        align-items: center;
                        img {
                            width: 5rem;
                            height: 5rem;
                            margin-right: 1rem;
                        }
                        span {
                            font-size: 3.6rem;
                            color: var(--color-sell);
                            // font-weight: bold;
                        }
                    }
                    img {
                        height: 5rem;
                    }
                }
            }
            .info {
                padding: 1rem 0;
                font-size: 1.4rem;
                li.info-item {
                    display: flex;
                    justify-content: space-between;
                    padding: 0;
                    color: var(--color-text3);
                    border-radius: 0;
                    
                    .title {
                        display: flex;
                        align-items: center;
                        .mark {
                            display: inline-block;
                            width: .7rem;
                            height: .7rem;
                            background: var( --color-icon);
                            margin-right: .5rem;
                            transform: rotate(45deg);
                        }
                        
                    }
                    .value {
                            font-weight: bold;
                            color: var(--color-text);
                        }
                }
            }
            .progress-bar {
                margin-top: .5rem;
                height: 0.6rem;
                width: 100%;
                background-color: var(--color-icon);
                border-radius: 1rem;
            }
            .bottom {
                display: flex;
                margin-top: 1rem;
                justify-content: space-between;
                font-size: 1.4rem;
                color: var(--color-text3);
                .progress {
                    span {
                        margin-right: 1rem;
                        &:nth-child(2){
                            font-weight: bold;
                            color: var(--color-text);
                        }
                    }
                   
                }
                p.button {
                       background: var(--color-icon);
                       color: var(--color-white);
                       font-size: 1.4rem;
                       line-height: 3rem;
                       padding: 0 1rem;
                       border-radius: .5rem;
                    }
            }
        }
    }
</style>