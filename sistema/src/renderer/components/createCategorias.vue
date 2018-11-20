<template>
    <panel title="Cadastrar fornecedor">
      <v-content>
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
                <v-form ref="form" name="cadastar" autocomplete="off" v-model="valid" lazy-validation>
                  <v-text-field required :rules="nomeRules" name="categoria_nome" v-model="categoria.categoria_nome" label="Nome de catgoria" type="text"></v-text-field>
                  <v-text-field required name="categoria_desc" v-model="categoria.categoria_desc" label="Descrisção de categoria" type="text"></v-text-field>
                  <v-content>
                  <v-container fluid>
                    <v-flex xs12 class="text-xs-center text-sm-center text-md-center text-lg-center">
                      <img :src="imageUrl" height="150" v-if="imageUrl"/>
                      <v-text-field label="Select Image" @click='pickFile' v-model='imageName' prepend-icon='attach_file'></v-text-field>
                      <input
                        type="file"
                        style="display: none"
                        ref="image"
                        accept="image/*"
                        @change="onFilePicked"
                      >
                    </v-flex>
                  </v-container>
                  </v-content>
                  <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn v-shortkey="['enter']" @shortkey="create" :disabled="!valid" class="primary" @click="create">Cadastrar categoria</v-btn>
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
import CategoriasService from "@/services/CategoriasService";

export default {
  data() {
    return {
      imageName: '',
      imageUrl: '',
      imageFile: '',
      valid: true,
      nomeRules: [v => !!v || "Campo nome categoria é obrigatorio"],
      categoria: {
        categoria_nome: null,
        categoria_desc: null
      },
      error: null,
      alert: false,
      drawer: null
    };
  },
  methods: {
    pickFile () {
        this.$refs.image.click ()
    },
		onFilePicked (e) {
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
          console.log(files)
				})
			} else {
				this.imageName = ''
				this.imageFile = ''
				this.imageUrl = ''
			}
		},
    async create() {
      if (this.$refs.form.validate()) {
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
      }
    }
  }
};
</script>

<style scoped>
</style>