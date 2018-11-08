<template>
    <panel title="Vendas">
      <v-content>
      <v-layout justify-end row wrap>
        <v-flex text-lg-left xs12>
        </v-flex>
      </v-layout>

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

      <v-card
        class="hide-overflow"
        color="white lighten-1"
      >
        <v-toolbar
          card
          color="white"
        >
          <v-icon>mdi-account</v-icon>
          <v-btn dark small fab class="primary" v-shortkey="['ctrl','n']" @shortkey="addNewProduto" @click="addNewProduto"><v-icon>add</v-icon></v-btn>
          <v-spacer></v-spacer>
          <v-flex text-lg-right xs6>
            <v-toolbar-title style="font-weight:bold; font-size:1.6em;" class="primary--text">{{ $t('message.listaproduto') }}</v-toolbar-title>
          </v-flex>
          <v-flex text-lg-right xs6>
            <v-btn right router-link to="listavendas" dark class="primary">{{ $t('message.listavendas') }}</v-btn>
          </v-flex>
        </v-toolbar>
        <v-card-text>
            <v-divider></v-divider>
            <v-layout wrap>
                <!-- Dados para criar nova Venda -->
                <span hidden>{{ venda.data_venda = Date() | moment("DD-MM-YYYY HH:mm:ss") }}</span>
                <span hidden>{{ venda.UserId = user.id }}</span>
                <input name="produto_id" v-model="venda.UserId" type="hidden"/>
                <input name="produto_id" v-model="venda.data_venda" type="hidden"/>   
                <v-flex xs12 sm12 md12>
                <div grid-list-md class="meudiv">
                  <v-layout style="margin-bottom: -25px;">
                    <v-flex class="titleProd" xs12 sm2 md2>
                      <label class=""> {{ $t('message.refCodBarra') }} </label>
                    </v-flex>
                    <v-flex class="titleProd" xs12 sm3 md3>
                      <label > {{ $t('message.produto_nome') }} </label>
                    </v-flex>
                    <v-flex class="titleProd" xs12 sm2 md2>
                      <label>{{ $t('message.quantidade') }} </label>
                    </v-flex>
                    <v-flex class="titleProd" xs12 sm2 md2>
                      <label> {{ $t('message.precodevenda') }} </label>
                    </v-flex>
                    <v-flex class="titleProd" xs12 sm1 md1>
                      <label>{{ $t('message.iva') }}</label>
                    </v-flex>
                    <v-flex class="titleProd" xs12 sm1 md1>
                      <label>{{ $t('message.total') }}</label>
                    </v-flex>
                    <v-flex text-lg-center class="titleProd" xs12 sm1 md1>
                      <label><v-icon>remove</v-icon></label>
                    </v-flex>
                  </v-layout>
                </div>
                
                <div v-bind:key="index" v-for="(produto, index) in produtos">
                  <h3 hidden>ID VENDA: {{ produto.VendaId = idVenda }}</h3>
                  <h3 hidden>ID VENDA UPDATE: {{ pagamento.VendaId = idVenda }}</h3>
                  
                  <div v-if="produtos[index].idProduto && produtos[index].idProduto.Iva">
                    <h2 hidden v-if="user.nivel == 2 && userconfig != 1">PRECO VENDA: {{ produto.preco_venda = produtos[index].idProduto.PVendas[0].pvenda_preco }} </h2>
                    <h2 hidden>PRECO VENDA 1: {{ produto.PVendaListOne = produtos[index].idProduto.PVendas[0] }} </h2>
                    <h2 hidden >SELECT PRECO VENDA: {{ produto.PVendaList = produtos[index].idProduto.PVendas }} </h2>
                    <h4 hidden>NOME: {{ produto.nome = produtos[index].idProduto.produto_nome }}</h4>
                    <h4 hidden>IVA: {{ produto.iva = produtos[index].idProduto.Iva.iva_valor }}</h4>
                    <h4 hidden>ID PRODUTO: {{ produto.ProdutoId = produtos[index].idProduto.id }}</h4>
                    <h4 hidden v-if="pagamento.valorentregado != '' && pagamento.valorentregadovint4 == '' && pagamento.valorentregadocheque == '' ">TROOCO: {{ dvenda.troco = pagamento.valorentregado - totalPrice }}</h4>
                    <h4 hidden v-if="pagamento.valorentregadovint4 != '' && pagamento.valorentregado == '' && pagamento.valorentregadocheque == '' ">TROOCO: {{ dvenda.troco = pagamento.valorentregadovint4 - totalPrice }}</h4>
                    <h4 hidden v-if="pagamento.valorentregadocheque != '' && pagamento.valorentregado == '' && pagamento.valorentregadovint4 == '' ">TROOCO: {{ dvenda.troco = pagamento.valorentregadocheque - totalPrice }}</h4>
                    <h4 hidden v-else-if="pagamento.valorentregado != '' && pagamento.valorentregadovint4 != ''">TROOCO: {{ dvenda.troco = pagamento.valorentregado + pagamento.valorentregadovint4 - totalPrice }}</h4>
                    <h4 hidden v-else-if="pagamento.valorentregado != '' && pagamento.valorentregadovint4 != '' && pagamento.valorentregadocheque != '' ">TROOCO: {{ dvenda.troco = pagamento.valorentregado + pagamento.valorentregadovint4 + pagamento.valorentregadocheque - totalPrice }}</h4>
                    <h4 hidden>TOTAL LIQUIDO: {{ dvenda.tLiquido = totalPriceLiquido }}</h4>
                    <h4 hidden>TOTAL A PAGAR: {{ dvenda.tapagar = totalPrice }}</h4>
                    <h4 hidden>TOTAL A PAGAR IVA: {{ dvenda.tapagariva = totalIva }}</h4>
                    
                  </div>
                  <div v-else>
                    <h2 hidden>Sorry Vady</h2>
                  </div>

                  <v-form ref="form" name="cadastar" autocomplete="off" lazy-validation>
                  <v-layout class="layoutmeu">
                    <v-dialog v-model="dialog" persistent max-width="550px" @keydown.esc="dialog = false">
                      <v-card align-center justify-center>
                        <v-card-title>
                          <span class="headline"> {{ $t('message.metodoPagamento') }} </span>
                          <v-spacer></v-spacer>
                          <v-btn color="red" icon outline right small fab dark @click.native="dialog = false"><v-icon>close</v-icon></v-btn>
                        </v-card-title>
                        <v-card-text>
                          <v-container grid-list-md>
                            <v-layout wrap>
                              <v-flex xs12>
                                <h4 class="primary--text text-md-center" style="font-size:1.6em;"> {{ $t('message.totalaPagar') }} </h4>
                                <p>
                                  <vue-numeric readonly class="green--text" style="text-align:center; font-weight:bold; font-size:2em; width:100%" :value="dvenda.tapagar"></vue-numeric>
                                  <input name="" v-model="dvenda.tapagar" type="hidden"/>
                                  <input name="" v-model="dvenda.tapagariva" type="hidden"/>
                                  <input name="" v-model="dvenda.tLiquido" type="hidden"/>   
                                </p>
                              </v-flex>
                              <v-flex xs12 sm12 md12>
                                <div grid-list-md class="meudiv">
                                  <v-layout style="margin-bottom: -30px;">
                                    <v-flex class="titleProdPag" xs7 sm7 md7>
                                      <label class="">{{ $t('message.metodoPagamento') }}</label>
                                    </v-flex>
                                    <v-flex class="titleProdPag" xs5 sm5 md5>
                                      <label>{{ $t('message.valor') }}</label>
                                    </v-flex>
                                  </v-layout>
                                  <span hidden> {{pagamento.dinheiro = 'Dinheiro'}} </span>
                                  <span hidden> {{pagamento.vint4 = 'Vint4'}} </span>
                                  <span hidden> {{pagamento.cheque = 'Cheque'}} </span>
                                  <v-layout style="margin-bottom: -35px;">
                                    <v-flex xs7 sm7 md7>
                                      <v-text-field box readonly :value="pagamento.dinheiro" type="text"></v-text-field>
                                    </v-flex>
                                    <v-flex xs5 sm5 md5>
                                      <v-text-field box v-model.number="pagamento.valorentregado" type="number"></v-text-field>
                                    </v-flex>
                                  </v-layout>
                                  <v-layout style="margin-bottom: -35px;">
                                    <v-flex xs7 sm7 md7>
                                      <v-text-field readonly box :value="pagamento.vint4" type="text"></v-text-field>
                                    </v-flex>
                                    <v-flex xs5 sm5 md5>
                                      <v-text-field box v-model.number="pagamento.valorentregadovint4" type="number"></v-text-field>
                                    </v-flex>
                                  </v-layout>
                                  <v-layout style="margin-bottom: -35px;">
                                    <v-flex xs7 sm7 md7>
                                      <v-text-field box readonly :value="pagamento.cheque" type="text"></v-text-field>
                                    </v-flex>
                                    <v-flex xs5 sm5 md5>
                                      <v-text-field box v-model.number="pagamento.valorentregadocheque" type="text"></v-text-field>
                                    </v-flex>
                                  </v-layout>
                                </div>
                              </v-flex>
                              <!--<v-flex xs12 sm12 md12>
                                <v-select
                                  box color="blue"
                                  name="metodopagamento"
                                  v-model="pagamento.metodopagamento"
                                  :items="metodoPagamento"
                                  label="Metodo de pagamento"
                                  item-text="tipoPagamento"
                                  item-value="id"
                                ></v-select>
                              </v-flex>
                              <v-flex xs12 sm12 md12>
                                <v-text-field box v-model="dvenda.valorentregado" label="Valor entregado" ></v-text-field>
                              </v-flex>-->
                              
                              <v-flex xs12>
                                <h4 class="primary--text text-md-center" style="font-size:2em;"> {{ $t('message.troco') }} </h4>
                                <p v-if="pagamento.valorentregado || pagamento.valorentregadovint4 || pagamento.valorentregadocheque" >
                                  <vue-numeric v-if="dvenda.troco < 0 " readonly class="red--text" style="text-align:center; font-size:2em; font-weight:700; width:100%" :value="dvenda.troco"></vue-numeric>
                                  <vue-numeric v-else readonly class="green--text" style="text-align:center; font-size:2em; font-weight:700; width:100%" :value="dvenda.troco"></vue-numeric>
                                  <input name="produto_id" v-model="dvenda.troco" type="hidden"/>   
                                </p>
                                <p v-else class="red--text" style="text-align:center; font-size:1em;"> {{ $t('message.valorEntregado') }} </p>
                              </v-flex>
                              
                            </v-layout>
                          </v-container>
                        </v-card-text>
                        <v-card-actions>
                          <v-spacer></v-spacer>
                          
                          <v-btn large right color="primary darken-1" :disabled="!stockIsValid" @click.native="dialog = false"> {{ $t('message.finalizacompra') }} </v-btn>
                          <v-btn large color="success darken-1" :disabled="!stockIsValid" @click="createVendaProd"> {{ $t('message.fcompraimprimir') }} </v-btn>
                        </v-card-actions>
                      </v-card>
                    </v-dialog>


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

                    <v-dialog v-model="dialogStock" persistent max-width="550px" @keydown.esc="dialogStock = false">
                      <v-card align-center justify-center>
                        <v-card-text>
                          <v-container grid-list-md>
                            <v-layout wrap>
                              <v-flex xs12>
                                <h4 class="red--text text-md-center" style="font-size:2em;">Esse produto não tem estoque </h4>
                              </v-flex>
                            </v-layout>
                          </v-container>
                        </v-card-text>
                        <v-card-actions>
                          <v-spacer></v-spacer>
                          <v-btn center large color="primary darken-1" @click.native="dialogStock = false; removeNewProduto(index)">OK</v-btn>
                        </v-card-actions>
                      </v-card>
                    </v-dialog>

                    <v-flex flex xs12 sm2 md2>
                      <v-layout flex class="layoutmeu">
                        <v-btn style="display:none;" v-shortkey="['p']" @shortkey="searchProd" @click.stop="searchProd"></v-btn>
                        <v-flex xs12 sm12 md12>
                          <v-text-field box v-model.trim="produto.search" ref="search" autofocus v-on:keyup.enter="pesquisar(index)" type="text"></v-text-field>
                          <input v-model.trim="produto.search" type="hidden" autofocus />
                          <input v-model="produto.ProdutoId" type="hidden"/>
                        </v-flex>
                      </v-layout>
                    </v-flex>

                    <v-flex xs12 sm3 md3>
                      <v-text-field box readonly :value="produto.nome" type="text"></v-text-field>
                    </v-flex>
                    <v-flex xs12 sm2 md2>
                      <v-text-field box v-model.number="produto.quantidade" @keyup.enter="addNewProduto(index)" ref="searchquantidade" label="Quantidade" type="number"></v-text-field>
                      <input v-model.number="produto.quantidade" @keyup.enter="addNewProduto(index)" type="hidden" autofocus/>
                    </v-flex>

                    <v-dialog v-model="dialogPreco" @keydown.enter="login" persistent max-width="550px" @keydown.esc="dialogPreco = false">
                      <v-card align-center justify-center>
                        <v-card-text>
                          <v-container grid-list-md>
                            <v-layout align-center justify-center>
                            <v-flex xs12 sm12 md12 lg12>
                              <v-alert
                                v-html="error"
                                :value="alert"
                                transition="scale-transition"
                                type="error"
                                >
                              </v-alert>
                              <v-alert
                                v-html="noadmin"
                                :value="alertadmin"
                                transition="scale-transition"
                                type="warning"
                              >
                              </v-alert>

                              <v-card class="elevation-0 pa-3">
                              <v-card-title>
                                <v-spacer></v-spacer>
                                <v-btn color="red" icon outline right small fab dark @click.native="dialogPreco = false"><v-icon>close</v-icon></v-btn>
                              </v-card-title>
                                <v-card-text>
                                  <div class="layout column align-center">
                                    <h1 class="flex my-4 primary--text">LOGIN ADMINISTRADOR</h1>
                                  </div>                
                                  <v-form>
                                    <v-text-field
                                      autofocus
                                      prepend-icon="person" 
                                      name="usuario" 
                                      v-model="usuario" 
                                      label="Nome de usuario">
                                    </v-text-field>
                                    <v-text-field
                                      :append-icon="show1 ? 'visibility_off' : 'visibility'"
                                      :type="show1 ? 'text' : 'password'"
                                      @click:append="show1 = !show1"
                                      prepend-icon="lock" 
                                      name="password" 
                                      v-model="password" 
                                      label="Palavra passe" 
                                      id="password">
                                    </v-text-field>
                                  </v-form>
                                </v-card-text>
                                <v-card-actions>
                                  <v-spacer></v-spacer>
                                  <v-btn class="primary" @click="login()">Efetuar login</v-btn>
                                </v-card-actions>
                              </v-card>
                            </v-flex>
                          </v-layout>
                          </v-container>
                        </v-card-text>
                      </v-card>
                    </v-dialog>
                    <v-flex xs12 sm2 md2>

                      <v-select
                        v-if="user.nivel == 1"
                        box color="blue"
                        v-model="produto.preco_venda"
                        :items="produto.PVendaList"
                        label="Preço de venda"
                        item-text="pvenda_preco"
                        item-value="pvenda_preco"
                      ></v-select>
              
                      <v-select
                        v-if="user.nivel == 2 && userconfig == 1"
                        box color="blue"
                        v-model="produto.preco_venda"
                        :items="produto.PVendaList"
                        label="Preço de venda"
                        item-text="pvenda_preco"
                        item-value="pvenda_preco"
                      ></v-select>

                      <v-text-field box readonly v-if="userconfig != 1 && user.nivel == 2" v-model="produto.preco_venda" @click="changePVenda" name="" type="number"></v-text-field>
                      <span v-if="produto.preco_venda">
                      <h4 hidden>TOTAL LIQUIDO: {{ produto.totalLiquido = produto.quantidade * produto.preco_venda }}</h4>
                      <h4 hidden>TOTAL: {{ produto.total = produto.quantidade * produto.preco_venda }}</h4>
                      <span hidden> TOTAL IVA:  {{ produto.totalIva = produto.preco_venda * produto.iva / 100 }}</span>
                      </span>

                    </v-flex>
                    <v-flex xs12 sm1 md1>
                      <v-text-field box readonly :value="produto.iva" name="" type="number"></v-text-field>
                    </v-flex>
                    <v-flex xs12 sm1 md1>
                      <!--<v-text-field box readonly :value="produto.total" name="" type="number"></v-text-field>-->
                      <vue-numeric readonly style="border-bottom:1px solid #999; background:#f5f5f5; padding:15px 0 12px 4px; font-size:1.4em; color: green;" :value="produto.total"></vue-numeric>
                    </v-flex>
                    <v-spacer></v-spacer>
                    <v-flex text-lg-center xs12 sm1 md1>
                      <v-btn small left fab outline @click="removeNewProduto(index)" class="red"><v-icon>remove</v-icon></v-btn>
                    </v-flex>
                  </v-layout>
                  </v-form>
                </div>
                <v-spacer></v-spacer>
                <v-divider></v-divider>
                <v-flex style="float:right">
                  <v-btn large class="green" v-shortkey="['ctrl','enter']" @shortkey="modoPagamento()" @click="modoPagamento()"> <span style="font-size:2em; font-weight:bold; color: #fff;"> FINALIZAR </span></v-btn>
                </v-flex>
              </v-flex>

            <div hidden> 
              <v-flex xs12 sm3 md3>
                <div grid-list-md>
                  <label class="span">Dados loja</label>
                    <v-divider></v-divider>
                    <h3>Produtos</h3>
                    <v-layout>
                    <v-flex class="" xs12 sm7 md7>
                        Produto
                    </v-flex>
                    <v-flex class="" xs12 sm3 md3>
                        Valor
                    </v-flex> <v-flex class="" xs12 sm2 md2>
                        Iva
                    </v-flex>
                    </v-layout>
                    <v-layout v-bind:key="dados.id" v-for="dados in recibo">
                      <v-flex class="" xs12 sm7 md7>
                          {{dados.Produto.produto_nome}}
                      </v-flex>
                      <v-flex class="" xs12 sm3 md3>
                          {{dados.preco_venda}}
                      </v-flex> <v-flex class="" xs12 sm2 md2>
                          {{dados.Produto.Iva.iva_valor}} %
                      </v-flex>                 
                    </v-layout>
                    
                    <v-divider></v-divider>
                    <v-divider></v-divider>
                    <span class="span">Total Liquido: {{ dvenda.tLiquido }} </span>
                    <span class="span">Total Iva: {{ dvenda.tapagariva }} </span>
                    <v-divider></v-divider>
                    <h4>ENTREGADO</h4>
                     <!--<span class="span">Dinheiro: {{ dvenda.valorentregado }} </span>-->
                    <span class="span"></span>
                    <h4>A PAGAR: {{ dvenda.tapagar }} </h4>
                    <h4>TROCO: {{ dvenda.troco }} </h4>
                  </div>
              </v-flex>
            </div>
            </v-layout>
            
        </v-card-text>
      </v-card>
    </v-content>

    <v-bottom-nav
      :value="showNav"
      fixed
      color="green"
    >
      <v-flex xs12 sm8 md8>
      </v-flex>
      <!--<v-flex xs2 sm2 md2>
        <h1 style="font-size:1.7em; font-weight:300; margin-top: 10px;" class="white--text"> {{ $t('message.quantidade') }}:  <span style="font-weight:bold;">{{ totalQty }}</span>  </h1>
      </v-flex>
      <v-flex xs12 sm3 md3>
        <h1 style="font-size:1.5em; font-weight:bold; margin-top: 10px;" class="text-xs-center white--text"> TOTAL IVA:  {{ totalIva}} </h1>
      </v-flex>
      <v-flex xs12 sm3 md3>
        <h1 style="font-size:1.5em; font-weight:bold; margin-top: 10px;" class="text-xs-center white--text"> T. LIQUIDO:  {{ totalPriceLiquido}} </h1>
      </v-flex> 
      ( isNaN(totalPrice ))
      <v-flex style="display:none" class="primary" xs12 sm3 md3>
        <v-btn large dark v-shortkey="['ctrl','enter']" @shortkey="modoPagamento()" @click="modoPagamento()"> <span style="font-size:2em; font-weight:bold; color: #fff;"> FINALIZAR </span></v-btn>
      </v-flex>-->
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
import VendaServices from "@/services/VendaServices"
import listaVendaServices from "@/services/listaVendaServices"
import stockServices from "@/services/stockServices"
import metodoPagamentoServices from '@/services/metodoPagamentoServices'
import AuthenticationService from "@/services/AuthenticationService";
export default {
  data() {
    return {
      usuario: "",
      password: "",
      error: null,
      alert: false,
      noadmin: "Por Favor entre com uma conta de administrador",
      alertadmin: false,
      show1: false,
      userconfig: '',
      dialogPreco: false,
      dialogStock: false,
      dialogPesquisa: false,
      dialog: false,
      showNav: true,
      snack: false,
      snackColor: '',
      snackText: '',
      e1: '',
      PVendaList: [],
      idVenda: [],
      metodoPagamento: [],
      recibo: [],
      listaprodutos: [],
      usuario_nome: '',
      snackbar: false,
      color: 'error',
      mode: '',
      timeout: 6000,
      text: 'Não foi encontrado produto com esse código ou código de barra',
      fornecRules: [v => !!v || "Campo fornecedor é obrigatório"],
      produtos: [{
        input: null,
        total: '',
        totalIva: '',
        totalLiquido: '',
        preco_venda: '',
        VendaId: '',
        ProdutoId: '',
        idProduto: '',
        quantidade: '1',
        search: '',
        stock_id: ''
      }],
      stock: {
        quantidade: '',
        ProdutoId: '',
      },
      pagamento: {
        VendaId: '',
        dinheiro: '',
        vint4: '',
        cheque: '',
        valorentregado: '',
        valorentregadovint4: '',
        valorentregadocheque: ''
      },
      venda: {
        data_venda: '',
        UserId: '',
        status: 'vendido'
      },
      dvenda: {
        tLiquido: '',
        tapagar: '',
        tapagariva: '',
        troco: ''
      },
      valid: true,
      error: null
    };
  },
  methods: {
    addNewProduto (index) {
      if (this.produtos[index].search.length !== 0) {
        this.produtos.push({
          total: '',
          totalIva: '',
          totalLiquido: '',
          preco_venda: '',
          VendaId: '',
          ProdutoId: '',
          idProduto: '',
          quantidade: '1',
          search: '',
          stock_id: ''
        })
      }
    },
    async login() {
      try {
        const response = await AuthenticationService.login({
          usuario: this.usuario,
          password: this.password
        });
        this.dadosUser = response.data.user.nivel
        this.userconfig = this.dadosUser
        if(this.userconfig == 1) {
          this.dialogUser = false;
          this.snackbar = true
        } else if (this.userconfig == 2) {
          this.alertadmin = true;
          this.usuario = '',
          this.password = ''
        }
        console.log(this.userconfig)
        
      } catch (error) {
        this.error = error.response.data.error;
        // this.store.commit('LOADER', false)
        this.alert = true;
      }
    },
    removeNewProduto(index) {
      this.produtos.splice(index, 1)
    },
    async pesquisar(index) {
      try {
        this.search = this.produtos[index].search
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
            this.$refs.searchquantidade[index].focus();
          }
          this.userconfig = ''
        }
      } catch (err) {
        console.log(err);
      }
    },
    async modoPagamento() {
      this.dialog = true
    },
    async searchProd() {
      this.dialogPesquisa = true
    },
    async changePVenda() {
      this.dialogPreco = true
    },
    async createVendaProd() {
      console.log(this.produtos)
      console.log('ID PAGAMENTO: ', this.pagamento)
      listaVendaServices.post(this.produtos)
      stockServices.putvendas(this.produtos)
      VendaServices.putidpagamento(this.pagamento)

      // Create nova venda
      await VendaServices.post(this.venda)
      this.idVenda = (await VendaServices.lastid()).data[0].id;

      if (this.isUserLoggedIn) {
        this.recibo = (await VendaServices.index({
          userId: this.user.id
        })).data[0].ListaVendas;
      }
      console.log('Dados venda: - ', this.recibo)
      console.log('DADO VENDA: ', this.dvenda)

      this.dialog = false
      this.produtos = [{
        total: '',
        totalIva: '',
        totalLiquido: '',
        preco_venda: '',
        VendaId: '',
        ProdutoId: '',
        idProduto: '',
        quantidade: '1',
        search: '',
        stock_id: ''
      }]
      this.$refs.search.focus()
      this.$toast.success({
        title: "Sucesso",
        message: "Venda adicionada com sucesso no sistema"
      })
    }
  },
  async mounted() {
    this.listaprodutos = (await ProdutosService.index()).data;
    this.metodoPagamento = (await metodoPagamentoServices.index()).data;
    console.log('Metodos pagamento', this.metodoPagamento)
    this.idVenda = (await VendaServices.lastid()).data[0].id;
    console.log("ID VENDA: ", this.idVenda)
  },
  computed: {
    ...mapState([
      'isUserLoggedIn',
      'user'
    ]),
    stockIsValid() {
      return this.dvenda.tapagar;
    },
    formIsValid () {
      return (
        this.venda.data_venda &&
        this.venda.UserId
      )
    },
    ListaProdIsValid () {
      return (
        this.produtos.VendaId &&
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
    totalIva() {
      return this.produtos.reduce((total, produto) => {
        return total + Number(produto.totalIva);
      }, 0);
    },
    totalPriceLiquido() {
      return this.produtos.reduce((total, produto) => {
        return total + Number(produto.totalLiquido);
      }, 0);
    }
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


</style>