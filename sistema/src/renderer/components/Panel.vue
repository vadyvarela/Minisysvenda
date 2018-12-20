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
    <div  class="pl-4 pr-4 pt-2 pb-2">
    <h2 style="text-align:center" class="red--text"> <span>Sem conexão com a internet!</span> <br> Verifique sua conexão com a internet</h2>
        
    <!--v-btn xs6 class="primary" @click="logout">SAIR</v-btn-->
    </div>
  </v-app>

</div>
</template>

<script>
import Vendedor from "@/components/componentes/Vendedor";
import Admin from "@/components/componentes/Admin";
import { mapState } from 'vuex'
export default {
  components: {
    Vendedor,
    Admin
  },
  data: () => ({
    dark: false,
    isDark: false,
    drawer: null,
  }),
  methods: {
  },
  computed: {
    networkStatus () {
        return this.isOnline ? 'My network is fine' : 'I am offline'
    },
    ...mapState([
      'isUserLoggedIn',
      'user'
    ]),
  },
  props: [
    'title'
  ]
  
}
</script>
