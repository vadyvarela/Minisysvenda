<template>
    <panel :title="$t('message.compra')">
      <v-content>
      <v-layout justify-end row wrap>
        <v-flex text-lg-left xs12>
        </v-flex>
      </v-layout>
      <v-divider></v-divider>
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

      <v-btn style="display:none;" dark v-shortkey="['f3']" @shortkey="left = !left" @click.stop="left = !left"> </v-btn>
                
      <v-stepper class="marginmeu" v-model="e1">
        <v-stepper-header>
          <v-stepper-step editable :complete="e1 > 1" step="1"> {{ $t('message.dadoscompra') }} </v-stepper-step>
          <v-divider></v-divider>
          <v-stepper-step editable step="2"> {{ $t('message.produtos') }} </v-stepper-step>
        </v-stepper-header>

        <v-stepper-items>
        <v-stepper-content step="1">
          <v-layout align-center justify-center>
          <v-flex xs12 sm12 md12>
            <v-alert
              v-html="error"
              :value="alert"
              transition="scale-transition"
              type="error"
              >
            </v-alert>
            <v-card class="elevation-0">
              <v-card-text>
                <v-form ref="form" name="cadastar" autocomplete="off" lazy-validation>
                  <v-container grid-list-md>
                      <v-layout wrap>
                        <v-flex xs12 sm12 md12>
                        </v-flex>
                        <span hidden>{{ compra.UserId = user.id }}</span>
                        <v-flex xs12 sm4 md4>
                          <v-text-field readonly box color="blue" name="usuarios_id" :value="user.usuario" :label="$t('message.funcionario')" type="text"></v-text-field>
                          <input name="produto_id" v-model="compra.UserId" type="hidden"/>
                        </v-flex>
                        <v-flex xs12 sm4 md4>
                          <v-autocomplete
                            box
                            :items="FornecedoreId"
                            color="white"
                            v-model="compra.FornecedoreId"
                            item-text="fornecedor_nome"
                            item-value="id"
                            :label="$t('message.fornecedor_nome')"
                            required
                            :rules="fornecRules"
                          ></v-autocomplete>
                          <input name="" v-model="compra.FornecedoreId" type="hidden"/>  
                        </v-flex>
                        <v-flex xs12 sm4 md4>
                          <span hidden>{{ compra.data_compra = Date() | moment("DD-MM-YYYY HH:mm:ss") }}</span>
                          <input name="" v-model="compra.data_compra" type="hidden"/>   
                          <v-text-field box color="blue" readonly required :value="compra.data_compra" name="data_compra" :label="$t('message.dataCompra')" type="text"></v-text-field>
                        </v-flex>
                    </v-layout>
                  </v-container>
                  <v-spacer></v-spacer>
                  <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="primary" :disabled="!formIsValid" @click="createCompra(), e1 = 2"> {{ $t('message.btnContinuar') }} </v-btn>
                  </v-card-actions>
              </v-form>
            </v-card-text>
            </v-card>
          </v-flex>

        </v-layout>
        </v-stepper-content>

        <v-stepper-content step="2">
          <v-toolbar
            card
            color="white"
          >
            <v-flex xs6>
              <v-toolbar-title style="font-weight:bold; font-size:1.8em;" class="primary--text">{{ $t('message.listaproduto') }}</v-toolbar-title>
            </v-flex>
            <v-spacer></v-spacer>
            <v-flex text-lg-right xs6>
              <v-btn right large router-link to="listacompras" dark class="primary" > {{ $t('message.inventarioProd') }} </v-btn>
            </v-flex>
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
                <div v-bind:key="index" v-for="(produto, index) in produtos">
                  <h2 hidden> {{ banana = index }} </h2>
                  <h2 hidden>{{ produto.CompraId = idCompra }}</h2>
                  <div v-if="produtos[index].idProduto && produtos[index].idProduto.Iva">
                    <h4 hidden>NOME: {{ produto.nome = produtos[index].idProduto.produto_nome }}</h4>
                    <h4 hidden>IVA: {{ produto.iva = produtos[index].idProduto.Iva.iva_valor }}</h4>
                    <h4 hidden>PREÇO: {{ produto.preco = produtos[index].idProduto.produto_preco }}</h4>
                    <h4 hidden>ID PRODUTO: {{ produto.ProdutoId = produtos[index].idProduto.id }}</h4>
                    <span v-if="produto.preco">
                      <h4 hidden>TOTAL LIQUIDO: {{ produto.totalLiquido = produto.quantidade * produto.preco_venda }}</h4>
                      <h4 hidden>TOTAL: {{ produto.total = produto.quantidade * produto.preco }}*</h4>
                      <span hidden> TOTAL IVA:  {{ produto.totalIva = produto.preco_venda * produto.iva / 100 }}</span>
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
                        <v-text-field box v-model.number="produto.quantidade" @keyup.enter="addNewProduto(index)" ref="searchquantidade" label="Quantidade" type="number"></v-text-field>
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
    </v-content>

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
            v-shortkey="['ctrl','n']" @shortkey="addNewProduto(banana)" @click="addNewProduto(banana)"
          >
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


    </panel>
