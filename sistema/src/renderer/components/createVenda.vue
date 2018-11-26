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
                <h2 class="myinputsdata">DATA VENDA: <span style="font-weight:100"> {{ Date() | moment("DD-MM-YYYY HH:MM") }} </span></h2>
              </v-flex>
              <v-flex sm2 md2>
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
                  <span v-if="clienteNow !== ''" hidden> 
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
                    </v-flex>
                  </v-layout>
                </div>
                
                <h4 hidden v-if="pagamento.valorentregado != '' && pagamento.valorentregadovint4 == '' && pagamento.valorentregadocheque == '' ">TROOCO: {{ pagamento.troco = pagamento.valorentregado - totalPrice }}</h4>
                <h4 hidden v-if="pagamento.valorentregadovint4 != '' && pagamento.valorentregado == '' && pagamento.valorentregadocheque == '' ">TROOCO: {{ pagamento.troco = pagamento.valorentregadovint4 - totalPrice }}</h4>
                <h4 hidden v-if="pagamento.valorentregadocheque != '' && pagamento.valorentregado == '' && pagamento.valorentregadovint4 == '' ">TROOCO: {{ pagamento.troco = pagamento.valorentregadocheque - totalPrice }}</h4>
                <h4 hidden v-else-if="pagamento.valorentregado != '' && pagamento.valorentregadovint4 != ''">TROOCO: {{ pagamento.troco = pagamento.valorentregado + pagamento.valorentregadovint4 - totalPrice }}</h4>
                <h4 hidden v-else-if="pagamento.valorentregado != '' && pagamento.valorentregadocheque != ''">TROOCO: {{ pagamento.troco = pagamento.valorentregado + pagamento.valorentregadocheque - totalPrice }}</h4>
                <h4 hidden v-else-if="pagamento.valorentregado != '' && pagamento.valorentregadovint4 != '' && pagamento.valorentregadocheque != '' ">TROOCO: {{ pagamento.troco = pagamento.valorentregado + pagamento.valorentregadovint4 + pagamento.valorentregadocheque - totalPrice }}</h4>
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
                        <!--<v-card-title>
                          <span class="headline"> {{ $t('message.metodoPagamento') }} </span>
                          <v-spacer></v-spacer>
                          <v-btn color="red" icon outline right small fab dark @click.native="dialog = false"><v-icon>close</v-icon></v-btn>
                        </v-card-title>-->
                        <v-card-text>
                          <v-container grid-list-md>
                            <v-layout wrap>
                              <v-flex xs12>
                                <h4 class="primary--text text-md-center" style="font-size:1.6em;"> {{ $t('message.totalaPagar') }} </h4>
                                <p>
                                  <vue-numeric readonly class="green--text" style="text-align:center; font-weight:bold; font-size:2em; width:100%" :value="pagamento.tapagar"></vue-numeric>
                                  <input name="" v-model="pagamento.tapagar" type="hidden"/>
                                  <input name="" v-model="pagamento.tapagariva" type="hidden"/>
                                  <input name="" v-model="pagamento.tLiquido" type="hidden"/> 
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
                                      <v-text-field box v-model.number="pagamento.valorentregado" autofocus type="number"></v-text-field>
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
                                <v-text-field box v-model="pagamento.valorentregado" label="Valor entregado" ></v-text-field>
                              </v-flex>-->
                              
                              <v-flex xs12>
                                <h4 class="primary--text text-md-center" style="font-size:2em;"> {{ $t('message.troco') }} </h4>
                                <p v-if="pagamento.valorentregado || pagamento.valorentregadovint4 || pagamento.valorentregadocheque" >
                                  <vue-numeric v-if="pagamento.troco < 0 " readonly class="red--text" style="text-align:center; font-size:2em; font-weight:700; width:100%" :value="pagamento.troco"></vue-numeric>
                                  <vue-numeric v-else readonly class="green--text" style="text-align:center; font-size:2em; font-weight:700; width:100%" :value="pagamento.troco"></vue-numeric>
                                  <input name="produto_id" v-model="pagamento.troco" type="hidden"/>   
                                </p>
                                <p v-else class="red--text" style="text-align:center; font-size:1em;"> {{ $t('message.valorEntregado') }} </p>
                              </v-flex>
                              
                            </v-layout>
                          </v-container>
                        </v-card-text>
                        <v-card-actions>
                          <v-spacer></v-spacer>
                          <div v-if="idSearch == '' && pagamento.troco >= 0">
                            <v-btn large right color="primary darken-1" :disabled="!stockIsValid" @click.native="createVendaProdnoPrinter(index)"> {{ $t('message.finalizacompra') }} </v-btn>
                            <v-btn large color="success darken-1" :disabled="!stockIsValid" @click="createVendaProd(index)"> {{ $t('message.fcompraimprimir') }} </v-btn>
                          </div>
                          <div v-if="idSearch !== '' && pagamento.troco >= 0">
                            <v-btn large right color="primary darken-1" :disabled="!stockIsValid" @click.native="updateVenda(index)"> Atualizar Venda </v-btn>
                            <v-btn large color="success darken-1" :disabled="!stockIsValid" @click.native="updateVenda(index)"> Atualizar & Imprimir Venda </v-btn>
                          </div>
                        </v-card-actions>
                      </v-card>
                    </v-dialog>


                    <v-dialog v-model="dialogPesquisaCategoria" persistent max-width="850px" @keydown.esc="dialogPesquisaCategoria = false">
                      <v-card align-center justify-center>
                        <v-card-title>
                          <v-spacer></v-spacer>
                          <v-btn color="red" icon outline right small fab dark @click.native="dialogPesquisaCategoria = false"><v-icon>close</v-icon></v-btn>
                        </v-card-title>
                        <h4 class="primary--text text-md-center" style="font-size:2em;">SELECIONE A CATEGORIA DO PRODUTO </h4>
                        <v-card-text>
                          <v-container grid-list-md>
                            <v-layout wrap>

                              <div v-bind:key="index" v-for="(categoria, index) in categorias">
                                <v-flex xs12>
                                  <v-btn outline color="indigo"> {{ categoria.categoria_nome }} </v-btn>
                                </v-flex>
                              </div>
                              
                            </v-layout>
                          </v-container>
                        </v-card-text>
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

                    <v-dialog v-model="dialogPesquisaBolsa" persistent max-width="550px" @keydown.esc="dialogPesquisaBolsa = false">
                      <v-card align-center justify-center>
                        <v-card-title>
                          <v-spacer></v-spacer>
                          <v-btn color="red" icon outline right small fab dark @click.native="dialogPesquisaBolsa = false"><v-icon>close</v-icon></v-btn>
                        </v-card-title>
                        <v-card-text>
                          <v-container grid-list-md>
                            <v-layout wrap>
                              <h4 class="primary--text text-md-center" style="font-size:1.5em;">ADICIONAR BOLSA A LISTA DE COMPRAS? </h4>
                            </v-layout>
                          </v-container>
                        </v-card-text>
                        <v-card-actions>
                          <v-spacer></v-spacer>
                          <v-btn center large color="primary darken-1" @click.native="dialogPesquisaBolsa = false; pesquisarBolsa(index)">SIM</v-btn>
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
                          <input v-model.trim="produto.search"  ref="search" type="hidden" autofocus />
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

                      <v-text-field box readonly v-if="userconfig != 1 && user.nivel == 2" v-model.number="produto.preco_venda" @click="changePVenda" name="" type="number"></v-text-field>
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
                      <v-btn small left fab outline @click="removeNewProdutoUpdate(index)" class="red"><v-icon>remove</v-icon></v-btn>
                    </v-flex>
                  </v-layout>
                  </v-form>
                </div>
                <v-spacer></v-spacer>
                <v-divider></v-divider>
                <v-flex style="float:left">
                  <v-btn style="margin-top:20px;" dark small fab class="primary" v-shortkey="['ctrl','b']" @shortkey="addBolsa" @click.native="addBolsa"><v-icon>shopping_basket</v-icon></v-btn>
                </v-flex>
                <v-flex style="float:right">
                  <v-btn style="margin-top:20px;" dark small fab class="primary" v-shortkey="['ctrl','n']" @shortkey="addNewProduto" @click="addNewProduto"><v-icon>add</v-icon></v-btn>
                </v-flex>
              </v-flex>
              <v-divider></v-divider>
              <v-flex>
                <div style="float:right">
                  <v-btn style="margin-top:20px;" large class="green" v-shortkey="['ctrl','enter']" @shortkey="modoPagamento()" @click="modoPagamento()"> <span style="font-size:2em; font-weight:bold; color: #fff;"> FINALIZAR </span></v-btn>
                </div>
              </v-flex>
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
      dialogPesquisaBolsa: false,
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
      listaclientes: [],
      usuario_nome: '',
      snackbar: false,
      color: 'error',
      mode: '',
      timeout: 6000,
      text: 'Não foi encontrado produto com esse código ou código de barra',
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
  methods: {
    changeQuantidade (index) {
      if(this.produtos[index].idSearch == null){
        console.log("Nao Fazer nada")
      }else {
        stockServices.putstockaddremove(this.produtos[index])
        this.$toast.success({
          title: "Aviso",
          message: "Stock do produto atualizado com sucesso"
        })
      }
    },
    addNewProduto () {
      // if (this.produtos[index].search.length !== 0) {
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
      // }
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
    removeNewProdutoUpdate(index) {
      // console.log('MEU: ', this.produtos[index])
      if(this.produtos[index].idSearch == null){
        this.produtos.splice(index, 1)
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
          this.produtos = this.res[0].ListaVendas
        }else{
          this.$toast.error({
            title: "Aviso",
            message: "Venda com esse id de registro nao existe no sistema!"
          })
        }
      }
    },
    async updateVenda(index) {
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
    async pesquisarBolsa(index) {
      try {
        this.search = 'Bolsa'
        this.produtos[index].search = 'Bolsa'
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
    async addBolsa() {
      this.dialogPesquisaBolsa = true
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
      await ClienteServices.post(this.cliente)
      this.$toast.success({
        title: "Sucesso",
        message: "Cliente adicionada com sucesso no sistema!"
      })
      // console.log("DADOS CLI: ", this.cliente)
      this.clienteNow = (await ClienteServices.lastid()).data[0]
    },
    async PrintVenda(index) {
        const recibo = (await VendaServices.index({ userId: this.user.id })).data[0].ListaVendas
        const pagamento = this.pagamento.tLiquido - this.pagamento.tapagariva
        const tapagar = this.pagamento.tapagar
        const tapagariva = this.pagamento.tapagariva
        const troco = this.pagamento.troco
        const horaVenda = moment().format('LT')
        const dataVenda = moment().format('l')
        const vendedor = this.user.usuario
        const idvenda = this.pagamento.VendaId - 1
        let dinheiro = this.pagamento.valorentregado
        let vint4 = this.pagamento.valorentregadovint4
        let cheque = this.pagamento.valorentregadocheque
        let prod = ''
        // let entregado = ''

        //const dataVenda = this.venda.data_venda
        if (dinheiro !== '') {
          dinheiro = dinheiro + ' CVE'
        } else if (vint4 !== '') {
          vint4 = vint4 + ' CVE'
        } else {
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
            .text('CLIENTE: Maria de Monte de Brito Varela')
            .text('MORADA: Varzea - Praia')
            .text('NIF: 378564756')
            .text('TELEFONE: 5845777')
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
                    prod = value.Produto.produto_nome_rec + '   '
                }else if (value.Produto.produto_nome_rec.length > 20 && value.Produto.produto_nome_rec.length < 23) {
                    prod = value.Produto.produto_nome_rec + '     '
                }else if (value.Produto.produto_nome_rec.length > 18 && value.Produto.produto_nome_rec.length <= 20) {
                    prod = value.Produto.produto_nome_rec + '         '
                }else if (value.Produto.produto_nome_rec.length >= 15 && value.Produto.produto_nome_rec.length <= 18) {
                    prod = value.Produto.produto_nome_rec + '           '
                }else if (value.Produto.produto_nome_rec.length < 15 && value.Produto.produto_nome_rec.length >= 10) {
                    prod = value.Produto.produto_nome_rec + '                '
                }else if (value.Produto.produto_nome_rec.length < 10 && value.Produto.produto_nome_rec.length > 5) {
                    prod = value.Produto.produto_nome_rec + '                  '
                }else {
                    prod = value.Produto.produto_nome_rec + '                    '
                }
                  printer
                  .font('b')
                  .align('lt')
                  .size(1, 1)
                  .text( quantidade + '  ' + prod + value.preco_venda + '     ' + value.Produto.Iva.iva_valor + '%  ' + pTotal)
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
    this.listaclientes = (await ClienteServices.index()).data;
    console.log("MEUS CLI:", this.listaclientes)
    this.metodoPagamento = (await metodoPagamentoServices.index()).data;
    console.log('Metodos pagamento', this.metodoPagamento)
    this.idVenda = (await VendaServices.lastid()).data[0].id;
    console.log("ID VENDA: ", this.idVenda)
    this.categorias = (await CategoriasService.index()).data;
    console.log("MEUS CAT:", this.categorias)
  },
  computed: {
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

</style>