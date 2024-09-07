<template>
    <div class="trade-info">
        <div class="box-head">
            <p><span>价格</span><span>(USDT)</span></p>
            <p><span>成交量</span><span>(BTC)</span></p>
        </div>
        <div class="trade-content">
            <ul class="trade-list sell">
                <li class="trade-list-row" v-for="(sell, index) in sellList" :key="'sell' + index">
                    <span class="bg-color"></span>
                    <p><span class="left">{{ sell.price }}</span> <span class="right">{{ sell.volume }}</span></p>
                </li>
            </ul>
            <div class="trade-coin-price">
                <p :class="{ sell: coinInfo.priceChangePercent < 0, buy: coinInfo.priceChangePercent >= 0 }">
                    {{ coinInfo.price }}</p>
                <p>≈${{ coinInfo.price }}</p>
            </div>
            <ul class="trade-list buy">
                <li class="trade-list-row" v-for="(buy, index) in buyList" :key="'buy' + index">
                    <span class="bg-color"></span>
                    <p><span class="left">{{ buy.price }}</span> <span class="right">{{ buy.volume }}</span></p>
                </li>
            </ul>
            <div class="select-opt">
                <div class="left" @click="() => { showPriceChange = true }">
                    <p class="quantity-buy">{{ priceChangeVal }}</p>
                    <img src="@/assets/img/common/jiantou10x5-x.svg" alt="">
                </div>
                <div class="right" @click="() => { showSelectBuySellOpt = true }">
                    <img src="@/assets/img/common/morenpan.svg" alt="">
                </div>
                <van-popup v-model:show="showPriceChange" round position="bottom">
                    <ul class="price-change-list">
                        <li @click="selectPriceChange(index)" :class="{ active: index === activeSelectPriceChange }"
                            v-for="item, index in priceChange" class="price-change-item" :key="index">{{ item }}
                        </li>
                    </ul>
                </van-popup>
                <van-popup v-model:show="showSelectBuySellOpt" round position="bottom">
                    <ul class="price-change-list">
                        <li @click="changeSelectBuySellOpt(index)" :class="{ active: index === activeSelectBuySellOpt }"
                            v-for="item, index in selectBuySellOpt" class="price-change-item" :key="index">{{ item }}
                        </li>
                    </ul>
                </van-popup>
            </div>
        </div>
    </div>
</template>

<script>
import { formatNumber } from '@/services/helper'
export default {
    data() {
        return {
            coinInfo: {
                price: '',
                priceChangePercent: ''
            },

            symbol: '',
            sellList: [
                { price: '68096.40', volume: '0.00023' },
                { price: '68096.40', volume: '0.00023' },
                { price: '68096.40', volume: '0.00023' },
                { price: '68096.40', volume: '0.00023' },
                { price: '68096.40', volume: '0.00023' }
            ],
            buyList: [
                { price: '68096.40', volume: '0.00023' },
                { price: '68096.40', volume: '0.00023' },
                { price: '68096.40', volume: '0.00023' },
                { price: '68096.40', volume: '0.00023' },
                { price: '68096.40', volume: '0.00023' }
            ],
            priceChangeVal: '',
            showPriceChange: false,
            priceChange: [],
            activeSelectPriceChange: 0,
            selectBuySellOpt: ['默认', '卖出', '买入'],
            showSelectBuySellOpt: false,
            activeSelectBuySellOpt: 0,
            interValId: ''
        }
    },
    created() {
        const config = JSON.parse(sessionStorage.getItem('config'))
        if (config) {
            this.symbol = config.default_coin;
        } else {
            this.symbol = this.$store.state.coinSymbolDefault;
        }
        this.getCoinInfo()


    },
    mounted() {
        this.interValId = setInterval(() => {
            this.caculateBuySellList()
        }, 1000);
        // setTimeout(() => {
        //     this.caculateBuySellList()
        // }, 1000);
    },
    watch: {
        '$store.state.coinSymbolDefault'(value) {
            this.symbol = this.$store.state.coinSymbolDefault
            this.getCoinInfo()
        }
    },
    methods: {

        changeSelectBuySellOpt() {

        },
        selectPriceChange(index) {
            this.activeSelectPriceChange = index
            this.showPriceChange = falseơ
            this.priceChangeVal = this.priceChange[index]
        },
        caculateBuySellList() {

            let strPriceChangeVal = this.priceChangeVal.toString()
            this.buyList = []
            this.sellList = []

            let initCoinPrice = this.coinInfo.price.toString().replace('.', '');

            let buyPrice = parseInt(initCoinPrice)
            let sellPrice = parseInt(initCoinPrice)
            let partsStrPriceChangeVal = strPriceChangeVal.split('.');
            let decimalPart = partsStrPriceChangeVal[1];
            strPriceChangeVal = parseInt(1 + '0'.repeat(decimalPart.length))
            for (let i = 1; i <= 5; i++) {
                buyPrice += parseInt(strPriceChangeVal)
                sellPrice -= parseInt(strPriceChangeVal)
                let buyItem = { price: formatNumber(buyPrice.toString().slice(0, (buyPrice.toString().length-1)-decimalPart.length) + '.' + buyPrice.toString().slice((buyPrice.toString().length-1)-decimalPart.length)), volume: this.getRandomFloat(0, 100) }
                let sellItem = { price: formatNumber(sellPrice.toString().slice(0, decimalPart.length) + '.' + sellPrice.toString().slice(decimalPart.length)), volume: this.getRandomFloat(0, 100) }
                this.sellList.unshift(sellItem)
                this.buyList.push(buyItem)
            }
            console.log(partsStrPriceChangeVal)

        },
        getRandomFloat(min, max) {
            return Math.random() * (max - min) + min;
        },
        caculateChangePrice() {
            const coinPrice = parseInt(this.coinInfo.price) + ''
            let len = 5 - (coinPrice.length - 1)
            this.priceChange = [];
            for (let i = 1; i <= 4; i++) {
                this.priceChange.unshift(('0.' + '0'.repeat(len) + '1') * 10000)
                len += 1
            }
            this.priceChangeVal = this.priceChange[0]
        },

        async getCoinInfo() {
            try {

                const res = await this.$wedApi.get('/Guest/getCoinPriceBySymbol', { symbol: this.symbol });
                if (res.data.code === 1) {
                    this.coinInfo.price = formatNumber(parseFloat(res.data.data.askPrice))
                    this.coinInfo.priceChangePercent = res.data.data.priceChangePercent

                    this.caculateChangePrice()
                } else {
                    console.error('Failed to fetch coin list:', res.info);
                }


            } catch (error) {
                console.error('API request failed:', error);
            }
            this.$socket.on('ticker', (ticker) => {
                if (ticker.symbol === this.symbol) {
                    this.coinInfo.price = formatNumber(parseFloat(ticker.curDayClose))
                    this.coinInfo.priceChangePercent = ticker.priceChangePercent
                }
            });

        }
    },
    unmounted() {
        clearInterval(this.interValId)

    },
}
</script>

