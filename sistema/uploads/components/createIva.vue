<template>
    <panel title="Cadastrar novo valor Iva">
      <v-content>
      <v-layout justify-end row wrap>
            <v-flex text-lg-right xs6>
              <v-btn router-link to="iva" text-lg-right class="primary"> Mostrar valores cadastrados </v-btn>
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
                  <v-text-field required :rules="valorRules" name="iva_valor" v-model="iva.iva_valor" label="Valor do IVA" type="text"></v-text-field>
                    <v-text-field required name="iva_desc" v-model="iva.iva_desc" label="Descrição Iva" type="text"></v-text-field>
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
import IvaService from "@/services/IvaService";

export default {
  data() {
    return {
      valid: true,
      valorRules: [v => !!v || "Campo valor IVA é obrigatorio"],
      iva: {
        iva_valor: null,
        iva_desc: null
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
          await IvaService.post(this.iva);
          this.$toast.success({
            title: "Sucesso",
            message: "Valor IVA cadastrado co sucesso"
          });
          this.$router.push({
            name: "iva"
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