<template>
    <panel title="Lista código de barra">
      <v-content>
      <v-container>
            <v-dialog v-model="dialog" persistent max-width="500px">
            <v-card>
              <v-card-title>
                <span class="headline center">Atualizar dados código barra</span>
              </v-card-title>
              <v-card-text>
                <v-container grid-list-md>
                  <v-form ref="form" name="cadastar" autocomplete="off" v-model="valid" lazy-validation>
                    <v-text-field required :rules="cbarraRules" name="cbarra_valor" v-model="cbarra.cbarra_valor" label="Código barra" type="text"></v-text-field>
                    <v-text-field required name="cbarra_desc" v-model="cbarra.cbarra_desc" label="Descrição" type="text"></v-text-field>
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
              <v-subheader>Lista códigos de barra</v-subheader>
            </v-flex>
            <v-flex text-lg-right xs6>
              <v-btn :to="{name: 'cadCBarra'}" text-lg-right class="primary"> Introduzir no cód barra</v-btn>
            </v-flex>
          </v-layout>

          <v-divider></v-divider>
         
            <v-data-table
                :headers="headers"
                :items="desserts"
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
                  <td>{{ props.item.cbarra_valor }}</td>
                  <td class="text-xs-center ">{{ props.item.cbarra_desc }}</td>
                  <td class="justify-center layout px-0 dark">
                    <v-btn flat icon color="green" @click="editCBarra(props.item)"> <v-icon>edit</v-icon> </v-btn>
                    <!--<v-btn flat icon color="red" @click="deleteIva(props.item)"> <v-icon>delete</v-icon> </v-btn>-->
                  </td>
                </template>
            </v-data-table>
        </v-container>
      <v-divider></v-divider>
    </v-content>
    </panel>
</template>

<script>
import CBarraService from "@/services/CBarraService";

export default {
  data() {
    return {
      valid: true,
      editedIndex: -1,
      cbarra_valor: "",
      cbarra_desc: "",
      cbarraRules: [v => !!v || "Campo c+odigo de barra é obrigatorio"],
      cbarra: {
        cbarra_valor: null,
        cbarra_desc: null
      },
      error: null,
      alert: false,
      dialog: false,
      headers: [
        { text: "Código de barra", value: 'cbarra_valor', align: "left", sortable: true },
        { text: "Descrisão", value: 'cbarra_desc', align: "center", sortable: true },
        { text: "Actions", align: "right", value: "name", sortable: false }
      ],
      desserts: []
    };
  },
  methods: {
    editCBarra: function(item) {
      this.editedIndex = this.desserts.indexOf(item);
      this.cbarra = Object.assign({}, item);
      this.dialog = true;
    },
    async update() {
      if (this.$refs.form.validate()) {
        try {
          this.dialog = false;
          await CBarraService.put(this.cbarra);
          this.$toast.success({
          title: "Aviso",
          message: "Código de barra atualizado com sucesso"
          })
          this.$router.push({
            name: "cbarra"
          });
          Object.assign(this.desserts[this.editedIndex], this.cbarra);
        } catch (err) {
          console.log(err);
        }
      }
    }
  },
  async mounted() {
    // Fazer requisicao para pegar todas os produtos
    this.desserts = (await CBarraService.index()).data;
    console.log(this.desserts)
  }
};
</script>

<style lang="css" scoped>
</style>
