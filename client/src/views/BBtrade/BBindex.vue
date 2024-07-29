<template>
    <div class="bb-trade">
        <div class="top-select-coin">
               <CoinPage/>
            <div class="right">
                <img src="@/assets/img/common/k-xian.svg" alt="Icon 1">
                <img src="@/assets/img/common/guize.svg" alt="Icon 2">
            </div>
        </div>
        <Content />
        <OrderList />
    </div>
</template>

<script>
import Content from './Content.vue'
import OrderList from './OrderList.vue'
import CoinPage from '@/components/CoinPage.vue'

export default {
    components: {
        CoinPage,
        Content,
        OrderList
    }
}
</script>

<style lang="scss" scoped>
.bb-trade {
    .top-select-coin {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 2rem 1.5rem 0;

        .left {
            select {
                padding: 0.5rem;
                font-size: 1.2rem;
            }
        }

        .right {
            img {
                margin-left: 1rem;
                width: 2.4rem;
                height: 2.4rem;
            }
        }
    }
}
</style>