<template>
    <panel title="Cadastrar fornecedor">
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

      <v-layout justify-end row wrap>
            <v-flex text-lg-right xs6>
              <v-btn router-link to="categorias" text-lg-right class="primary"> Mostrar categorias </v-btn>
            </v-flex>
        </v-layout>
        <v-divider></v-divider>
        <br>

        <v-layout align-center justify-center>
          <v-flex xs12 sm8 md8>
            <v-alert
              v-html="error"
              :value="alert"
              transition="scale-transition"
              type="error"
              >
            </v-alert>
            <v-card class="elevation-1">
              <v-card-text>
                <v-form method="post" name="cadastar" enctype="multipart/form-data" >
                  <v-text-field box required :rules="nomeRules" name="categoria_nome" v-model="categoria.categoria_nome" label="Nome de categoria" type="text"></v-text-field>
                  <v-text-field box required name="categoria_desc" v-model="categoria.categoria_desc" label="Descrição de categoria" type="text"></v-text-field>
                  <input ref="file" name="categoria_desc" type="hidden">
                  <!-- <input 
                    type="file"
                    ref="file"
                    @change="selectFile"
                  >-->
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
                  <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn v-shortkey="['enter']" @shortkey="sendFile" :disabled="!CatIsvalid" class="primary" @click="sendFile">Cadastrar categoria</v-btn>
                  </v-card-actions>
               </v-form>
              </v-card-text>
              
            </v-card>
          </v-flex>
        </v-layout>
    </v-content>
    </panel>
</template>

<script>
import axios from 'axios'
import CategoriasService from "@/services/CategoriasService";

export default {
  data() {
    return {
      meuloading: false,
      snackbarnorow: false,
      colornorow: 'error',
      textnorow: 'Erro ao ligar a base de dados! Verifica sua conexão com a internet!',
      mode: '',
      timeout: 6000,
      imageName: '',
      imageUrl: '',
      imageFile: '',
      valid: true,
      nomeRules: [v => !!v || "Campo nome categoria é obrigatorio"],
      categoria: {
        categoria_nome: null,
        categoria_desc: null,
        categoria_file: null
      },
      error: null,
      alert: false,
      drawer: null
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
    async sendFile() {
      const formData = new FormData()
      formData.append('file', this.categoria.categoria_file)
      formData.append('categoria_nome', this.categoria.categoria_nome)
      formData.append('categoria_desc', this.categoria.categoria_desc)
      try {
        this.meuloading = true
        await CategoriasService.post(formData)
        this.alert = false;
        this.$toast.success({
            title: "Sucesso",
            message: "Categoria cadastrado com sucesso"
          });
          this.snackbar = true
          this.$router.push({
            name: "categorias"
          });
          this.meuloading = false
      } catch (error) {
        if (!error.response) {
          this.meuloading = false
          this.snackbarnorow = true
        }
        this.error = error.response.data.error;
        this.alert = true;

      }
    },
    /* async create() {
        try {
          await CategoriasService.post(this.categoria);
          this.$toast.success({
            title: "Sucesso",
            message: "Categoria cadastrado co sucesso"
          });
          this.snackbar = true
          this.$router.push({
            name: "categorias"
          });
        } catch (err) {
          console.log(err);
        }
    } */
  },
};
</script>

<style scoped>
</style>