<template>
    <panel :title="$t('message.usuarios')">
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

        <v-dialog
          v-model="meuloading"
          persistent
          width="300">
          <v-card
            color="primary"
            dark>
            <v-card-text>
              Carregando os dados, Aguarde...
              <v-progress-linear
                indeterminate
                color="white"
                class="mb-0"
              ></v-progress-linear>
            </v-card-text>
          </v-card>
        </v-dialog>

      <v-container fluid>

          <v-dialog @keydown.esc="dialogSenha= false" v-model="dialogSenha" persistent max-width="500px">
            <v-card>
              <v-card-title >
                <span class="headline"> {{ $t('message.updatesenhauser') }} <br> <b> {{ user.nome }} </b></span>
              </v-card-title>
              <v-card-text>
                <v-container grid-list-md>
                  <v-alert
                    v-html="error"
                    :value="alert"
                    transition="scale-transition"
                    type="error"
                    >
                  </v-alert>
                  <v-form ref="form" name="cadastar" autocomplete="off" v-model="valid" lazy-validation>
                    <v-text-field box
                    :rules="senhaRules"
                    :append-icon="show1 ? 'visibility_off' : 'visibility'"
                    :type="show1 ? 'text' : 'password'"
                    @click:append="show1 = !show1"
                    name="password" v-model="password" :label="$t('message.passUser')" id="password" ></v-text-field>
                  
                  </v-form>
                </v-container>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="red darken-1" flat outline @click.native="dialogSenha = false">{{ $t('message.cancelar') }}</v-btn>
                <v-btn :disabled="!valid" outline color="green darken-1" flat @click="updateSenha">{{ $t('message.salvar') }}</v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>

          <v-dialog @keydown.esc="dialog= false" v-model="dialog" persistent max-width="500px">
            <v-card>
              <v-card-title>
                <span class="headline center">{{ $t('message.updatedadosuser') }} <b> {{ user.nome }} </b></span>
              </v-card-title>
              <v-card-text>
                <v-container grid-list-md>

                  <v-alert
                    v-html="error"
                    :value="alert"
                    transition="scale-transition"
                    type="error"
                    >
                  </v-alert>

                  <v-form ref="form" name="cadastar" autocomplete="off" v-model="valid" lazy-validation>
                    <v-text-field box append-icon="people" name="nome" :rules="nomeRules" v-model="user.nome" :label="$t('message.nomeCompleto')" type="text"></v-text-field>
                    <v-text-field box append-icon="account_circle" name="usuario" :rules="usuarioRules" v-model="user.usuario" :label="$t('message.nomeUser')" type="text"></v-text-field>
                    <v-text-field box name="nivel" :rules="nivelRules" v-model="user.nivel" :label="$t('message.levelUser')" id="nivel" type="text"></v-text-field>
                    <small>Nivel de acesso <br> <span>1 = ADMINISTRADOR <br> 2 = VENDEDOR</span></small>
                  </v-form>
                </v-container>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="red darken-1" flat outline @click.native="dialog = false">{{ $t('message.cancelar') }}</v-btn>
                <v-btn :disabled="!valid" outline color="green darken-1" flat @click="update">{{ $t('message.salvar') }}</v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>

          <v-layout justify-end row wrap>
              <v-flex text-lg-right xs6>
                <v-subheader> {{ $t('message.titleuser') }}</v-subheader>
              </v-flex>
              <v-flex text-lg-right xs6>
                <v-btn router-link to="register" text-lg-right class="primary"><v-icon>perm_identity</v-icon> {{ $t('message.novouser') }} </v-btn>
              </v-flex>
          </v-layout>

          <v-divider></v-divider>
          <br>

          <v-data-table
              :headers="headers"
              :items="desserts"
              hide-actions
              class="elevation-1"
          >
              <template slot="headerCell" slot-scope="props">
              <v-tooltip bottom>
                  <span slot="activator">
                  {{ props.header.text }}
                  </span>
                  <span>
                  {{ props.header.text }}
                  </span>
              </v-tooltip>
              </template>
              <template slot="items" slot-scope="props">
              <td>{{ props.item.nome }}</td>
              <td>{{ props.item.usuario }}</td>
              <td v-if=" props.item.nivel == 1 " class="text-xs-center "> <span class="green--text">Administrador</span>  </td>
              <td v-if=" props.item.nivel == 2 " class="text-xs-center "> <span class="primary--text">Vendedor</span> </td>
              <td class="justify-center layout px-0 dark">
                <v-tooltip left>
                  <v-btn slot="activator" flat icon color="green" @click="editUser(props.item)"> <v-icon>edit</v-icon> </v-btn>
                  <span>Editar usuario</span>
                </v-tooltip>
                <v-tooltip left>
                  <v-btn slot="activator" flat icon color="green" @click="editSenha(props.item)"> <v-icon>lock</v-icon> </v-btn>
                  <span>Mudar senha</span>
                </v-tooltip>
                <v-tooltip left>
                  <v-btn slot="activator" v-if="props.item.status == 1" flat icon color="red" @click="inativarUser(props.item)"> <v-icon>block</v-icon> </v-btn>
                  <v-btn slot="activator" v-if="props.item.status == 2" flat icon color="green" @click="ativarUser(props.item)"> <v-icon>block</v-icon> </v-btn>
                  <span v-if="props.item.status == 1">Inativar usuario no sistema</span>
                  <span v-if="props.item.status == 2">Ativar usuario no sistema</span>
                </v-tooltip>
              </td>
              </template>
              <template slot="no-data">
                <p class="noDataLoading"> {{ noDataLoading }} </p>
              </template>
          </v-data-table>
      </v-container>
      <v-divider></v-divider>
    </v-content>
    </panel>
