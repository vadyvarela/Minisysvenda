<template>
    <panel title="LISTA DE VENDAS">
      <v-content >
        <v-layout justify-end row>
          <v-flex text-lg-left xs6>
            <v-badge class='mt-3 mr-4' right>              
              <span class="title"> {{ $t('message.TotalVendasFeitas') }} </span>
              <span class="TVenda"> {{ total }} </span>
            </v-badge>
          </v-flex>
          <v-flex text-lg-right xs6>
            <v-btn router-link to="vendas" text-lg-right class="primary">  {{ $t('message.btnNovaVenda') }} </v-btn>
          </v-flex>
        </v-layout>


      <v-dialog v-model="dialog" persistent fullscreen hide-overlay transition="dialog-bottom-transition">
      <v-card>
        <v-toolbar dark color="primary">
          <v-btn icon dark @click.native="dialog = false">
            <v-icon>close</v-icon>
          </v-btn>
          <v-toolbar-title>Atualizar dados produto</v-toolbar-title>
          <v-spacer></v-spacer>
          <v-toolbar-items>
            <v-btn dark flat >Salvar</v-btn>
          </v-toolbar-items>
        </v-toolbar>
        <v-card-text>
              <v-stepper class="marginmeu" v-model="e1">
              <v-stepper-header>
                <v-stepper-step editable :complete="e1 > 1" step="1"> {{ $t('message.dadoscompra') }} </v-stepper-step>
                <v-divider></v-divider>
                <v-stepper-step editable step="2"> {{ $t('message.produtos') }} </v-stepper-step>
              </v-stepper-header>

              <v-stepper-items>
              <v-stepper-content step="1">
              </v-stepper-content>
              <v-stepper-content step="2">
                <v-toolbar card color="white">
                  <v-flex xs6>
                    <v-toolbar-title style="font-weight:bold; font-size:1.8em;" class="primary--text">{{ $t('message.listaproduto') }}</v-toolbar-title>
                  </v-flex>
                  <v-spacer></v-spacer>
                  
                </v-toolbar>
                <br>
                <v-divider></v-divider>
                  <v-layout wrap>
                    <v-flex xs12 sm12 md12>
                    <div grid-list-md>
                      <v-layout style="margin-bottom: -25px;">
                        <v-flex class="titleProd" xs12 sm2 md2>
                          <label class=""> {{ $t('message.refCodBarra') }} </label>
                        </v-flex>
                        <v-flex class="titleProd" xs12 sm2 md2>
                          <label >{{ $t('message.produto_nome') }}</label>
                        </v-flex>
                        <v-flex class="titleProd" xs12 sm2 md2>
                          <label>{{ $t('message.quantidade') }}</label>
                        </v-flex>
                        <v-flex style="text-align:right" class="titleProd" xs12 sm1 md1>
                          <label> {{ $t('message.produto_p') }} </label>
                        </v-flex>
                        <v-flex style="text-align:right" class="titleProd" xs12 sm2 md2>
                          <label> {{ $t('message.precodevenda') }} </label>
                        </v-flex>
                        <v-flex style="text-align:right" class="titleProd" xs12 sm1 md1>
                          <label> {{ $t('message.iva') }} </label>
                        </v-flex>
                        <v-flex style="text-align:right" class="titleProd" xs12 sm2 md2>
                          <label> {{ $t('message.total') }} </label>
                        </v-flex>
                      </v-layout>
                    </div>
                    <div v-bind:key="index" v-for="(pd, index) in produto">
                      <h2 > index: {{ index }} </h2>
                      <h2> TESTE: {{ produto[index].Produto }} </h2>
                      <!--h2 hidden>{{ produto.CompraId = idCompra }}</h2-->
                      <div v-if="produto[index].Produto">
                        <h4 >NOME: {{ produto.nome = produto[index].Produto.produto_nome }}</h4>
                        <h4 >PREÇO: {{ produto.preco = produto[index].Produto.produto_preco }}</h4>
                        <h4 >ID PRODUTO: {{ produto.ProdutoId = produto[index].Produto.id }}</h4>
                        <span v-if="produto.preco">
                          <h4 >TOTAL LIQUIDO: {{ produto.totalLiquido = produto.quantidade * produto.preco_venda }}</h4>
                          <h4 >TOTAL: {{ produto.total = produto.quantidade * produto.preco }}*</h4>
                          <span > TOTAL IVA:  {{ produto.totalIva = produto.preco_venda * produto.iva / 100 }}</span>
                        </span>
                      </div>
                      <div v-else>
                        <h2 >Sorry Vady</h2>
                      </div>
                      

                      <v-dialog v-model="dialogPesquisa" persistent max-width="550px" @keydown.esc="dialogPesquisa = false">
                      <v-card align-center justify-center>
                        <v-card-title>
                          <v-spacer></v-spacer>
                          <v-btn color="red" icon outline right small fab dark @click.native="dialogPesquisa = false"><v-icon>close</v-icon></v-btn>
                        </v-card-title>
                        <v-card-text>
                          <v-container grid-list-md>
                            <v-layout wrap>
                              <v-flex xs12>
                                <h4 class="primary--text text-md-center" style="font-size:2em;">DIGITE O NOME PRODUTO </h4>
                                <p class="red--text" style="text-align:center; font-size:2em;">
                                  <v-autocomplete
                                    box
                                    :items="listaprodutos"
                                    color="white"
                                    v-model="produto.search"
                                    item-text="produto_nome"
                                    item-value="produto_nome"
                                    label="Nome produto"
                                  ></v-autocomplete>
                                  <input name="" v-model="produto.search" type="hidden"/>   
                                </p>
                              </v-flex>
                            </v-layout>
                          </v-container>
                        </v-card-text>
                        <v-card-actions>
                          <v-spacer></v-spacer>
                          <v-btn center large color="primary darken-1" @click.native="dialogPesquisa = false; pesquisar(index)">OK</v-btn>
                        </v-card-actions>
                      </v-card>
                    </v-dialog>

                      <v-form ref="form" name="cadastar" autocomplete="off" lazy-validation>
                      <v-layout class="layoutmeu">
                        <v-flex xs12 sm2 md2>
                            <v-btn style="display:none;" v-shortkey="['ctrl','p']" @shortkey="searchProd" @click.stop="searchProd"></v-btn>
                            <v-text-field box v-model.trim="produto.search" ref="search" autofocus v-on:keyup.enter="pesquisar(index)" type="text"></v-text-field>
                            <input v-model="produto.search" type="hidden" autofocus />
                            <input v-model="produto.CompraId" type="hidden"/>
                            <input v-model="produto.ProdutoId" type="hidden"/>
                          </v-flex>
                          <v-flex xs12 sm2 md2>
                            <v-text-field box readonly :value="produto.nome" type="text"></v-text-field>
                          </v-flex>
                          <v-flex xs12 sm2 md2>
                            <div v-if="typeof produtos[index].idProduto.produto_nome === 'undefined'">
                              <v-text-field box type="hidden"></v-text-field>
                            </div>
                            <div v-else>
                              <v-text-field box v-model.number="produto.quantidade" @keyup.enter="addNewProduto(index)" ref="searchquantidade" label="Quantidade" type="text"></v-text-field>
                              <input v-model.trim="produto.quantidade" @keyup.enter="addNewProduto(index)" type="hidden" autofocus/>
                            </div>
                          </v-flex>
                          <v-flex xs12 sm1 md1>
                            <v-text-field box reverse readonly :value="produto.preco" name="" type="number"></v-text-field>
                          </v-flex>
                          <v-flex xs12 sm2 md2>
                            <v-select
                              reverse
                              readonly
                              v-model="produtos[index].idProduto.PVendas"
                              :items="produtos[index].idProduto.PVendas"
                              chips
                              multiple
                              solo
                              box
                              item-text="pvenda_preco"
                              item-value="id"
                            ></v-select>
                          </v-flex>
                          <v-flex right xs12 sm1 md1>
                            <v-text-field reverse box readonly :value="produto.iva" name="" type="number"></v-text-field>
                          </v-flex>
                          <v-flex xs12 sm2 md2>
                            <!--<v-text-field box readonly :value="produto.total" name="" type="number"></v-text-field>-->
                            <vue-numeric readonly style="border-bottom:1px solid #999; background:#f5f5f5; width:80%; padding:15px 3px 12px 4px; margin-right:-3px; font-size:1.4em; color: green; text-align:right" :value="produto.total"> </vue-numeric>                   
                            <v-btn style="margin-left:-4px; width:10%;" small icon left dark @click="removeNewProduto(index)" class="red"><v-icon>remove</v-icon></v-btn>
                          </v-flex>
                        
                      </v-layout>
                      </v-form>


                    </div>
                    </v-flex>
                  </v-layout>
              </v-stepper-content>
              </v-stepper-items>
            </v-stepper>
            </v-card-text>

            <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn outline right color="red" flat @click.native="dialog = false">Cancelar</v-btn>
            <v-btn outline :disabled="!valid" color="green" flat>Salvar dados</v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>

        
        <v-divider></v-divider>
            <v-card flat>
              <v-divider></v-divider>
              <v-card-title>
                  <v-flex xs12 sm3 md3>
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
                        :label="$t('message.dataInicio')"
                        prepend-icon="event"
                        readonly
                      ></v-text-field>
                      <v-date-picker v-model="data_ini" locale="pt-pt" @input="$refs.menu2.save(data_ini)"></v-date-picker>
                    </v-menu>
                  </v-flex>
                  <v-flex xs12 sm3 md3>
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
                        :label="$t('message.dataFim')"
                        prepend-icon="event"
                        readonly
                      ></v-text-field>
                      <v-date-picker v-model="data_fim" locale="pt-pt" @input="$refs.menu1.save(data_fim)"></v-date-picker>
                    </v-menu>
                  </v-flex>
                  <!--<v-flex xs12 sm4 md4>
                    <v-text-field box v-model="data_fim" type="date"></v-text-field>
                  </v-flex>-->
                  
                  <v-flex xs12 sm4 md4>
                    <v-btn dark class="primary" @click="pesquisar"><v-icon>search</v-icon> {{ $t('message.btnPesquisar') }} </v-btn>
                    <v-btn dark class="success" @click="reload"><v-icon>loop</v-icon> {{ $t('message.btnResetar') }}</v-btn>
                  </v-flex>
                  
                </v-card-title>

              <v-card-text>
                <v-layout row wrap>
                <v-flex class="elevation-0" xs12 sm12 md12>
                <v-spacer></v-spacer>
                
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
                  <td class="text-xs-left"> {{ props.item.id }} <!--<router-link :to="{ name: 'venda', params: { vendasId: props.item.id }}" > TXT </router-link>--> </td>
                  <td class="text-xs-left"> {{ props.item.createdAt | moment("DD-MM-YYYY") }} - {{ props.item.createdAt | moment("HH:mm:ss") }} </td>
                  <v-expansion-panel popout>
                    <v-expansion-panel-content>
                      <div slot="header"> {{ $t('message.listaproduto') }} </div>
                      <v-card>
                        <v-card-text> 
                          <tr class="nobordertr">
                          <td>NOME PRODUTO</td>
                          <td>QUANTIDADE</td>
                          <td>PREÇO</td>
                          </tr>

                          <tr class="nobordertr" v-bind:key="index" v-for="(produto,index) in props.item.ListaCompras">
                          <td>{{ produto.Produto.produto_nome }}</td>
                          <td>{{ q = produto.quantidade }}</td>
                          <td>{{ p = produto.Produto.produto_preco }}</td>
                          </tr>
                        </v-card-text>
                      </v-card>
                    </v-expansion-panel-content>
                  </v-expansion-panel>
                  <td class="text-xs-left"> {{ props.item.Fornecedore.fornecedor_nome }} </td>
                  <td class="text-xs-left"> <span class="boxquantidadegreen"> {{q * p}} CVE </span> </td>
                  <td class="text-xs-left dark">
                    <v-btn flat icon color="primary" @click="PrintVenda(props.item)"> <v-icon>print</v-icon> </v-btn>
                    <v-btn flat icon color="primary" @click="editCompra(props.item)"> <v-icon>edit</v-icon> </v-btn>
                  </td>
                  </template>
                  <template slot="no-data">
                      <v-alert :value="true" color="warning" icon="warning">
                        {{ $t('message.txtResuPesquisa') }} {{data_ini}} & {{data_fim}}!
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
import Vendedor from "@/components/componentes/Vendedor";
import Admin from "@/components/componentes/Admin";
import filterServices from "@/services/filterServices"
import CompraServices from "@/services/CompraServices";
import ProdutosService from "@/services/ProdutosService"
import stockServices from "@/services/stockServices"
import AuthenticationService from "@/services/AuthenticationService";
import moment from 'moment'
import { mapState } from 'vuex'

