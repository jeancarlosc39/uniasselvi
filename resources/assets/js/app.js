global.jQuery = require('jquery');
var $ = global.jQuery;
window.$ = $;

const Vue = require('vue');
window.axios = require('axios');
window.axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest'
Vue.prototype.$http = window.axios

import MaskedInput from 'vue-text-mask'
import Vuetify from 'vuetify'
import store from '~/store'
import router from '~/router'
import { i18n } from '~/plugins'
import App from '~/components/App'
import money from 'v-money'

import '~/components'
Vue.component('masked-input', MaskedInput);
Vue.component('notification', require('./components/Notification.vue'));

Vue.use(Vuetify)
Vue.config.productionTip = false;
Vue.use(money, {precision: 4})

// As a plugin
// Or as a directive
// Global
import VueTheMask from 'vue-the-mask'
Vue.use(VueTheMask)

import JqueryMask from 'jquery-mask-plugin'
Vue.use(JqueryMask )

import VInputmask from 'v-inputmask';

Vue.use(VInputmask);

new Vue({
  el: '#app',
  i18n,
  store,
  router,
  ...App
})
