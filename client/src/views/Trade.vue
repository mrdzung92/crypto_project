<template>
    <div class="trade-page">
        <header>
            <p class="back"><van-icon name="arrow-left" /></p>
            <van-tabs v-model:active="active">
                <van-tab title="秒合约"> </van-tab>
                <van-tab title="币币交易"> </van-tab>
                <van-tab title="U本拉合约"> </van-tab>
            </van-tabs>
        </header>
        <div class="tab-content">
            <div class="tab1">
                <SecondContract  :symbol="symbol"/>
            </div>
        </div>
    </div>
</template>

<script>
import SecondContract from '@/components/SecondContract.vue'
export default {
    components: {
        SecondContract
    },
    data() {
        return {
            active: 0,
            showLeft: false,
            coinInfo: {},
            symbol: ''
        }
    },
    created() {
        this.getCoinSymbol()
    },
    methods: {
        getCoinSymbol() {
            const paramsSymbol = this.$route.params.symbol
            
            if (paramsSymbol !== '') {
                this.symbol = paramsSymbol
                this.$store.commit('setCoinSymbolDefault', paramsSymbol)
            }
            this.$router.replace({ name: 'Trade', params: { symbol: this.symbol } });
           
        },
        onClickLeft() {
            this.showLeft = !this.showLeft
            console.log('showLeft', this.showLeft);
        }
    },

}
</script>

<style lang="scss" scoped>
.trade-page {

    header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0 1.6rem;
        height: 4.4rem;
        background-color: var(--color-bg);

        .van-tabs {
            flex: 1;
        }

        .back {
            font-size: 2rem;
        }
    }

    .tab-content {
        flex: 1;
        overflow-y: scroll;
        height: calc(100vh - 4.4rem);


    }
}
</style>