<template>
    <div class="second-contract">
        <div class="wrap">
            <CoinChart />
            <!-- 订单列表 -->
            <div class="history">
                <div class="head">
                    <div class="left">
                        <p @click="changeOrderTypeIndex(1)" :class="{ active: orderTypeIndex === 1 }">当前委托{{
                            countUnsettlement
                                > 0 ?
                                `(${countUnsettlement})` : '' }}</p>
                        <p @click="changeOrderTypeIndex(2)" :class="{ active: orderTypeIndex === 2 }">历史委托{{
                            countSettled
                                > 0 ?
                                `(${countSettled})` : '' }}</p>
                    </div>
                    <div class="right">
                        <van-icon v-if="!displayOrderList" @click="displayOrderList = true" class="icon" name="eye-o" />
                        <van-icon v-else @click="displayOrderList = false" name="closed-eye" />
                        <van-icon @click="getOrdersList()" class="icon" name="replay" />
                    </div>
                </div>
                <div class="history-content">
                    <!-- 订单列表 -->
                    <p v-if="loadingOrder" class="loadding-order">
                        <van-loading size="42px" />
                    </p>

                    <template v-else>
                        <van-empty v-if="(orderList.length === 0 || displayOrderList)" description="没有数据" />
                        <ul v-else class="bet-list">
                            <li class="bet-item" v-for="item, index in orderList" :key="item.add_time">
                                <p class="head">
                                    <span class="direction"
                                        :class="{ buy: item.direction === 'up', sell: item.direction === 'down' }">{{
                            item.direction === 'up' ? '买涨' : '买跌' }}</span>
                                    <span class="add-time">{{ item.add_time }}</span>
                                </p>
                                <ul class="detail-list">
                                    <li class="detail-item"><span>{{ item.code }}/USDT</span> <span>{{
                            parseFloat(item.start_price) }}</span></li>
                                    <li class="detail-item"><span>数量</span> <span>{{ parseFloat(item.bet_amount) * 1
                                            }}</span>
                                    </li>
                                    <li v-if="orderTypeIndex == 1" class="detail-item"><span>当前价</span> <span>{{
                            item.curr_price }}</span></li>
                                    <li v-if="orderTypeIndex == 2" class="detail-item"><span>收盘时间</span> <span>{{
                            item.settlement_time }}</span></li>
                                    <li v-if="orderTypeIndex == 2" class="detail-item"><span>收盘价</span> <span>{{
                            parseFloat(item.end_price) * 1 }}</span></li>
                                    <li class="detail-item"><span>时间</span> <span>{{ item.time }}s</span></li>
                                    <li v-if="orderTypeIndex == 2" class="detail-item"><span>盈亏</span> <span>{{
                            parseFloat(item.bet_result) > 0 ? '+' + parseFloat(item.bet_result) :
                                parseFloat(item.bet_result) }} USDT</span></li>
                                    <li v-if="orderTypeIndex == 1" class="detail-item"><span>倒计时</span> <van-count-down
                                            :key="item.add_time" :time="getTimeRemaining(item.add_time, item.time)"
                                            @change="(time) => betTimeChange(time, index)" format="HH:mm:ss" /></li>
                                </ul>
                            </li>
                            <div v-if="orderList.length > 0" class="no-more-data">
                                没有更多数据了
                            </div>
                        </ul>
                    </template>
                </div>
            </div>
        </div>
        <!-- 投注明细 -->
        <van-popup v-model:show="showBuyContent" closeable close-icon="close" round position="bottom"
            class="buy-container" :style="{ height: 'auto' }">
            <div class="popup-header">
                <p class="coin">BTC</p>
                <p class="type" :class="{ sell: sellClass }">{{ buyText }}</p>
            </div>
            <div class="popup-content">
                <div class="select-cycle">
                    <p class="bold">选择周期</p>
                    <ul class="cycle-list">
                        <li class="cycle-item " :class="{ active: activeCycle == index }"
                            v-for="item, index in cycleItem" @click="handleChangeCycle(index)">
                            <span class="time bold">{{ item.time }}s</span>
                            <span class="rate bold">{{ item.rate }}%</span>
                        </li>
                    </ul>
                </div>
                <div class="buy-quantity">
                    <p class="bold">买入量</p>
                    <input type="text" placeholder="最少 1 USDT" v-model="quantity" @input="handleInputQuantity">
                </div>
                <ul class="quantity-list">
                    <li :class="{ active: activeQuantity === index }" class="quantity-item"
                        v-for="item, index in quantityList" :key="index" @click="handleChangeQuantity(index)">
                        <span class="bold">{{ item }}</span>
                    </li>
                </ul>
                <div class="balance">
                    <span>可用余额: </span>
                    <span class="bold">{{ userCoin }} USDT</span>
                </div>
                <div v-if="loading === false" @click="submit" class="buy-btn" :class="{ sell: sellClass }">
                    确定
                </div>
                <div v-else class="buy-btn" :class="{ sell: sellClass }">
                    <van-loading />
                </div>
            </div>
        </van-popup>
        <!-- 当前订单详情 -->
        <van-popup class="show-order-detail" v-model:show="showBuyDetail" close-icon="close" round closeable
            :key="lastOrderDetail.add_time" :style="{ padding: '15px' }">
            <h3>{{ lastOrderDetail.code }}</h3>
            <p v-if="loadingLastOrderDetail" style="display: flex; align-items: center; justify-content: center; padding: 3.2rem 0;" ><van-loading size="42" /></p>
            <template v-else>
                <div v-if="displayResult === false" class="clock-count">
                    <van-circle v-model:current-rate="currentRate" rate="rate" style="width: 150px; height: 150px;" :stroke-width="100" layer-color="#ebedf0"
                        color="var(--color-buy)">
                        <template #default>
                            <van-count-down :key="lastOrderDetail.add_time" :time="time" class="count-down1"
                                format="mm:ss" @change="onTimeChange" />
                        </template>
                    </van-circle>
                </div>
                <div v-else class="clock-count-end">
                    <p class="result"><span class="amount" :class="{buy:parseFloat(lastOrderDetail.bet_result)>0,sell:parseFloat(lastOrderDetail.bet_result)<0}">{{ parseFloat(lastOrderDetail.bet_result)>0?'+'+ parseFloat(lastOrderDetail.bet_result):parseFloat(lastOrderDetail.bet_result) }}</span><span class="curency">USDT</span></p>
                    <p class="tit">到期结算完成</p>
                </div>
                <ul class="order-detail-list">
                    <li v-if="displayResult" class="order-detail-item">
                        <span class="name">现价</span> <span class="value bold">{{ lastOrderDetail.end_price }}</span>
                    </li>
                    <li v-else class="order-detail-item">
                        <span class="name">现价</span> <span class="value bold">{{
                            parseFloat(lastOrderDetail.curr_price) }}</span>
                    </li>

                    <li class="order-detail-item">
                        <span class="name">周期</span> <span class="value bold">{{ lastOrderDetail.time }}s</span>
                    </li>
                    <li class="order-detail-item">
                        <span class="name">方向</span> <span class="value"
                            :class="{ buy: lastOrderDetail.direction === 'up', sell: lastOrderDetail.direction === 'down' }">{{
                            lastOrderDetail.direction ===
                                'up' ? '买涨' : '买跌'
                        }}</span>
                    </li>
                    <li class="order-detail-item">
                        <span class="name">数量</span> <span class="value bold ">{{ lastOrderDetail.bet_amount
                            }} USDT</span>
                    </li>
                    <li class="order-detail-item">
                        <span class="name">价格</span> <span class="value bold">{{
                            parseFloat(lastOrderDetail.start_price) }}
                            USDT</span>
                    </li>
                    <li class="order-detail-item" v-if="!displayResult">
                        <span class="name">预计盈利</span> <span class="value bold" :class="classDetail">{{ classDetail ===
                            'buy' ? '+' + lastOrderDetail.expected_profit : classDetail === 'sell' ?
                            '-' + lastOrderDetail.expected_profit : '' + 0.00
                            }}
                            USDT</span>
                    </li>
                </ul>
                <p class="tit">最终价格以系统结算为准</p>
            </template>
        </van-popup>
        <div class="up-down">
            <p @click="buy('up')" class="up">买涨</p>
            <p @click="buy('down')" class="down">买跌</p>
        </div>
    </div>
