<template>
    <div class="quote-page">
        <div class="head-search">
            <div class="search">
                <div class="box">
                    <van-icon name="search" />
                    <input type="text" placeholder="搜索币种">
                </div>

            </div>
            <div class="moni">
                <div class="left">
                    <p class="tip1">交易账户暂无资</p>
                    <p class="tip2">您可以尝试模拟交易</p>
                </div>
                <div class="right">
                    <span>模拟交易</span>
                </div>
            </div>
        </div>
        <CoinList />
        <Navigator />
    </div>
</template>

<script>
import CoinList from '@/components/CoinList.vue'
import Navigator from '@/components/Navigator.vue'
export default {
    components: {
        CoinList,
        Navigator
    },
}
</script>

<style lang="scss" scoped>
.quote-page {
    padding-bottom: 5.2rem;
    .head-search {
        padding: 0 1.5rem;
        margin-bottom: 2rem;
        .search {
            padding: 2rem 0rem 1rem;

            .box {
                background-color: var(--color-bg);
                padding: 0 2rem;
                border-radius: 2rem;
                display: flex;
                justify-content: space-between;
                align-items: center;

                input {
                    flex: 1;
                    border: none;
                    outline: none;
                    padding: .0rem .6rem;
                    background: transparent;
                    font-size: 1.2rem;
                    line-height: 3.2rem;
                }
            }

        }

        .moni {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: url('@/assets/img/quote/simulate.png') no-repeat center;
            background-size: cover;
            padding: 1rem;

            .left {
                color: var(--color-text);

                .tip1 {
                    font-weight: bold;
                    font-size: 1.8rem;
                }

                .tip2 {
                    font-size: 1.2rem;
                    background: var(--color-icon);
                    color: var(--color-text4);
                    margin-top: .8rem;
                    padding: .2rem .8rem;
                    border-radius: 2rem;
                }
            }

            .right {
                width: 5.8rem;
                height: 5.8rem;
                border-radius: 50%;
                background: url('@/assets/img/quote/quan.png') no-repeat center;
                display: flex;
                justify-content: center;
                align-items: center;

                span {
                    color: var(--color-text4);
                    font-size: 1.2rem;
                    // padding: 5px 10px;

                }
            }
        }
    }
}
</style>