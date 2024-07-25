<template>
    <div class="coin-change">
        <p class="text" @click="showPopup"> <van-icon name="bar-chart-o" />{{ coinName.replace('USDT', '/USDT') }}</p>
        <van-popup class="coin-popup" close-icon="close" closeable v-model:show="show" position="left"
            style="width: 80%;height: 100%;">
            <div class="popup-content">
                <div class="popup-head">
                    <p class="popup-title">
                        行情
                    </p>
                    <div class="search-box">
                        <van-icon name="search" size="3rem" />
                        <input type="text" placeholder="搜索币种" />
                    </div>

                </div>
                <div class="popup-list">
                    <CoinList @update-show="handleUpdateShow" />
                </div>
            </div>
        </van-popup>
    </div>
</template>

<script>
import CoinList from './CoinList.vue';
import { mapGetters } from 'vuex';
export default {
    components: {
        CoinList
    },

    data() {
        return {
            show: false,
            coinName: ''
        }
    },
    created() {
        this.coinName = this.coinSymbolDefault;

    },
    computed: {
        ...mapGetters(['getCoinSymbolDefault']),
        coinSymbolDefault() {
            return this.getCoinSymbolDefault;
        }
    },
    methods: {
        handleUpdateShow() {
            this.show = false
            this.coinName = this.$store.state.coinSymbolDefault
        },
        showPopup() {
            this.show = !this.show
        },

    },

}
</script>

<style lang="scss" scoped>
.coin-change {
    .text {
        font-weight: bold;
    }

    .coin-popup {
        .popup-content {
            margin-top: 2rem;

            .popup-head {
                padding: 2rem 1.5rem 0;

                .popup-title {
                    font-size: 2.4rem;
                    font-weight: bold;
                }

                .search-box {
                    margin: 1rem 0;
                    height: 4.6rem;
                    display: flex;
                    align-items: center;
                    padding: 0 1.5rem;
                    background: var(--color-bg);
                    border-radius: 4.6rem;
                    color: var(--color-text3);

                    input {
                        margin-left: 1rem;
                        flex: 1;
                        height: 100%;
                        background: transparent;
                        border: none;
                        outline: none;
                    }
                }
            }
        }
    }



}
</style>