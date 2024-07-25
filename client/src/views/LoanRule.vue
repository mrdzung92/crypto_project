<template>
    <div class="loan-rule">
        <van-nav-bar class="header" :title="headerTitle" left-text="返回" left-arrow @click-left="$router.go(-1)">
            <template #right>
                <img @click.stop="goPath('kefu')" src="@/assets/img/common/kefu.svg" alt=""
                    style="width: 2.4rem; height: 2.4rem;">
            </template>
        </van-nav-bar>
        <div class="rule-content">
            <van-empty description="暂无数据" />
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            headerTitle: '借款规则'
        }
    },
}
</script>

<style lang="scss" scoped></style>