<template>
    <panel :title="$t('message.nossosfornecedores')">
      <v-content>
      <v-container>
            <v-dialog v-model="dialog" persistent max-width="500px">
            <v-card>
              <v-card-title>
                <span class="headline center"> {{ $t('message.updateDadFornec') }} </span>
              </v-card-title>
              <v-card-text>
                <v-container grid-list-md>
                  <v-form ref="form" name="cadastar" autocomplete="off" v-model="valid" lazy-validation>
                    <v-text-field box append-icon="account_circle" required :rules="nameRules" name="fornecedor_nome" v-model="fornecedor.fornecedor_nome" :label="$t('message.novoFornecedor')" id="fornecedor_nome" type="text"></v-text-field>
                    <v-text-field box append-icon="perm_identity" required :rules="nifRules" :counter="9" name="fornecedor_nif" v-model="fornecedor.fornecedor_nif" label="NIF" id="fornecedor_nif" type="number"></v-text-field>
                    <v-text-field box append-icon="home" required :rules="enderecoRules" name="fornecedor_endereco" v-model="fornecedor.fornecedor_endereco" :label="$t('message.endereco')" id="fornecedor_endereco" type="text"></v-text-field>
                    <v-text-field box append-icon="smartphone" required :rules="contatoRules" name="fornecedor_movel" v-model="fornecedor.fornecedor_movel" :label="$t('message.telefone')" id="fornecedor_movel" type="number"></v-text-field>
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
              <v-subheader> {{ $t('message.nossosfornecedores') }} </v-subheader>
            </v-flex>
            <v-flex text-lg-right xs6>
              <v-btn :to="{name: 'cadFornecedores'}" text-lg-right class="primary"> {{ $t('message.cadNovoFornec') }} </v-btn>
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
              :label="$t('message.pesquisarfornecedor')"
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
                  <td>{{ props.item.fornecedor_nome }}</td>
                  <td class="text-xs-center ">{{ props.item.fornecedor_nif }}</td>
                  <td class="text-xs-left">{{ props.item.fornecedor_endereco }}</td>
                  <td class="text-sm-left">{{ props.item.fornecedor_movel }} </td>
                  <td class="justify-center layout px-0 dark">
                    <v-btn flat icon color="green" @click="editFornecedor(props.item)"> <v-icon>edit</v-icon> </v-btn>
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
import FornecedoresService from "@/services/FornecedorService";

export default {
  data() {
    return {
      noDataLoading: 'Carregando os dados aguarde',
      search: '',
      snackbar: false,
      color: 'success',
      mode: '',
      timeout: 6000,
      text: 'Dados fornecedor atualizado com sucesso',
      valid: true,
      nameRules: [v => !!v || "Campo nome é obrigatorio"],
      nifRules: [v => !!v || "Campo NIF é obrigatorio"],
      enderecoRules: [v => !!v || "Campo endereço é obrigatório"],
      contatoRules: [v => !!v || "Campo contato é obrigatorio"],
      editedIndex: -1,
      fornecedor: {
        fornecedor_nome: "",
        fornecedor_nif: "",
        fornecedor_endereco: "",
        fornecedor_movel: ""
      },
      error: null,
      alert: false,
      dialog: false,
      headers: [
        { text: "Nome fornecedor ", value: 'fornecedor_nome', align: "left", sortable: true },
        { text: "NIF", value: 'fornecedor_nif', align: "center", sortable: true },
        { text: "Endereço", value: 'fornecedor_endereco', sortable: true },
        { text: "Contato", value: 'fornecedor_movel', sortable: false },
        { text: "Actions", align: "right", value: "name", sortable: false }
      ],
      desserts: []
    };
  },
  methods: {
    async deleteFornecedor (item) {
      this.editedIndex = this.desserts.indexOf(item);
      this.fornecedor = Object.assign({}, item);
      const res = await this.$confirm('Deseja mesmo apagar o fornecedor?', {
      });
      
      if (res) {
        try {
          await FornecedoresService.delete(this.fornecedor);
          this.$toast.success({
          title: "Aviso",
          message: "Dados fornecedor eliminado com sucesso"
          })
          this.$router.push({
            name: "fornecedores"
          });
          this.desserts.splice(this.editedIndex, 1)
        } catch (err) {
          console.log(err);
        }
      }
    },
    editFornecedor: function(item) {
      this.editedIndex = this.desserts.indexOf(item);
      this.fornecedor = Object.assign({}, item);
      this.dialog = true;
    },
    async update() {
      if (this.$refs.form.validate()) {
        try {
          this.dialog = false;
          await FornecedoresService.put(this.fornecedor);
          this.snackbar = true
          /*this.$toast.success({
            title: "Sucesso",
            message: "Dados fornecedor atualizado com sucesso"
          });*/
          this.$router.push({
            name: "fornecedores"
          });
          Object.assign(this.desserts[this.editedIndex], this.fornecedor);
        } catch (err) {
          console.log(err);
        }
      }
      this.close();
    }
  },
  async mounted() {
    // Fazer requisicao para pegar todas os produtos
    this.desserts = (await FornecedoresService.index()).data;
    console.log("ERRO:" + error)
        console.log("teste" + error.response)
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
