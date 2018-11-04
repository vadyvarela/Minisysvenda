<template>
    <panel title="Cadastrar novo código de barra">
      <v-content>
      <v-layout justify-end row wrap>
            <v-flex text-lg-right xs6>
              <v-btn router-link to="iva" text-lg-right class="primary"> Lista de códigos de barra </v-btn>
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
            <v-card class="elevation-0">
              <v-card-text>
                <v-form ref="form" name="cadastar" autocomplete="off" v-model="valid" lazy-validation>
                    <v-text-field box color="blue" required :rules="cbarraRules" name="cbarra_valor" v-model="cbarra.cbarra_valor" label="Código barra" type="text"></v-text-field>
                    <v-text-field box color="blue" required name="cbarra_desc" v-model="cbarra.cbarra_desc" label="Descrição" type="text"></v-text-field>
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
import CBarraService from "@/services/CBarraService";

export default {
  data() {
    return {
      valid: true,
      cbarraRules: [v => !!v || "Campo código de barra é obrigatório"],
      cbarra: {
        cbarra_valor: null,
        cbarra_desc: null
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
          await CBarraService.post(this.cbarra);
          this.$toast.success({
            title: "Sucesso",
            message: "Código de barra cadastrado co sucesso"
          });
          this.$router.push({
            name: "cbarra"
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