<template>
    <panel :title="$t('message.cadNovoFornec')">
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
                <v-btn router-link to="fornecedores" text-lg-right class="primary"><v-icon>perm_identity</v-icon> {{ $t('message.mostarFornecedor') }} </v-btn>
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
                  <v-text-field box append-icon="account_circle" required :rules="nameRules" name="fornecedor_nome" v-model="fornecedor.fornecedor_nome" :label="$t('message.novoFornecedor')" type="text"></v-text-field>
                  <v-text-field box append-icon="perm_identity" required :rules="nifRules" :counter="9" name="fornecedor_nif" v-model="fornecedor.fornecedor_nif" label="NIF" type="number"></v-text-field>
                  <v-text-field box append-icon="home" required :rules="enderecoRules" name="fornecedor_endereco" v-model="fornecedor.fornecedor_endereco" :label="$t('message.endereco')" type="text"></v-text-field>
                  <v-text-field box append-icon="smartphone" required :rules="contatoRules" name="fornecedor_movel" v-model="fornecedor.fornecedor_movel" :label="$t('message.telefone')" type="number"></v-text-field>
                  <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn  v-shortkey="['enter']" @shortkey="create" :disabled="!valid" class="primary" @click="create"> {{ $t('message.cadFornenedor') }} </v-btn>
                  </v-card-actions>
               </v-form>
              </v-card-text>
              
            </v-card>
          </v-flex>
        </v-layout>


        <v-dialog
          v-model="meuloading"
          hide-overlay
          persistent
          width="300"
        >
          <v-card
            color="primary"
            dark
          >
            <v-card-text>
              Fazendo cadastro, Aguarde...
              <v-progress-linear
                indeterminate
                color="white"
                class="mb-0"
              ></v-progress-linear>
            </v-card-text>
          </v-card>
        </v-dialog>


    </v-content>
    </panel>
</template>

<script>
import FornecedoresService from "@/services/FornecedorService";

export default {
  data() {
    return {
      snackbarnorow: false,
      colornorow: 'error',
      textnorow: 'Erro ao ligar a base de dados! Verifica sua conexão com a internet!',
      mode: '',
      timeout: 6000,
      meuloading: false,
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
          this.meuloading = true
          await FornecedoresService.post(this.fornecedor);
          this.meuloading = false
          this.$toast.success({
            title: "Sucesso",
            message: "Fornecedor cadastrado co sucesso"
          });
          this.$router.push({
            name: "fornecedores"
          });
        } catch (error) {
          if (!error.response) {
            this.meuloading = false
            this.snackbarnorow = true
          }
        }
      }
    }
  }
};
</script>

<style scoped>
</style>