</template>

<script>
import CoinChart from '@/components/CoinChart.vue'
import { mapGetters } from 'vuex';
import { showToast } from 'vant';
export default {

    data() {
        return {
            time: 0,
            initialTime: 0,
            rate: 100,
            currentRate: 0,
            displayResult: false,
            classDetail: '',
            showBuyContent: false,
            loading: false,
            buyText: '买涨',
            sellClass: false,
            activeCycle: 0,
            quantity: '',
            activeQuantity: '',
            quantityList: [10, 20, 50, 100, 500, 1000, 2000, '全部'],
            coinName: '',
            coinId: '',
            rateId: '',
            direction: 'up',
            userCoin: 0,
            lastOrderDetail: {},
            cycleItem: [],
            showBuyDetail: false,
            countSettled: 0,
            countUnsettlement: 0,
            orderList: [],
            orderTypeIndex: 1,
            displayOrderList: false,
            loadingOrder: true,
            loadingLastOrderDetail: false
        }
    },
    components: {
        CoinChart
    },
    created() {
        this.getUserCoin()
        this.getOrdersList()
    },
    computed: {
        ...mapGetters(['getCoinSymbolDefault']),
        coinSymbolDefault() {
            return this.getCoinSymbolDefault;
        }

    },
    mounted() {
        this.listenCoinPrice()
    },
    watch: {
        coinSymbolDefault: {
            immediate: true,
            handler(newValue, oldValue) {
                this.getCoinSetting();
            }
        }
    },

    methods: {
        checkBetResult(betId) {
            this.loadingLastOrderDetail = true
            this.$wedApi.get('SecondContract/checkBetResult', { betId: betId }).then(res => {
                this.loadingLastOrderDetail = false
                this.showBuyDetail = true
                this.lastOrderDetail = res.data.data
            })
        },
        changeOrderTypeIndex(index) { //变更订单类型
            this.orderTypeIndex = index
            this.getOrdersList()

        },
        getOrdersList() {   //获取未结算订单
            this.loadingOrder = true
            this.$wedApi.get('SecondContract/orderList', { type: this.orderTypeIndex }).then(res => {
                this.loadingOrder = false
                if (res.data.code === 1) {
                    this.countSettled = res.data.data.countSettled
                    this.countUnsettlement = res.data.data.countUnsettlement
                    this.orderList = res.data.data.list
                }
            })
        },
        getTimeRemaining(add_time, time) { // 处理倒计时间
            const addTimeDate = new Date(add_time.replace(/-/g, '/'));
            addTimeDate.setSeconds(addTimeDate.getSeconds() + time);
            const currentTime = new Date();
            let diffInSeconds = Math.floor((addTimeDate - currentTime) / 1000); // Tính khoảng cách thời gian bằng giây
            if (diffInSeconds < 0 || diffInSeconds > time) {
                return 0;
            }
            return diffInSeconds * 1000;
        },
        betTimeChange(time, index) { // 倒计时间为零
            if (time.total === 0 && this.orderTypeIndex === 1) {
                this.orderList.splice(index, 1)
                this.countSettled += 1
                this.countUnsettlement -= 1
            }
        },
        listenCoinPrice() {
            this.$socket.on('ticker', (ticker) => {
                if (this.lastOrderDetail.code + 'USDT' === ticker.symbol) {
                    this.lastOrderDetail.curr_price = ticker.curDayClose
                    if (this.lastOrderDetail.direction === 'up') {
                        if (this.lastOrderDetail.curr_price > this.lastOrderDetail.start_price) {
                            this.classDetail = 'buy'
                        }
                        else if (this.lastOrderDetail.curr_price < this.lastOrderDetail.start_price) {
                            this.classDetail = 'sell'
                        } else {
                            this.classDetail = ''
                        }
                    }
                }
                if (this.orderList.length > 0 && this.orderTypeIndex === 1) {
                    this.orderList.forEach((order) => {
                        if (order.code + 'USDT' === ticker.symbol) {
                            order.curr_price = parseFloat(ticker.curDayClose)
                        }
                    })
                }


            });
        },
        onTimeChange(time) {
            const elapsedTime = this.initialTime - time.total;
            this.currentRate = Math.ceil((elapsedTime / this.initialTime) * 100);
            if (time.total === 0) {
                this.displayResult = true
                this.checkBetResult(this.lastOrderDetail.bet_id)
            }
        },
        getUserCoin() {
            this.$wedApi.get('Users/getUsersCoin').then(res => {
                if (res.data.code === 1) {
                    this.userCoin = res.data.data
                }
            })
        },
        handleInputQuantity(e) {
            const val = e.target.value
            const sanitizedVal = val.replace(/[^0-9.]/g, '');
            e.target.value = sanitizedVal;
            this.quantity = sanitizedVal;
        },
        submit() {
            if (parseFloat(this.quantity) <= 0 || this.quantity == '') {
                showToast('请输入购买金额')
                return
            }
            if (parseFloat(this.quantity) > parseFloat(this.userCoin)) {
                showToast('购买金额小于账号余额')
                return
            }
            const params = {
                coinId: this.coinId,
                direction: this.direction,
                rateId: this.rateId,
                quantity: this.quantity
            }

            this.loading = true

            this.$wedApi.post('SecondContract/makeOrder', params).then(res => {
                this.displayResult = false
                this.loading = false
                if (res.data.code === 1) {
                    this.lastOrderDetail = {}
                    this.lastOrderDetail = res.data.data
                    this.showBuyDetail = true
                    this.showBuyContent = false
                    this.time = this.lastOrderDetail.time * 1000
                    this.initialTime = this.lastOrderDetail.time * 1000
                    this.countUnsettlement += 1
                    if (this.orderTypeIndex === 1) {
                        this.orderList.unshift(this.lastOrderDetail)
                    }

                }

                this.quantity = ''
                this.activeQuantity = ''
                this.activeCycle = 0
                this.rateId = this.cycleItem[0].id
            })


        },
        getCoinSetting() {
            let coinName = this.getCoinSymbolDefault
            this.$wedApi.get('SecondContract/getSecondContractDetails', { code: coinName.replace('USDT', '') }).then(res => {
                if (res.data.code === 1) {
                    this.cycleItem = res.data.data.rate_setting
                    this.coinId = res.data.data.id
                    this.rateId = res.data.data.rate_setting[0].id

                }
            })
        },
        buy(stat) {

            this.showBuyContent = true
            if (stat === 'up') {
                this.buyText = '买涨'
                this.sellClass = false

            } else {
                this.buyText = '买跌'
                this.sellClass = true
            }
            this.direction = stat

        }
        ,
        handleChangeCycle(index) {
            this.activeCycle = index
            this.rateId = this.cycleItem[index].id
        },
        handleChangeQuantity(index) {
            if (index == this.quantityList.length - 1) {
                this.quantity = this.userCoin
            } else {
                this.quantity = this.quantityList[index]
            }
            this.activeQuantity = index

        }
    }
}
</script>

