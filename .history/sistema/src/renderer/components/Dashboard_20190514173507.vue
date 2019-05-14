<template>
    <panel :title="$t('message.estatisticas')">
    <v-content>
      
    <v-container grid-list-md>
    <v-layout row align-center justify-center>
    
        <v-flex md3 sm3 xs6>
          <v-card class="" >
            <div class="">
              <h3 class="h3Total"> {{ $t('message.tprodutos') }} </h3>
              <v-divider></v-divider>
              <p class="text-md-center spanTotal">{{ totalProdutos }}</p>
            </div>
          </v-card>
        </v-flex>

        <v-flex md3 sm3 xs6>
          <v-card class="" >
            <div class="">
              <h3 class="h3Total light-blue--text"> {{ $t('message.tstock') }} </h3>
              <v-divider></v-divider>
              <p class="text-md-center spanTotal">{{ totalStock }}</p>
            </div>
          </v-card>
        </v-flex>

        <v-flex md3 sm3 xs6>
          <v-card class="" >
            <div class="">
              <h3 class="h3Total"> {{ $t('message.tvendas') }} </h3>
              <v-divider></v-divider>
              <p class="text-md-center spanTotal"> {{ totalVendas }} </p>
            </div>
          </v-card>
        </v-flex>

        <v-flex md3 sm3 xs6>
          <v-card class="" >
            <div class="">
              <h3 class="h3Total"> {{ $t('message.tcompras') }} </h3>
              <v-divider></v-divider>
              <p class="text-md-center spanTotal">{{ totalCompras }}</p>
            </div>
          </v-card>
        </v-flex>
    </v-layout>
    
    <v-dialog
      v-model="meuloadingwindow"
      persistent
      width="300">
      <v-card color="primary" dark>
        <v-card-text>
          Preparando seu ambiente de venda, Aguarde...
          <v-progress-linear indeterminate color="white" class="mb-0" ></v-progress-linear>
        </v-card-text>
      </v-card>
    </v-dialog>

    <networkerror v-bind:snackbarnorow="snackbarnorow" />

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

    </v-container>

    <v-layout wrap align-center justify-center>
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
                      <span style="font-size:2em" class="green--text title"> {{ $t('message.TotalVendasFeitas') }} </span>
                      <span class="TVenda"> {{ total }} </span>
                    </v-badge>
                  </v-flex>
                </v-layout>
                
                <v-card-title>
                  <v-flex xs4 sm3 md2>
                    <v-menu
                      ref="menu2"
                      :close-on-content-click="false"
                      v-model="menu2"
                      :nudge-right="40"
                      :return-value.sync="data_ini"
                      lazy
                      transition="scale-transition"
                      offset-y
                      min-width="290px"
                    >
                      <v-text-field
                        slot="activator"
                        v-model="data_ini"
                        label="Data inicio"
                        prepend-icon="event"
                        readonly
                      ></v-text-field>
                      <v-date-picker v-model="data_ini" locale="pt-pt"  @input="$refs.menu2.save(data_ini)"></v-date-picker>
                    </v-menu>
                  </v-flex>
                  <v-flex xs4 sm3 md2>
                    <v-menu
                      ref="menu1"
                      :close-on-content-click="false"
                      v-model="menu1"
                      :nudge-right="40"
                      :return-value.sync="data_fim"
                      lazy
                      transition="scale-transition"
                      offset-y
                      min-width="290px"
                    >
                      <v-text-field
                        slot="activator"
                        v-model="data_fim"
                        label="Data Fim"
                        prepend-icon="event"
                        readonly
                      ></v-text-field>
                      <v-date-picker v-model="data_fim" locale="pt-pt"  @input="$refs.menu1.save(data_fim)"></v-date-picker>
                    </v-menu>
                  </v-flex>
                  <!--<v-flex xs12 sm4 md4>
                    <v-text-field box v-model="data_fim" type="date"></v-text-field>
                  </v-flex>-->
                  
                  <v-flex xs4 sm3 md3>
                    <v-btn dark class="primary" v-shortkey="['ctrl','p']" @shortkey="pesquisar" @click="pesquisar"><v-icon>search</v-icon></v-btn>
                    <v-btn dark class="error" v-shortkey="['ctrl','r']" @shortkey="reload" @click="reload"><v-icon>loop</v-icon></v-btn>
                  </v-flex>
                  <v-layout wrap align-center justify-center>
                  <v-flex xs4 sm3 md5>
                    <v-select
                      v-model="filtro"
                      @input="pesByFiltro()"
                      :items="items"
                      standard
                      label="POR TEMPO"
                    ></v-select>
                  </v-flex>
                  <v-flex xs4 sm1 md1 >
                  </v-flex>
                  <v-flex xs4 sm3 md5 >
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

                  <td class="text-xs-left"> {{ props.item.User.nome }} </td>
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
    </v-layout>

    </v-content>
    </panel>
