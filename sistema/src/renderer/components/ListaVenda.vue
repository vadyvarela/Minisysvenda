<template>
    <panel title="Lista de vendas">
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
        <v-divider></v-divider>
        <!--<template>
          <div class="hello">
            <table border="1">
              <tbody>
                <tr v-bind:key="item" v-for="item in desserts">
                    <td colspan='6'> <b>{{ item.createdAt | moment("DD-MM-YYYY") }}</b></td>
                      <table border="1">
                          <tr v-bind:key="job" v-for="job in item.ListaVendas">
                            <td>{{job.quantidade}}</td>
                            <td>{{job.Produto.produto_nome}}</td>
                          </tr>
                      </table>
                    </tr>     
              </tbody>
            </table>

          </div>
        </template>-->
        <v-dialog v-model="dialogUser" @keydown.enter="login()" persistent max-width="550px" @keydown.esc="dialogUser = false">
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
                    <v-btn color="red" icon outline right small fab dark @click.native="dialogUser = false"><v-icon>close</v-icon></v-btn>
                  </v-card-title>
                    <v-card-text>
                      <div class="layout column align-center">
                        <h1 class="flex my-4 primary--text"> {{ $t('message.loginadmin') }} </h1>
                      </div>                
                      <v-form>
                        <v-text-field
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
                      <v-btn class="primary" @click="login()"> {{ $t('message.btnEfetuarLogn') }} </v-btn>
                    </v-card-actions>

                  </v-card>
                </v-flex>
              </v-layout>
              </v-container>
            </v-card-text>
          </v-card>
        </v-dialog>

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
                      <v-date-picker v-model="data_ini" @input="$refs.menu2.save(data_ini)"></v-date-picker>
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
                      <v-date-picker v-model="data_fim" @input="$refs.menu1.save(data_fim)"></v-date-picker>
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
                  <td class="text-xs-left"> {{ props.item.id }} </td>
                  <td class="text-xs-left"> {{ props.item.createdAt | moment("DD-MM-YYYY") }} - {{ props.item.createdAt | moment("HH:mm:ss") }} </td>
                  <v-expansion-panel popout>
                    <v-expansion-panel-content>
                      <div slot="header"> {{ $t('message.listaproduto') }} </div>
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

                  <td v-if="props.item.valor_venda_dinheiro != '' && props.item.valor_venda_cheque == '' && props.item.valor_venda_vint4 == '' " class="text-xs-left"> {{ props.item.meio_pagamento_dinheiro }} </td>
                  <td v-else-if="props.item.valor_venda_cheque != '' && props.item.valor_venda_dinheiro == '' && props.item.valor_venda_vint4 == '' " class="text-xs-left"> {{ props.item.meio_pagamento_cheque }} </td>
                  <td v-else-if="props.item.valor_venda_vint4 != '' && props.item.valor_venda_dinheiro == '' && props.item.valor_venda_cheque == '' " class="text-xs-left"> {{ props.item.meio_pagamento_vint4 }} </td>
                  <td v-else-if="props.item.valor_venda_vint4 != '' && props.item.valor_venda_dinheiro != ''" class="text-xs-left"> {{ props.item.meio_pagamento_dinheiro }} - {{ props.item.meio_pagamento_vint4 }} </td>
                  <td v-else-if="props.item.valor_venda_cheque != '' && props.item.valor_venda_dinheiro != ''" class="text-xs-left"> {{ props.item.meio_pagamento_dinheiro }} - {{ props.item.meio_pagamento_cheque }} </td>
                  <td v-else-if="props.item.valor_venda_vint4 != '' && props.item.valor_venda_cheque != '' " class="text-xs-left"> {{ props.item.meio_pagamento_vint4 - props.item.meio_pagamento_cheque }} </td>
                  <td v-else-if="props.item.valor_venda_dinheiro != '' && props.item.valor_venda_vint4 != '' && props.item.valor_venda_cheque != '' " class="text-xs-left"> {{ props.item.meio_pagamento_dinheiro - props.item.meio_pagamento_vint4 - props.item.meio_pagamento_cheque }} </td>
                  
                  
                  <td class="text-xs-left"> <span class="boxquantidadegreen"> {{ props.item.valor_total }} CVE </span></td>
                  <td class="text-xs-left"> 
                    <span v-if="props.item.valor_venda_dinheiro != '' && props.item.valor_venda_cheque == '' && props.item.valor_venda_vint4 == '' " class="text-xs-left boxquantidade"> {{ props.item.valor_venda_dinheiro }} CVE </span>
                    <span v-else-if="props.item.valor_venda_cheque != '' && props.item.valor_venda_dinheiro == '' && props.item.valor_venda_vint4 == '' " class="text-xs-left boxquantidade"> {{ props.item.valor_venda_cheque }} CVE</span>
                    <span v-else-if="props.item.valor_venda_vint4 != '' && props.item.valor_venda_dinheiro == '' && props.item.valor_venda_cheque == '' " class="text-xs-left boxquantidade"> {{ props.item.valor_venda_vint4 }} CVE</span>
                    <span v-else-if="props.item.valor_venda_vint4 != '' && props.item.valor_venda_dinheiro != ''" class="text-xs-left boxquantidade"> {{ props.item.valor_venda_dinheiro }} - {{ props.item.valor_venda_vint4 }} CVE</span>
                    <span v-else-if="props.item.valor_venda_cheque != '' && props.item.valor_venda_dinheiro != ''" class="text-xs-left boxquantidade"> {{ props.item.valor_venda_dinheiro }} - {{ props.item.valor_venda_cheque }} CVE</span>
                    <span v-else-if="props.item.valor_venda_vint4 != '' && props.item.valor_venda_cheque != '' " class="text-xs-left boxquantidade"> {{ props.item.valor_venda_vint4 - props.item.valor_venda_cheque }} CVE</span>
                    <span v-else-if="props.item.valor_venda_dinheiro != '' && props.item.valor_venda_vint4 != '' && props.item.valor_venda_cheque != '' " class="text-xs-left boxquantidade"> {{ props.item.valor_venda_dinheiro - props.item.valor_venda_vint4 - props.item.valor_venda_cheque }} CVE</span>
                  </td>
                  <td class="text-xs-left"> <span class="boxquantidadered"> {{ props.item.valor_troco }} CVE </span> </td>
                  <td class="text-xs-left dark">
                    <v-btn flat icon color="primary" @click="PrintVenda(props.item)"> <v-icon>print</v-icon> </v-btn>
                    <v-btn title="Anular Venda" flat icon color="red" @click="AnularVenda(props.item)"> <v-icon>error_outline</v-icon> </v-btn>
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
import filterServices from "@/services/filterServices"
import VendaServices from "@/services/VendaServices";
import listaVendaServices from "@/services/listaVendaServices";
import stockServices from "@/services/stockServices"
import AuthenticationService from "@/services/AuthenticationService";
import moment from 'moment'
import { mapState } from 'vuex'

