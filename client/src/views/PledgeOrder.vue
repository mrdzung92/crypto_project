<template>
    <div class="pledge-order">
        <van-nav-bar class="header" :title="headerTitle" left-text="返回" left-arrow @click-left="$router.go(-1)">
            <template #right>
                <img @click.stop="goPath('kefu')" src="@/assets/img/common/kefu.svg" alt=""
                    style="width: 2.4rem; height: 2.4rem;">
            </template>
        </van-nav-bar>
        <div class="tabs-controll">
            <van-tabs v-model:active="active" @click-tab="onClickTab">
                <van-tab v-for="tab in tabs" :title="tab" />
            </van-tabs>
        </div>
        <div class="tabs-order">
            <van-empty v-if="list.length == 0" description="暂时没有数据" />
            <ul class="order-list">
                <li v-for="item, index in list">
                    <div class="order-title">
                        <img src="@/assets/img/pledge/usdt.svg" alt="">
                        <span>USDT</span>
                    </div>
                    <div class="order-detail">
                        <span class="name">投资金额</span>
                        <span class="value bold">{{ item.amount }}</span>
                    </div>
                    <div class="order-detail">
                        <span class="name">状态</span>
                        <span class="value blue">{{ item.status }}</span>
                    </div>
                    <div class="order-detail">
                        <span class="name">日收益率</span>
                        <span class="value bold">{{ `${item.min_yield}%~${item.max_yield}%` }}</span>
                    </div>
                    <div class="order-detail">
                        <span class="name">周期</span>
                        <span class="value bold">{{ `${item.days}(天)` }}</span>
                    </div>
                    <div class="order-detail">
                        <span class="name">开始日期</span>
                        <span class="value">{{ item.start_time }}</span>
                    </div>
                    <div class="order-detail">
                        <span class="name">结束日期</span>
                        <span class="value">{{ item.end_time }}</span>
                    </div>
                    <div class="order-btn" @click="redemption(item.id)">
                        赎回
                    </div>
                </li>
            </ul>
            <div class="no-more-data">
                没有更多数据了
            </div>
        </div>

    </div>
</template>

<script>
export default {
    data() {
        return {
            active: 0,
            headerTitle: '订单记录',
            tabs: ['全部', '进行中', '已完成', '已赎回'],
            list: []
        }
    },
    created() {
        this.getList()
    },
    methods: {
        getList() {
            this.list = [
                {
                    id: 1,
                    start_time: '2021-08-01 12:00:00',
                    end_time: '2021-08-08 12:00:00',
                    status: '进行中',
                    amount: 50000,
                    min_yield: 2,
                    max_yield: 4.75,
                    days: 7
                },
                {
                    id: 2,
                    start_time: '2021-08-01 12:00:00',
                    end_time: '2021-08-08 12:00:00',
                    status: '已完成',
                    amount: 10000,
                    min_yield: 2,
                    max_yield: 4.75,
                    days: 30
                },
                {
                    id: 3,
                    start_time: '2021-08-01 12:00:00',
                    end_time: '2021-08-08 12:00:00',
                    status: '已赎回',
                    amount: 5000,
                    min_yield: 2,
                    max_yield: 4.75,
                    days: 14
                }
            ]
        },
        goPath(path) {
            switch (path) {
                case 'kefu':
                    
                    break
                default:
                this.$router.push(path)
                    break
            }
            
        },
        onClickTab() {
            //处理tab切换
            this.getList()
        },
        redemption(id) {
          //赎回
        }
    }
}
</script>

<style lang="scss" scoped>
.pledge-order {
    .header {}

    .tabs-controll {
        border-bottom: 1px solid var(--color-border);
    }

    .tabs-order {
        .order-list {
            li {
                padding: 1rem 1.5rem;
                border-bottom: 1px solid var(--color-border);

                .order-title {
                    display: flex;
                    align-items: center;
                    margin-bottom: 1.5rem;

                    img {
                        width: 2rem;
                        height: 2rem;
                    }

                    span {
                        margin-left: 1rem;
                    }
                }

                .order-detail {
                    display: flex;
                    justify-content: space-between;
                    padding: 1.5rem 0;

                    .name {
                        color: var(--color-text3);
                    }

                    .value {
                        &.bold {
                            font-weight: bold;
                        }

                        &.blue {
                            color: var(--color-icon);
                        }
                    }
                }

                .order-btn {
                    background-color: var(--color-icon);
                    color: var(--color-bg);
                    text-align: center;
                    border-radius: .4rem;
                    margin: 1.5rem 0;
                    line-height: 4.2rem;
                }
            }
        }
    }
}
</style>