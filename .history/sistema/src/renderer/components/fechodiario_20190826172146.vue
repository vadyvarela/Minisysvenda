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
                <v-layout row wrap align-center justify-center>
                <v-flex class="elevation-3" xs12 sm12 md12>
                <v-spacer></v-spacer>
                <span hidden> {{ data_ini = Date() | moment("YYYY-MM-DD HH:mm:ss") }}</span>
                
                <v-card-title>
                  <v-layout wrap align-center justify-center>
                  </v-layout>
                  <v-spacer></v-spacer>
                  <v-flex xs4 sm2 md2>
                    <v-btn dark class="error" v-shortkey="['ctrl','r']" @shortkey="reload" @click="reload"><v-icon>loop</v-icon></v-btn>
                  </v-flex>
                </v-card-title>

                <v-layout v-if="total == null " justify-end row>
                  <v-flex text-lg-center xs12>
                    <v-badge class='mt-3 mr-4' right>              
                      <span style="font-size:2em" class="blue--text"> SELECIONE O VENDEDOR PARA FILTRAR O FECHO DIÁRIO </span>
                    </v-badge>
                  </v-flex>
                </v-layout>

                <v-layout wrap align-center justify-center xs6 sm6 md6>
                  <v-flex text-lg-center xs12 sm6 md6>
                  <v-autocomplete
                    outline
                    :items="vendedores"
                    color="white"
                    @input="pesByVendedor()"
                    v-model="filtroV"
                    item-text="nome"
                    item-value="id"
                    label="SELECIONE O VENDEDOR"
                  ></v-autocomplete>
                  </v-flex>
                </v-layout>

                <v-layout style="margin-bottom:100px" v-if="total > 0 " row>
                  <v-flex text-lg-center xs12>
                    <v-badge class='mt-3 mr-4' right>              
                      <span style="font-size:2em" class="green--text"> O VENDEDOR VENDEU HOJE </span><br>
                      <span style="margin-top:20px; font-size:3em" class="TVenda"> {{ totalIva }} CVE </span>
                    </v-badge>
                  </v-flex>
                </v-layout>

                <v-layout style="margin-bottom:100px" v-if="total == 0" justify-end row>
                  <v-flex text-lg-center xs12>
                    <v-badge class='mt-3 mr-4' right>              
                      <span style="font-size:2em" class="red--text"> O VENDEDOR NÃO VENDEU NADA HOJE </span><br>
                      <span style="font-size:3em" class="TNVenda"> 0 </span>
                    </v-badge>
                  </v-flex>
                  <hr>
                  <br>
                </v-layout>

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
      total: null,
      filtro: null,
      filtroV: null,
      desserts: []
    }
  },
  components: {
    // ChartBar,
    ChartDoughnut
  },
  methods: {
    async pesByVendedor() {
      try{
        this.meuloading = true
        this.desserts = (await VendaServices.byVendedor({
          dataIni: this.data_ini,
          idVendedor: this.filtroV
        })).data;
        this.meuloading = false
        this.total = this.desserts.length
        console.log(this.desserts);
      }catch (error) {
        if (!error.response) {
          this.meuloading = false
          this.snackbarnorow = true
        }
      }
    },
    
    async reload() {
      this.desserts = []
      this.data_ini = null,
      this.filtroV = null,
      this.filtro = null,
      this.total = null
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
    this.meuloading = false
    }catch (error) {
      if (!error.response) {
        this.meuloading = false
        this.snackbarnorow = true
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
  margin: 20px;
  padding:5px 10px 5px 10px; 
  background-color:#1976d2;
  color:#fff;
  font-weight:400;
  border-radius:5px;
}
.TNVenda{
  margin: 20px;
  padding:5px 10px 5px 10px; 
  background-color:#d22519;
  color:#fff;
  font-weight:400;
  border-radius:5px;
}
.mybackground{
  background-color: #ded8d8 !important;
}
</style>
