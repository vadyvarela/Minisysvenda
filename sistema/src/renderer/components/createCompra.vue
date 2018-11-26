<template>
    <panel title="Compras">
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

      <v-stepper v-model="e1">
        <v-stepper-header>
          <v-stepper-step editable :complete="e1 > 1" step="1">Dados de compra</v-stepper-step>
          <v-divider></v-divider>
          <v-stepper-step step="2">Produtos</v-stepper-step>
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
                          <v-text-field readonly box color="blue" name="usuarios_id" :value="user.usuario" label="Funcionario" type="text"></v-text-field>
                          <input name="produto_id" v-model="compra.UserId" type="hidden"/>
                        </v-flex>
                        <v-flex xs12 sm4 md4>
                          <v-select
                            box color="blue"
                            name="FornecedoreId"
                            v-model="compra.FornecedoreId"
                            :items="FornecedoreId"
                            label="Selecione o fornecedor"
                            required
                            :rules="fornecRules"
                            item-text="fornecedor_nome"
                            item-value="id"
                          ></v-select>
                        </v-flex>
                        <v-flex xs12 sm4 md4>
                          <span hidden>{{ compra.data_compra = Date() | moment("DD-MM-YYYY HH:mm:ss") }}</span>
                          <input name="" v-model="compra.data_compra" type="hidden"/>   
                          <v-text-field box color="blue" readonly required :value="compra.data_compra" name="data_compra" label="Data da compra" type="text"></v-text-field>
                        </v-flex>
                    </v-layout>
                  </v-container>
                  <v-spacer></v-spacer>
                  <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="primary" :disabled="!formIsValid" @click="createCompra(), e1 = 2"> Continuar </v-btn>
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
              <v-toolbar-title style="font-weight:bold; font-size:1.8em;" class="primary--text">LISTA DE PRODUTOS</v-toolbar-title>
            </v-flex>
            <v-spacer></v-spacer>
            <v-flex text-lg-right xs6>
              <v-btn right large router-link to="listacompras" dark class="primary" >Inventário de produtos</v-btn>
            </v-flex>
          </v-toolbar>
          <br>
          <v-divider></v-divider>
            <v-layout wrap>
              <v-flex xs12 sm12 md12>
                <div grid-list-md>
                  <v-layout style="margin-bottom: -25px;">
                    <v-flex class="titleProd" xs12 sm2 md2>
                      <label class="">Ref/ Cód barra</label>
                    </v-flex>
                    <v-flex class="titleProd" xs12 sm2 md2>
                      <label >Produto</label>
                    </v-flex>
                    <v-flex class="titleProd" xs12 sm2 md2>
                      <label>Quantidade</label>
                    </v-flex>
                    <v-flex class="titleProd" xs12 sm1 md1>
                      <label>Preço </label>
                    </v-flex>
                    <v-flex class="titleProd" xs12 sm2 md2>
                      <label>Preço VendA </label>
                    </v-flex>
                    <v-flex class="titleProd" xs12 sm1 md1>
                      <label>IVA%</label>
                    </v-flex>
                    <v-flex class="titleProd" xs12 sm1 md1>
                      <label>Total</label>
                    </v-flex>
                    <v-flex class="titleProd" xs12 sm1 md1>
                    </v-flex>
                  </v-layout>
                </div>
                <div v-bind:key="index" v-for="(produto, index) in produtos">
                  <h2 hidden>{{ produto.CompraId = idCompra }}</h2>
                  <div v-if="produtos[index].idProduto && produtos[index].idProduto.Iva">
                    <h4 hidden>NOME: {{ produto.nome = produtos[index].idProduto.produto_nome }}</h4>
                    <h4 hidden>IVA: {{ produto.iva = produtos[index].idProduto.Iva.iva_valor }}</h4>
                    <h4 hidden>PREÇO: {{ produto.preco = produtos[index].idProduto.produto_preco }}</h4>
                    <h4 hidden>ID PRODUTO: {{ produto.ProdutoId = produtos[index].idProduto.id }}</h4>
                    <h4 hidden>TOTAL: {{ produto.total = produtos[index].idProduto.produto_preco * ( 1 + produtos[index].idProduto.Iva.iva_valor / 100) }}</h4>
                  </div>
                  <div v-else>
                    <h2 hidden>Sorry Vady</h2>
                  </div>

                  <v-form ref="form" name="cadastar" autocomplete="off" lazy-validation>
                  <v-layout class="layoutmeu">
                    <v-flex xs12 sm2 md2>
                      <v-text-field box v-model.trim="produto.search" ref="search" autofocus v-on:keyup.enter="pesquisar(index)" type="text"></v-text-field>
                      <input v-model="produto.search" type="hidden" autofocus />
                      <input v-model="produto.CompraId" type="hidden"/>
                      <input v-model="produto.ProdutoId" type="hidden"/>
                    </v-flex>
                    <v-flex xs12 sm2 md2>
                      <v-text-field box readonly :value="produto.nome" type="text"></v-text-field>
                    </v-flex>
                    <v-flex xs12 sm2 md2>
                      <v-text-field box v-model.number="produto.quantidade" @keyup.enter="addNewProduto(index)" ref="searchquantidade" label="Quantidade" type="text"></v-text-field>
                      <input v-model.trim="produto.quantidade" @keyup.enter="addNewProduto(index)" type="hidden" autofocus/>
                    </v-flex>
                    <v-flex xs12 sm1 md1>
                      <v-text-field box readonly :value="produto.preco" name="" type="number"></v-text-field>
                    </v-flex>
                    <v-flex xs12 sm2 md2>
                      <v-select
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
                      <v-text-field box readonly :value="produto.iva" name="" type="number"></v-text-field>
                    </v-flex>
                    <v-flex xs12 sm1 md1>
                      <!--<v-text-field box readonly :value="produto.total" name="" type="number"></v-text-field>-->
                      <vue-numeric readonly style="border-bottom:1px solid #999; background:#f5f5f5; padding:15px 0 12px 4px; font-size:1.4em; color: green;" :value="produto.total"></vue-numeric>
                    </v-flex>
                    <v-spacer></v-spacer>
                    <v-flex xs12 sm1 md1>
                      <v-btn small left fab outline @click="removeNewProduto(index)" class="red"><v-icon>remove</v-icon></v-btn>
                    </v-flex>
                  </v-layout>
                  </v-form>
                </div>
                
                <v-spacer></v-spacer>
                <v-card-actions>
                  <v-btn dark fab class="primary" v-shortkey="['ctrl','n']" @shortkey="addNewProduto" @click="addNewProduto"><v-icon>add</v-icon></v-btn>
                  <v-spacer></v-spacer>
                  <v-btn large class="green" @click="createCompraProd()"> <span style="font-size:2em; font-weight:bold; color: #fff;"> Finalizar </span> </v-btn>
                </v-card-actions>
              </v-flex>
            </v-layout>
        </v-stepper-content>

        </v-stepper-items>
      </v-stepper>
    </v-content>

    <v-bottom-nav
      :value="showNav"
      fixed
      color="green"
    >
      <v-flex xs12 sm8 md8>
      </v-flex>
      <v-flex class="text-xs-right" xs12 sm3 md3>
        <span style="font-size:2.4em; font-weight:300; margin-right:8px" class="text-xs-right white--text"> {{ $t('message.total') }}: </span>
      </v-flex>
      <v-flex class="" xs12 sm1 md1>
        <vue-numeric v-if="totalPrice === ''" read-only style="font-size:2.4em; font-weight:700; color: #fff;" class="text-xs-center white--text" :value="0"></vue-numeric>
        <vue-numeric v-else read-only style="font-size:2.5em; font-weight:700; color: #fff;" class="text-xs-left white--text" :value="totalPrice"></vue-numeric>
      </v-flex>
    </v-bottom-nav>

    </panel>
</template>

<script>
import { mapState } from 'vuex'
import FornecedoresService from "@/services/FornecedorService";
import ProdutosService from "@/services/ProdutosService";
import filterServices from "@/services/filterServices"
import CompraServices from "@/services/CompraServices"
import listaCompraServices from "@/services/listaCompraServices"
import stockServices from "@/services/stockServices"

export default {
  data() {
    return {
      snack: false,
      snackColor: '',
      showNav: true,
      snackText: '',
      e1: '',
      idCompra: [],
      usuario_nome: '',
      snackbar: false,
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
        quantidade: '',
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
  methods: {
    addNewProduto() {
      this.produtos.push({
        CompraId: '',
        ProdutoId: '',
        idProduto: '',
        total: '',
        quantidade: '',
        search: '',
        stock_id: ''
      })
    },
    removeNewProduto(index) {
      this.produtos.splice(index, 1)
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
          this.$refs.searchquantidade[index].focus();
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
    // Fazer requisicao para pegar todas os fornecedores
    this.FornecedoreId = (await FornecedoresService.index()).data;
    //this.ProdutoId = (await ProdutosService.index()).data;
    //console.log(this.ProdutoId)
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
  text-align: center;
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
</style>