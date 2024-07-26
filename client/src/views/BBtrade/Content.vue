<template>
    <div>
        <TopSelectCoin />
        <TradeInfo />
    </div>
</template>

<script>
import TopSelectCoin from '@/components/TopSelectCoin.vue'
import TradeInfo from '@/components/TradeInfo.vue'

export default {
    components: {
        TopSelectCoin,
        TradeInfo
    }
}
</script>

<style lang="scss" scoped></style>