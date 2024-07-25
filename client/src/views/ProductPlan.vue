<template>
    <div class="product-plan">
        <p @click="()=>{$router.go(-1)}" class="back"><van-icon name="arrow-left" size="18" /><span>返回</span></p>
        <img src="@/assets/img/productPlan/productbg.png" alt="">
    </div>
</template>

<script>
export default {

}
</script>

<style lang="scss" scoped>
.product-plan {
    position: relative;

    p.back {
        position: absolute;
        padding: 2rem 1.5rem;
        font-size: 1.6rem;

        span {
            margin-left: 1rem;
        }
    }

    img {
        width: 100%;
    }

    // background: url('@/assets/img/productPlan/productbg.png') no-repeat;
    // background-size: cover;
    // height: 100vh;
}
</style>