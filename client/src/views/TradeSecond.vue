<template>
    <div class="trade-second">
        <van-nav-bar :title="headerTitle" left-text="Back" left-arrow @click-left="$router.push('/')" />
        <SecondContract />
    </div>
</template>

<script>
import SecondContract from '@/components/SecondContract.vue';
export default {
    components: {
        SecondContract
    },
    data() {
        return {
            headerTitle: '秒合约'
        }
    }
}
</script>

<style lang="scss" scoped></style>