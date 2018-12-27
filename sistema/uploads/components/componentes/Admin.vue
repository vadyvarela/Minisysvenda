<template>
    <div>
        
        
    </div>
</template>
<script>

import Panel from "@/components/Panel"
import { mapState } from 'vuex'
export default {
  components: {
    Panel
  },
  data: () => ({
    dark: false,
    isDark: false,
    drawer: false,
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
.v-list>div {
    padding: 5px !important;
}
.v-list--dense .v-list__tile:not(.v-list__tile--avatar) {
  height: 60px !important;
}
.v-list__tile__title {
    font-size: 1.2em !important;
}
.v-list__group__items>div {
    display: block;
    padding: 7px !important;
}
</style>