export default {
  data() {
    return {
      e1: "",
      dialogPesquisa: false,
      data_hoje: new Date().toISOString().substr(0, 10),
      modal: false,
      idSearch: "",
      menu1: false,
      menu2: false,
      listaprodutos: [],
      data_ini: null,
      data_fim: null,
      show1: false,
      userconfig: 0,
      valid: true,
      total: '',
      error: null,
      alert: false,
      alertadmin: false,
      dialog: false,
      produto: [{
        VendaId: '',
        ProdutoId: '',
        idProduto: '',
        quantidade: '',
        search: '',
        stock_id: ''
      }],
      venda: {
        data_venda: '',
        UserId: '',
        status: 'vendido'
      },
      stock: {
        quantidade: '',
        ProdutoId: '',
      },
      headers: [
        { text: "N.", value: "id", align: "left", width: '5%', sortable: true },
        { text: "Data / Hora", value: "createdAt", align: "left", sortable: true },
        { text: "Produto / Quantidade", align: "left", sortable: false },
        { text: "Fornecedor", align: "left", sortable: false },
        { text: "Valor Total", value: "valor_total", align: "left", sortable: true },
        { text: "Ações", align: "left", sortable: false },
      ],
      desserts: [],
      CategoriaId: []
    };
  },
  components: {
        Vendedor,
        Admin
    },
  methods: {
    async searchProd() {
      this.dialogPesquisa = true
    },
    async reload() {
      if (this.isUserLoggedIn) {
        this.desserts = (await CompraServices.index()).data;
      }
      this.data_ini = null,
      this.data_fim = null,
      this.total = this.desserts.length
    },
    editCompra: function(item) {
      //this.editedIndex = this.desserts.indexOf(item);
      this.lista = Object.assign({}, item);
      this.produto =  this.lista.ListaCompras;
      console.log(this.produto)
      this.dialog = true;
      //this.precos = Object.assign({}, item)
    },
    async pesquisar() {
        this.desserts = (await CompraServices.indexTotal({
          dataIni: this.data_ini,
          dataFim: this.data_fim
        })).data;
      this.total = this.desserts.length
      console.log("TESTE::: "  + this.desserts)
    },
  },
  created() {
    this.currentTime = moment().format('LTS')
    this.currentDate = moment().format('l')
  },
  computed: {
    ...mapState([
      'isUserLoggedIn',
      'user'
    ])
  },
  async mounted() {
    this.desserts = (await CompraServices.index()).data;

    console.log("DADOS", this.desserts)
    this.total = this.desserts.length

    this.listaprodutos = (await ProdutosService.index()).data;
    console.log('Meus Produtos', this.listaprodutos)
  }
}
</script>

