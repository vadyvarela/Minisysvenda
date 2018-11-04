<template>
    <panel title="Cadastrar fornecedor">
      <v-content>
      <v-layout justify-end row wrap>
              <v-flex text-lg-right xs6>
                <v-btn router-link to="fornecedores" text-lg-right class="primary"><v-icon>perm_identity</v-icon> Mostrar fornecedores </v-btn>
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
                  <v-text-field required :rules="nameRules" name="fornecedor_nome" v-model="fornecedor.fornecedor_nome" label="Nome de fornecedor" type="text"></v-text-field>
                  <v-text-field required :rules="nifRules" :counter="9" name="fornecedor_nif" v-model="fornecedor.fornecedor_nif" label="Numero de NIF" type="number"></v-text-field>
                  <v-text-field required :rules="enderecoRules" name="fornecedor_endereco" v-model="fornecedor.fornecedor_endereco" label="Endereço" type="text"></v-text-field>
                  <v-text-field required :rules="contatoRules" name="fornecedor_movel" v-model="fornecedor.fornecedor_movel" label="Contato telefonico" type="number"></v-text-field>
                  <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn  v-shortkey="['enter']" @shortkey="create" :disabled="!valid" class="primary" @click="create">Cadastrar fornecedor</v-btn>
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
import FornecedoresService from "@/services/FornecedorService";

export default {
  data() {
    return {
      valid: true,
      nameRules: [v => !!v || "Campo nome é obrigatorio"],
      nifRules: [
        v => !!v || "Campo NIF é obrigatorio",
        v => (v && v.length >= 9 || "Valor Maximo no campo NIF é 9 digitos")
      ],
      enderecoRules: [v => !!v || "Campo endereço é obrigatório"],
      contatoRules: [v => !!v || "Campo contato é obrigatorio"],
      fornecedor: {
        fornecedor_nome: null,
        fornecedor_nif: null,
        fornecedor_endereco: null,
        fornecedor_movel: null
      },
      error: null,
      alert: false,
      drawer: null
    };
  },
  methods: {
    async create() {
      if (this.$refs.form.validate()) {
        try {
          await FornecedoresService.post(this.fornecedor);
          this.$toast.success({
            title: "Sucesso",
            message: "Fornecedor cadastrado co sucesso"
          });
          this.$router.push({
            name: "fornecedores"
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