<style lang="scss" scoped>
.trade-info {
    padding-right: 2rem;
    flex: 1;

    .box-head {
        display: flex;
        justify-content: space-between;
        color: var(--color-text3);
        margin-bottom: 1.5rem;

        p {
            font-size: 1.2rem;
            display: flex;
            flex-direction: column;
            align-items: center;

            span {
                line-height: 1.4rem;
            }
        }
    }

    .trade-content {
        .trade-coin-price {
            padding: 1.2rem 0;
            text-align: center;

            p {
                &:nth-child(1) {
                    font-size: 1.6rem;
                    font-weight: bold;

                    &.buy {
                        color: var(--color-buy);
                    }

                    &.sell {
                        color: var(--color-sell);
                    }
                }

                &:nth-child(2) {
                    color: var(--color-text3);
                    font-size: 1.2rem;
                }
            }
        }

        .trade-list {
            .trade-list-row {
                position: relative;
                padding: 0 .4rem;
                margin-bottom: .4rem;

                .bg-color {
                    position: absolute;
                    right: 0;
                    height: 100%;
                    width: 100%;
                    opacity: 0.2;
                }

                p {
                    position: relative;
                    z-index: 2;
                    display: flex;
                    justify-content: space-between;

                    span {
                        font-weight: bold;
                        font-size: 1.2rem;
                    }
                }
            }

            &.sell {
                .trade-list-row {
                    .bg-color {
                        background: var(--color-sell);
                    }

                    p {
                        .left {
                            color: var(--color-sell);
                        }
                    }

                }
            }

            &.buy {
                .trade-list-row {
                    .bg-color {
                        background: var(--color-buy);
                    }

                    p {
                        .left {
                            color: var(--color-buy);
                        }
                    }
                }
            }
        }

        .select-opt {
            display: flex;
            align-items: center;
            margin-top: 1rem;
            padding: 0 1rem;
            background: var(--color-bg);

            .left {
                display: flex;
                flex: 1;
                justify-content: space-between;

                .quantity-buy {
                    font-size: 1.2rem;
                    font-weight: bold;
                    line-height: 3rem;
                }
            }

            .right {
                padding-left: 1.5rem;
                display: flex;
                align-items: center;
                justify-content: center;
            }
        }

    }

    .price-change-list {
        width: 100%;
        padding: 2rem 1.5rem;

        li {
            text-align: center;
            padding: 1rem 0;
            border-bottom: .1rem solid var(--color-border);

            &.active {
                color: var(--color-icon);
            }
        }
    }
}
</style>