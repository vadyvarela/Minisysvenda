<template>
    <panel title="Categorias dos produtos">
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

      <v-container>
            <v-dialog v-model="dialog" persistent max-width="500px">
            <v-card>
              <v-card-title>
                <span class="headline center">Atualizar dados categorias</span>
              </v-card-title>
              <v-card-text>
                <v-container grid-list-md>
                  <v-form ref="form" name="cadastar" autocomplete="off" v-model="valid" lazy-validation>
                    <v-text-field box required :rules="nomeRules" name="categoria_nome" v-model="categoria.categoria_nome" label="Nome de categoria" type="text"></v-text-field>
                    <v-text-field box required name="categoria_desc" v-model="categoria.categoria_desc" label="Descrição de categoria" type="text"></v-text-field>
                    <input ref="file" name="categoria_desc" type="hidden">
                    <v-flex xs12 class="text-xs-center text-sm-center text-md-center text-lg-center">
                      <img :src="imageUrl" height="150" v-if="imageUrl"/>
                      <v-text-field box label="Select Image" @click='pickFile' v-model='imageName' append-icon='attach_file'></v-text-field>
                      <input
                        type="file"
                        ref="file"
                        @change="onFilePicked"
                        style="display: none"
                        name=""
                        accept="image/*"
                      >
                    </v-flex>
                  </v-form>
                </v-container>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="red darken-1" outline flat @click.native="dialog = false">Cancelar</v-btn>
                <v-btn :disabled="!valid" outline color="green darken-1" flat @click="sendFile">Salvar</v-btn>
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
                  <td v-if="props.item.filename !== null">
                    <v-card width="100" style="padding:15px" flat tile class="d-flex">
                      <v-img
                        :src="'http://minisys.innovatmedialab.com/server/src/uploads/' + props.item.filename"
                        :lazy-src="'http://minisys.innovatmedialab.com/server/src/uploads/' + props.item.filename"
                        aspect-ratio="1"
                        class="grey lighten-2"
                      >
                        <v-layout
                          slot="placeholder"
                          fill-height
                          align-center
                          justify-center
                          ma-0
                        >
                          <v-progress-circular indeterminate color="grey lighten-5"></v-progress-circular>
                        </v-layout>
                      </v-img>
                    </v-card>
                  </td>
                  <td class="justify-center layout px-0 dark">
                    <v-btn flat icon color="green" @click="editCategoria(props.item)"> <v-icon>edit</v-icon> </v-btn>
                    <!--v-btn flat icon color="red" @click="deleteCategoria(props.item)"> <v-icon>delete</v-icon> </v-btn-->
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
import CategoriasService from "@/services/CategoriasService";

export default {
  data() {
    return {
      snackbarnorow: false,
      colornorow: 'error',
      textnorow: 'Erro ao ligar a base de dados! Verifica sua conexão com a internet!',
      mode: '',
      timeout: 6000,
      noDataLoading: 'Carregando os dados aguarde',
      imageName: '',
      imageUrl: '',
      imageFile: '',
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
    onFilePicked (e) {
      this.categoria.categoria_file = this.$refs.file.files[0]
			const files = e.target.files
			if(files[0] !== undefined) {
				this.imageName = files[0].name
				if(this.imageName.lastIndexOf('.') <= 0) {
					return
				}
				const fr = new FileReader ()
				fr.readAsDataURL(files[0])
				fr.addEventListener('load', () => {
					this.imageUrl = fr.result
					this.imageFile = files[0] // this is an image file that can be sent to server...
				})
			} else {
				this.imageName = ''
				this.imageFile = ''
				this.imageUrl = ''
			}
		},
    pickFile () {
        this.$refs.file.click ()
    },
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
    async sendFile() {
      console.log("DADOS CAT ---",  this.categoria);
      const formData = new FormData()
      formData.append('id', this.categoria.id)
      formData.append('file', this.categoria.categoria_file)
      formData.append('categoria_nome', this.categoria.categoria_nome)
      formData.append('categoria_desc', this.categoria.categoria_desc)
      console.log("DADOS CAT FOMDATA ---",  formData);
      try {
        this.dialog = false;
        await CategoriasService.put(formData, this.categoria);
        this.snackbar = true
        this.$router.push({
          name: "categorias"
        });
        Object.assign(this.desserts[this.editedIndex], this.categoria);
      } catch (error) {
        this.error = error.response.data.error;
        this.alert = true;
       
          if (!error.response) {
            this.meuloading = false
            this.snackbarnorow = true
          }
      }
    },
    /* async update() {
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
    }*/
  },
  async mounted() {
    try{
      this.desserts = (await CategoriasService.index()).data;
    }catch (error) {
      if (!error.response) {
        this.meuloading = false
        this.snackbarnorow = true
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
