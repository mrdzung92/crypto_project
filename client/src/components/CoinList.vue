<template>
    <div class="coin-box">
        <div class="box-head">
            <p>
                <span class="title">名称</span>
                <span class="soft">
                    <van-icon name="play" class="asc" />
                    <van-icon name="play" class="desc" />
                </span>
            </p>
            <p>
                <span class="title">最新价</span>
                <span class="soft">
                    <van-icon name="play" class="asc" />
                    <van-icon name="play" class="desc" />
                </span>
            </p>
            <p>
                <span class="title">涨幅跌</span>
                <span class="soft">
                    <van-icon name="play" class="asc" />
                    <van-icon name="play" class="desc" />
                </span>
            </p>
        </div>
        <ul class="coin-list">
            <div class="loading" v-if="loading">
                <van-loading  type="spinner" />
            </div>
           
            <li v-else v-for="coin, index in coinList" :key="index" @click="goTrade(coin.symbol)">
                <div class="left">
                    <img :src="coin.icon" alt="">
                    <span>{{ coin.symbol.replace('USDT', '') }}/USDT</span>
                </div>
                <div class="center">
                    {{ coin.hasOwnProperty('curDayClose') ?
                parseFloat(coin.curDayClose).toFixed(2) : parseFloat(coin.askPrice).toFixed(2) }}
                </div>
                <div class="right" :class="{ sell: coin.priceChangePercent * 1 < 0 }">
                    {{ parseFloat(coin.priceChangePercent).toFixed(2) }}%
                </div>
            </li>
        </ul>
    </div>

</template>

<script>

export default {
    data() {
        return {
            coinList: [],
            loading:false
        }
    },
    created() {

    },
    mounted() {
        this.renderCoinList();
    },
    methods: {
        async renderCoinList() {
            this.loading = true
            try {
                const res = await this.$wedApi.get('/Guest/coinList');
                this.loading = false
                if (res.data.code === 1) {
                    this.coinList = res.data.data;
                } else {
                    console.error('Failed to fetch coin list:', res.info);
                }
            } catch (error) {
                console.error('API request failed:', error);
            }
            this.$socket.on('ticker', (ticker) => {
                const index = this.coinList.findIndex(t => t.symbol === ticker.symbol);
                if (index !== -1) {
                    ticker.icon = this.coinList[index].icon
                    this.coinList.splice(index, 1, ticker);
                } else {
                    this.coinList.push(ticker);
                }
            });
        },
        goTrade(symbol) {
            this.$store.dispatch('loadCoinDefault', symbol)
            const currentRouter = this.$route.name
            this.$emit('update-show');
            switch (currentRouter) {
                case "Trade":
                    this.$router.push(`/trade/${symbol}`);
                    break;

                default:
                    break;
            }
       
           
        }

    }
}

</script>

<style lang="scss" scoped>
.coin-box {
    .box-head {
        display: flex;
        justify-content: space-between;
        font-size: 1.2rem;
        padding: 0rem 1.5rem .5rem;

        p {
            display: flex;
            align-items: center;
            justify-content: center;

            span.soft {
                display: flex;
                flex-direction: column;
                justify-content: center;

                .asc {
                    line-height: .4rem;
                    font-size: .8rem;
                    transform: rotate(-90deg);
                }

                .desc {
                    line-height: .4rem;
                    font-size: .8rem;
                    transform: rotate(90deg);
                }
            }

            &:first-child {
                flex: 2;
                justify-content: flex-start;
            }

            &:nth-child(2),
            &:nth-child(3) {
                flex: 1;

            }

            &:nth-child(3) {
                justify-content: flex-end;
            }

        }
    }

    ul {
        .loading {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100%;
            height: 15rem;
        }
        li {
            display: flex;
            justify-content: space-between;
            padding: 0rem 1.5rem 1rem;
            align-items: center;

            div {
                text-align: left;
                flex: 2;

                &:nth-child(2),
                &:nth-child(3) {
                    text-align: center;
                    flex: 1;
                }
            }

            .left {
                display: flex;
                align-items: center;

                img {
                    width: 2.5rem;
                    height: 2.5rem;
                    margin-right: 1.5rem;
                }

                span {
                    font-weight: bold;
                    text-transform: uppercase;
                }
            }

            .center {
                font-weight: bold;
                font-size: 1.4rem;
                // color: var(--color-buy);

            }

            .right {
                background-color: var(--color-buy-bg);
                line-height: 3.6rem;
                font-weight: 700;
                font-size: 1.4rem;
                border-radius: .4rem;
                color: var(--color-buy);

                &.sell {
                    background-color: var(--color-sell-bg);
                    color: var(--color-sell);
                }
            }
        }
    }

}
</style>
