<template>
    <div>
        <Content/>
        <OrderList/>
    </div>
</template>

<script>
import Content from './Content.vue'
import OrderList from './OrderList.vue'

    export default {
        components:{
            Content, 
            OrderList
        }
    }
</script>

<style lang="scss" scoped>

</style>