</template>

<script>
import { mapState } from 'vuex'
import FornecedoresService from "@/services/FornecedorService";
import ProdutosService from "@/services/ProdutosService";
import CategoriasService from "@/services/CategoriasService"
import filterServices from "@/services/filterServices"
import CompraServices from "@/services/CompraServices"
import listaCompraServices from "@/services/listaCompraServices"
import stockServices from "@/services/stockServices"

export default {
  data() {
    return {
      snackbarnorow: false,
      colornorow: 'error',
      textnorow: 'Para criar nova linha tem que preencher a linha anterior',
      snack: false,
      drawer: false,
      left: false,
      drawer1: false,
      clipped: false,
      snackColor: '',
      showNav: true,
      blockRemoval: true,
      snackText: '',
      e1: '',
      listaprodutos: [],
      idCompra: [],
      categorias: [],
      listaprodutos: [],
      listaprodutosCat: [],
      usuario_nome: '',
      snackbar: false,
      dialogPesquisa: false,
      color: 'error',
      mode: '',
      timeout: 6000,
      text: 'Não foi encontrado produto com esse código ou código de barra',
      fornecRules: [v => !!v || "Campo fornecedor é obrigatório"],
      FornecedoreId: [],
      produtos: [{ 
        CompraId: '',
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
      valid: true,
      error: null,
      alert: false
    };
  },
  watch: {
    produtos () {
      this.blockRemoval = this.produtos.length <= 1
    }
  },
  methods: {
    addNewProduto(banana) {
      if (this.produtos[banana].search.length !== 0 ) {
        this.produtos.push({
          CompraId: '',
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
    async pesquisar(index) {
      try {
        this.search = this.produtos[index].search
        this.produtos[index].idProduto = (await filterServices.bynamecompra(this.search)).data
        Object.keys(this.produtos[index].idProduto).forEach(key => {
          this.produtos[index].idProduto = this.produtos[index].idProduto[key];
        })
        if (this.produtos[index].idProduto.length === 0) {
          this.snackbar = true
          this.$refs.search[index].reset();
          this.$refs.search[index].focus();
        } else {
          // this.$refs.searchquantidade[index].focus();
          this.addNewProduto(index)
        }
        console.log('PRODUTO', this.produtos[index].idProduto)
      } catch (err) {
        console.log(err);
      }
    },
    async createCompra() {
      console.log(this.compra)
      await CompraServices.post(this.compra);
      this.idCompra = (await CompraServices.lastid()).data[0].id;
      console.log("ID: ", this.idCompra)
      /*this.$toast.success({
        title: "Sucesso",
        message: "Sucesso ao cadastrar"
      })*/
    },
    async createCompraProd() {
      listaCompraServices.post(this.produtos);
      console.log('Meus Produtos: ', this.produtos)
      stockServices.putcompras(this.produtos);
      console.log('Meus Stock: ', this.produtos) 
      this.$router.push({
        name: 'listacompras'
      })
      this.$toast.success({
        title: "Sucesso",
        message: "Compra adicionada com sucesso no sistema"
      })
    }
  },
  async mounted() {
    this.listaprodutos = (await ProdutosService.index()).data;
    console.log('Meus Produtos', this.listaprodutos)
    // Fazer requisicao para pegar todas os fornecedores
    this.FornecedoreId = (await FornecedoresService.index()).data;
    //this.ProdutoId = (await ProdutosService.index()).data;
    //console.log(this.ProdutoId)
    this.categorias = (await CategoriasService.indexImage()).data;
    console.log("MEUS CAT:", this.categorias)
  },
  computed: {
    ...mapState([
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
    },
  }
}
</script>

<style scoped>
 
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