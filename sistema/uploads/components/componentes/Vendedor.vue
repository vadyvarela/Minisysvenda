<template>
<div>
    <v-toolbar color="primary" dark fixed app>
    <v-toolbar-title> Bemvindo {{ user.nome }} </v-toolbar-title>
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
          <img style="margin-right:8px" src="/static/portugal.png" alt="MiniSysVenda" width="30" height="30">
          <v-list-tile-title> PORTUGUES</v-list-tile-title>
        </v-list-tile>
      </v-list>
      <v-divider></v-divider>
      <v-list light>
        <v-list-tile v-on:click="switchLocaleCh()">
          <img style="margin-right:8px" src="/static/china.png" alt="MiniSysVenda" width="30" height="30">
          <v-list-tile-title> CHINES</v-list-tile-title>
        </v-list-tile>
      </v-list>
    </v-menu>
    <v-btn icon @click="logout">
      <v-icon>exit_to_app</v-icon>
    </v-btn>
    </v-toolbar>
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

