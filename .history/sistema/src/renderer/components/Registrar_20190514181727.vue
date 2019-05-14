<template>
    <panel :title="$t('message.cadUser')">
      <v-content>

        <v-snackbar
          v-model="snackbarnorow"
          :color="colornorow"
          :multi-line="mode === 'multi-line'"
          :timeout="timeout"
          :vertical="mode === 'vertical'">
          {{ textnorow }}
          <v-btn
            dark
            flat
            @click="snackbarnorow = false">
            Fechar
          </v-btn>
        </v-snackbar>
        
      <v-container fluid >
        <v-layout justify-end row wrap>
              <v-flex text-lg-right xs6>
                <v-btn router-link to="usuarios" text-lg-right class="primary"><v-icon>perm_identity</v-icon> {{$t('message.mostrarUser')}} </v-btn>
              </v-flex>
        </v-layout>

        <v-divider></v-divider>
<br>
        <v-layout align-center justify-center>
          <v-flex xs12 sm8 md4>
            <v-alert
              v-html="error"
              :value="alert"
              transition="scale-transition"
              type="error"
              >
            </v-alert>
            <v-card class="elevation-1">
              
              <v-card-text>
                <v-form name="cadastar" autocomplete="off">
                  <h2 hidden>{{ usuario.LojaId = user.LojaId }}</h2>
                  <input name="" v-model="usuario.LojaId" type="hidden"/>
                  <v-text-field name="usuario" append-icon="people" box v-model="usuario.nome" :label="$t('message.nomeCompleto')" type="text"></v-text-field>
                  <v-text-field box append-icon="account_circle" name="usuario" v-model="usuario.usuario" :label="$t('message.nomeUser')" type="text"></v-text-field>
                  <v-text-field box
                    :append-icon="show1 ? 'visibility_off' : 'visibility'"
                    :type="show1 ? 'text' : 'password'"
                    @click:append="show1 = !show1"
                    name="password" v-model="usuario.password" :label="$t('message.passUser')" id="password" ></v-text-field>
                  <v-select
                    box
                    name="nivel"
                    v-model="usuario.nivel"
                    :items="nivel"
                    :label="$t('message.levelUser')"
                    required
                    item-text="nome"
                    item-value="id"
                  ></v-select>
                </v-form>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn class="primary" large @click="register"> <v-icon>arrow_forward </v-icon> &nbsp; {{$t('message.cadastrar')}}</v-btn>
              </v-card-actions>
            </v-card>
          </v-flex>
        </v-layout>
      </v-container>
    </v-content>
    </panel>
</template>

<script>
import { mapState } from 'vuex'
import Panel from "@/components/Panel";
import AuthenticationService from "@/services/AuthenticationService";

export default {
  data () {
    return {
      nivel: [ { id: "1", nome: "Administrador" }, { id: "2", nome: "Vendedor"} ],
      usuario: {
        nome: "",
        LojaId: '',
        nivel: '',
        status: '1',
        usuario: "",
        password: ""
      },
      show1: false,
      error: null,
      alert: false
    };
  },
  computed: {
    ...mapState([
      'isUserLoggedIn',
      'user'
    ]),
  },
  methods: {
    async register() {
      try {
        const response = await AuthenticationService.register({
          nome: this.usuario.nome,
          usuario: this.usuario.usuario,
          password: this.usuario.password,
          nivel: this.usuario.nivel,
          status: this.usuario.status
        });
        this.$toast.success({
          title: "Succeso",
          message: "Usuario cadastrado com sucesso no sistema!"
        })
        this.$store.dispatch("setToken", response.data.token);
        this.$store.dispatch("setToken", response.data.user);
        this.$router.push({
          name: 'usuarios'
        })
      } catch (error) {
        if (!error.response) {
          this.snackbarnorow = true
        }
        this.error = error.response.data.error;
        this.alert = true;
      }
    }
  }
};
</script>

<style lang="css" scoped>

</style>
