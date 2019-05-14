<template>
    <panel title="NOVO CLIENTE">
      <v-content>
      <v-layout justify-end row wrap>
              <v-flex text-lg-right xs6>
                <v-btn router-link to="clientes" text-lg-right class="primary"><v-icon>perm_identity</v-icon> Mostrar clientes </v-btn>
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
                 <v-text-field box append-icon="account_circle" required :rules="nameRules" name="cliente_nome" v-model="cliente.cliente_nome" label="Nome do cliente" id="fornecedor_nome" type="text"></v-text-field>
                    <v-text-field box append-icon="perm_identity" required :rules="nifRules" :counter="9" name="cliente_nif" v-model="cliente.cliente_nif" label="NIF" id="cliente_nif" type="number"></v-text-field>
                    <v-text-field box append-icon="home" required :rules="enderecoRules" name="cliente_morada" v-model="cliente.cliente_morada" label="Morada do cliente" id="cliente_morada" type="text"></v-text-field>
                    <v-text-field box append-icon="smartphone" required :rules="contatoRules" name="cliente_telefone" v-model="cliente.cliente_telefone" label="Contato do cliente" id="cliente_telefone" type="number"></v-text-field>
                  <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn  v-shortkey="['enter']" @shortkey="create" :disabled="!valid" class="primary" @click="create"> Cadastar Cliente </v-btn>
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
import ClienteService from "@/services/ClienteService";

export default {
  data() {
    return {
      meuloading: false,
      valid: true,
      nameRules: [v => !!v || "Campo nome é obrigatorio"],
      nifRules: [
        v => !!v || "Campo NIF é obrigatorio",
        v => (v && v.length >= 9 || "Valor Maximo no campo NIF é 9 digitos")
      ],
      enderecoRules: [v => !!v || "Campo endereço é obrigatório"],
      contatoRules: [v => !!v || "Campo contato é obrigatorio"],
      cliente: {
        cliente_nome: "",
        cliente_nif: "",
        cliente_morada: "",
        cliente_telefone: ""
      },
      error: null,
      alert: false,
      drawer: null
    };
  },
  methods: {
    async create() {
      
      if (this.$refs.form.validate()) {
        this.cliente = true
        try {
          await ClienteService.post(this.cliente);
          this.meuloading = false
          this.$toast.success({
            title: "Sucesso",
            message: "Cliente cadastrado co sucesso"
          });
          this.$router.push({
            name: "clientes"
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