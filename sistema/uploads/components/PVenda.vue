<template>
    <panel title="Preço de venda">
      <v-content>
      <v-container>
            <v-dialog v-model="dialog" persistent max-width="500px">
            <v-card>
              <v-card-title>
                <span class="headline center">Atualizar preço de venda</span>
              </v-card-title>
              <v-card-text>
                <v-container grid-list-md>
                  <v-form ref="form" name="cadastar" autocomplete="off" v-model="valid" lazy-validation>
                    <v-text-field required :rules="precoRules" name="pvenda_preco" v-model="pvenda.pvenda_preco" label="Valor" type="text"></v-text-field>
                    <v-text-field required name="pvenda_desc" v-model="pvenda.pvenda_desc" label="Descrição preço de venda" type="text"></v-text-field>
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
              <v-subheader>Preços de venda cadastradas</v-subheader>
            </v-flex>
            <v-flex text-lg-right xs6>
              <v-btn :to="{name: 'cadPVenda'}" text-lg-right class="primary"> Cadastrar novo preço venda </v-btn>
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
                  <td>{{ props.item.pvenda_preco }}</td>
                  <td class="text-xs-center ">{{ props.item.pvenda_desc }}</td>
                  <td class="justify-center layout px-0 dark">
                    <v-btn flat icon color="green" @click="editPVenda(props.item)"> <v-icon>edit</v-icon> </v-btn>
                    <v-btn flat icon color="red" @click="deletePVenda(props.item)"> <v-icon>delete</v-icon> </v-btn>
                  </td>
                </template>
            </v-data-table>
        </v-container>
      <v-divider></v-divider>
    </v-content>
    </panel>
</template>

<script>
import PVendaService from "@/services/PVendaServices";

export default {
  data() {
    return {
      valid: true,
      editedIndex: -1,
      valorRules: [v => !!v || "Campo valor IVA é obrigatorio"],
      pvenda: {
        pvenda_desc: null,
        pvenda_preco: null
      },
      error: null,
      alert: false,
      dialog: false,
      headers: [
        { text: "Preço de venda", value: 'pvenda_preco', align: "left", sortable: true },
        { text: "Descrisão", value: 'pvenda_desc', align: "center", sortable: true },
        { text: "Actions", align: "right", value: "name", sortable: false }
      ],
      desserts: []
    };
  },
  methods: {
    async deletePVenda (item) {
      this.editedIndex = this.desserts.indexOf(item);
      this.pvenda = Object.assign({}, item);
      const res = await this.$confirm('Deseja mesmo apagar esse preço de venda?', {
      });
      
      if (res) {
        try {
          await PVendaService.delete(this.pvenda);
          this.$toast.success({
          title: "Aviso",
          message: "Preço de venda eliminado com sucesso"
          })
          this.$router.push({
            name: "pvenda"
          });
          this.desserts.splice(this.editedIndex, 1)
        } catch (err) {
          console.log(err);
        }
      }
    },
    editPVenda: function(item) {
      this.editedIndex = this.desserts.indexOf(item);
      this.pvenda = Object.assign({}, item);
      this.dialog = true;
    },
    async update() {
      if (this.$refs.form.validate()) {
        try {
          this.dialog = false;
          await PVendaService.put(this.pvenda);
          this.$toast.success({
          title: "Aviso",
          message: "Dados preco de venda atualizado com sucesso"
          })
          this.$router.push({
            name: "pvenda"
          });
          Object.assign(this.desserts[this.editedIndex], this.pvenda);
        } catch (err) {
          console.log(err);
        }
      }
    }
  },
  async mounted() {
    // Fazer requisicao para pegar todas os produtos
    this.desserts = (await PVendaService.index()).data;
  }
};
</script>

<style lang="css" scoped>
</style>
