
import Vuex from 'vuex'

// import Vue from 'vue'
export default new Vuex.Store({
  state: {
    isLogin: false,
    coinSymbolDefault: '',
    coinTaskDefault: '',
  },
  getters: {
    getCoinSymbolDefault(state) {
      let config = JSON.parse(sessionStorage.getItem('config'));
      return state.coinSymbolDefault !== '' ? state.coinSymbolDefault : config.default_coin
    }
  },
  mutations: {
    login(state) {
      state.isLogin = true
    },
    logout(state) {
      state.isLogin = false
    },
    setCoinSymbolDefault(state, payload) {
      let config = JSON.parse(sessionStorage.getItem('config'));
      if (!config) {
        config = {};
      }
      config.default_coin = payload;
      sessionStorage.setItem('config', JSON.stringify(config));
      state.coinSymbolDefault = payload;
    }
  },
  actions: {
    loadCoinDefault({ commit },symbol) {
      commit('setCoinSymbolDefault', symbol);
    }
  },
  modules: {}
})