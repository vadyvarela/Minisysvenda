<template>
    <panel title="Categorias dos produtos">
      <v-content>
      <v-container>
            <v-dialog v-model="dialog" persistent max-width="500px">
            <v-card>
              <v-card-title>
                <span class="headline center">Atualizar dados categorias</span>
              </v-card-title>
              <v-card-text>
                <v-container grid-list-md>
                  <v-form ref="form" name="cadastar" autocomplete="off" v-model="valid" lazy-validation>
                    <v-text-field required :rules="nomeRules" name="categoria_nome" v-model="categoria.categoria_nome" label="Nome de catgoria" type="text"></v-text-field>
                    <v-text-field required name="categoria_desc" v-model="categoria.categoria_desc" label="Descrisção de categoria" type="text"></v-text-field>
                  </v-form>
                </v-container>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="blue darken-1" flat @click.native="dialog = false">Cancelar</v-btn>
                <v-btn :disabled="!valid" color="blue darken-1" flat @click="update">Salvar</v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>

          <v-layout justify-end row wrap>
            <v-flex text-lg-left xs6>
              <v-subheader>Categorias dos produtos</v-subheader>
            </v-flex>
            <v-flex text-lg-right xs6>
              <v-btn :to="{name: 'cadCategorias'}" text-lg-right class="primary"> Cadastrar novo categoria </v-btn>
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
              label="Pesquisar"
              single-line
              hide-details
              solo
              placeholder="Pesquisar categoria"
            ></v-text-field>
          </v-card-title>
            <v-data-table
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
                  <td>{{ props.item.categoria_nome }}</td>
                  <td class="text-xs-center ">{{ props.item.categoria_desc }}</td>
                  <td>
                    <img :src="'uploads/' + props.item.filename">
                  </td>
                  <td class="justify-center layout px-0 dark">
                    <v-btn flat icon color="green" @click="editCategoria(props.item)"> <v-icon>edit</v-icon> </v-btn>
                    <v-btn flat icon color="red" @click="deleteCategoria(props.item)"> <v-icon>delete</v-icon> </v-btn>
                  </td>
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
import CategoriasService from "@/services/CategoriasService";

export default {
  data() {
    return {
      search: '',
      snackbar: false,
      color: 'success',
      mode: '',
      timeout: 6000,
      text: 'Dados categoria atualizado com sucesso',
      valid: true,
      editedIndex: -1,
      nomeRules: [v => !!v || "Campo nome categoria é obrigatorio"],
      categoria: {
        categoria_nome: null,
        categoria_desc: null
      },
      error: null,
      alert: false,
      drawer: null,
      dialog: false,
      headers: [
        { text: "Nome categoria ", value: 'categoria_nome', align: "left", sortable: true },
        { text: "Descrisão", value: 'categoria_desc', align: "center", sortable: true },
        { text: "Actions", align: "right", value: "name", sortable: false }
      ],
      desserts: []
    };
  },
  methods: {
    async deleteCategoria (item) {
      this.editedIndex = this.desserts.indexOf(item);
      this.categoria = Object.assign({}, item);
      const res = await this.$confirm('Deseja mesmo apagar o categoria?', {
      });
      
      if (res) {
        try {
          await CategoriasService.delete(this.categoria);
          this.$toast.success({
          title: "Aviso",
          message: "Dados categoria eliminado com sucesso"
          })
          this.$router.push({
            name: "categorias"
          });
          this.desserts.splice(this.editedIndex, 1)
        } catch (err) {
          console.log(err);
        }
      }
    },
    editCategoria: function(item) {
      this.editedIndex = this.desserts.indexOf(item);
      this.categoria = Object.assign({}, item);
      this.dialog = true;
    },
    async update() {
      if (this.$refs.form.validate()) {
        try {
          this.dialog = false;
          await CategoriasService.put(this.categoria);
          this.snackbar = true
          this.$router.push({
            name: "categorias"
          });
          Object.assign(this.desserts[this.editedIndex], this.categoria);
        } catch (err) {
          console.log(err);
        }
      }
      this.close();
    }
  },
  async mounted() {
    // Fazer requisicao para pegar todas os produtos
    this.desserts = (await CategoriasService.index()).data;
  }
};
</script>

<style lang="css" scoped>
</style>