export default {
  data() {
    return {
      idSearch: "",
      menu1: false,
      menu2: false,
      data_ini: null,
      data_fim: null,
      usuario: "",
      password: "",
      show1: false,
      userconfig: 0,
      dialogUser: false,
      snackbar: false,
      color: 'success',
      mode: '',
      timeout: 6000,
      text: 'Agora já pode anular as vendas',
      valid: true,
      total: '',
      error: null,
      noadmin: "Por Favor entre com uma conta de administrador",
      alert: false,
      alertadmin: false,
      dialog: false,
      produtos: [{ 
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
        { text: "Vendedor", align: "left", sortable: false },
        { text: "F. Pagamento", align: "left", sortable: false },
        { text: "Valor Total", value: "valor_total", align: "left", sortable: true },
        { text: "Valor Entregue", align: "left", sortable: false },
        { text: "Troco", value: "valor_troco", align: "left", sortable: true },
        { text: "Ações", align: "left", sortable: false },
      ],
      desserts: [],
      CategoriaId: []
    };
  },
  methods: {
    async AnularVendaAdmin() {
      this.dialogUser = true
    },
    async reload() {
      if (this.isUserLoggedIn) {
        this.desserts = (await VendaServices.index({
          userId: this.user.id
        })).data;
      }
    },
    async pesquisar() {
      //Lista venda
      this.desserts = (await VendaServices.indexTotal({
        userId: this.user.id,
        dataIni: this.data_ini,
        dataFim: this.data_fim
      })).data;
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
        this.alert = true;
      }
    },
    async PrintVenda(item) {
        this.editedIndex = this.desserts.indexOf(item);
        this.produtos = item
        const recibo = item.ListaVendas
        const pagamento = item.valor_total
        const tapagar = item.valor_total
        const tapagariva = item.valor_iva
        const troco = item.valor_troco
        const horaVenda = moment().format('LT')
        const dataVenda = moment().format('l')
        const vendedor = this.user.usuario
        let dinheiro =  item.valor_venda_dinheiro
        let vint4 = item.valor_venda_vint4
        let cheque = item.valor_venda_cheque
        let prod = ''

        if (dinheiro !== '') {
          dinheiro = dinheiro
        } else if (vint4 !== '') {
          vint4 = vint4
        } else {
          cheque = cheque
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
            .text('FRUT&PÃO - Loja de Conveniência')
            .text('Praia - Fazenda')
            .text('NIF: 278272509')
            .text('TEL/FAX: +238 3560200')
            .text('--------------------------------')
            .text('Data do Doc: ' + dataVenda + '  ' + horaVenda)
            .text('VENDEDOR: ' + vendedor)
            .text('\n')
            // ----------------------------------------------------
            .text('Produto                     IVA')
            .text('  ' + 'Valor')
            .text('-------------------------------')
            for (var key in recibo) {
              if (recibo.hasOwnProperty(key)) {
                const value = recibo[key]
                console.log("MEUS PROD", value)
                console.log("TAMANHO ", value.Produto.produto_nome.length)
                if (value.Produto.produto_nome.length >= 23) {
                    prod = value.Produto.produto_nome + ' '
                }else if (value.Produto.produto_nome.length > 20 && value.Produto.produto_nome.length < 23) {
                    prod = value.Produto.produto_nome + '      '
                }else if (value.Produto.produto_nome.length > 18 && value.Produto.produto_nome.length <= 20) {
                    prod = value.Produto.produto_nome + '         '
                }else if (value.Produto.produto_nome.length >= 15 && value.Produto.produto_nome.length <= 18) {
                    prod = value.Produto.produto_nome + '           '
                }else if (value.Produto.produto_nome.length < 15 && value.Produto.produto_nome.length >= 10) {
                    prod = value.Produto.produto_nome + '               '
                }else if (value.Produto.produto_nome.length < 10 && value.Produto.produto_nome.length > 5) {
                    prod = value.Produto.produto_nome + '                  '
                }else {
                    prod = value.Produto.produto_nome + '                    '
                }
                  printer
                  .font('b')
                  .align('lt')
                  .size(1, 1)
                  
                  .text(prod + value.Produto.Iva.iva_valor + '%')
                  .text('  ' + value.Produto.produto_preco)
              }
            }
            // ----------------------------------------------------
            printer
            .text('--------------------------------')
            .text('Dinheiro                   ' + dinheiro)
            .text('VINT4                      ' + vint4)
            .text('Cheque                     ' + cheque)
            .text('--------------------------------')
            .font('b')
            .align('lt')
            .size(1, 1)
            .text('================================')
            .text('Total Liquido:          ' + pagamento + ' CVE')
            .text('Total Iva:            ' + tapagariva + ' CVE')
            .text('A pagar:                ' + tapagar + ' CVE')
            .text('Troco:                  ' + troco + ' CVE')
            .text('================================')
            .cut()
            printer
            .font('b')
            .align('ct')
            .size(1, 1)
            .text('Obrigado e volte sempre')
            .cut(null, 5)
            .close()
          })
    },
    async AnularVenda (item) {
      if(this.userconfig == 0) {
        this.AnularVendaAdmin()
      } 
      else if (this.userconfig == 1) {
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
      }
    }
  },
  computed: {
    ...mapState([
      'isUserLoggedIn',
      'user'
    ])
  },
  async mounted() {
    if (this.isUserLoggedIn) {
      this.desserts = (await VendaServices.index({
        userId: this.user.id
      })).data;
    }
    console.log("DADOS", this.desserts)
    this.total = this.desserts.length
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
</style>
