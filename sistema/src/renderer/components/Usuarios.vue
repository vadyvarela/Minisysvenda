<template>
    <panel title="Usuarios">
      <v-content>
      <v-container fluid>

          <v-dialog @keydown.esc="dialogSenha= false" v-model="dialogSenha" persistent max-width="500px">
            <v-card>
              <v-card-title >
                <span class="headline">Atualizar senha usuario <br> <b> {{ user.nome }} </b></span>
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
                    <v-text-field name="nome" :rules="senhaRules" v-model="password" label="Digite a nova sennha" type="text"></v-text-field>
                  </v-form>
                </v-container>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="blue darken-1" flat @click.native="dialogSenha = false">Cancelar</v-btn>
                <v-btn :disabled="!valid" color="green darken-1" flat @click="updateSenha">Salvar</v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>

          <v-dialog @keydown.esc="dialog= false" v-model="dialog" persistent max-width="500px">
            <v-card>
              <v-card-title>
                <span class="headline center">Atualizar dados usuario <b> {{ user.nome }} </b></span>
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
                    <v-text-field name="nome" :rules="nomeRules" v-model="user.nome" label="Seu nome completo" type="text"></v-text-field>
                    <v-text-field name="usuario" :rules="usuarioRules" v-model="user.usuario" label="Usuario" type="text"></v-text-field>
                    <v-text-field name="nivel" :rules="nivelRules" v-model="user.nivel" label="Nivel de acesso" id="nivel" type="text"></v-text-field>
                    <small>Nivel de acesso <br> <span>1 = ADMINISTRADOR <br> 2 = VENDEDOR</span></small>
                  </v-form>
                </v-container>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="blue darken-1" flat @click.native="dialog = false">Cancelar</v-btn>
                <v-btn :disabled="!valid" color="green darken-1" flat @click="update">Salvar</v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>

          <v-layout justify-end row wrap>
              <v-flex text-lg-right xs6>
                <v-subheader>Usuarios Cadastrados no Sistema</v-subheader>
              </v-flex>
              <v-flex text-lg-right xs6>
                <v-btn router-link to="register" text-lg-right class="primary"><v-icon>perm_identity</v-icon> Novo usuario</v-btn>
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
        { text: "Nome ", name:"nome", align: "left", sortable: true},
        { text: "Usuario ", align: "left", sortable: false},
        { text: "Nivel ", align: "center", sortable: false},
        { text: 'Actions', align: "center", value: 'name', sortable: false }
      ],
      desserts: []
    };
  },
  async mounted() {
    // Fazer requisicao para pegar todas os produtos
    this.desserts = (await UsuariosServices.index()).data;
  },
  methods: {
    async inativarUser (item) {
      this.editedIndex = this.desserts.indexOf(item);
      this.user = Object.assign({}, item);
      const res = await this.$confirm('Deseja mesmo inativar usuario ' + this.user.nome + '?', {
      });
      
      if (res) {
        try {
          await AuthenticationService.inativar(this.user);
          this.$toast.success({
          title: "Aviso",
          message: "Usuario inativado com sucesso no sistema!"
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
      const res = await this.$confirm('Deseja mesmo ativar usuario ' + this.user.nome + '?', {
      });
      
      if (res) {
        try {
          await AuthenticationService.ativar(this.user);
          this.$toast.success({
          title: "Aviso",
          message: "Usuario foi ativado com sucesso no sistema!"
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
          Object.assign(this.desserts[this.editedIndex], this.user);
        } catch (error) {  
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
</style>
