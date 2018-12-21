<template>
    <panel title="Vendas">
      <div v-if="isOnline">
      <v-content>
      <v-layout justify-end row wrap>
        <v-flex text-lg-left xs12>
        </v-flex>
      </v-layout>

      <v-snackbar
        v-model="snackbarcliente"
        :color="colorcliente"
        :multi-line="mode === 'multi-line'"
        :timeout="timeout"
        :vertical="mode === 'vertical'"
      >
        {{ error }}
        <v-btn
          dark
          flat
          @click="snackbarcliente = false"
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
        <v-card-text>
          <v-dialog v-model="dialogPesquisaCliente" persistent max-width="550px" @keydown.esc="dialogPesquisaCliente = false">
            <v-card align-center justify-center>
              <v-card-title>
                <v-spacer></v-spacer>
                <v-btn color="red" icon outline right small fab dark @click.native="dialogPesquisaCliente = false"><v-icon>close</v-icon></v-btn>
              </v-card-title>
              <v-card-text>
                <v-container grid-list-md>
                  <v-layout wrap>
                    <v-flex xs12>
                      <h4 class="primary--text text-md-center" style="font-size:2em;">DIGITE O NOME DO CLIENTE </h4>
                      <p class="red--text" style="text-align:center; font-size:2em;">
                        <v-autocomplete
                          box
                          :items="listaclientes"
                          color="white"
                          v-model="cliente.search"
                          item-text="cliente_nome"
                          item-value="cliente_nome"
                          label="Nome cliente"
                        ></v-autocomplete>
                        <input name="" v-model="cliente.search" type="hidden"/>   
                      </p>
                    </v-flex>
                    
                  </v-layout>
                </v-container>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn center large color="primary darken-1" @click.native="dialogPesquisaCliente = false; pesquisarCliente()">OK</v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>
          <v-dialog v-model="dialogNewCliente" persistent max-width="550px" @keydown.esc="dialogNewCliente = false">
              <v-card align-center justify-center>
                <v-card-title>
                  <span class="headline"> <v-icon>account_circle</v-icon> Novo Cliente</span>
                  <v-spacer></v-spacer>
                  <v-btn color="red" icon outline right small fab dark @click.native="dialogNewCliente = false"><v-icon>close</v-icon></v-btn>
                </v-card-title>
                <v-card-text>
                  <v-container grid-list-md>
                      <v-flex xs12 sm12 md12>
                        <v-text-field small box v-model="cliente.cliente_nome" label="Nome do cliente" type="text"></v-text-field>
                      </v-flex>
                      <v-flex xs12 sm12 md12>
                        <v-text-field box v-model="cliente.cliente_morada" label="Morada do cliente" type="text"></v-text-field>
                      </v-flex>
                      <v-flex xs12 sm12 md12>
                        <v-text-field box v-model="cliente.cliente_nif" label="NIF" type="number"></v-text-field>
                      </v-flex>
                      <v-flex xs12 sm12 md12>
                        <v-text-field box v-model="cliente.cliente_telefone" label="Telefone" type="number"></v-text-field>
                      </v-flex>
                  </v-container>
                </v-card-text>
                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn center large color="primary darken-1" @click.native="createCliente()">Salvar</v-btn>
                </v-card-actions>
              </v-card>
          </v-dialog>

          <v-layout style="padding:-20px;" row>
          <v-flex xs6 sm3 md3>
            <v-layout style="margin-top:-10px">
              <v-flex sm3 md3>
                <v-text-field outline label="N. Venda" @keyup.enter="searchIdProd()" v-model.number="idSearch" type="text"></v-text-field> 
              </v-flex>
              <v-flex sm7 md7>
                <h2 class="myinputsdata">DATA: <span style="font-weight:100"> {{ Date() | moment("DD-MM-YYYY") }} </span></h2>
              </v-flex>
              <v-flex v-if="idSearch !== ''" sm1 md1>
                <v-btn class="error" fab small @click.stop="reset"> <v-icon>loop</v-icon> </v-btn>
              </v-flex>
              <v-flex sm1 md1>
                <v-btn style="display:none;" dark v-shortkey="['f3']" @shortkey="left = !left" @click.stop="left = !left"> TXT </v-btn>
                <v-btn large left router-link to="listavendas" dark class="primary"> {{ $t('message.listavendas') }} </v-btn>
              </v-flex>
            </v-layout>
            <!--<h2 class="myinputs">NO: <span style="font-weight:100"> {{ idVenda }} </span> </h2>-->
          </v-flex>

          <v-flex xs1 sm2 md2>
           
          </v-flex>

          <v-flex xs6 sm7 md7>
              <v-layout>
                <div>
                  <span v-if="clipesquisa !== ''" hidden> 
                    {{ cliente.cliente_no = clipesquisa.cliente_nome }}
                    {{ cliente.cliente_mor = clipesquisa.cliente_morada }}
                    {{ cliente.cliente_ni = clipesquisa.cliente_nif }} 
                    {{ cliente.cliente_tel = clipesquisa.cliente_telefone }}
                  </span>
                  <span v-else-if="clienteNow !== ''" hidden> 
                    {{ cliente.cliente_no = clienteNow.cliente_nome }}
                    {{ cliente.cliente_mor = clienteNow.cliente_morada }}
                    {{ cliente.cliente_ni = clienteNow.cliente_nif }} 
                    {{ cliente.cliente_tel = clienteNow.cliente_telefone }}
                  </span>
                  <span v-else hidden> 
                    {{ cliente.cliente_no = "VD" }}
                    {{ cliente.cliente_mor = "" }}
                    {{ cliente.cliente_ni = "" }} 
                    {{ cliente.cliente_tel = "" }}
                  </span>
                </div>
                <v-flex xs12 sm6 md6>
                  <h2 class="myinputs">CLIENTE: <span style="font-weight:100"> {{ cliente.cliente_no }} </span>  </h2>
                </v-flex>
                <v-flex xs12 sm5 md5>
                  <h2 class="myinputs"> NIF: <span style="font-weight:100"> {{ cliente.cliente_ni }}</span> </h2>
                </v-flex>
                <v-flex xs1 sm1 md1>
                  <v-btn style="margin-top:-2px" fab small dark @click="searchCliente" class="primary"> <v-icon>search</v-icon> </v-btn>
                </v-flex>
              </v-layout>
              <v-layout row>
                
                <v-flex xs6 sm6 md6>
                  <h2 class="myinputs">MORADA: <span style="font-weight:100"> {{ cliente.cliente_mor }} </span> </h2>
                </v-flex>
                <v-flex xs6 sm5 md5>
                  <h2 class="myinputs">TELEFONE: <span style="font-weight:100"> {{ cliente.cliente_tel }} </span> </h2>
                </v-flex>
                <v-flex xs1 sm1 md1>
                  <v-btn style="margin-top:-2px" fab small dark @click="newCliente" class="primary"> <v-icon>add</v-icon> </v-btn>
                </v-flex>
              </v-layout>
          </v-flex>
          </v-layout>
        </v-card-text>

        <v-divider></v-divider>
        <v-card-text>
             <!-- <v-toolbar-title style="font-weight:bold; font-size:1.5em;" class="primary--text">{{ $t('message.listaproduto') }}</v-toolbar-title>-->
            <v-layout wrap>
                <!-- Dados para criar nova Venda -->
                <span hidden>{{ venda.data_venda = Date() | moment("DD-MM-YYYY") }}</span>
                <span hidden>{{ venda.UserId = user.id }}</span>  
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
                    <v-flex style="text-align:right" class="titleProd" xs12 sm2 md2>
                      <label> {{ $t('message.precodevenda') }} </label>
                    </v-flex>
                    <v-flex style="text-align:right" class="titleProd" xs12 sm1 md1>
                      <label >{{ $t('message.iva') }}</label>
                    </v-flex>
                    <v-flex style="text-align:right" class="titleProd" xs12 sm2 md2>
                      <label>{{ $t('message.total') }}</label>
                    </v-flex>
                    
                  </v-layout>
                </div>
                
               <h4 hidden>TOTAL LIQUIDO: {{ pagamento.tLiquido = totalPriceLiquido }}</h4>
                <h4 hidden>TOTAL A PAGAR: {{ pagamento.tapagar = totalPrice }}</h4>
                <h4 hidden>TOTAL A PAGAR IVA: {{ pagamento.tapagariva = totalIva }}</h4>
                <h4 hidden v-if="clipesquisa !== ''"> ID CLIENTE {{ pagamento.ClienteId = clipesquisa.id }} </h4>
                <h4 hidden v-else-if="clienteNow !== ''">ID CLIENTE {{ pagamento.ClienteId = clienteNow.id }} </h4>
                <h4 hidden v-else>ID CLIENTE {{ pagamento.ClienteId = 1 }} </h4>
                  
                <div v-bind:key="index" v-for="(produto, index) in produtos">
                  <h3 hidden>ID Pesquisa: {{ produto.idSearchNew = idSearch }}</h3>
                  <div v-if="produto.idSearchNew == ''">
                    <h3 hidden>ID VENDA: {{ produto.VendaId = idVenda }}</h3>
                    <h3 hidden>ID VENDA UPDATE: {{ pagamento.VendaId = idVenda }}</h3>
                  </div>
                 
                  <div v-else>
                    <h3 hidden>ID VENDA: {{ produto.VendaId = idSearch }}</h3>
                    <h3 hidden>ID VENDA UPDATE: {{ pagamento.VendaId = idSearch }}</h3>
                  </div>
                  <div hidden v-if="produto.Produto">
                    <h3>ID Pesquisa: {{ produto.idSearch = idSearch }}</h3>
                    <h4>NOME: {{ produto.nome = produto.Produto.produto_nome }}</h4>
                    <h2 v-if="user.nivel == 2 && userconfig != 1">PRECO VENDA: {{ produto.preco_venda = produto.Produto.PVendas[0].pvenda_preco }} </h2>
                    <h2>PRECO VENDA 1: {{ produto.PVendaListOne = produto.Produto.PVendas[0] }} </h2>
                    <h2>SELECT PRECO VENDA: {{ produto.PVendaList = produto.Produto.PVendas }} </h2>
                    <h4>IVA: {{ produto.iva = produto.Produto.Iva.iva_valor }}</h4>
                    <h4>IVA: {{ produto.search = produto.Produto.produto_nome }}</h4>
                    <h4>ID PRODUTO: {{ produto.ProdutoId = produto.Produto.id }}</h4>
                  </div>
                  <h2 hidden> {{ banana = index }} </h2>
                  <div v-if="produtos[index].idProduto && produtos[index].idProduto.Iva">
                    <h2 hidden v-if="user.nivel == 2 && userconfig != 1">PRECO VENDA: {{ produto.preco_venda = produtos[index].idProduto.PVendas[0].pvenda_preco }} </h2>
                    <h2 hidden>PRECO VENDA 1: {{ produto.PVendaListOne = produtos[index].idProduto.PVendas[0] }} </h2>
                    <h2 hidden >SELECT PRECO VENDA: {{ produto.PVendaList = produtos[index].idProduto.PVendas }} </h2>
                    <h4 hidden>NOME: {{ produto.nome = produtos[index].idProduto.produto_nome }}</h4>
                    <h4 hidden>IVA: {{ produto.iva = produtos[index].idProduto.Iva.iva_valor }}</h4>
                    <h4 hidden>ID PRODUTO: {{ produto.ProdutoId = produtos[index].idProduto.id }}</h4>
                  </div>
                  <div v-else>
                    <h2 hidden>Sorry Vady</h2>
                  </div>
                  <v-form ref="form" name="cadastar" autocomplete="off" lazy-validation>
                  <v-layout class="layoutmeu">
                    <v-dialog v-model="dialog" persistent max-width="550px" @keydown.esc="dialog = false">
                      <v-card align-center justify-center>
                        <v-card-title>
                          <v-spacer></v-spacer>
                          <v-btn color="red" small icon outline right fab dark @click.native="dialog = false"><v-icon>close</v-icon></v-btn>
                        </v-card-title>
                        <v-card-text>
                          <v-container grid-list-md>
                              <v-flex xs12>
                                <div v-if="idSearch !== ''">
                                  
                                  <h4 hidden> {{ tt = totalPrice - (pagamento.valor_venda_dinheiro - pagamento.valor_troco) }}</h4>
                                  <v-layout wrap v-if=" tt >= 0">
                                    <v-flex md12 sm12 xs12>
                                      <h4 class="primary--text text-md-center" style="font-size:1.6em;"> A PAGAR </h4>
                                    </v-flex>
                                    <v-flex right md6 sm6 xs6>
                                      <vue-numeric readonly class="green--text" style="text-align:right; font-weight:bold; font-size:2em; width:100%" :value="tt"></vue-numeric>
                                    </v-flex>
                                    <v-flex md6 sm6 xs6>
                                      <span class="green--text" style="text-align:left; font-weight:bold; font-size:2em; width:100%"> CVE</span>
                                    </v-flex>
                                  </v-layout>
                                  <v-layout wrap v-else>
                                    <v-flex md12 sm12 xs12>
                                      <h4 class="primary--text text-md-center" style="font-size:1.6em;"> A DEVOLVER </h4>
                                    </v-flex>
                                    <v-flex right md6 sm6 xs6>
                                      <vue-numeric readonly class="red--text" style="text-align:right; font-weight:bold; font-size:2em; width:100%" :value="tt"></vue-numeric>
                                    </v-flex>
                                    <v-flex md6 sm6 xs6>
                                      <span class="red--text" style="text-align:left; font-weight:bold; font-size:2em; width:100%"> CVE</span>
                                    </v-flex>
                                  </v-layout>
                                </div>
                                <div>
                                  <div v-if="idSearch === ''">
                                    <h4 class="primary--text text-md-center" style="font-size:1.6em;"> {{ $t('message.totalaPagar') }} </h4>
                                  <v-layout >
                                    <v-flex right xs6>
                                      <vue-numeric readonly class="green--text" style="text-align:right; font-weight:bold; font-size:2em; width:100%" :value="pagamento.tapagar"></vue-numeric>
                                    </v-flex>
                                    <v-flex xs6>
                                      <span class="green--text" style="text-align:left; font-weight:bold; font-size:2em; width:100%"> CVE</span>
                                    </v-flex>
                                  </v-layout>
                                  </div>
                                  <input name="" v-model="pagamento.tapagar" type="hidden"/>
                                  <input name="" v-model="pagamento.tapagariva" type="hidden"/>
                                  <input name="" v-model="pagamento.tLiquido" type="hidden"/> 
                                </div>
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
                                  <span hidden> {{ pagamento.dinheiro = 'Dinheiro' }} </span>
                                  <span hidden> {{ pagamento.vint4 = 'Vint4' }} </span>
                                  <span hidden> {{ pagamento.cheque = 'Cheque' }} </span>
                                  <v-layout style="margin-bottom: -35px;">
                                    <v-flex xs7 sm7 md7>
                                      <v-text-field box readonly v-model.number="pagamento.dinheiro" type="text"></v-text-field>
                                    </v-flex>
                                      <v-flex xs5 sm5 md5>
                                        <!-- span >{{ pagamento.valorentregado }}</span>
                                        <span hidden >{{ pagamento.valorentregadovint4 = '' }}</span>
                                        <span hidden >{{ pagamento.valorentregadocheque = '' }}</span -->
                                        <div v-if="idSearch !== ''">
                                          <div v-if=" tt >= 0">
                                            <v-text-field box v-model.number="valorentregadoU" v-if="dialog" autofocus type="number"></v-text-field>
                                            <h2 hidden v-if="valorentregadoU !== null"> TROC: {{ pagamento.valorentregado = valorentregadoU + pagamento.valor_venda_dinheiro }} </h2>
                                            <h2 hidden v-else-if="valorentregadoU === null"> TROC: {{ pagamento.valorentregado = pagamento.valor_venda_dinheiro }} </h2>
                                            
                                          </div>
                                          <div v-else>
                                            <v-text-field box readonly type="number"></v-text-field>
                                            {{ pagamento.troco = pagamento.valor_venda_dinheiro - totalPrice }}
                                            <input name="produto_id" v-model="pagamento.troco" type="text"/>
                                            <h2 hidden> {{ pagamento.valorentregado = pagamento.valor_venda_dinheiro + (tt) }} </h2>
                                            
                                          </div>
                                        </div>
                                        <div v-else>
                                          <v-text-field box v-model.number="pagamento.valorentregado" v-on:input="update" v-if="dialog" autofocus type="number"></v-text-field>
                                        </div>
                                      </v-flex>
                                  </v-layout>
                                  <v-layout style="margin-bottom: -35px;">
                                    <v-flex xs7 sm7 md7>
                                      <v-text-field readonly box :value="pagamento.vint4" type="text"></v-text-field>
                                    </v-flex>
                                    <v-flex xs5 sm5 md5>
                                      <div v-if="idSearch !== ''">
                                        <div v-if=" tt >= 0">
                                          <v-text-field box v-model.number="valorentregadovint4U" type="number"></v-text-field>
                                          <!-- h2> {{ pagamento.valorentregadovint4 = pagamento.valorentregadovint4U + pagamento.valor_venda_vint4 }} </h2-->
                                          <h2 hidden v-if="valorentregadovint4U !== null"> TROC: {{ pagamento.valorentregadovint4 = valorentregadovint4U + pagamento.valor_venda_vint4 }} </h2>
                                          <h2 hidden v-else-if="valorentregadovint4U === null"> TROC: {{ pagamento.valorentregadovint4 = pagamento.valor_venda_vint4 }} </h2>
                                            
                                        </div>
                                        <div v-else>
                                          <v-text-field box v-model.number="pagamento.valorentregadovint4" readonly type="number"></v-text-field>
                                        </div>
                                      </div>
                                      <div v-else>
                                        <v-text-field box v-model.number="pagamento.valorentregadovint4" type="number"></v-text-field>
                                      </div>
                                    </v-flex>
                                  </v-layout>
                                  <v-layout style="margin-bottom: -35px;">
                                    <v-flex xs7 sm7 md7>
                                      <v-text-field box :value="pagamento.cheque" type="text"></v-text-field>
                                    </v-flex>
                                    <v-flex xs5 sm5 md5>
                                      <div v-if="idSearch !== ''">
                                        <div v-if=" tt >= 0">
                                          <v-text-field box v-model.number="valorentregadochequeU" type="number"></v-text-field>
                                          <h2 hidden v-if="valorentregadochequeU !== null"> TROC: {{ pagamento.valorentregadocheque = valorentregadochequeU + pagamento.valor_venda_cheque }} </h2>
                                          <h2 hidden v-else-if="valorentregadochequeU === null"> TROC: {{ pagamento.valorentregadocheque = pagamento.valor_venda_cheque }} </h2>
                                        </div>
                                        <div v-else>
                                          <v-text-field readonly box v-model.number="pagamento.valorentregadocheque" type="number"></v-text-field>
                                        </div>
                                      </div>
                                      <div v-else>
                                        <v-text-field box v-model.number="pagamento.valorentregadocheque" type="number"></v-text-field>
                                      </div>
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
                                <v-text-field box v-model="pagamento.valorentregado" label="Valor entregado" ></v-text-field>
                              </v-flex>-->
                              <h4> dinheiro {{ pagamento.valorentregado }} </h4>
                              <h4> vint4 {{ pagamento.valorentregadovint4 }} </h4>
                              <h4> cheque {{ pagamento.valorentregadocheque }} </h4>
                              <span v-if="idSearch !== ''">
                                  <h4  v-if="pagamento.valorentregado != null && pagamento.valorentregadovint4 == null && pagamento.valorentregadocheque == null ">TROCO: {{ trocoU = valorentregadoU - tt }}</h4>
                                  <h4  v-if="pagamento.valorentregadovint4 != null && pagamento.valorentregado == null && pagamento.valorentregadocheque == null ">TROOCO: {{ trocoU = valorentregadovint4U - tt }}</h4>
                                  <h4  v-if="pagamento.valorentregadocheque != null && pagamento.valorentregado == null && pagamento.valorentregadovint4 == null ">TROOCOO: {{ trocoU = valorentregadochequeU - tt }}</h4>
                                  <h4  v-else-if="pagamento.valorentregado != null && pagamento.valorentregadovint4 != null">TROOCOOO: {{ trocoU = valorentregadoU + valorentregadovint4U + valorentregadochequeU - tt }}</h4>
                                  <h4  v-else-if="pagamento.valorentregado != null && pagamento.valorentregadocheque != null">TROOCOOOO: {{ trocoU = valorentregadoU + valorentregadochequeU - tt }}</h4>
                                  <h4  v-else-if="pagamento.valorentregado != null && pagamento.valorentregadovint4 != null && pagamento.valorentregadocheque != null ">TROOCOOOOO: {{ trocoU = valorentregadoU + valorentregadovint4U + valorentregadochequeU - tt }}</h4>
                              </span>
                              <span v-else>
                                <h4 hidden v-if="pagamento.valorentregado != '' && pagamento.valorentregadovint4 == '' && pagamento.valorentregadocheque == '' ">TROCO: {{ pagamento.troco = pagamento.valorentregado - totalPrice }}</h4>
                                <h4 hidden v-if="pagamento.valorentregadovint4 != '' && pagamento.valorentregado == '' && pagamento.valorentregadocheque == '' ">TROOCO: {{ pagamento.troco = pagamento.valorentregadovint4 - totalPrice }}</h4>
                                <h4 hidden v-if="pagamento.valorentregadocheque != '' && pagamento.valorentregado == '' && pagamento.valorentregadovint4 == '' ">TROOCOO: {{ pagamento.troco = pagamento.valorentregadocheque - totalPrice }}</h4>
                                <h4 hidden v-else-if="pagamento.valorentregado != '' && pagamento.valorentregadovint4 != ''">TROOCOOO: {{ pagamento.troco = pagamento.valorentregado + pagamento.valorentregadovint4 - totalPrice }}</h4>
                                <h4 hidden v-else-if="pagamento.valorentregado != '' && pagamento.valorentregadocheque != ''">TROOCOOOO: {{ pagamento.troco = pagamento.valorentregado + pagamento.valorentregadocheque - totalPrice }}</h4>
                                <h4 hidden v-else-if="pagamento.valorentregado != '' && pagamento.valorentregadovint4 != '' && pagamento.valorentregadocheque != '' ">TROOCOOOOO: {{ pagamento.troco = pagamento.valorentregado + pagamento.valorentregadovint4 + pagamento.valorentregadocheque - totalPrice }}</h4>
                              </span>
                              <v-flex xs12>
                                <h4 class="primary--text text-md-center" style="font-size:2em;"> {{ $t('message.troco') }} </h4>
                                <v-layout wrap>
                                  <v-flex right xs6>
                                    <span v-if="idSearch !== ''">
                                      <h2 v-if="pagamento.valorentregadocheque == 0 && pagamento.valorentregado > 0 && pagamento.valorentregadovint4 == 0 ">DINHEIRO {{ pagamento.troco = pagamento.valorentregado - totalPrice  }} </h2>
                                      <h2 v-if="pagamento.valorentregadocheque > 0 && pagamento.valorentregado != null && pagamento.valorentregadovint4 == 0 ">CHEQUE {{ pagamento.troco = pagamento.valorentregado + pagamento.valorentregadocheque - totalPrice  }} </h2>
                                      <h2 v-if="pagamento.valorentregadovint4 > 0 && pagamento.valorentregado != null && pagamento.valorentregadocheque == 0 ">VINT4 {{ pagamento.troco = pagamento.valorentregado + pagamento.valorentregadovint4 - totalPrice  }} </h2>
                                      
                                      <p v-if="pagamento.valorentregado || pagamento.valorentregadovint4 || pagamento.valorentregadocheque" >
                                        <vue-numeric v-if="trocoU < 0" readonly class="red--text" style="text-align:right; font-size:2em; font-weight:700; width:100%" :value="trocoU"></vue-numeric>
                                        <vue-numeric v-else readonly class="green--text" style="text-align:right; font-size:2em; font-weight:700; width:100%" :value="trocoU"></vue-numeric>
                                        INPUT <input name="produto_id" v-model="pagamento.troco" type="text"/>   
                                      </p>
                                    </span>
                                    <span v-else>
                                    <p v-if="pagamento.valorentregado || pagamento.valorentregadovint4 || pagamento.valorentregadocheque" >
                                      <vue-numeric v-if="pagamento.troco < 0" readonly class="red--text" style="text-align:right; font-size:2em; font-weight:700; width:100%" :value="pagamento.troco"></vue-numeric>
                                      <vue-numeric v-else readonly class="green--text" style="text-align:right; font-size:2em; font-weight:700; width:100%" :value="pagamento.troco"></vue-numeric>
                                    <input name="produto_id" v-model="pagamento.troco" type="hidden"/>   
                                    </p>
                                    </span>
                                    <!--p v-else class="red--text" style="text-align:center; font-size:1em;"> {{ $t('message.valorEntregado') }} </p-->
                                  </v-flex>
                                  <v-flex xs6>
                                    <p v-if="pagamento.valorentregado || pagamento.valorentregadovint4 || pagamento.valorentregadocheque" >
                                      <span v-if="pagamento.troco < 0" class="red--text" style="text-align:left; font-weight:bold; font-size:2em; width:100%"> CVE</span>
                                      <span v-else class="green--text" style="text-align:left; font-weight:bold; font-size:2em; width:100%"> CVE</span>
                                    </p>
                                  </v-flex>
                                </v-layout >
                              </v-flex>
                              
                          </v-container>
                        </v-card-text>
                        <v-card-actions>
                          <v-spacer></v-spacer>
                          <div v-if="idSearch == '' && pagamento.troco >= 0">
                            <v-btn large right color="primary darken-1" :disabled="!stockIsValid" @click.native="createVendaProdnoPrinter(index)"> {{ $t('message.finalizacompra') }} </v-btn>
                            <v-btn large color="success darken-1" :disabled="!stockIsValid" @click="createVendaProd(index)"> {{ $t('message.fcompraimprimir') }} </v-btn>
                          </div>
                          <div v-if="idSearch !== '' && pagamento.troco >= 0">
                            <v-btn large right color="primary darken-1" :disabled="!stockIsValid" @click.native="updateVendaNoPrinter(index)"> Atualizar Venda </v-btn>
                            <v-btn large color="success darken-1" :disabled="!stockIsValid" @click.native="updateVenda(index)"> Atualizar & Imprimir Venda </v-btn>
                          </div>
                        </v-card-actions>
                      </v-card>
                    </v-dialog>


                    <v-dialog v-model="dialogPesquisaCategoria" persistent max-width="1050px" @keydown.esc="dialogPesquisaCategoria = false">
                      <v-card align-center justify-center>
                        <v-card-title>
                          <v-spacer></v-spacer>
                          <v-btn color="red" icon outline right small fab dark @click.native="dialogPesquisaCategoria = false"><v-icon>close</v-icon></v-btn>
                        </v-card-title>
                        <h4 class="primary--text text-md-center" style="font-size:2em;">SELECIONE A CATEGORIA DO PRODUTO </h4>
                        <v-card-text>
                        <v-container grid-list-sm fluid>
                          <v-layout row wrap>
                            <v-flex
                              v-for="(categoria, index) in categorias"
                              :key="index"
                              xs2
                              d-flex
                              @click="prodByCat(myCatId = categoria.id)"
                            >
                              <v-card style="padding:15px" flat tile class="d-flex">
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
                      </v-card>
                    </v-dialog>

                    <v-dialog v-model="dialogProdCategorias" persistent max-width="550px" @keydown.esc="dialogProdCategorias = false">
                      <v-card align-center justify-center>
                        <v-card-title>
                          <v-spacer></v-spacer>
                          <v-btn color="red" icon outline right small fab dark @click.native="dialogProdCategorias = false"><v-icon>close</v-icon></v-btn>
                        </v-card-title>
                        <v-card-text>
                          <v-container grid-list-sm fluid>
                          <v-layout row wrap>
                            <v-flex
                              v-for="(prod, idx) in listaprodutosCat"
                              :key="idx"
                              xs2
                              d-flex
                            >
                              <span hidden> {{ nome = prod.produto_nome }} </span> 
                              <v-btn center large color="primary darken-1" @click.native="dialogProdCategorias = false; pesquisarbyCat(index, nome)"> {{ prod.produto_nome }} </v-btn>
                            </v-flex>
                          </v-layout>
                          </v-container>
                        </v-card-text>
                      </v-card>
                    </v-dialog>
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
                      <v-btn small fab outline color="red" dark @click="backToCat"> <v-icon>keyboard_backspace</v-icon> </v-btn>
                      
                      <h4 class="primary--text text-md-center" style="font-size:2em;">SELECIONE O PRODUTO </h4>
                      <v-divider></v-divider>
                        <v-card-text>
                        <v-container grid-list-sm fluid>
                          <v-layout row wrap>
                            <h2 class="text-md-center red--text" v-if="listaprodutosCat.length === 0">Nenhum produro encontrado nessa categoria!</h2>
                            <v-flex
                              v-for="(prod, idx) in listaprodutosCat"
                              :key="idx"
                              xs4
                              d-flex
                            >
                              <span hidden> {{ nome = prod.produto_nome }} </span>
                              
                              <v-card style="padding:12px" flat tile class="d-flex">
                                <v-img
                                  :src="'http://minisys.innovatmedialab.com/server/src/uploads/' + prod.filename"
                                  :lazy-src="'http://minisysvenda.innovatmedialab.com/server/src/uploads/' + prod.filename"
                                  aspect-ratio="1"
                                  class="grey lighten-2"
                                  @click.native="dialogProdCategorias = false; pesquisarbyCat(index, nome)"
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
                        <v-btn style="display:none;" v-shortkey="['ctrl','p']" @shortkey="searchProd" @click.stop="searchProd"></v-btn>
                        <v-btn style="display:none;" v-shortkey="['f2']" @shortkey="searchProdCat" @click.stop="searchProdCat"></v-btn>
                        <v-flex xs12 sm12 md12>
                          <v-text-field box v-model.trim="produto.search" ref="search" autofocus v-on:keyup.enter="pesquisar(index)" type="text"></v-text-field>
                          <input v-model="produto.ProdutoId" type="hidden"/>
                        </v-flex>
                      </v-layout>
                    </v-flex>

                    <v-flex xs12 sm3 md3>
                      <v-text-field box readonly :value="produto.nome" type="text"></v-text-field>
                    </v-flex>
                    <v-flex xs12 sm2 md2>
                      <v-text-field box v-model.number="produto.quantidade" v-on:input="changeQuantidade(index)" @keyup.enter="addNewProduto(index)" ref="searchquantidade" label="Quantidade" type="number"></v-text-field>
                      <input v-model.number="produto.quantidade" v-on:input="changeQuantidade(index)" @keyup.enter="addNewProduto(index)" type="hidden"/>
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
                        reverse
                        v-if="user.nivel == 1"
                        box color="blue"
                        v-model="produto.preco_venda"
                        :items="produto.PVendaList"
                        label="Preço de venda"
                        item-text="pvenda_preco"
                        item-value="pvenda_preco"
                      ></v-select>
              
                      <v-select
                        reverse
                        v-if="user.nivel == 2 && userconfig == 1"
                        box color="blue"
                        v-model="produto.preco_venda"
                        :items="produto.PVendaList"
                        label="Preço de venda"
                        item-text="pvenda_preco"
                        item-value="pvenda_preco"
                      ></v-select>

                      <v-text-field reverse box readonly v-if="userconfig != 1 && user.nivel == 2" v-model.number="produto.preco_venda" @click="changePVenda" name="" type="number"></v-text-field>
                      <span v-if="produto.preco_venda">
                      <h4 hidden>TOTAL LIQUIDO: {{ produto.totalLiquido = produto.quantidade * produto.preco_venda }}</h4>
                      <h4 hidden>TOTAL: {{ produto.total = produto.quantidade * produto.preco_venda }}</h4>
                      <span hidden> TOTAL IVA:  {{ produto.totalIva = produto.preco_venda * produto.iva / 100 }}</span>
                      </span>

                    </v-flex>
                    <v-flex xs12 sm1 md1>
                      <v-text-field reverse box readonly :value="produto.iva" name="" type="number"></v-text-field>
                    </v-flex>
                    <v-flex xs12 sm2 md2>
                      <content>
                      <!--<v-text-field box readonly :value="produto.total" name="" type="number"></v-text-field>-->
                      <vue-numeric readonly style="border-bottom:1px solid #999; background:#f5f5f5; width:80%; padding:15px 3px 12px 4px; margin-right:-3px; font-size:1.4em; color: green; text-align:right" :value="produto.total"> </vue-numeric>
                      <v-btn style="margin-left:-4px; width:10%;" small icon left dark @click="removeNewProdutoUpdate(index)" class="red"><v-icon>remove</v-icon></v-btn>
                      </content>
                    </v-flex>
                    <v-spacer></v-spacer>
                    
                  </v-layout>
                  </v-form>
                </div>
                <v-spacer></v-spacer>
                <!--<v-divider></v-divider>
                <v-flex style="float:left">
                  <v-btn style="margin-top:20px;" dark small fab class="primary" v-shortkey="['ctrl','b']" @shortkey="addBolsa" @click.native="addBolsa"><v-icon>shopping_basket</v-icon></v-btn>
                </v-flex>
                <v-flex style="float:right">
                  <v-btn style="margin-top:20px;" dark small fab class="primary" v-shortkey="['ctrl','n']" @shortkey="addNewProduto" @click="addNewProduto"><v-icon>add</v-icon></v-btn>
                </v-flex>-->
              </v-flex>
              <v-divider></v-divider>
              <!--<v-flex>
                <div style="float:right">
                  <v-btn style="margin-top:20px;" large class="green" v-shortkey="['ctrl','enter']" @shortkey="modoPagamento()" @click="modoPagamento()"> <span style="font-size:2em; font-weight:bold; color: #fff;"> FINALIZAR </span></v-btn>
                </div>
              </v-flex>-->
            </v-layout>
            
        </v-card-text>
      </v-card>
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
            v-shortkey="['ctrl','n']" @shortkey="addNewProduto" @click="addNewProduto(banana)"
          >
            <span style="font-size:1.5em;">NOVA</span>
            <v-icon>add</v-icon>
          </v-btn>
          <v-btn
            color="white"
            flat
            v-shortkey="['ctrl','b']" @shortkey="pesquisarBolsa(banana)" @click.native="pesquisarBolsa(banana)"
          >
            <span style="font-size:1.5em; float_left">BOLSA</span>
            <v-icon>shopping_basket</v-icon>
          </v-btn>
        </v-flex>
        <v-flex class="text-xs-right" xs12 sm2 md2>
          <v-btn
            color="white"
            flat
            v-shortkey="['ctrl','enter']" @shortkey="modoPagamento()" @click="modoPagamento()"
          >
            <span style="font-size:1.5em;">FINALIZAR VENDA</span>
            <v-icon>send</v-icon>
          </v-btn>
        </v-flex>
      </v-layout>
      <v-divider dark></v-divider>
      <v-layout style="">
        <v-flex xs12 sm9 md9>
        </v-flex>
        <v-flex class="text-xs-right" xs12 sm3 md3>
          <span style="font-size:2.4em; font-weight:300; margin-right:8px" class="text-xs-right white--text"> {{ $t('message.totall') }}: </span>
          <vue-numeric v-if="totalPrice === ''" read-only style="font-size:2.4em; font-weight:700; color: #fff;" class="text-xs-center white--text" :value="0"></vue-numeric>
          <vue-numeric v-if="totalPrice >= 100000" read-only style="font-size:1.6em; font-weight:700; color: #fff;" class="text-xs-center white--text" :value="totalPrice"></vue-numeric>
          <vue-numeric v-else read-only style="font-size:2.5em; font-weight:700; color: #fff;" class="text-xs-left white--text" :value="totalPrice"></vue-numeric>
          <span v-if="totalPrice >= 100000" style="font-size:1.6em; font-weight:700; color: #fff;" class="text-xs-right white--text" > CVE</span>
          <span v-else style="font-size:2.4em; font-weight:700; color: #fff;" class="text-xs-right white--text" > CVE</span>
        </v-flex>
      </v-layout>
    </v-container>
    </v-bottom-nav>
    </div>
    <div v-if="isOffline">
      <v-content>
      <v-layout justify-end row wrap>
        <v-flex text-lg-left xs12>
          <h2 class="red--text"> <span style="text-align:center">Sem conexão com a internet!</span> <br> Verifique sua conexão com a internet</h2>
        </v-flex>
      </v-layout>
      </v-content>
    </div>
    </panel>