<style lang="css" scoped>
.TVenda{
  padding:5px 10px 5px 10px; 
  background-color:#1976d2;
  color:#fff;
  font-weight:400;
  font-size: 1.2em;
  border-radius:5px;
}

.nobordertr{
  border-bottom: 0px !important;
}
.boxquantidade {
  font-weight:400;
  background: #1976d2;
  color: aliceblue;
  padding: 4px 6px;
  border-radius: 10%
}
.boxquantidadegreen {
  font-weight:400;
  background: green;
  color: aliceblue;
  padding: 4px 6px;
  border-radius: 10%
}
.boxquantidadered {
  font-weight:400;
  background: red;
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

.span {
  padding: 6px;
  display: block;
}
.meutexto{
  font-size: 2em !important;
  font-weight: bold;
  font-family: 'Arial', monospace  !important;
}
.fixo {
  z-index: 199;
  position: fixed;
  bottom: 0;
}
.titleProdPag{
  text-align: center;
  margin-bottom: 26px;
  background: #999;
  color: #fff;
  font-size: 1.2em;
  padding: 10px 20px;
}
.titleProd {
  margin-bottom: 26px;
  background: #999;
  color: #fff;
  font-size: 1.2em;
  padding: 10px 20px;
}
.meudiv{
  padding: 2px;
}
.layoutmeu{
  margin-bottom: -26px;
}
.quantidadetext{
  text-align: center !important;
  color: green !important;
  font-size: 1.2em;
  margin: 0 auto !important;
  text-transform: uppercase
}

.panel-body {
	padding: 15px;
}

.dadosTolbar{
  font-size: 1.6em;
  color: #1976d2;
  margin: 4px 5px 4px 0;
}

.myinputs {
  font-size:1.2em; 
  padding:6px 15px; 
  border:2px solid #dcd5d5; 
  border-radius:5px;
  margin-bottom: 5px;
  margin-left: 5px
}
.myinputsdata {
  font-size:1.2em; 
  padding:14px 16px; 
  border:2px solid rgba(0,0,0,.54);
  border-radius:5px;
  margin-bottom: 5px;
  margin-left: 5px
}
@media only screen and (min-width: 1264px){
  .container {
      max-width: 100% !important;
  }
}
@media only screen and (min-width: 960px){
  .container {
      max-width: 100% !important;
  }
}
@media only screen and (min-width: 1904px){
  .container {
      max-width: 100% !important;
  }
}
@media only screen and (min-width: 960px){
  .container[data-v-51dca86c] {
      max-width: 100% !important;
  }
}
.v-bottom-nav .v-btn {
    background: transparent!important;
    border-radius: 0;
    box-shadow: none!important;
    flex-shrink: 1;
    font-weight: 400;
    height: 100%;
    margin: 0;
    max-width: 168px;
    min-width: 80px;
    opacity: 1 !important;
    padding: 8px 12px 10px;
    text-transform: none;
    width: 100%;
}
.marginmeu {
  margin-bottom: 200px;
}
</style>
