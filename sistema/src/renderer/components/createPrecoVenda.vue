<template>
    <panel title="Cadastrar novo preço de venda">
      <v-content>
      <v-layout justify-end row wrap>
            <v-flex text-lg-right xs6>
              <v-btn router-link to="iva" text-lg-right class="primary"> Preços de venda cadastrados </v-btn>
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
                    <v-text-field required :rules="precoRules" name="pvenda_preco" v-model="pvenda.pvenda_preco" label="Valor" type="text"></v-text-field>
                    <v-text-field required name="pvenda_desc" v-model="pvenda.pvenda_desc" label="Descrição preço de venda" type="text"></v-text-field>
                  <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn v-shortkey="['enter']" @shortkey="create" :disabled="!valid" class="primary" @click="create">Cadastrar</v-btn>
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
import PVendaService from "@/services/PVendaServices";

export default {
  data() {
    return {
      valid: true,
      precoRules: [v => !!v || "Campo preço de venda é obrigatorio"],
      pvenda: {
        pvenda_desc: null,
        pvenda_preco: null
      },
      error: null,
      alert: false,
      drawer: null
    };
  },
  methods: {
    async create() {
      console.log(this.pvenda)
      if (this.$refs.form.validate()) {
        try {
          await PVendaService.post(this.pvenda);
          this.$toast.success({
            title: "Sucesso",
            message: "Preço de venda cadastrado co sucesso"
          });
          this.$router.push({
            name: "pvenda"
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