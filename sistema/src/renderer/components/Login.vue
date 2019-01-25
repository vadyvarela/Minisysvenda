<template>
<div>
  <v-app id="login" v-if="isOnline" class="primary">
    <v-content>
      <div>
          <v-toolbar color="primary" dark fixed app>
          <v-toolbar-title> {{ $t('message.bemvindominivenda') }} </v-toolbar-title>
          <v-spacer></v-spacer>
          <!--<v-btn :to="{name: 'registrarLoja'}" outline> <v-icon> account_circle </v-icon> &nbsp; Fazer cadastro</v-btn>-->
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
          </v-toolbar>
      </div> 
      <v-container fluid fill-height>
        <v-layout align-center justify-center>
          <v-flex xs12 sm8 md4 lg4>
            <v-alert
              v-html="error"
              :value="alert"
              transition="scale-transition"
              type="error"
              >
            </v-alert>
            <v-card class="elevation-1 pa-3">
              <v-card-text>
                <div class="layout column align-center">
                  <img src="http://minisys.innovatmedialab.com/server/img/m.png" alt="MiniSysVenda" width="120" height="120">
                  <h1 class="flex my-4 primary--text">MiniSysVenda</h1>
                </div>  
                        
                  <v-text-field
                  id="keyboard"
                    prepend-icon="person" 
                    name="usuario" 
                    v-model="usuario" 
                    :label="$t('message.nomeUser')">
                  </v-text-field>
                  <v-text-field
                    :append-icon="show1 ? 'visibility_off' : 'visibility'"
                    :type="show1 ? 'text' : 'password'"
                    @click:append="show1 = !show1"
                    prepend-icon="lock" 
                    name="password" 
                    v-model="password" 
                    :label="$t('message.passUser')" 
                    id="password">
                  </v-text-field>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn large v-shortkey="['enter']" @shortkey="login" class="primary" @click="login"> <v-icon>arrow_forward</v-icon> &nbsp; {{ $t('message.btnEfetuarLogn') }} </v-btn>
              </v-card-actions>

            </v-card>
          </v-flex>
        </v-layout>

         <v-dialog
          v-model="meuloading"
          hide-overlay
          persistent
          width="300"
        >
          <v-card
            color="primary"
            dark
          >
            <v-card-text>
              Efetuando login, Aguarde...
              <v-progress-linear
                indeterminate
                color="white"
                class="mb-0"
              ></v-progress-linear>
            </v-card-text>
          </v-card>
        </v-dialog>

      </v-container>
    </v-content>
  </v-app>
  <v-app v-if="isOffline" id="inspire">
    <conexao/>
  </v-app>
</div>
</template>
<script>
import AuthenticationService from "@/services/AuthenticationService";
import Conexao from "@/components/componentes/Conexao";
// import Loader from "./componentes/loader"

export default {
  data() {
    return {
      meuloading: false,
      usuario: "",
      password: "",
      error: null,
      alert: false,
      show1: false
    };
  },
  components: {
    Conexao
  },
  methods: {
    async login() {
      this.meuloading = true
      try {
        const response = await AuthenticationService.login({
          usuario: this.usuario,
          password: this.password
        });
        this.$store.dispatch("setToken", response.data.token);
        this.$store.dispatch("setUser", response.data.user);
        //this.$store.commit('LOADER', true)
        if (response.data.user.nivel === 1){
          this.meuloading = false
          this.$router.push({
            name: "dashboard"
          });
        } else {
          this.meuloading = false
          this.$router.push({
            name: "vendedor"
          });
        }
        
      } catch (error) {
        this.meuloading = false
        this.error = error.response.data.error;
        // this.store.commit('LOADER', false)
        this.alert = true;
      }
    },switchLocale () {
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
  }
};
</script>

<style scoped lang="css">
 
  #login {
    height: 50%;
    width: 100%;
    position: absolute;
    top: 0;
    left: 0;
    content: "";
    z-index: 0;
  }
</style>