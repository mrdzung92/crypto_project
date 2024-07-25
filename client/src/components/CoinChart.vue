<template>
    <div class="coin-chart">
        <div class="tab-head">
            <div class="top">
                <CoinPage />
                <van-icon name="warning-o" />
            </div>
            <div class="coin-info">
                <div class="left">
                    <p class="price" :class="{ blue: coinInfo.curDayClose > coinInfo.bestBid }">
                        {{coinInfo.hasOwnProperty('askPrice')? parseFloat(coinInfo.askPrice).toFixed(2) :parseFloat(coinInfo.curDayClose).toFixed(2)}}</p>
                    <p class="change" :class="{ blue: coinInfo.priceChangePercent * 1 > 0 }">
                        {{ coinInfo.priceChangePercent * 1 >= 0 ? '+' + parseFloat(coinInfo.priceChangePercent)
                        .toFixed(2) : parseFloat(coinInfo.priceChangePercent).toFixed(2) }}%</p>
                </div>
                <div class="right">
                    <p>
                        <span class="title">高</span>
                        <span class="value">{{ coinInfo.hasOwnProperty('highPrice') ?parseFloat(coinInfo.highPrice).toFixed(2):parseFloat(coinInfo.high).toFixed(2) }}</span>
                    </p>
                    <p>
                        <span class="title">低</span>
                        <span class="value">{{ coinInfo.hasOwnProperty('lowPrice')? parseFloat(coinInfo.lowPrice).toFixed(2):parseFloat(coinInfo.low).toFixed(2) }}</span>
                    </p>
                    <p>
                        <span class="title">量</span>
                        <span class="value">{{ (parseFloat(coinInfo.volume) / 1000).toFixed(2) }}k</span>
                    </p>
                </div>
            </div>
           
        </div>
        <div id="tv_chart_container" class="chart">
            <ul  class="select-time">
                <li @click="changeActiveInterval(index)" :class="{active:index==activeInterval}" v-for="item, index in activeIntervalVal" :key="index">{{ item.text }}
                </li>
            </ul>
            <iframe
                :src="`https://www.tradingview.com/widgetembed/?symbol=BINANCE%3A${symbol}&interval=${activeIntervalVal[activeInterval].code}&hidesidetoolbar=1&hidesymbolsearch=0&hideindicators=&symboledit=0&hidesaveimage=0&theme=light&hidelegend=1&hidetoptoolbar=1&locale=en&indicatorlegend=0`"
                width="100%" frameborder="0" allowtransparency="true" scrolling="no" allowfullscreen></iframe>
        </div>
    </div>
</template>

<script>
import CoinPage from '@/components/CoinPage.vue'
export default {
    components: {
        CoinPage
    },
    data() {
        return {
            coinInfo: {},
            symbol: '',
            activeInterval:0,
            activeIntervalVal:[
                {
                    text:'1m',
                    code:1
                },
                {
                    text:'5m',
                    code:5
                },
                {
                    text:'15m',
                    code:15
                },
                {
                    text:'30m',
                    code:30
                },
                {
                    text:'1h',
                    code:60
                },
                {
                    text:'2h',
                    code:120
                },
            ]
        }
    },
    created() {
        const config = JSON.parse(sessionStorage.getItem('config'))
        if(config){
            this.symbol = config.default_coin;
        }else {
            this.symbol = this.$store.state.coinSymbolDefault;
        }
       

        
        // this.setCoinInfo()
        this.getCoinInfo()
    },
    watch:{
        '$store.state.coinSymbolDefault'(value){
            this.symbol = this.$store.state.coinSymbolDefault
            this.getCoinInfo()
        }
    },
    methods: {
        // setCoinInfo() {

        // },
        changeActiveInterval(index){
            this.activeInterval = index
        },
        async getCoinInfo() {
            try {

                const res = await this.$wedApi.get('/Guest/getCoinPriceBySymbol',{symbol:this.symbol});
                if (res.data.code === 1) {
                    this.coinInfo = res.data.data;
                } else {
                    console.error('Failed to fetch coin list:', res.info);
                }
                
            } catch (error) {
                console.error('API request failed:', error);
            }
            this.$socket.on('ticker', (ticker) => {
                if(ticker.symbol === this.symbol){
                    this.coinInfo = ticker
                 
                }
               
              
            });
            
        }
    },
}
</script>

<style lang="scss" scoped>
.coin-chart {


    .tab-head {
        padding: 0 1.6rem;

        .top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 0;

            .van-icon {
                font-size: 2rem;
                color: var(--color-buy);
            }
        }

        .coin-info {
            display: flex;
            justify-content: space-between;
            padding-bottom: 1rem;

            .left {
                .price {
                    font-size: 3.6rem;
                    font-weight: bold;
                    color: var(--color-sell);
                    transition: all 0.3s;

                    &.blue {
                        color: var(--color-buy);
                    }
                }

                .change {
                    color: var(--color-sell);
                    font-weight: bold;

                    &.blue {
                        color: var(--color-buy);
                    }
                }
            }

            .right {
                p {
                    display: flex;
                    justify-content: space-between;

                    .title {
                        color: var(--color-text2);
                        margin-right: 1rem;
                        text-align: left;
                    }

                    .value {
                        font-weight: bold;
                        text-align: right;
                        color: var(--color-text);
                    }
                }
            }
        }

       
    }

    .chart {
        flex: 1;
        position: relative;
        .select-time {
            position: absolute;
            top: 0;
            background: var(--color-bg2);
            width: 100%;
            height: 3.8rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 1.5rem 0;

            li {
                color: var(--color-text);
                &.active {
                    color: var(--color-icon);
                }
            }
        }
        iframe {
            height: 348px;

        }
    }
}
</style>