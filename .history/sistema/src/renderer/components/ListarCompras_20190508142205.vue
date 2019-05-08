<template>
    <panel title="LISTA DE VENDAS">
      <v-content >
        <v-layout justify-end row>
          <v-flex text-lg-left xs6>
            <v-badge class='mt-3 mr-4' right>              
              <span class="title"> {{ $t('message.TotalVendasFeitas') }} </span>
              <span class="TVenda"> {{ totall }} </span>
            </v-badge>
          </v-flex>
          <v-flex text-lg-right xs6>
            <v-btn router-link to="vendas" text-lg-right class="primary">  {{ $t('message.btnNovaVenda') }} </v-btn>
          </v-flex>
        </v-layout>

        <v-snackbar
        v-model="snackbarnorow"
        :color="colornorow"
        :multi-line="mode === 'multi-line'"
        :timeout="timeout"
        :vertical="mode === 'vertical'"
      >
        {{ textnorow }}
        <v-btn
          dark
          flat
          @click="snackbarnorow = false"
        >
          Fechar
        </v-btn>
      </v-snackbar>


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
          <v-container>
              
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
                        <v-flex class="titleProd" xs12 sm4 md4>
                          <label class=""> {{ $t('message.refCodBarra') }} </label>
                        </v-flex>
                        <v-flex class="titleProd" xs12 sm4 md4>
                          <label >{{ $t('message.produto_nome') }}</label>
                        </v-flex>
                        <v-flex class="titleProd" xs12 sm2 md2>
                          <label>{{ $t('message.quantidade') }}</label>
                        </v-flex>
                        <v-flex style="text-align:right" class="titleProd" xs12 sm1 md1>
                          <label> {{ $t('message.produto_p') }} </label>
                        </v-flex>
                        <v-flex style="text-align:right" class="titleProd" xs12 sm2 md2>
                          <label> {{ $t('message.total') }} </label>
                        </v-flex>
                      </v-layout>
                    </div>
                    

                  <div v-bind:key="index" v-for="(produto, index) in produtos">
                      <h2 hidden> {{ banana = index }} </h2>

                      <h3 >ID Pesquisa: {{ produto.idSearchNew = idCompra }}</h3>
                      <div  v-if="produto.Produto">
                    <h3>ID Pesquisa: {{ produto.idSearch = idSearch }}</h3>
                    <span hidden> {{ produto.adminPVenda = produtos[index].adminPVenda }} </span>
                    <h4>NOME: {{ produto.nome = produto.Produto.produto_nome }}</h4>
                    <h2 hidden v-if="user.nivel == 2 && userconfig != 1">PRECO VENDA: {{ produto.preco_venda = produto.Produto.PVendas[0].pvenda_preco }} </h2>
                    <h2 hidden v-if="user.nivel == 1 && produto.adminPVenda  == ''">PRECO VENDA ADMIn: {{ produto.preco_venda = produto.Produto.PVendas[0].pvenda_preco }} </h2>
                    <h2>PRECO VENDA 1: {{ produto.PVendaListOne = produto.Produto.PVendas[0] }} </h2>
                    <h2>SELECT PRECO VENDA: {{ produto.PVendaList = produto.Produto.PVendas }} </h2>
                    <h4>IVA: {{ produto.iva = produto.Produto.Iva.iva_valor }}</h4>
                    <h4>IVA: {{ produto.search = produto.Produto.produto_nome }}</h4>
                    <h4>ID PRODUTO: {{ produto.ProdutoId = produto.Produto.id }}</h4>
                  </div>

                      <div v-if="produtos[index].Produto">
                        <h4 hidden>NOME: {{ produto.nome = produtos[index].Produto.produto_nome }}</h4>
                        <h4 hidden>NOME: {{ produto.search = produtos[index].Produto.produto_nome }}</h4>
                        <h4 hidden>PREÇO: {{ produto.preco = produtos[index].Produto.produto_preco }}</h4>
                        <h4 hidden>ID PRODUTO: {{ produto.ProdutoId = produtos[index].Produto.id }}</h4>
                        <span v-if="produto.preco">
                          <h4 hidden>TOTAL: {{ produto.total = produto.quantidade * produto.preco }}*</h4>
                        </span>
                      </div>
                      <div v-else>
                        <h2 hidden>Sorry Vady</h2>
                      </div>

                      <v-form ref="form" name="cadastar" autocomplete="off" lazy-validation>
                      <v-layout class="layoutmeu">
                      
                      <v-navigation-drawer width="700" temporary fixed :clipped="clipped" v-model="left" enable-resize-watcher app right >
                          <v-divider></v-divider>
                          <h4 class="primary--text text-md-center" style="font-size:2em; margin-top:4px">SELECIONE A CATEGORIA DO PRODUTO </h4>
                          <v-divider></v-divider>
                            <v-card-text>
                            <v-container grid-list-sm fluid>
                              <v-layout row wrap>
                                <v-flex
                                  v-for="(categoria, index) in categorias"
                                  :key="index" xs3 d-flex @click="prodByCat1(myCatId = categoria.id)"
                                >
                                  <v-card style="padding:12px" flat tile class="d-flex">
                                    <v-img
                                      :src="'http://minisys.innovatmedialab.com/server/src/uploads/' + categoria.filename"
                                      :lazy-src="'http://minisys.innovatmedialab.com/server/src/uploads/' + categoria.filename"
                                      aspect-ratio="1"
                                      class="grey lighten-2"
                                    >
                                      <v-layout
                                        slot="placeholder"
                                        fill-height
                                        align-center
                                        justify-center
                                        ma-0
                                      >
                                        <v-progress-circular indeterminate color="grey lighten-5"></v-progress-circular>
                                      </v-layout>
                                    </v-img>
                                  </v-card>
                                </v-flex>
                              </v-layout>
                            </v-container>
                            </v-card-text>
                        </v-navigation-drawer>
                        <v-navigation-drawer width="700" temporary fixed right :clipped="clipped" v-model="drawer1" enable-resize-watcher app >
                          <v-divider></v-divider>
                          <v-layout>
                            <v-flex xs6 sm2 md2>
                            <v-btn flat icon color="primary" dark @click="backToCat"> <v-icon>keyboard_backspace</v-icon> </v-btn>
                            </v-flex>
                            <v-flex xs6 sm8 md8>
                            <h4 class="primary--text text-md-center" style="font-size:2em;">SELECIONE O PRODUTO </h4>
                            </v-flex>
                          </v-layout>
                          <v-divider></v-divider>
                            <v-card-text>
                            <v-container grid-list-sm fluid>
                              <v-layout row wrap>
                                <h2 class="text-md-center red--text" v-if="listaprodutosCat.length === 0">Nenhum produto encontrado nessa categoria!</h2>
                                <v-flex
                                  v-for="(prod, idx) in listaprodutosCat"
                                  :key="idx"
                                  xs3
                                  d-flex
                                >
                                  
                                  <v-card style="padding:12px;" flat tile class="elevation-4 d-flex">
                                    <v-img
                                      :src="'http://minisys.innovatmedialab.com/server/src/uploads/' + prod.filename"
                                      :lazy-src="'http://minisys.innovatmedialab.com/server/src/uploads/' + prod.filename" aspect-ratio="1"
                                      class="grey lighten-2"
                                      @click.native="dialogProdCategorias = false; pesquisarbyCat(index, nome = prod.produto_nome)"
                                    >
                                      <v-layout
                                        slot="placeholder"
                                        fill-height
                                        align-center
                                        justify-center
                                        ma-0
                                      >
                                        <v-progress-circular indeterminate color="grey lighten-5"></v-progress-circular>
                                      </v-layout>   
                                    </v-img>
                                  </v-card>
                                </v-flex>
                              </v-layout>
                              </v-container>
                            </v-card-text>
                        </v-navigation-drawer>
                      

                        <v-flex xs12 sm4 md4>
                          <v-btn style="display:none;" v-shortkey="['ctrl','p']" @shortkey="searchProd" @click.stop="searchProd"></v-btn>
                          <v-text-field box v-model.trim="produto.search" ref="search" autofocus v-on:keyup.enter="pesquisarProd(index)" type="text"></v-text-field>
                          <input v-model="produto.search" type="hidden" autofocus />
                          <input v-model="produto.CompraId" type="hidden"/>
                          <input v-model="produto.ProdutoId" type="hidden"/>
                        </v-flex>
                        <v-flex xs12 sm4 md4>
                          <v-text-field box readonly :value="produto.nome" type="text"></v-text-field>
                        </v-flex>
                       <v-flex xs12 sm2 md2>
                          <v-text-field box v-model.number="produto.quantidade" v-on:input="changeQuantidade(index)" ref="searchquantidade" label="Quantidade" type="number"></v-text-field>
                          <input v-model.number="produto.quantidade" v-on:input="changeQuantidade(index)" @keyup.enter="addNewProduto(index)" type="hidden"/>
                        </v-flex>
                        <v-flex xs12 sm1 md1>
                          <v-text-field box reverse readonly :value="produto.preco" name="" type="number"></v-text-field>
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
              </v-container>
            </v-card-text>
        </v-card>

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
                                        v-model="podpesquisa"
                                        item-text="produto_nome"
                                        item-value="produto_nome"
                                        label="Nome produto"
                                      ></v-autocomplete>
                                      <input name="" v-model="podpesquisa" type="hidden"/>   
                                    </p>
                                  </v-flex>
                                </v-layout>
                              </v-container>
                            </v-card-text>
                            <v-card-actions>
                              <v-spacer></v-spacer>
                              <v-btn center large color="primary darken-1" @click.native="dialogPesquisa = false; pesquisarProd(banana)">OK</v-btn>
                            </v-card-actions>
                          </v-card>
                        </v-dialog>

         <v-bottom-nav
            height="120"
            :value="showNav"
            fixed
            color="green"
          >
          <v-container>
            <v-layout style="margin-top:-22px;" wrap>
              <v-flex class="text-xs-left" xs12 sm10 md10>
                <v-btn
                  color="white"
                  flat
                  v-shortkey="['ctrl','n']" @shortkey="addNewProduto(banana)" @click="addNewProduto(banana)">
                  <span style="font-size:1.5em;"> {{ $t('message.novaL') }} </span>
                  <v-icon>add</v-icon>
                </v-btn>
              </v-flex>
              <v-flex v-if="e1 == '1'" class="text-xs-right" xs12 sm2 md2>
                <v-btn
                  disabled
                  color="white"
                  flat
                  v-shortkey="['ctrl','enter']" @shortkey="createCompraProd()" @click="createCompraProd()"
                >
                  <span style="font-size:1.5em;"> {{ $t('message.finalizarCompra') }} </span>
                  <v-icon>send</v-icon>
                </v-btn>
              </v-flex>
              <v-flex v-else class="text-xs-right" xs12 sm2 md2>
                <v-btn
                  color="white"
                  flat
                  v-shortkey="['ctrl','enter']" @shortkey="createCompraProd()" @click="createCompraProd()"
                >
                  <span style="font-size:1.5em;"> {{ $t('message.finalizarCompra') }} </span>
                  <v-icon>send</v-icon>
                </v-btn>
              </v-flex>
            </v-layout>
            <v-divider dark></v-divider>
            <v-layout style="">
              <v-flex xs12 sm9 md9>
              </v-flex>
              <v-flex class="text-xs-right" xs12 sm3 md3>
                <span style="font-size:2.4em; font-weight:300; margin-right:8px" class="text-xs-right white--text"> {{ $t('message.total') }}: </span>
                <vue-numeric v-if="totalPrice === ''" read-only style="font-size:2.4em; font-weight:700; color: #fff;" class="text-xs-center white--text" :value="0"></vue-numeric>
                <vue-numeric v-if="totalPrice >= 100000" read-only style="font-size:1.6em; font-weight:700; color: #fff;" class="text-xs-center white--text" :value="totalPrice"></vue-numeric>
                <vue-numeric v-else read-only style="font-size:2.5em; font-weight:700; color: #fff;" class="text-xs-left white--text" :value="totalPrice"></vue-numeric>
                <span v-if="totalPrice >= 100000" style="font-size:1.6em; font-weight:700; color: #fff;" class="text-xs-right white--text" > CVE</span>
                <span v-else style="font-size:2.4em; font-weight:700; color: #fff;" class="text-xs-right white--text" > CVE</span>
              </v-flex>
            </v-layout>
          </v-container>
          </v-bottom-nav>
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
                  
                  <template slot="items" slot-scope="props" v-if="props.item.ListaCompra !== ''">
                  
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
                          <!--td>{{ produto.Produto.produto_nome }}</td>
                          <td>{{ q = produto.quantidade }}</td>
                          <td>{{ p = produto.Produto.produto_preco }}</td-->
                          </tr>
                        </v-card-text>
                      </v-card>
                    </v-expansion-panel-content>
                  </v-expansion-panel>
                  <td class="text-xs-left"> {{ props.item.Fornecedore.fornecedor_nome }} </td>
                  <!-- <td class="text-xs-left"> <span class="boxquantidadegreen"> {{q * p}} CVE </span> </td> -->
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
import FornecedoresService from "@/services/FornecedorService";
import CategoriasService from "@/services/CategoriasService"
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
      snackbarnorow: false,
      podpesquisa: '',
      colornorow: 'error',
      textnorow: 'Para criar nova linha tem que preencher a linha anterior',
      e1: "",
      dialogPesquisa: false,
      data_hoje: new Date().toISOString().substr(0, 10),
      modal: false,
      idSearch: "",
      menu1: false,
      menu2: false,
      drawer: false,
      left: false,
      drawer1: false,
      clipped: false,
      listaprodutos: [],
      idCompra: '',
      categorias: [],
      listaprodutos: [],
      listaprodutosCat: [],
      showNav: true,
      data_ini: null,
      data_fim: null,
      show1: false,
      userconfig: 0,
      valid: true,
      totall: '',
      error: null,
      alert: false,
      alertadmin: false,
      dialog: false,
      color: 'error',
      mode: '',
      timeout: 6000,
      produtos: [{ 
        CompraId: '',
        idSearch: '',
        ProdutoId: '',
        idProduto: '',
        total: '',
        quantidade: '1',
        search: '',
        stock_id: ''
      }],
      compra: {
        FornecedoreId: "",
        data_compra: '',
        UserId: '',
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
      this.totall = this.desserts.length
    },
    addNewProduto(banana) {
      if (this.produtos[banana].search.length !== 0 ) {
        this.produtos.push({
          CompraId: '',
          idSearchNew: '',
          ProdutoId: '',
          idProduto: '',
          total: '',
          quantidade: '1',
          search: '',
          stock_id: ''
        })
      }else {
         this.snackbarnorow = true
      }
    },
    removeNewProduto(index) {
      if (!this.blockRemoval) this.produtos.splice(index, 1)
    },
    async backToCat () {
      this.left = true
      this.drawer1 = false
    },
    async prodByCat (myCatId) {
      console.log('MEU ID CAT ___________.::::::::.____________', myCatId)
      this.listaprodutosCat = (await ProdutosService.indexByCat({
        CategoriaId: myCatId
      })).data;
      console.log('Meus Produtos', this.listaprodutosCat)
      this.dialogPesquisaCategoria = false
      this.dialogProdCategorias = true
    },
    async prodByCat1 (myCatId) {
      console.log('MEU ID CAT ___________.::::::::.____________', myCatId)
      this.listaprodutosCat = (await ProdutosService.indexByCat({
        CategoriaId: myCatId
      })).data;
      console.log('Meus Produtos', this.listaprodutosCat)
      this.left = false
      this.drawer1 = true
    },
    async searchProd() {
      this.dialogPesquisa = true
    },
    async pesquisarbyCat(index, nome) {
      this.drawer1 = false
      try {
        this.search = nome
        this.produtos[index].search = nome
        if (this.search !== '') {
          this.produtos[index].idProduto = (await filterServices.bynamevenda(this.search)).data
          console.log(this.produtos[index].idProduto)
          Object.keys(this.produtos[index].idProduto).forEach(key => {
            this.produtos[index].idProduto = this.produtos[index].idProduto[key];
            if (this.produtos[index].idProduto.Stock.quantidade === 0) {
              this.dialogStock = true
            }
          });
          if (this.produtos[index].idProduto.length === 0) {
            this.snackbar = true
            this.$refs.search[index].reset();
            this.$refs.search[index].focus();
          } else {
            this.addNewProduto(index)
            // this.$refs.searchquantidade[index].focus();
          }
          this.produtos[index].adminPVenda = ''
        }
      } catch (err) {
        console.log(err);
      }
    },
    changeQuantidade (index) {
      console.log("vady " + this.produtos[index].idSearch)
      if(this.produtos[index].idSearch == null || this.produtos[index].idSearch == '' ){
        console.log("Nao Fazer nada")
      }else {
        stockServices.putstockaddremove(this.produtos[index])
        this.$toast.success({
          title: "Aviso",
          message: "Stock do produto atualizado com sucesso"
        })
      }
    },
    async pesquisarProd(banana) {
      try {
        this.search = this.podpesquisa
        this.produtos[banana].search = this.podpesquisa
        this.produtos[banana].Produto = (await filterServices.bynamecompra(this.search)).data
        Object.keys(this.produtos[banana].Produto).forEach(key => {
          this.produtos[banana].Produto = this.produtos[banana].Produto[key];
        })
        if (this.produtos[banana].Produto.length === 0) {
          this.snackbar = true
          this.$refs.search[banana].reset();
          this.$refs.search[banana].focus();
        } else {
          // this.$refs.searchquantidade[index].focus();
          this.addNewProduto(banana)
        }
        console.log('PRODUTO', this.produtos[banana].Produto)
      } catch (err) {
        console.log(err);
      }
    },
    editCompra: function(item) {
      //this.editedIndex = this.desserts.indexOf(item);
      this.lista = Object.assign({}, item);
      this.produtos =  this.lista.ListaCompras;
      console.log(this.idCompra =  this.lista.id);
      this.dialog = true;
      //this.precos = Object.assign({}, item)
    },
    async pesquisar() {
        this.desserts = (await CompraServices.indexTotal({
          dataIni: this.data_ini,
          dataFim: this.data_fim
        })).data;
      this.totall = this.desserts.length
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
    ]),
    formIsValid () {
      return (
        this.compra.FornecedoreId &&
        this.compra.data_compra &&
        this.compra.UserId
      )
    },
    ListaProdIsValid () {
      return (
        this.produtos.CompraId &&
        this.produtos.ProdutoId
      )
    },
    totalQty() {
      return this.produtos.reduce((total, produto) => {
        return total + Number(produto.quantidade);
      }, 0);
    },
    totalPrice() {
      return this.produtos.reduce((total, produto) => {
        return total + Number(produto.total);
      }, 0);
    }
  },
  async mounted() {
    this.desserts = (await CompraServices.index()).data;
    console.log("DADOS", this.desserts)
    this.totall = this.desserts.length
    this.listaprodutos = (await ProdutosService.index()).data;
    // console.log('Meus Produtos', this.listaprodutos)
    // Fazer requisicao para pegar todas os fornecedores
    this.FornecedoreId = (await FornecedoresService.index()).data;
    //this.ProdutoId = (await ProdutosService.index()).data;
    //console.log(this.ProdutoId)
    this.categorias = (await CategoriasService.indexImage()).data;
    console.log("MEUS CAT:", this.categorias)
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