</template>

<script>
import { mapState } from 'vuex'
import FornecedoresService from "@/services/FornecedorService"
import CategoriasService from "@/services/CategoriasService"
import ProdutosService from "@/services/ProdutosService"
import filterServices from "@/services/filterServices"
import VendaServices from "@/services/VendaServices"
import listaVendaServices from "@/services/listaVendaServices"
import stockServices from "@/services/stockServices"
import ClienteServices from "@/services/ClienteService"
import metodoPagamentoServices from '@/services/metodoPagamentoServices'
import AuthenticationService from "@/services/AuthenticationService"
import moment from 'moment'

export default {
  data() {
    return {
      valorentregadoU: null,
      valorentregadovint4U: null,
      valorentregadochequeU: null,
      drawer: false,
      left: false,
      drawer1: false,
      clipped: false,
      vendasId: "",
      blockRemoval: true,
      idSearch: "",
      usuario: "",
      password: "",
      clienteNow: '',
      error: null,
      alert: false,
      noadmin: "Por Favor entre com uma conta de administrador",
      alertadmin: false,
      show1: false,
      userconfig: '',
      dialogPreco: false,
      dialogStock: false,
      dialogPesquisa: false,
      dialogNewCliente: false,
      dialogPesquisaCliente: false,
      dialogPesquisaCategoria: false,
      dialogProdCategorias: false,
      dialog: false,
      showNav: true,
      snack: false,
      snackColor: '',
      snackText: '',
      e1: '',
      PVendaList: [],
      categorias: [],
      idVenda: [],
      clipesquisa: '',
      metodoPagamento: [],
      recibo: [],
      listaprodutos: [],
      listaprodutosCat: [],
      listaclientes: [],
      usuario_nome: '',
      snackbar: false,
      color: 'error',
      mode: '',
      timeout: 6000,
      text: 'Não foi encontrado produto com esse código ou código de barra',

      snackbarnorow: false,
      colornorow: 'error',
      textnorow: 'Para criar nova linha tem que preencher a linha anterior',

      snackbarcliente: false, 
      colorcliente: 'error',

      fornecRules: [v => !!v || "Campo fornecedor é obrigatório"],
      produtos: [{
        input: null,
        idSearch: '',
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
      cliente: {
        search: '',
        cliente_nome: '',
        cliente_nif: '',
        cliente_morada: '',
        cliente_telefone: '' 
      },
      pagamento: {
        ClienteId: '',
        VendaId: '',
        dinheiro: '',
        vint4: '',
        cheque: '',
        valorentregado: '',
        valorentregadovint4: '',
        valorentregadocheque: '',
        tLiquido: '',
        tapagar: '',
        tapagariva: '',
        troco: ''
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
  watch: {
    produtos () {
      this.blockRemoval = this.produtos.length <= 1
    }
  },
  methods: {
    async reset () {
      this.idSearch = '',
      this.produtos = [{
        input: null,
        idSearch: '',
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
      this.pagamento = {
        ClienteId: '',
        VendaId: '',
        dinheiro: '',
        vint4: '',
        cheque: '',
        valorentregado: '',
        valorentregadovint4: '',
        valorentregadocheque: '',
        tLiquido: '',
        tapagar: '',
        tapagariva: '',
        troco: ''
      }
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
    update: function(event) {
      this.pagamento.valorentregado = this.pagamento.valorentregado 
    },
    changeQuantidade (index) {
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
    addNewProduto (banana) {
      if (this.produtos[banana].search.length !== 0 && this.produtos[banana].ProdutoId.length !== 0) {
        this.produtos.push({
          idSearchNew: '',
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
      } else {
         this.snackbarnorow = true
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
      if (!this.blockRemoval) this.produtos.splice(index, 1)
    },
    removeNewProdutoUpdate(index) {
      // console.log('MEU: ', this.produtos[index])
      if(this.produtos[index].idSearch == null || this.produtos[index].idSearch == '' ){
         if (!this.blockRemoval) this.produtos.splice(index, 1)
      }else {
        stockServices.putstockvenda(this.produtos[index])
        listaVendaServices.delete(this.produtos[index])
        this.$toast.error({
          title: "Aviso",
          message: "Produto eliminado da lista de venda"
        })
        this.produtos.splice(index, 1)
      }
    },
    async searchIdProd() {
      if (this.idSearch !== '') {
        this.res = (await VendaServices.byIdVenda({
          userId: this.user.id,
          idSearch: this.idSearch
        })).data
        if(this.res.length !== 0 ) {
          this.pagamento = this.res[0]
          this.produtos = this.res[0].ListaVendas
          console.log("Produto restornados »»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»", this.pagamento)
        }else{
          this.$toast.error({
            title: "Aviso",
            message: "Venda com esse id de registro nao existe no sistema!"
          })
        }
      }
    },
    async updateVendaNoPrinter(index) {
      console.log("TESTE:- ", this.pagamento)
      listaVendaServices.postnewprod(this.produtos)
      VendaServices.putidpagamento(this.pagamento)
      
      this.idSearch = ''
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
      }],
      this.pagamento = {
        ClienteId: '',
        VendaId: '',
        dinheiro: '',
        vint4: '',
        cheque: '',
        valorentregado: '',
        valorentregadovint4: '',
        valorentregadocheque: '',
        tLiquido: '',
        tapagar: '',
        tapagariva: '',
        troco: ''
      },
      this.$refs.search[index].focus()
      this.$toast.success({
        title: "Sucesso",
        message: "Venda atualizada com sucesso no sistema!"
      })
    },
    async updateVenda(index) {
      console.log("TESTE:- ", this.pagamento)
      listaVendaServices.postnewprod(this.produtos)
      VendaServices.putidpagamento(this.pagamento)

      this.PrintVenda()
      
      this.idSearch = ''
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
      }],
      this.pagamento = {
        ClienteId: '',
        VendaId: '',
        dinheiro: '',
        vint4: '',
        cheque: '',
        valorentregado: '',
        valorentregadovint4: '',
        valorentregadocheque: '',
        tLiquido: '',
        tapagar: '',
        tapagariva: '',
        troco: ''
      },
      this.$refs.search[index].focus()
      this.$toast.success({
        title: "Sucesso",
        message: "Venda atualizada com sucesso no sistema!"
      })
    },
    async pesquisarBolsa(banana) {
      try {
        this.search = 'Bolsa'
        this.produtos[banana].search = 'Bolsa'
        if (this.search !== '') {
          this.produtos[banana].idProduto = (await filterServices.bynamevenda(this.search)).data
          console.log(this.produtos[banana].idProduto)
          Object.keys(this.produtos[banana].idProduto).forEach(key => {
            this.produtos[banana].idProduto = this.produtos[banana].idProduto[key];
            if (this.produtos[banana].idProduto.Stock.quantidade === 0) {
              this.dialogStock = true
            }
          });
          if (this.produtos[banana].idProduto.length === 0) {
            this.snackbar = true
            this.$refs.search[banana].reset();
            this.$refs.search[banana].focus();
          } else {
            this.$refs.searchquantidade[banana].focus();
          }
          this.userconfig = ''
        }
      } catch (err) {
        console.log(err);
      }
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
            this.$refs.searchquantidade[index].focus();
          }
          this.userconfig = ''
        }
      } catch (err) {
        console.log(err);
      }
    },
    async pesquisar(index, nome) {
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
    async pesquisarCliente() {
      try {
        this.search = this.cliente.search
        this.clienteNow = ''
        if (this.search !== '') {
          this.clipesquisa = (await ClienteServices.byname(this.search)).data[0]
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
    async searchProdCat() {
      this.dialogPesquisaCategoria = true
    },
    async searchCliente() {
      this.dialogPesquisaCliente = true
    },
    async changePVenda() {
      this.dialogPreco = true
    },
    async newCliente() {
      this.cliente.cliente_nome = "",
      this.cliente.cliente_morada = "",
      this.cliente.cliente_nif = "",
      this.cliente.cliente_telefone = ""
      this.dialogNewCliente = true
    },
    async createCliente() {
      this.dialogNewCliente = false
      this.clipesquisa = ''
      // Create nova venda
      try {
        await ClienteServices.post(this.cliente)
        this.$toast.success({
          title: "Sucesso",
          message: "Cliente adicionada com sucesso no sistema!"
        })
        this.clienteNow = (await ClienteServices.lastid()).data[0]
      } catch (error) {
        this.error = error.response.data.error;
        this.snackbarcliente = true
      }
    },
    async PrintVenda(index) {
        /*this.recibo = (await VendaServices.index({
          userId: this.user.id
        })).data[0].ListaVendas;*/
        this.cliente = (await VendaServices.index({ userId: this.user.id })).data[0].Cliente
        this.valorVenda = (await VendaServices.index({
          userId: this.user.id
        })).data[0];
        console.log("Meus Valores: ----- ", this.valorVenda)

        /* if(this.valorVenda.valor_venda_dinheiro != '' && this.valorVenda.valor_venda_cheque == '' && this.valorVenda.valor_venda_vint4){
          const pagamento = this.valorVenda.valor_venda_dinheiro
        }else if(this.valorVenda.valor_venda_cheque != '' && this.valorVenda.valor_venda_dinheiro == '' && this.valorVenda.valor_venda_vint4){
          const pagamento = this.valorVenda.valor_venda_cheque
        }else if(this.valorVenda.valor_venda_vint4 != '' && this.valorVenda.valor_venda_dinheiro == '' && this.valorVenda.valor_venda_cheque == ''){
          const pagamento = this.valorVenda.valor_venda_vint4
        }else if(this.valorVenda.valor_venda_vint4 != '' && this.valorVenda.valor_venda_dinheiro != ''){
          const pagamento = this.valorVenda.valor_venda_vint4 + ' - ' + this.valorVenda.valor_venda_dinheiro
        }else if(this.valorVenda.valor_venda_cheque != '' && this.valorVenda.valor_venda_dinheiro != ''){
          const pagamento = this.valorVenda.valor_venda_cheque + ' - ' + this.valorVenda.valor_venda_dinheiro
        }else if(this.valorVenda.valor_venda_vint4 != '' && this.valorVenda.valor_venda_cheque != '' ){
          const pagamento = this.valorVenda.valor_venda_vint4 + ' - ' + this.valorVenda.valor_venda_cheque
        }else if(this.valorVenda.valor_venda_dinheiro != '' && this.valorVenda.valor_venda_vint4 != '' && this.valorVenda.valor_venda_cheque != ''){
          const pagamento = this.valorVenda.valor_venda_dinheiro + ' - ' + this.valorVenda.valor_venda_vint4 + ' - ' + this.valorVenda.valor_venda_cheque
        } */
        const nomeCliente = this.cliente.cliente_nome
        const moradaCliente = this.cliente.cliente_morada
        const nifCliente = this.cliente.cliente_nif
        const telefoneCliente = this.cliente.cliente_telefone

        const recibo = this.valorVenda.ListaVendas
        console.log("MEU PROD -----", recibo)

        const pagamento = this.valorVenda.valor_total - this.valorVenda.valor_iva
        const tapagar = this.valorVenda.valor_total
        const tapagariva = this.valorVenda.valor_iva
        const troco = this.valorVenda.valor_troco
        const horaVenda = moment().format('LT')
        const dataVenda = moment().format('l')
        const vendedor = this.user.usuario
        const idvenda = this.pagamento.VendaId - 1
        let dinheiro = this.pagamento.valorentregado
        let vint4 = this.pagamento.valorentregadovint4
        let cheque = this.pagamento.valorentregadocheque
        let prod = ''
        let pVenda = ''
        // let entregado = ''

        //const dataVenda = this.venda.data_venda
        if (dinheiro !== '') {
          dinheiro = dinheiro + ' CVE'
        } else if (vint4 !== '') {
          vint4 = vint4 + ' CVE'
        }else if (cheque !== '') {
          cheque = cheque + ' CVE'
        }else if (vint4 !== '' && dinheiro !== '') {
          dinheiro = dinheiro + ' CVE'
          vint4 = vint4 + ' CVE'
        }else if (cheque !== '' && dinheiro !== '') {
          dinheiro = dinheiro + ' CVE'
          cheque = cheque + ' CVE'
        }else if (cheque !== '' && vint4 !== '') {
          vint4 = vint4 + ' CVE'
          cheque = cheque + ' CVE'
        }else if(dinheiro !== '' && cheque !== '' && vint4 !== '') {
          dinheiro = dinheiro + ' CVE'
          vint4 = vint4 + ' CVE'
          cheque = cheque + ' CVE'
        }

        const escpos = require('escpos')
        const device = new escpos.USB()
        const options = { encoding: 'CP860' }
        const printer = new escpos.Printer(device, options)
        
          device.open(function () {
            printer
            .font('b')
            .align('lt')
            .style('bu')
            .size(2, 1.6)
            .text('FRUT&PÃO - Loja de Conveniência')
            .text('Praia - Fazenda')
            .text('NIF: 278272509')
            .text('TEL/FAX: +238 3560200')
            .text('------------------------------------------------')
            .text('\n')
            .text('VENDA NUMERO: ' + idvenda )
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
                    prod = value.Produto.produto_nome_rec + '                   '
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
            .text('Obrigado e volte sempre')
            .text('\n')
            .cut()
            .close()
          })
    },
    async createVendaProdnoPrinter(index) {
      listaVendaServices.post(this.produtos)
      stockServices.putvendas(this.produtos)
      VendaServices.putidpagamento(this.pagamento)
      
      console.log("MEU PROD ---- ", this.produtos)
      // Create nova venda
      await VendaServices.post(this.venda)
      this.idVenda = (await VendaServices.lastid()).data[0].id;

      if (this.isUserLoggedIn) {
        this.recibo = (await VendaServices.index({
          userId: this.user.id
        })).data[0].ListaVendas;
      }

      this.dialog = false
      this.clipesquisa = '',
      this.produtos = [{
        input: null,
        idSearch: '',
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
      this.pagamento = {
        ClienteId: '',
        VendaId: '',
        dinheiro: '',
        vint4: '',
        cheque: '',
        valorentregado: '',
        valorentregadovint4: '',
        valorentregadocheque: '',
        tLiquido: '',
        tapagar: '',
        tapagariva: '',
        troco: ''
      },
      this.$refs.search[index].focus()
      this.$toast.success({
        title: "Sucesso",
        message: "Venda adicionada com sucesso no sistema!"
      })
    },
    async createVendaProd(index) {
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
      console.log('DADO VENDA: ', this.pagamento)
      this.PrintVenda()

      this.clipesquisa = '',
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
      this.$refs.search[index].focus()
      this.$toast.success({
        title: "Sucesso",
        message: "Venda adicionada com sucesso no sistema"
      })
    }
  },
  async mounted() {
    
    this.listaprodutos = (await ProdutosService.index()).data;
    console.log('Meus Produtos', this.listaprodutos)
    this.listaclientes = (await ClienteServices.index()).data;
    console.log("MEUS CLI:", this.listaclientes)
    this.metodoPagamento = (await metodoPagamentoServices.index()).data;
    console.log('Metodos pagamento', this.metodoPagamento)
    this.idVenda = (await VendaServices.lastid()).data[0].id;
    console.log("ID VENDA: ", this.idVenda)
    this.categorias = (await CategoriasService.indexImage()).data;
    console.log("MEUS CAT:", this.categorias)
  },
  computed: {
    networkStatus () {
        return this.isOnline ? 'My network is fine' : 'I am offline'
    },
    ...mapState([
      'isUserLoggedIn',
      'user'
    ]),
    stockIsValid() {
      return (
        this.pagamento.tapagar &&
        this.pagamento.valorentregado ||
        this.pagamento.valorentregadovint4 ||
        this.pagamento.valorentregadocheque
      )
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
        return total + Number(produto.quantidade * produto.preco_venda);
      }, 0);
    },
    totalIva() {
      return this.produtos.reduce((total, produto) => {
        return total + Number(produto.preco_venda * produto.iva / 100);
      }, 0);
    },
    totalPriceLiquido() {
      return this.produtos.reduce((total, produto) => {
        return total + Number(produto.quantidade * produto.preco_venda);
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
      max-width: 900px !important;
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
</style>