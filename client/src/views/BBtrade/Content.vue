<template>
    <div class="bb-trade-content">
        <TradeInfo />
        <div class="buy-info">
           
        </div>
    </div>
</template>

<script>

import TradeInfo from '@/components/TradeInfo.vue'

export default {
    components: {
        TradeInfo
    }
}
</script>

<style lang="scss" scoped>
.bb-trade-content{
    padding: 2rem 1.5rem;
    display: flex;
    justify-content: space-between;
    .buy-info {
        flex: 1;
    }
}
</style>