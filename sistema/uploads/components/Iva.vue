<template>
    <panel title="IVA">
      <v-content>
      <v-container>
            <v-dialog v-model="dialog" persistent max-width="500px">
            <v-card>
              <v-card-title>
                <span class="headline center">Atualizar dados Iva</span>
              </v-card-title>
              <v-card-text>
                <v-container grid-list-md>
                  <v-form ref="form" name="cadastar" autocomplete="off" v-model="valid" lazy-validation>
                    <v-text-field required :rules="valorRules" name="iva_valor" v-model="iva.iva_valor" label="Valor do IVA" type="text"></v-text-field>
                    <v-text-field required name="iva_desc" v-model="iva.iva_desc" label="Descrição Iva" type="text"></v-text-field>
                  </v-form>
                </v-container>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="blue darken-1" flat outline @click.native="dialog = false">Cancelar</v-btn>
                <v-btn :disabled="!valid" outline color="green darken-1" flat @click="update">Salvar</v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>

          <v-layout justify-end row wrap>
            <v-flex text-lg-left xs6>
              <v-subheader>Valores IVA cadastradas</v-subheader>
            </v-flex>
            <v-flex text-lg-right xs6>
              <v-btn :to="{name: 'cadIva'}" text-lg-right class="primary"> Cadastrar novo valor IVA </v-btn>
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
                  <td>{{ props.item.iva_valor }}</td>
                  <td class="text-xs-center ">{{ props.item.iva_desc }}</td>
                  <td class="justify-center layout px-0 dark">
                    <v-btn flat icon color="green" @click="editIva(props.item)"> <v-icon>edit</v-icon> </v-btn>
                    <!--v-btn flat icon color="red" @click="deleteIva(props.item)"> <v-icon>delete</v-icon> </v-btn-->
                  </td>
                </template>
            </v-data-table>
        </v-container>
      <v-divider></v-divider>
    </v-content>
    </panel>
</template>

<script>
import IvaService from "@/services/IvaService";

export default {
  data() {
    return {
      valid: true,
      editedIndex: -1,
      valorRules: [v => !!v || "Campo valor IVA é obrigatorio"],
      iva: {
        iva_valor: null,
        iva_desc: null
      },
      error: null,
      alert: false,
      drawer: null,
      dialog: false,
      headers: [
        { text: "Valor Iva", value: 'iva_valor', align: "left", sortable: true },
        { text: "Descrisão", value: 'iva_desc', align: "center", sortable: true },
        { text: "Actions", align: "right", value: "name", sortable: false }
      ],
      desserts: []
    };
  },
  methods: {
    async deleteIva (item) {
      this.editedIndex = this.desserts.indexOf(item);
      this.iva = Object.assign({}, item);
      const res = await this.$confirm('Deseja mesmo apagar iva?', {
      });
      
      if (res) {
        try {
          await IvaService.delete(this.iva);
          this.$toast.success({
          title: "Aviso",
          message: "Dados iva eliminado com sucesso"
          })
          this.$router.push({
            name: "iva"
          });
          this.desserts.splice(this.editedIndex, 1)
        } catch (err) {
          console.log(err);
        }
      }
    },
    editIva: function(item) {
      this.editedIndex = this.desserts.indexOf(item);
      this.iva = Object.assign({}, item);
      this.dialog = true;
    },
    async update() {
      if (this.$refs.form.validate()) {
        try {
          this.dialog = false;
          await IvaService.put(this.iva);
          this.$toast.success({
          title: "Aviso",
          message: "Dados iva atualizado com sucesso"
          })
          this.$router.push({
            name: "iva"
          });
          Object.assign(this.desserts[this.editedIndex], this.iva);
        } catch (err) {
          console.log(err);
        }
      }
    }
  },
  async mounted() {
    // Fazer requisicao para pegar todas os produtos
    this.desserts = (await IvaService.index()).data;
  }
};
</script>

<style lang="css" scoped>
</style>
