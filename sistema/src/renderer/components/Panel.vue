<template>
<div>
  <v-app :dark="dark" v-if="isUserLoggedIn, isOnline" id="inspire">
    <div v-if="user.nivel == 1">
      <admin/>
    </div>

    <div v-if="user.nivel == 2">
      <vendedor/>
    </div>

    <div class="pl-4 pr-4 pt-2 pb-2">
      <slot>
        No slot content defined.
      </slot>
    </div>

    <v-footer v-if="!user.nivel == 2" color="primary" app inset>
        <span align-center class="white--text">&nbsp;&nbsp;&nbsp;Sistema de vendas &copy; Imedia <span>{{ new Date() | moment("YYYY") }}</span></span>
    </v-footer>
  </v-app>

  <v-app v-if="!isUserLoggedIn, isOffline" id="inspire">
    <conexao/>
  </v-app>

</div>
</template>

<script>
import Vendedor from "@/components/componentes/Vendedor";
import Admin from "@/components/componentes/Admin";
import Conexao from "@/components/componentes/Conexao";
import { mapState } from 'vuex'
export default {
  components: {
    Vendedor,
    Admin,
    Conexao
  },
  data: () => ({
    dark: false,
    isDark: false,
    drawer: null,
  }),
  methods: {
    switchLocale () {
      if (this.$i18n.locale === 'pt') {
        this.$i18n.locale = 'en'
      } else if (this.$i18n.locale === 'en') {
        this.$i18n.locale = 'ch'
      } else {
        this.$i18n.locale = 'pt'
      }
    },
    switchLocalePt () {
      this.$i18n.locale = 'pt'
    },
    switchLocaleCh () {
      this.$i18n.locale = 'ch'
    },
    logout () {
      this.$store.dispatch('setToken', null)
      this.$store.dispatch('setUser', null)
      //TODO: redirect to login page
      this.$router.push({
        name: 'login'
      })
    }
  },
  computed: {
    networkStatus () {
        return this.isOnline ? 'My network is fine' : 'I am offline'
    },
    ...mapState([
      'isUserLoggedIn',
      'user'
    ]),
    displayLocale () {
      let other = 'Portugues'
      if (this.$i18n.locale === 'pt') {
        other = 'Ingles'
      } else if (this.$i18n.locale === 'en') {
        other = 'Chines'
      }
      return other
    }
  },
  props: [
    'title'
  ]
  
}
</script>
