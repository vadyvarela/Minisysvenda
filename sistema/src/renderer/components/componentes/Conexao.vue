<template>
<div>
    <v-container>
      <v-toolbar color="primary" dark fixed app>
    <v-toolbar-title> MiniSysVenda </v-toolbar-title>
      <v-spacer></v-spacer>
          <v-menu offset-y>
            <v-btn
              fab
              small
              outline
              slot="activator"
            >
              <v-icon>language</v-icon>
            </v-btn>
              <v-list light>
                <v-list-tile v-on:click="switchLocalePt()">
                  <img style="margin-right:8px" src="http://minisys.innovatmedialab.com/server/img/portugal.png" alt="MiniSysVenda" width="30" height="30">
                  <v-list-tile-title> PORTUGUES</v-list-tile-title>
                </v-list-tile>
              </v-list>
              <v-divider></v-divider>
              <v-list light>
                <v-list-tile v-on:click="switchLocaleCh()">
                  <img style="margin-right:8px" src="http://minisys.innovatmedialab.com/server/img/china.png" alt="MiniSysVenda" width="30" height="30">
                  <v-list-tile-title> CHINES</v-list-tile-title>
                </v-list-tile>
              </v-list>
          </v-menu>
      <v-btn icon @click="logout">
      <v-icon>exit_to_app</v-icon>
    </v-btn>
    </v-toolbar>
      <v-content>
        <div  class="pl-4 pr-4 pt-2 pb-2">
          <div class="layout column align-center">
            <img src="http://minisys.innovatmedialab.com/server/img/errorn.png" alt="MiniSysVenda" width="120" height="120">
            <h1 class="flex my-4 primary--text">MiniSysVenda</h1>
          </div>
          <div class="layout column align-center">
            <span class="pText red--text">Sem conexão com a internet!</span>
            <span class="sText orange--text">Verifique sua conexão com a internet</span> <br>
            <!--v-divider></v-divider>
            <v-btn xs6 fab large class="primary" @click="logout"><v-icon>loop</v-icon></v-btn-->
          </div>
        </div>
      </v-content>
    </v-container>
</div> 
</template>

<script>
import { mapState } from 'vuex'
export default {
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
<style scoped>
.pText{
  text-align:center;
  text-transform: uppercase;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  font-size: 2em;
  margin-top: 20px;
}
.sText{
  font-size: 1.4em;
  font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
}

</style>