<style lang="scss" scoped>
.second-contract {
    display: flex;
    flex-direction: column;
    height: 100%;
    padding-bottom: 8.3rem;

    .wrap {
        flex: 1;
        overflow-y: scroll;



        .history {

            .head {
                display: flex;
                justify-content: space-between;
                border-bottom: 1px solid var(--color-border);
                padding: 1rem 1.5rem;

                .left {
                    display: flex;

                    p {
                        margin-right: 1rem;
                        font-size: 1.4rem;

                        &.active {
                            color: var(--color-icon);
                        }
                    }

                }

                .right {
                    display: flex;

                    .icon {
                        margin-left: 1rem;
                    }
                }

            }

            .history-content {
                .loadding-order {
                    padding: 3.2rem 0;
                    height: 26rem;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }

                .bet-list {
                    .bet-item {
                        padding: 2rem 1.5rem 0;
                        font-size: 1.2rem;

                        p.head {
                            padding: 0;
                            padding-bottom: 2rem;
                            justify-content: flex-start;
                            align-items: center;

                            .direction {
                                font-size: 1.2rem;
                                padding: .4rem .5rem;
                                margin-right: 1rem;
                                color: var(--color-text4);
                                border-radius: .2rem;

                                &.buy {
                                    background: var(--color-buy);
                                }

                                &.sell {
                                    background: var(--color-sell);
                                }
                            }

                            .add-time {
                                font-weight: bold;
                            }
                        }

                        .detail-list {
                            .detail-item {
                                display: flex;
                                justify-content: space-between;
                                align-items: center;
                                margin-bottom: 2rem;

                                span {
                                    &:nth-child(1) {
                                        color: var(--color-text3);
                                    }

                                    &:nth-child(2) {
                                        font-weight: bold;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

    }

    .buy-container {
        max-width: 540px;
        margin: 0 auto;
        // left: 50%;
        // transform: translateX(-50%);

        .bold {
            font-weight: bold;
        }

        .sell {
            background: var(--color-sell) !important;
        }

        .popup-header {
            display: flex;
            padding: 1.2rem 1.5rem 2rem;
            align-items: center;

            .coin {
                font-weight: bold;
                font-size: 1.8rem;
                margin-right: 1rem;
            }

            .type {
                background: var(--color-buy);
                color: var(--color-text4);
                padding: 0 .5rem;
                border-radius: .4rem;
            }
        }

        .popup-content {
            padding: 1rem 1.5rem 2rem;
            border-top: 1px solid var(--color-border2);

            .select-cycle {
                .cycle-list {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin: 1rem 0;

                    .cycle-item {
                        display: flex;
                        flex-direction: column;
                        flex: 1;
                        align-items: center;
                        background: var(--color-bg);
                        margin-right: 1.5rem;
                        border-radius: .5rem;
                        padding: 1rem 0;

                        &.active {
                            background: var(--color-icon);
                            color: white;
                        }

                        &:last-child {
                            margin-right: 0;

                        }
                    }
                }
            }

            .buy-quantity {
                input {
                    margin: 1rem 0;
                    width: 100%;
                    line-height: 4.6rem;
                    padding: 0 1.5rem;
                    border: 1px solid var(--color-border2);
                }
            }

            .quantity-list {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                text-align: center;
                gap: 1rem;

                .quantity-item {
                    background: var(--color-bg);
                    border-radius: .4rem;

                    &.active {
                        background: var(--color-icon);

                        span {
                            color: white;
                        }

                    }

                    span {
                        line-height: 3.6rem;
                    }
                }
            }

            .balance {
                margin: 1rem 0;
            }

            .buy-btn {
                display: flex;
                justify-content: center;
                margin-top: 4rem;
                background-color: var(--color-buy);
                color: white;
                text-align: center;
                line-height: 4.6rem;
                border-radius: .4rem;
            }
        }

    }

    .show-order-detail {
        padding: 1.5rem;
        width: 92%;

        h3 {
            font-weight: bold;
            font-size: 1.6rem;
        }

        .clock-count {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 1.5rem;
           
            .count-down1 {
                position: absolute;
                left: 0;
                right: 0;
                top: 0;
                bottom: 0;
                margin: auto;
                width: 100%;
                height: 100%;
                z-index: 999;
                display: flex;
                justify-content: center;
                align-items: center;
                font-weight: bold;
                font-size: 2rem;
            }
          
        }
        .clock-count-end{
            margin-top: 1.5rem;
            text-align: center;
            .result{
                font-size: 1.6rem;
                font-weight: bold;
                margin-bottom: 1.5rem;
          
                .amount{
                    font-size: 3.6rem;
                    margin-right: 1rem;
                    &.sell{
                        color: var(--color-sell);
                    }
                    &.buy{
                        color: var(--color-buy);
                    }
                }
                .curency {
                    font-weight: bold;
                    color: var(--color-text3);
                }
            }
            .tit{
               padding-top: 0;
               color: var(--color-text3);
            }
        }
        .order-detail-list {
            .order-detail-item {
                display: flex;
                justify-content: space-between;
                padding: 1rem 0;

                .name {
                    color: var(--color-text3);
                }

                .value.bold {
                    font-weight: bold;
                }

                .buy {
                    color: var(--color-buy);
                }

                .sell {
                    color: var(--color-sell);
                }
            }
        }

        .tit {
            padding-top: 2rem;
        }

    }

    .up-down {
        display: flex;
        padding: 2rem 1.5rem;
        position: fixed;
        bottom: 0;
        max-width: 540px;
        width: 100%;
        background: var(--color-bg2);

        .up {
            flex: 1;
            padding: 1rem 0;
            text-align: center;
            background-color: var(--color-buy);
            color: var(--color-bg);
            border-radius: 0.4rem;
            margin-right: 1rem;
        }

        .down {
            flex: 1;
            padding: 1rem 0;
            text-align: center;
            background-color: var(--color-sell);
            color: var(--color-bg);
            border-radius: 0.4rem;
        }
    }
}
</style>