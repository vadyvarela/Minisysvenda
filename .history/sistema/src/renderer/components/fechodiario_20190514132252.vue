<template>
    <panel title="Fecho Diário">
    <v-content>
    <v-layout wrap align-center justify-center>

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

        <!-- LISTA COMPRAS -->
        <v-flex sm12 md12>
          <v-card flat>
              <v-divider></v-divider>
              <v-card-text>
                <v-layout row wrap>
                <v-flex class="elevation-3" xs12 sm12 md12>
                <v-spacer></v-spacer>
                <v-layout v-if="total > 0 " justify-end row>
                  <v-flex text-lg-center xs12>
                    <v-badge class='mt-3 mr-4' right>              
                      <span style="font-size:2em" class="green--text title"> TOTAL VENDIDO HOJE <b>{{ filtro }}</b>  </span>
                      <span class="TVenda"> {{ totalIva }} </span>
                    </v-badge>
                  </v-flex>
                </v-layout>
                
                <v-card-title>
                  <v-layout wrap align-center justify-center>
                  <v-flex xs8 sm5 md5 >
                    <v-select
                      v-model="filtroV"
                      @input="pesByVendedor()"
                      :items="vendedores"
                      item-text="nome"
                      item-value="id"
                      standard
                      label="POR VENDEDOR"
                    ></v-select>
                  </v-flex>
                  </v-layout>
                  <v-flex xs4 sm3 md3>
                    <v-btn dark class="error" v-shortkey="['ctrl','r']" @shortkey="reload" @click="reload"><v-icon>loop</v-icon></v-btn>
                  </v-flex>
                </v-card-title>

                <v-data-table
                    :headers="headers"
                    :items="desserts"
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
                  <td class="text-xs-left"> {{ props.item.createdAt | moment("DD-MM-YYYY") }} </td>
                  <td class="text-xs-left"> {{ props.item.createdAt | moment("HH:mm:ss") }} </td>
                  <td class="text-xs-left"> {{ props.item.valor_iva }} </td>
                  <td class="text-xs-left"> {{ props.item.User.nome }} </td>
                  
                  </template>
                </v-data-table>
                </v-flex>
                </v-layout>
              </v-card-text>
            </v-card>
        </v-flex>

    </v-layout>
    </v-content>
    </panel>
</template>

<script>
// import ChartLine from "@/components/chart-line";
// import ChartBar from "@/components/grafico/chart-bar";
import ChartDoughnut from "@/components/grafico/chart-doughnut";
import ProdutosService from "@/services/ProdutosService";
import StockServices from "@/services/StockServices";
import VendaServices from "@/services/VendaServices";
import listaCompraServices from "@/services/listaCompraServices";
import UsuariosServices from "@/services/UsuariosServices";
import listaVendaServices from "@/services/listaVendaServices";

export default {
  data () {
    return {
      vendedores: [],
      menu1: false,
      snackbarnorow: false,
      colornorow: 'error',
      textnorow: 'Erro ao ligar a base de dados! Verifica sua conexão com a internet!',
      mode: '',
      timeout: 6000,
      meuloading: false,
      menu2: false,
      data_ini: null,
      data_fim: null,
      total: null,
      filtro: null,
      filtroV: null,
      totalProdutos: '',
      totalStock: '',
      totalVendas: '',
      totalCompras: '',
      headers: [
        { text: "Data", align: "left", sortable: false },
        { text: "Hora", align: "left", sortable: false },
        { text: "Valor Iva", align: "left", sortable: false },
        { text: "Produto / Quantidade", align: "left", sortable: false },
        { text: "Ações", align: "left", sortable: false },
      ],
      desserts: []
    }
  },
  components: {
    // ChartBar,
    ChartDoughnut
  },
  methods: {
    async pesByVendedor() {
      this.meuloading = true
      this.desserts = (await VendaServices.byVendedor({
        idVendedor: this.filtroV
      })).data;
      this.meuloading = false
      this.total = this.desserts.length
      console.log(this.desserts);
    },
    
    async reload() {
      this.desserts = []
      this.data_ini = null,
      this.data_fim = null,
      this.filtroV = null,
      this.filtro = null,
      this.total = this.desserts.length
    }
  },
  computed: {
    totalIva: function(){
      let totalIva = [];
      Object.entries(this.desserts).forEach(([key, val]) => {
          totalIva.push(val.valor_total) // the value of the current key.
      });
      return totalIva.reduce(function(total, num){ return total + num }, 0);
    },
  },
  async mounted() {
    try{
    this.meuloading = true
    this.vendedores = (await UsuariosServices.index()).data;
    this.VendasT = (await VendaServices.total()).data;
    this.totalVendas = this.VendasT.length
    this.Produtos = (await ProdutosService.index()).data;
    this.totalProdutos = this.Produtos.length
    this.Stock = (await StockServices.soma()).data[0].total;
    this.totalStock = this.Stock;
    console.log('TESTE DE SOA DE PROD --- ', this.totalStock);
    this.Compras = (await listaCompraServices.index()).data;
    this.meuloading = false
    this.totalCompras = this.Compras.length;
    }catch (error) {
      if (!error.response) {
        // network error
        this.meuloading = false
        this.snackbarnorow = true
        //this.error = 'Erro: Verifica sua conexao com a internet! ';
        //this.alert = true;
        console.log("MEU ERRO -- " + error)
      }
    }
  }
}
</script>

<style scoped>
.divTotal{
  padding: 6px 10px;
}

.h3Total{
  text-transform: uppercase;
  text-align: center;
  font-size: 1.3em;
  color: rgb(173, 169, 169);
}
.spanTotal{
  text-align: center;
  font-size: 3em;
  color: green;
}
.TVenda{
  padding:5px 10px 5px 10px; 
  background-color:#1976d2;
  color:#fff;
  font-weight:400;
  font-size: 1.2em;
  border-radius:5px;
}
.mybackground{
  background-color: #ded8d8 !important;
}
</style>
