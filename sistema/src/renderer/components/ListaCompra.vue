<template>
    <panel :title="$t('message.inventarioProd')">
      <v-content>
        <v-snackbar
        v-model="snackbar"
        :color="color"
        :multi-line="mode === 'multi-line'"
        :timeout="timeout"
        :vertical="mode === 'vertical'"
      >
        {{ text }}
        <v-btn
          dark
          flat
          @click="snackbar = false"
        >
          Fechar
        </v-btn>
      </v-snackbar>
        
            <v-card flat>
              <v-divider></v-divider>
              <v-card-text>
                <v-layout style="margin-top:55px" row wrap>
                <v-flex class="elevation-1" xs12 sm12 md12>
                <v-spacer></v-spacer>
                <v-card-title>
                  <v-flex xs12 sm4 md4>
                    <v-autocomplete
                      box color="blue"
                      name="CategoriaId"
                      append-icon="search"
                      v-model="search"
                      :items="CategoriaId"
                      :label="$t('message.categoria_nome')"
                      item-text="categoria_nome"
                      item-value="id"
                      >
                    </v-autocomplete>
                    <input name="" v-model="search" type="hidden"/>

                    <!--<v-select
                      box color="blue"
                      v-model="search"
                      append-icon="search"
                      :items="CategoriaId"
                      label="Categoria do produto"
                      item-text="categoria_nome"
                      item-value="id"
                    ></v-select>-->
                  </v-flex>
                  <v-flex xs12 sm4 md4>
                    <v-btn dark class="primary" v-shortkey="['ctrl','p']" @shortkey="pesquisar" @click="pesquisar"><v-icon>search</v-icon> {{ $t('message.btnPesquisar') }} </v-btn>
                    <v-btn dark class="success" @click="reload"><v-icon>loop</v-icon> {{ $t('message.btnResetar') }}</v-btn>
                  </v-flex>
                </v-card-title>
                <v-data-table
                    :headers="headers"
                    :items="resultado"
                    class="elevation-1"
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
                    <td>{{ props.item.produto_nome }}</td>
                    <td class="text-xs-left">{{ props.item.Categoria.categoria_nome }} </td>
                    <td class="text-xs-left"> 
                      <span v-if="props.item.Stock.quantidade >= 10" class="boxquantidadesuccess">{{ props.item.Stock.quantidade }} </span>
                      <span v-else-if="props.item.Stock.quantidade >= 1 && props.item.Stock.quantidade < 10" class="boxquantidadealert">{{ props.item.Stock.quantidade }} </span>
                      <span v-else class="boxquantidadeerror">{{ props.item.Stock.quantidade }} </span>
                    </td>
                    </template>
                    <template slot="no-data">
                      <v-alert :value="true" color="info" icon="info">
                        Selecione a cartegoria do produto para exibir os dados
                      </v-alert>
                    </template>
                </v-data-table>
                </v-flex>
                </v-layout>
              </v-card-text>
            </v-card>
          
      <v-divider></v-divider>
    </v-content>
    </panel>
</template>

<script>
import filterServices from "@/services/filterServices"
import ProdutosService from "@/services/ProdutosService";
import CategoriasService from "@/services/CategoriasService";

export default {
  data() {
    return {
      search: '',
      snackbar: false,
      color: 'error',
      mode: '',
      timeout: 6000,
      text: 'Não foi encontrado nehum produto nessa categoria',
      valid: true,
      error: null,
      alert: false,
      dialog: false,
      headers: [
        { text: "Nome produto", value: "produto_nome", align: "left", sortable: true },
        { text: "Categoria ", sortable: true,  value: "categoria_nome" },
        { text: "Quantidade ", sortable: true, value: "quantidade" }
      ],
      resultado: [],
      CategoriaId: []
    };
  },
  props: [
    'title'
  ],
  methods: {
    async reload() {
      this.resultado = (await ProdutosService.index()).data;
      this.search = null
    },
    async pesquisar(index) {
      try {
        this.resultado = (await filterServices.bycategory(this.search)).data
        console.log("Resultdo retornado", this.resultado)
        if (this.resultado.length === 0) {
          this.snackbar = true
        }
        /*Object.keys(this.resultado).forEach(key => {
          this.resultado = this.resultado[key];
        });*/
      } catch (err) {
        console.log(err);
      }
    },
  },
  async mounted() {
    // Fazer requisicao para pegar todas os produtos
    this.resultado = (await ProdutosService.index()).data;
    this.CategoriaId = (await CategoriasService.index()).data;
  }
};
</script>

<style lang="css" scoped>
.boxquantidadesuccess {
  background: green;
  color: aliceblue;
  padding: 4px 6px;
  border-radius: 10%
}
.boxquantidadeerror {
  background: red;
  color: aliceblue;
  padding: 4px 6px;
  border-radius: 10%
}
.boxquantidadealert{
  background: orange;
  color: aliceblue;
  padding: 4px 6px;
  border-radius: 10%
}
.meupadding{
  margin: 0 auto;
  padding: 10px !important;
}
.dadosEstnumero{
  font-size: 1.2em;
  text-align: center;
}
.dadosEstTexto{
  text-transform: uppercase;
  margin: 0 auto;
  font-size: 1.4em;
  text-align: center;
}
.v-card__title {
  padding: 2px !important;
}
.v-card__text{
  padding: 2px !important;
}
</style>