</template>

<script>
import networkerror from "@/components/componentes/networkError";
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
      meuloading: false,
      snackbarnorow: false,
      meuloadingwindow: false,
      items: ['Diário', 'Semanal', 'Mensal', 'Trimestral'],
      vendedores: [],
      menu1: false,
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
        { text: "Produto / Quantidade", align: "left", sortable: false },
        { text: "Vendedor", align: "left", sortable: false },
        { text: "Ações", align: "left", sortable: false },
      ],
      desserts: []
    }
  },
  components: {
    'networkerror': {
      props:[
        snackbarnorow
      ]
    },
    ChartDoughnut
  },
  methods: {
    async pesByVendedor() {
      try{
        this.meuloading = true
        this.desserts = (await VendaServices.byVendedor({
          idVendedor: this.filtroV
        })).data;
        this.meuloading = false
        this.total = this.desserts.length
      }catch (error) {
        if (!error.response) {
          this.meuloading = false
          this.snackbarnorow = true
        }
      }
    },
    async pesByFiltro(){
      try{
        this.meuloading = true
        if (this.filtro == 'Semanal') {
          this.desserts = (await VendaServices.semanal()).data;
          this.meuloading = false
          this.total = this.desserts.length
        } else if (this.filtro == 'Diário') {
          this.desserts = (await VendaServices.diario()).data;
          this.meuloading = false
          this.total = this.desserts.length
        } else if (this.filtro == 'Mensal') {
          this.desserts = (await VendaServices.mensal()).data;
          this.meuloading = false
          this.total = this.desserts.length
        } else if (this.filtro == 'Trimestral') {
          this.desserts = (await VendaServices.trimestral()).data;
          this.meuloading = false
          this.total = this.desserts.length
        }
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
      this.data_fim = null,
      this.filtroV = null,
      this.filtro = null,
      this.total = this.desserts.length
    },
    async PrintVenda(item) {
        this.editedIndex = this.desserts.indexOf(item);
        this.cliente = item.Cliente

        const nomeCliente = this.cliente.cliente_nome
        const moradaCliente = this.cliente.cliente_morada
        const nifCliente = this.cliente.cliente_nif
        const telefoneCliente = this.cliente.cliente_telefone

        const recibo = item.ListaVendas
        const dadsss = item
        console.log("Dados------- ", dadsss)
        const pagamento = item.valor_total
        const tapagar = item.valor_total
        const tapagariva = item.valor_iva
        const troco = item.valor_troco
        const horaVenda = moment().format('LT')
        const dataVenda = moment().format('l')
        const ano = moment().year()
        const vendedor = this.user.nome
        let dinheiro =  item.valor_venda_dinheiro
        let vint4 = item.valor_venda_vint4 + ' CVE'
        let cheque = item.valor_venda_cheque + ' CVE'
        const idvenda = item.id
        let prod = ''
        let pVenda = ''

        if (dinheiro !== null) {
          dinheiro = dinheiro + ' CVE'
        } else if (vint4 !== null) {
          vint4 = vint4 + ' CVE'
        }else if (cheque !== null) {
          cheque = cheque + ' CVE'
        }else if (vint4 !== null && dinheiro !== null) {
          dinheiro = dinheiro + ' CVE'
          vint4 = vint4 + ' CVE'
        }else if (cheque !== null && dinheiro !== null) {
          dinheiro = dinheiro + ' CVE'
          cheque = cheque + ' CVE'
        }else if (cheque !== null && vint4 !== null) {
          vint4 = vint4 + ' CVE'
          cheque = cheque + ' CVE'
        }else if(dinheiro !== null && cheque !== null && vint4 !== null) {
          dinheiro = dinheiro + ' CVE'
          vint4 = vint4 + ' CVE'
          cheque = cheque + ' CVE'
        }
      
        const path = require('path');
        const escpos = require('escpos')
        const device = new escpos.USB()
        const options = { encoding: 'CP860' }
        const printer = new escpos.Printer(device, options)
        
          device.open(function () {
            printer
            .font('a')
            .align('lt')
            .style('bu')
            .size(1, 1)
            .text('Solid Invest - Investimentos e Comércio Geral Sociedade Unipessoal, Lda')
            .text('Rui Vaz')
            .text('NIF: 235491705')
            .text('TEL/FAX: +238 9188849')
            .text('------------------------------------------------')
            .text('\n')
            .text('Fatura/Recibo nº ' + idvenda + ' / ' + ano)
            .text('Data do Doc: ' + dataVenda + '  ' + horaVenda)
            .text('VENDEDOR: ' + vendedor)
            .text('\n')
            .text('CLIENTE: ' + nomeCliente)
            .text('MORADA: ' + moradaCliente)
            .text('NIF: ' + nifCliente)
            .text('TELEFONE: ' + telefoneCliente)
            .text('\n')
            // ----------------------------------------------------
            .text('QT PRODUTO                  P. UNIT  IVA  TOTAL')
            .text('------------------------------------------------')
            for (var key in recibo) {
              if (recibo.hasOwnProperty(key)) {
                const value = recibo[key]
                const quantidade = value.quantidade
                const pTotal = value.preco_venda * value.quantidade
                console.log("TAMANHO ", value.Produto.produto_nome_rec.length)
                if (value.Produto.produto_nome_rec.length >= 23) {
                    prod = value.Produto.produto_nome_rec + '    '
                }else if (value.Produto.produto_nome_rec.length > 20 && value.Produto.produto_nome_rec.length < 23) {
                    prod = value.Produto.produto_nome_rec + '      '
                }else if (value.Produto.produto_nome_rec.length > 18 && value.Produto.produto_nome_rec.length <= 20) {
                    prod = value.Produto.produto_nome_rec + '         '
                }else if (value.Produto.produto_nome_rec.length >= 15 && value.Produto.produto_nome_rec.length <= 18) {
                    prod = value.Produto.produto_nome_rec + '           '
                }else if (value.Produto.produto_nome_rec.length < 15 && value.Produto.produto_nome_rec.length >= 10) {
                    prod = value.Produto.produto_nome_rec + '               '
                }else if (value.Produto.produto_nome_rec.length < 10 && value.Produto.produto_nome_rec.length > 5) {
                    prod = value.Produto.produto_nome_rec + '                    '
                }else {
                    prod = value.Produto.produto_nome_rec + '                       '
                }

                if(value.preco_venda.length == 4){
                  pVenda = value.preco_venda + '   '
                }else if(value.preco_venda.length == 3){
                  pVenda = value.preco_venda + '    '
                }else if(value.preco_venda.length == 2){
                  pVenda = value.preco_venda + '     '
                }else if(value.preco_venda.length == 1){
                  pVenda = value.preco_venda + '       '
                }
                  printer
                  .font('b')
                  .align('lt')
                  .size(1, 1)
                  .text( quantidade + '  ' + prod + pVenda + value.Produto.Iva.iva_valor + '%  ' + pTotal)
              }
            }
            // ----------------------------------------------------
            printer
            .text('\n')
            .text('------------------------------------------------')
            .text('Dinheiro                              ' + dinheiro)
            .text('VINT4                                 ' + vint4)
            .text('Cheque                                ' + cheque)
            .text('\n')
            .font('b')
            .align('lt')
            .size(1, 1)
            .text('================================================')
            .text('Total Liquido:                       ' + pagamento + ' CVE')
            .text('Total Iva:                           ' + tapagariva + ' CVE')
            .text('A pagar:                             ' + tapagar + ' CVE')
            .text('Troco:                               ' + troco + ' CVE')
            .text('================================================')
            //.cut()
            printer
            .font('a')
            .align('ct')
            .size(1, 1)
            .text('\n')
            .text('Processado pelo programa Ivenda, Licenciado exclusivamente pelo contribuinte Solid Invest')
            .text('Obrigado e volte sempre')
            .text('\n')
            .cut()
            .close()
          })
    },
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
      try{
        this.meuloading = true
        //Lista venda
        this.desserts = (await VendaServices.DadosGeral({
          dataIni: this.data_ini,
          dataFim: this.data_fim
        })).data;
        this.meuloading = false
        this.total = this.desserts.length
        console.log("Pesquisa: ", this.desserts)
      }catch (error) {
        if (!error.response) {
          this.meuloading = false
          this.snackbarnorow = true
        }
      }
    }
  },
  async mounted() {
    this.meuloadingwindow = true
    try{
      this.vendedores = (await UsuariosServices.index()).data;
      this.VendasT = (await VendaServices.total()).data;
      this.totalVendas = this.VendasT.length
      this.Produtos = (await ProdutosService.index()).data;
      this.totalProdutos = this.Produtos.length
      this.Stock = (await StockServices.soma()).data[0].total;
      this.totalStock = (Number(this.Stock).toFixed(2));
      console.log('TESTE DE SOA DE PROD --- ', this.totalStock);
      this.Compras = (await listaCompraServices.index()).data;
      this.totalCompras = this.Compras.length
      this.meuloadingwindow = false
    }catch (error) {
      if (!error.response) {
        this.meuloadingwindow = false
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
