<template>
  <v-app id="login" class="primary">
    <v-content>
      <div>
          <v-toolbar color="primary" dark fixed app>
          <v-toolbar-title> Faça cadastro </v-toolbar-title>
          <v-spacer></v-spacer>
          <v-btn :to="{name: 'login'}" outline> <v-icon> account_circle </v-icon> &nbsp; Fazer Login</v-btn>
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
          </v-toolbar>
          
      </div> 
      
      <v-container fluid fill-height>
        <v-layout align-center justify-center>
          <v-flex xs12 sm8 md6 lg6>
            <h2 align-center style="text-align:center; margin-bottom:30px; color: #fff; font-size:2.6em;">Digite os seus dados para começar <br> a usar o sistema</h2>
            <v-alert
              v-html="error"
              :value="alert"
              transition="scale-transition"
              type="error"
              >
            </v-alert>
            <v-card class="elevation-0 pa-0">
              <v-card-text>
                
                <v-stepper v-model="e1">
                <v-stepper-header>
                <v-stepper-step editable :complete="e1 > 1" step="1"> Informe os dado da loja </v-stepper-step>
                <v-divider></v-divider>
                <v-stepper-step step="2"> Usuario </v-stepper-step>
                </v-stepper-header>

                <v-stepper-items>
                <v-stepper-content step="1">
                  <v-text-field
                    box
                    append-icon="home"
                    name="loja_nome" 
                    v-model="loja.loja_nome" 
                    label="Nome da loja">
                  </v-text-field>
                  <v-text-field
                    box
                    append-icon="format_list_numbered"
                    type="number"
                    name="loja_nif"
                    :rules="rules"
                    :counter="9"
                    v-model="loja.loja_nif" 
                    label="Loja Nif">
                  </v-text-field>
                  <v-text-field
                    box
                    append-icon="phone"
                    name="loja_telefone" 
                    v-model="loja.loja_telefone" 
                    label="Numero de telefone">
                  </v-text-field>
                  <v-text-field
                    box
                    append-icon="place"
                    name="loja_endereco" 
                    v-model="loja.loja_endereco" 
                    label="Endereço da loja">
                  </v-text-field>

                  <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="primary" large :disabled="!formIsValid" @click="create(), e1 = 2"> <v-icon>arrow_forward</v-icon> &nbsp; Continuar  </v-btn>
                  </v-card-actions>
                </v-stepper-content>
                <v-stepper-content step="2">
                    <h2 hidden>{{ user.LojaId = idLoja }}</h2>
                    <input name="" v-model="user.LojaId" type="hidden"/>
                    <input name="" v-model="user.nivel" type="hidden"/>
                    <v-text-field 
                      box
                      append-icon="people"
                      name="usuario" 
                      v-model="user.nome" 
                      label="Nome completo" 
                      type="text">
                    </v-text-field>
                    <v-text-field
                        box
                        append-icon="account_circle"
                        name="usuario" 
                        v-model="user.usuario" 
                        :label="$t('message.nomeUser')">
                    </v-text-field>
                    <v-text-field
                        box
                        :append-icon="show1 ? 'visibility_off' : 'visibility'"
                        :type="show1 ? 'text' : 'password'"
                        @click:append="show1 = !show1"
                        name="password" 
                        v-model="user.password" 
                        :label="$t('message.passUser')" 
                        id="password">
                    </v-text-field>

                    <v-card-actions>
                        <v-spacer></v-spacer>
                        <v-btn large v-shortkey="['enter']" @shortkey="register" class="primary" @click="register"> <v-icon>arrow_forward </v-icon> &nbsp; FINALIZAR </v-btn>
                    </v-card-actions>
                </v-stepper-content>
                </v-stepper-items>
                </v-stepper>
              </v-card-text>
              

            </v-card>
          </v-flex>
        </v-layout>

      </v-container>
    </v-content>
  </v-app>
</template>
<script>
import AuthenticationService from "@/services/AuthenticationService";
import LojaService from "@/services/LojaService";
// import Loader from "./componentes/loader.vue"

export default {
  data() {
    return {
      e1: "",
      rules: [v => v.length <= 9 || 'Caracter maximo 9'],
      user: {
        LojaId: "",
        status: '1',
        nome: "",
        usuario: "",
        password: "",
        nivel: 1,
      },
      idLoja: [],
      error: null,
      alert: false,
      show1: false,
      loja: {
        loja_nif: null,
        loja_nome: null,
        loja_telefone: null,
        loja_endereco: null
      }
    };
  },
  methods: {
      async create() {
      try {
        await LojaService.post(this.loja);
        this.idLoja = (await LojaService.lastid()).data[0].id;
        console.log("ID LOJAS CADASTRADA - ", this.idLoja)
      } catch (err) {
        console.log(err);
      }
    },
    async register() {
      try {
        const response = await AuthenticationService.register({
          nome: this.user.nome,
          usuario: this.user.usuario,
          password: this.user.password,
          nivel: this.user.nivel,
          status: this.user.status,
          LojaId: this.user.LojaId
        });
        console.log("MEUS DADOS ---- ", response)
        this.$toast.success({
          title: "Succeso",
          message: "Registro efetuado com succeso!"
        })
        this.$store.dispatch("setToken", response.data.token);
        this.$store.dispatch("setUser", response.data.user);
        if (response.data.user.nivel === 1){
          this.$router.push({
            name: "dashboard"
          });
        } else {
          this.$router.push({
            name: "vendedor"
          });
        }
      } catch (error) {
        this.error = error.response.data.error;
        this.alert = true;
      }
    },
    /*async login() {
      try {
        const response = await AuthenticationService.login({
          usuario: this.usuario,
          password: this.password
        });
        this.$store.dispatch("setToken", response.data.token);
        this.$store.dispatch("setUser", response.data.user);
        //this.$store.commit('LOADER', true)
        if (response.data.user.nivel === 1){
          this.$router.push({
            name: "dashboard"
          });
        } else {
          this.$router.push({
            name: "vendedor"
          });
        }
        
      } catch (error) {
        this.error = error.response.data.error;
        // this.store.commit('LOADER', false)
        this.alert = true;
      }
    },*/
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
  },
  computed: {
    formIsValid() {
      return (
        this.loja.loja_nome &&
        this.loja.loja_nif &&
        this.loja.loja_telefone &&
        this.loja.loja_endereco
      )
    }
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