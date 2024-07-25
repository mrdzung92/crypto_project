<template>
    <div class="navigator">
        <ul>
            <li v-for="item,index in navList">
                <router-link :to="item.link">
                    <img :src="$route.path ==item.link?item.iconA: item.icon" alt="">
                    <p :class="{active:$route.path ==item.link}">{{ item.name }}</p>
                </router-link>
            </li>
        </ul>
    </div>
</template>

<script>
import assets from '@/assets/img/nav/assets.png';
import assetsA from '@/assets/img/nav/assetsA.png';
import financial from '@/assets/img/nav/financial.png';
import financialA from '@/assets/img/nav/financialA.png';
import home from '@/assets/img/nav/home.png';
import homeA from '@/assets/img/nav/homeA.png';
import quote from '@/assets/img/nav/quote.png';
import quoteA from '@/assets/img/nav/quoteA.png';
import trade from '@/assets/img/nav/trade.png';
import tradeA from '@/assets/img/nav/tradeA.png';
export default {
    data() {
        return {
            navList: [
                {
                    name: 'Home',
                    link: '/',
                    icon: home,
                    iconA: homeA,
                },
                {
                    name: 'Quote',
                    link: '/quote',
                    icon: quote,
                    iconA: quoteA,
                },
                {
                    name: 'Trade',
                    link: '/trade',
                    icon: trade,
                    iconA: tradeA,
                },
                {
                    name: 'Financial',
                    link: '/financial',
                    icon: financial,
                    iconA: financialA,
                },
                {
                    name: 'Assets',
                    link: '/assets',
                    icon: assets,
                    iconA: assetsA,
                },
               
            ]
        }
    },
    created() {
     
    }

}
</script>

<style lang="scss" scoped>
    .navigator {
       position: fixed;
       bottom: 0;
       width: 100%;
       max-width: 540px;
       background: var(--color-bg);
       padding: .6rem 0 0 0;
       margin: 0 auto;
       ul {
        display: flex;
        justify-content: space-between;
        height: 100%;
        
        li {
            flex: 1;
            text-align: center;
            a {
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                img {
                    width: 2rem;
                    height: 2rem;
                }
                p.active {
                    color: var(--color-icon);
                }
            }
        }
       }
    }
</style>