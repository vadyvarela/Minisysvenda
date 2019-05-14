<template>
    <panel title="Nossos Clientes">
      <v-content>
      <v-container>
            <v-dialog v-model="dialog" persistent max-width="500px">
            <v-card>
              <v-card-title>
                <span class="headline center"> Atualizar Cliente </span>
              </v-card-title>
              <v-card-text>
                <v-container grid-list-md>
                  <v-form ref="form" name="cadastar" autocomplete="off" v-model="valid" lazy-validation>
                    <v-text-field box append-icon="account_circle" required :rules="nameRules" name="cliente_nome" v-model="cliente.cliente_nome" label="Nome do cliente" id="fornecedor_nome" type="text"></v-text-field>
                    <v-text-field box append-icon="perm_identity" required :rules="nifRules" :counter="9" name="cliente_nif" v-model="cliente.cliente_nif" label="NIF" id="cliente_nif" type="number"></v-text-field>
                    <v-text-field box append-icon="home" required :rules="enderecoRules" name="cliente_morada" v-model="cliente.cliente_morada" label="Morada do cliente" id="cliente_morada" type="text"></v-text-field>
                    <v-text-field box append-icon="smartphone" required :rules="contatoRules" name="cliente_telefone" v-model="cliente.cliente_telefone" label="Contato do cliente" id="cliente_telefone" type="number"></v-text-field>
                  </v-form>
                </v-container>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="red darken-1" outline flat @click.native="dialog = false"> {{ $t('message.cancelar') }} </v-btn>
                <v-btn :disabled="!valid" outline color="green darken-1" flat @click="update">{{ $t('message.salvar') }}</v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>

          <v-layout justify-end row wrap>
            <v-flex text-lg-left xs6>
              <v-subheader> Nossos Clientes </v-subheader>
            </v-flex>
            <v-flex text-lg-right xs6>
              <v-btn :to="{name: 'cadCliente'}" text-lg-right class="primary"> Cadastrar Cliente </v-btn>
            <v-snackbar
              v-model="snackbar"
              :color="color"
              :multi-line="mode === 'multi-line'"
              :timeout="timeout"
              :vertical="mode === 'vertical'"
            >
              {{ text }}
              <v-btn
                dark
                flat
                @click="snackbar = false"
              >
                Close
              </v-btn>
            </v-snackbar>
            </v-flex>
          </v-layout>

          <v-divider></v-divider>
          <v-card-title>
            <v-spacer></v-spacer>
            <v-text-field
              v-model="search"
              append-icon="search"
              single-line
              hide-details
              solo
              label="Pesquisar Cliente"
            ></v-text-field>
          </v-card-title>
            <v-data-table
                v-cloak
                :headers="headers"
                :items="desserts"
                :search="search"
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
                  <td>{{ props.item.cliente_nome }}</td>
                  <td class="text-xs-center ">{{ props.item.cliente_nif }}</td>
                  <td class="text-xs-left">{{ props.item.cliente_morada }}</td>
                  <td class="text-sm-left">{{ props.item.cliente_telefone }} </td>
                  <td class="justify-center layout px-0 dark">
                    <v-btn flat icon color="green" @click="editCliente(props.item)"> <v-icon>edit</v-icon> </v-btn>
                    <!-- v-btn flat icon color="red" @click="deleteFornecedor(props.item)"> <v-icon>delete</v-icon> </v-btn -->
                  </td>
                </template>
                <template slot="no-data">
                  <p class="noDataLoading"> {{ noDataLoading }} </p>
                </template>
                <v-alert slot="no-results" :value="true" color="error" icon="warning">
                  Sua pesquisa por "{{ search }}" não encontrou nenhum resultados.
                </v-alert>
            </v-data-table>
        </v-container>
      <v-divider></v-divider>
    </v-content>
    </panel>
</template>

<script>
import ClienteService from "@/services/ClienteService";

export default {
  data() {
    return {
      noDataLoading: 'Carregando os dados aguarde',
      search: '',
      snackbar: false,
      color: 'success',
      mode: '',
      timeout: 6000,
      text: 'Dados Cliente atualizado com sucesso',
      valid: true,
      nameRules: [v => !!v || "Campo nome é obrigatorio"],
      nifRules: [v => !!v || "Campo NIF é obrigatorio"],
      enderecoRules: [v => !!v || "Campo endereço é obrigatório"],
      contatoRules: [v => !!v || "Campo contato é obrigatorio"],
      editedIndex: -1,
      cliente: {
        cliente_nome: "",
        cliente_nif: "",
        cliente_morada: "",
        cliente_telefone: ""
      },
      error: null,
      alert: false,
      dialog: false,
      headers: [
        { text: "Nome Cliente ", value: 'cliente_nome', align: "left", sortable: true },
        { text: "NIF", value: 'cliente_nif', align: "center", sortable: true },
        { text: "Morada", value: 'cliente_morada', sortable: true },
        { text: "Contato", value: 'cliente_telefone', sortable: false },
        { text: "Actions", align: "right", value: "name", sortable: false }
      ],
      desserts: []
    };
  },
  methods: {
    async deleteCliente (item) {
      this.editedIndex = this.desserts.indexOf(item);
      this.cliente = Object.assign({}, item);
      const res = await this.$confirm('Deseja mesmo apagar o cliente?', {
      });
      
      if (res) {
        try {
          await ClienteService.delete(this.cliente);
          this.$toast.success({
          title: "Aviso",
          message: "Dados cliente eliminado com sucesso"
          })
          this.$router.push({
            name: "clientes"
          });
          this.desserts.splice(this.editedIndex, 1)
        } catch (err) {
          console.log(err);
        }
      }
    },
    editCliente: function(item) {
      this.editedIndex = this.desserts.indexOf(item);
      this.cliente = Object.assign({}, item);
      this.dialog = true;
    },
    async update() {
      if (this.$refs.form.validate()) {
        try {
          this.dialog = false;
          await ClienteService.put(this.cliente);
          this.snackbar = true
          this.$router.push({
            name: "clientes"
          });
          Object.assign(this.desserts[this.editedIndex], this.cliente);
        } catch (err) {
          console.log(err);
        }
      }
      this.close();
    }
  },
  async mounted() {
    // Fazer requisicao para pegar todas os produtos
    this.desserts = (await ClienteService.index()).data;
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
[v-cloak] {
    display: none;
  }
</style>
