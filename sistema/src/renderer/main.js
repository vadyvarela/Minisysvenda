import Vue from 'vue'
import Vuex from 'vuex'
import Vuetify from 'vuetify'
import VeeValidate from 'vee-validate'
import VueNumeric from 'vue-numeric'
// import { sync } from 'vuex-router-sync'
// import store from '@/store/store'
import axios from 'axios'
// Atalhos teclado
import VueShortkey from 'vue-shortkey'
// Notificação
import CxltToastr from 'cxlt-vue2-toastr'
import VueGoogleCharts from 'vue-google-charts'

import App from './App'
import router from './router'
import store from './store'
import VueI18n from 'vue-i18n'
import Panel from '@/components/Panel'
import './stylus/main.styl'

import "chart.js";
import "hchs-vue-charts";
Vue.use(window.VueCharts);

// Linguagens de erro de validacao de campos
import messagesPt from './i18n/messages/pt_PT.js';
import attributesPt from './i18n/attributes/pt_PT.js';
import messagesEn from './i18n/messages/en.js';
import attributesEn from './i18n/attributes/en.js';
import messagesCh from './i18n/messages/ch.js'
import attributesCh from './i18n/attributes/ch.js'
import VuetifyConfirm from 'vuetify-confirm'


import 'vuetify/dist/vuetify.min.css'
import 'material-design-icons-iconfont/dist/material-design-icons.css'
// import 'bootstrap/dist/css/bootstrap.css'
// import 'bootstrap-vue/dist/bootstrap-vue.css'
import Print from 'vue-print-nb'

Vue.use(Print);

// Configurar modeo exibicao notificacao
import 'cxlt-vue2-toastr/dist/css/cxlt-vue2-toastr.css'
var toastrConfigs = {
  position: 'top right',
  timeOut: 5000
}
Vue.use(require('vue-moment'));
Vue.use(Vuex)
Vue.use(VueCharts)
Vue.use(VuetifyConfirm, {
  buttonTrueText: 'SIM',
  buttonFalseText: 'Cancelar',
  color: 'error',
  icon: 'error',
  title: 'Aviso',
  width: 300,
  property: '$confirm'
})

Vue.use(VueNumeric)
Vue.use(VueGoogleCharts)
Vue.use(VueShortkey)
Vue.use(Vuetify)
Vue.use(VueI18n)
Vue.use(CxltToastr, toastrConfigs)
Vue.use(VeeValidate, {
  locale: 'ch',
  dictionary: {
    en: { messages: messagesEn, attributes: attributesEn }, //Mensagem Ingles
    ch: { messages: messagesCh, attributes: attributesCh }, //Mensagem Chines
    pt_PT: { messages: messagesPt, attributes: attributesPt } //Mensagen portugues
  }
})
import Traducao from './i18n/messages/ingles';

// Create VueI18n instance with options
const i18n = new VueI18n({
  locale: 'pt', // set locale
  messages: Traducao // set locale messages
})

if (!process.env.IS_WEB) Vue.use(require('vue-electron'))
Vue.http = Vue.prototype.$http = axios
Vue.config.productionTip = false
// Carregando o componente Header e Menu drawer
Vue.component('panel', Panel)

/* eslint-disable no-new */
new Vue({
  i18n,
  components: { App },
  router,
  store,
  template: '<App/>'
}).$mount('#app')