</template>

<script>
import UsuariosServices from "@/services/UsuariosServices";
import AuthenticationService from "@/services/AuthenticationService";

export default {
  data() {
    return {
      meuloading:false,
      snackbarnorow: false,
      colornorow: 'error',
      textnorow: 'Erro ao ligar a base de dados! Verifica sua conexão com a internet!',
      mode: '',
      timeout: 6000,
      noDataLoading: this.$t('message.carregandoaguarde'),
      show1: false,
      password: null,
      error: null,
      alert: false,
      valid: true,
      editedIndex: -1,
      nomeRules: [v => !!v || "Campo nome completo é obrigatorio"],
      senhaRules: [v => !!v || "Campo senha é obrigatorio"],
      usuarioRules: [v => !!v || "Campo usuario é obrigatorio"],
      nivelRules: [v => !!v || "Campo nivel de acesso é obrigatorio"],
      user: {
        nome: null,
        usuario: null,
        status: null,
        password: null,
        nivel: null
      },
      dialog: false,
      dialogSenha: false,
      headers: [
        { text: this.$t('message.nomeCompleto'), name:"nome", align: "left", sortable: true},
        { text: this.$t('message.nomeUser'), align: "left", sortable: false},
        { text: this.$t('message.levelUser'), align: "center", sortable: false},
        { text: 'Actions', align: "center", value: 'name', sortable: false }
      ],
      desserts: []
    };
  },
  async mounted() {
    try{
    this.meuloading = true
    this.desserts = (await UsuariosServices.index()).data;
    }catch (error) {
      if (!error.response) {
        this.meuloading = false
        this.snackbarnorow = true
      }
    }
  },
  methods: {
    async inativarUser (item) {
      this.editedIndex = this.desserts.indexOf(item);
      this.user = Object.assign({}, item);
      const res = await this.$confirm(this.$t('message.msginative') + this.user.nome + '?', {
      });
      
      if (res) {
        try {
          await AuthenticationService.inativar(this.user);
          this.$toast.success({
          title: this.$t('message.aviso'),
          message: this.$t('message.inativeuser')
          })
          this.$router.push({
            name: "usuarios"
          });
          Object.assign(this.desserts[this.editedIndex], this.user);
        } catch (err) {
          console.log(err);
        }
      }
    },
    async ativarUser (item) {
      this.editedIndex = this.desserts.indexOf(item);
      this.user = Object.assign({}, item);
      const res = await this.$confirm(this.$t('message.msgactive') + this.user.nome + '?', {
      });
      
      if (res) {
        try {
          await AuthenticationService.ativar(this.user);
          this.$toast.success({
          title: this.$t('message.aviso'),
          message: this.$t('message.activeuser')
          })
          this.$router.push({
            name: "usuarios"
          });
         Object.assign(this.desserts[this.editedIndex], this.user);
        } catch (err) {
          console.log(err);
        }
      }
    },
    editUser: function(item) {
      this.editedIndex = this.desserts.indexOf(item);
      this.user = Object.assign({}, item);
      this.dialog = true;
    },
    editSenha: function(item) {
      this.editedIndex = this.desserts.indexOf(item);
      this.user = Object.assign({}, item);
      this.dialogSenha = true;
    },
    async update() {
      if (this.$refs.form.validate()) {
        try {
          this.dialog = false;
          const response = await AuthenticationService.put({
            id: this.user.id,
            nome: this.user.nome,
            usuario: this.user.usuario,
            // password: this.user.password,
            nivel: this.user.nivel
          })
          this.$toast.success({
            title: "Aviso",
            message: "Dados usuario atualizado com sucesso"
          })
          this.$router.push({
            name: "usuarios"
          });
          Object.assign(this.desserts[this.editedIndex], this.user);
        } catch (error) {
          if (!error.response) {
            this.meuloading = false
            this.snackbarnorow = true
          } 
          this.dialog = true;
          this.error = error.response.data.error;
          this.alert = true;
        }
      }
    },
    async updateSenha() {
      if (this.$refs.form.validate()) {
        try {
          this.dialogSenha = false;
          const response = await AuthenticationService.putsenha({
            id: this.user.id,
            nome: this.user.nome,
            usuario: this.user.usuario,
            password: this.password,
            nivel: this.user.nivel
          })
          this.$toast.success({
            title: "Aviso",
            message: "Senha usuario atualizado com sucesso"
          })
          this.$router.push({
            name: "usuarios"
          });
          this.password = ""
          Object.assign(this.desserts[this.editedIndex], this.user);
        } catch (error) {
          if (!error.response) {
            this.meuloading = false
            this.snackbarnorow = true
          }  
          this.dialogSenha = true;
          this.error = error.response.data.error;
          this.alert = true;
        }
      }
    }
  }
};
</script>

<style lang="css" scoped>
.noDataLoading{
  padding: 30px;
  font-size: 1.2em;
  text-align: center;
  color: #c37f2a;
}
</style>
