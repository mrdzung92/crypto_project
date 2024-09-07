import { createRouter, createWebHistory } from 'vue-router'
import { showConfirmDialog } from 'vant';
const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'Home',
      component: () => import('../views/Home.vue'),
      meta: {
        requiresAuth: false,
      }
    },
    {
      path: '/quote',
      name: 'Quote',
      component: () => import('../views/Quote.vue')
    },
    {
      path: '/financial',
      name: 'Financial',
      component: () => import('../views/Financial.vue')
    },

    {
      path: '/trade/:symbol?',
      name: 'Trade',
      component: () => import('../views/Trade.vue')
    },
    {
      path: '/defi',
      name: 'Defi',
      component: () => import('../views/Defi.vue')
    },
    {
      path: '/pledge',
      name: 'Pledge',
      component: () => import('../views/Pledge.vue')
    },
    {
      path: '/pledgeDetail/:id',
      name: 'PledgeDetail',
      component: () => import('../views/PledgeDetail.vue')
    },
    {
      path: '/pledgeOrder',
      name: 'PledgeOrder',
      component: () => import('../views/PledgeOrder.vue')
    },
    {
      path: '/agentCenter',
      name: 'AgentCenter',
      component: () => import('../views/AgentCenter.vue')
    },
    {
      path: '/loan',
      name: 'Loan',
      component: () => import('../views/Loan.vue')
    },
    {
      path: '/loanRule',
      name: 'LoanRule',
      component: () => import('../views/LoanRule.vue')
    },
    {
      path: '/loanRecord',
      name: 'LoanRecord',
      component: () => import('../views/LoanRecord.vue')
    },
    {
      path: '/assets',
      name: 'Assets',
      component: () => import('../views/Assets.vue')
    },
    {
      path: '/recharge',
      name: 'Recharge',
      component: () => import('../views/Recharge.vue')
    },
    {
      path: '/rechargeApply/:id',
      name: 'RechargeApply',
      component: () => import('../views/RechargeApply.vue')
    },
    {
      path: '/trade/:symbol?',
      name: 'Trade',
      component: () => import('../views/Trade.vue')
    },
    {
      path: '/auth/:task?/:invite?',
      name: 'Auth',
      component: () => import('../views/Auth.vue'),
      meta: {
        requiresAuth: false,
      }
    },
    {
      path: '/tradeSecond',
      name: 'TradeSecond',
      component: () => import('../views/TradeSecond.vue'),
    },
    {
      path: '/BBtrade',
      name: 'BBtrade',
      component: () => import('../views/BBtrade.vue'),
    },
    
    {
      path: '/productPlan',
      name: 'ProductPlan',
      component: () => import('../views/ProductPlan.vue'),
      meta: {
        requiresAuth: false,
      }
    },
    {
      path: '/swap',
      name: 'Swap',
      component: () => import('../views/Swap.vue'),
    },
    {
      path: '/transfer',
      name: 'Transfer',
      component: () => import('../views/Transfer.vue'),
    },

  ]
})

router.beforeEach((to, from, next) => {
  const requiresAuth = to.meta.requiresAuth === undefined ? true : to.meta.requiresAuth
  const isLogin = localStorage.getItem('isLogin') === 'true';
  if (requiresAuth) {
    if (isLogin) {
      next();
    } else {
      showConfirmDialog({
        title: '温馨提示',
        message: '需要登录进行此操作',
        confirmButtonText: '确认',
        cancelButtonText: '取消'
      })
        .then(() => {
          next({ name: 'Auth' });
        })
        .catch(() => {

        });
    }

  } else {
    next();
  }

});


export default router
