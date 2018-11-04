<template>
    <panel title="Dashboard">
    <v-content>
    <v-container>Dados estatisticos</v-container> 
    <v-container grid-list-md>
    <v-layout wrap align-center justify-center>
        <v-flex md3 sm3 xs6>
          <v-card>
            <div class="divTotal">
              <h3 class="h3Total">Total de produtos</h3>
              <v-divider></v-divider>
              <p class="text-md-center spanTotal">{{totalProdutos}}</p>
            </div>
          </v-card>
        </v-flex>

        <v-flex md3 sm3 xs6>
          <v-card>
            <div class="divTotal">
              <h3 class="h3Total light-blue--text">Total de Stock</h3>
              <v-divider></v-divider>
              <p class="text-md-center spanTotal">{{totalStock}}</p>
            </div>
          </v-card>
        </v-flex>

        <v-flex md3 sm3 xs6>
          <v-card>
            <div class="divTotal">
              <h3 class="h3Total">Total de Vendas</h3>
              <v-divider></v-divider>
              <p class="text-md-center spanTotal">28</p>
            </div>
          </v-card>
        </v-flex>

        <v-flex md3 sm3 xs6>
          <v-card>
            <div class="divTotal">
              <h3 class="h3Total">Total de Compras</h3>
              <v-divider></v-divider>
              <p class="text-md-center spanTotal">28</p>
            </div>
          </v-card>
        </v-flex>

        <!-- LISTA COMPRAS -->
        <v-flex sm12 md12>
          <v-card flat>
              <v-divider></v-divider>
              <v-card-text>
                <v-layout row wrap>
                <v-flex class="elevation-0" xs12 sm12 md12>
                <v-spacer></v-spacer>
                
                <v-card-title>
                  <v-flex xs12 sm6 md4>
                    <v-menu
                      ref="menu2"
                      :close-on-content-click="false"
                      v-model="menu2"
                      :nudge-right="40"
                      :return-value.sync="data_ini"
                      lazy
                      transition="scale-transition"
                      offset-y
                      full-width
                      min-width="290px"
                    >
                      <v-text-field
                        slot="activator"
                        v-model="data_ini"
                        label="Data inicio"
                        prepend-icon="event"
                        readonly
                      ></v-text-field>
                      <v-date-picker v-model="data_ini" @input="$refs.menu2.save(data_ini)"></v-date-picker>
                    </v-menu>
                  </v-flex>
                  <v-flex xs12 sm6 md4>
                    <v-menu
                      ref="menu1"
                      :close-on-content-click="false"
                      v-model="menu1"
                      :nudge-right="40"
                      :return-value.sync="data_fim"
                      lazy
                      transition="scale-transition"
                      offset-y
                      full-width
                      min-width="290px"
                    >
                      <v-text-field
                        slot="activator"
                        v-model="data_fim"
                        label="Data Fim"
                        prepend-icon="event"
                        readonly
                      ></v-text-field>
                      <v-date-picker v-model="data_fim" @input="$refs.menu1.save(data_fim)"></v-date-picker>
                    </v-menu>
                  </v-flex>
                  <!--<v-flex xs12 sm4 md4>
                    <v-text-field box v-model="data_fim" type="date"></v-text-field>
                  </v-flex>-->
                  
                  <v-flex xs12 sm4 md4>
                    <v-btn dark class="primary" v-shortkey="['ctrl','p']" @shortkey="pesquisar" @click="pesquisar"><v-icon>search</v-icon> Pesquisar</v-btn>
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
                  
                    <v-expansion-panel popout>
                      <v-expansion-panel-content>
                        <div slot="header">Lista de produtos</div>
                        <v-card>
                          <v-card-text> 
                            <tr class="nobordertr" v-bind:key="index" v-for="(produto,index) in props.item.ListaVendas">
                            <td>{{produto.Produto.produto_nome}}</td>
                            <td> / </td>
                            <td>{{produto.quantidade}}</td>
                            </tr>
                          </v-card-text>
                        </v-card>
                      </v-expansion-panel-content>
                    </v-expansion-panel>

                  <td class="text-xs-left"> {{ props.item.User.usuario }} </td>
                  <td class="text-xs-left dark">
                    <v-btn flat icon color="primary" @click="printVenda(props.item)"> <v-icon>print</v-icon> </v-btn>
                    <v-btn title="Anular Venda" flat icon color="red" @click="AnularVenda(props.item)"> <v-icon>error_outline</v-icon> </v-btn>
                  </td>
                  </template>
                </v-data-table>
                </v-flex>
                </v-layout>
              </v-card-text>
            </v-card>
        </v-flex>

        <v-flex sm6 md6>
          <h3>Produtos mais vendidos</h3>
          <v-card>
            <chart-doughnut/>
          </v-card>
        </v-flex>

        <!--<v-flex sm6 md6>
          <h3>Produtos mais vendidos</h3>
          <v-card>
            <chart-bar/>
          </v-card>
        </v-flex>-->

    </v-layout>
    </v-container>

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
import listaVendaServices from "@/services/listaVendaServices";

export default {
  data () {
    return {
      menu1: false,
      menu2: false,
      data_ini: null,
      data_fim: null,
      totalProdutos: '',
      totalStock: '',
      headers: [
        { text: "Data", align: "left", sortable: false },
        { text: "Hora", align: "left", sortable: false },
        { text: "Produto / Quantidade", align: "left", sortable: false },
        { text: "Vendedor", align: "left", sortable: false },
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
    async AnularVenda (item) {
      this.editedIndex = this.desserts.indexOf(item);
      this.produtos = item;
      
      const res = await this.$confirm('Deseja mesmo anular essa venda?', {
      });
      if (res) {
        try {
          stockServices.putcompras(this.produtos.ListaVendas);
          VendaServices.put(this.produtos)
          this.$toast.success({
            title: "Aviso",
            message: "Venda anulada com sucesso"
          })
          this.$router.push({
            name: "listavendas"
          });
          this.desserts.splice(this.editedIndex, 1)
        } catch (err) {
          console.log(err);
        }
      }
    },
    async pesquisar() {
      //Lista venda
      this.desserts = (await VendaServices.indexTotal({
        dataIni: this.data_ini,
        dataFim: this.data_fim
      })).data;
    }
  },
  async mounted() {
    this.Produtos = (await ProdutosService.index()).data;
    this.totalProdutos = this.Produtos.length
    this.Stock = (await StockServices.index()).data;
    this.totalStock = this.Stock.length
  },
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
</style>
