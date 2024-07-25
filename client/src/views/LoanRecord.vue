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
                        <span class="name">借款金额</span>
                        <span class="value bold">{{ item.amount }}</span>
                    </div>
                    <div class="order-detail">
                        <span class="name">状态</span>
                        <span class="value blue">{{ item.status }}</span>
                    </div>
                    <div class="order-detail">
                        <span class="name">还款周期</span>
                        <span class="value bold">{{ `${item.days}(天)` }}</span>
                    </div>
                    <div class="order-detail">
                        <span class="name">日利率</span>
                        <span class="value bold">{{ item.daily_rate }}%</span>
                    </div>
                    <div class="order-detail">
                        <span class="name">利息</span>
                        <span class="value bold">{{ item.interest }}</span>
                    </div>

                    <div class="order-detail">
                        <span class="name">还款方式</span>
                        <span class="value">到期一次还本息</span>
                    </div>
                    <div class="order-detail">
                        <span class="name">放款机构</span>
                        <span class="value">Binnance</span>
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
            headerTitle: '借款记录',
            tabs: ['全部', '待审核', '审核成功', '审核失败', '已结清', '已逾期'],
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
                    status: '进行中',
                    amount: 50000,
                    daily_rate: 0.16,
                    interest: 20,
                    days: 7
                },
                {
                    id: 2,
                    status: '已完成',
                    amount: 10000,
                    daily_rate: 0.16,
                    interest: 23,
                    days: 30
                },
                {
                    id: 3,
                    status: '已赎回',
                    amount: 5000,
                    daily_rate: 0.16,
                    interest: 24,
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

            }
        }
    }
}
</style>