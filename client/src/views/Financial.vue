<template>
    <div class="financial-page">
        <header>
            <router-link to="/">
                <img src="@/assets/img/tmp/logo.png" alt="">
            </router-link>
            <div class="head-right">
                <img @click="goPath('kefu')" src="@/assets/img/common/kefu.svg" alt="">
                <img @click="goPath('sousuo')" src="@/assets/img/common/sousuo.svg" alt="">
                <img @click="goPath('user')" src="@/assets/img/common/cebian.svg" alt="">
            </div>
            <UserInfo v-model:show="showUserInfo" />
        </header>
        <div class="center">
            <div class="banner">
                <img src="@/assets/img/financial/financial_bg.png" alt="">
            </div>
            <ul>
                <li v-for="item, index in list">
                    <img :src="item.icon" alt="">
                    <p>{{ item.title }}</p>
                </li>
            </ul>
        </div>
        <div class="box-fun">
            <FunList />
        </div>
        <Navigator />
    </div>
</template>

<script>
import huiyuan from '@/assets/img/financial/huiyuan.svg'
import putong from '@/assets/img/financial/putong.svg'
import touzhi from '@/assets/img/financial/touzhi.svg'
import zhenzhi from '@/assets/img/financial/zhenzhi.svg'
import FunList from '@/components/FunList.vue'
import Navigator from '@/components/Navigator.vue'
import UserInfo from '@/components/UserInfo.vue'
export default {
    components: {
        FunList,
        Navigator,
        UserInfo
    },
    data() {

        return {
            showUserInfo:false,
            list: [
                {
                    icon: zhenzhi,
                    title: '增值收益',

                },
                {
                    icon: huiyuan,
                    title: '会员专区',

                },
                {
                    icon: putong,
                    title: '普通产品',

                },
                {
                    icon: touzhi,
                    title: '我的投资',

                },

            ]
        }
    },
    methods: {
        goPath(path) {
            switch (path) {
                case 'kefu':

                    break;
                case 'sousuo':

                    break;
                case 'user':
                    this.showUserInfo = !this.showUserInfo;
                    break;

                default:
                    break;
            }
        }

    }

}
</script>

<style lang="scss" scoped>
.financial-page {
    padding: 1.5rem 0rem 5.2rem;

    header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding-bottom: 1rem;
        padding-left: 1.5rem;
        padding-right: 1.5rem;

        a {
            img {
                height: 3rem;
            }
        }

        .head-right {
            img {
                margin-left: 2rem;
                width: 2.4rem;
                height: 2.4rem;
                // height: 2rem;
            }
        }
    }

    .center {
        border-top: 1px solid var(--color-border2);
        border-bottom: 1px solid var(--color-border2);
        padding: 2rem 1.5rem;

        .banner {
            img {
                width: 100%;
            }
        }

        ul {
            display: flex;
            justify-content: space-between;
            padding-top: 2rem;

            li {
                text-align: center;
                flex: 1;

                img {
                    width: 4rem;
                    height: 4rem;
                }

                p {
                    font-size: 1.4rem;
                    color: var(--color-text);
                    text-align: center;
                }
            }
        }
    }

    .box-fun {
        padding: 1rem 1.5rem;
    }

}
</style>