<template>
    <div class="bb-trade">
        <van-nav-bar :title="headerTitle" left-text="Back" left-arrow @click-left="$router.push('/')" />
        <BBindex/>
    </div>
</template>

<script>
import BBindex from './BBtrade/BBindex.vue';
export default {
    components: {
        BBindex
    },
    data() {
        return {
            headerTitle: '币币交易'
        }
    }
}
</script>

<style lang="scss" scoped></style>