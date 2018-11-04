<template>
    <panel title="Cadastar novo usuario">
      <v-content>
      <v-container fluid >
        
        <v-layout justify-end row wrap>
              <v-flex text-lg-right xs6>
                <v-btn router-link to="usuarios" text-lg-right class="primary"><v-icon>perm_identity</v-icon> Mostrar usuarios </v-btn>
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
                  <v-text-field name="usuario" v-model="usuario" label="Nome do usuario" type="text"></v-text-field>
                  <v-text-field name="password" v-model="password" label="Palavra passe" id="password" type="password"></v-text-field>
                  <v-select
                    name="nivel"
                    v-model="nivel"
                    :items="nivel"
                    label="Nivel do usuario"
                    required
                    item-text="nome"
                    item-value="id"
                  ></v-select>
                </v-form>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn class="primary" @click="register">Cadastrar</v-btn>
              </v-card-actions>
            </v-card>
          </v-flex>
        </v-layout>
      </v-container>
    </v-content>
    </panel>
</template>

<script>
import Panel from "@/components/Panel";
import AuthenticationService from "@/services/AuthenticationService";

export default {
  data () {
    return {
      nivel: [ { id: "1", nome: "Administrador" }, { id: "2", nome: "Vendedor"} ],
      usuario: "",
      password: "",
      error: null,
      alert: false
    };
  },
  methods: {
    async register() {
      try {
        const response = await AuthenticationService.register({
          usuario: this.usuario,
          password: this.password,
          nivel: this.nivel
        });
        this.$store.dispatch("setToken", response.data.token);
        this.$store.dispatch("setToken", response.data.user);
        this.$router.push({
          name: 'usuarios'
        })
      } catch (error) {
        this.error = error.response.data.error;
        this.alert = true;
      }
    }
  }
};
</script>

<style lang="css" scoped>

</style>
