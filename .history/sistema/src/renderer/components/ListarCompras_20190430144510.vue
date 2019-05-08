<template>
    <panel title="LISTA DE COMPRAS">
      <v-content >
        <v-layout justify-end row>
          <v-flex text-lg-left xs6>
            <v-badge class='mt-3 mr-4' right>              
              <span class="title"> Total de compras feitas </span>
              <span class="TVenda"> {{ total }} </span>
            </v-badge>
          </v-flex>
          <v-flex text-lg-right xs6>
            <v-btn router-link to="vendas" text-lg-right class="primary">  NOVA COMPRA </v-btn>
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
                          <tr class="nobordertr" v-bind:key="index" v-for="(produto,index) in props.item.ListaVendas">
                          <td>{{ produto.Produto.produto_nome }}</td>
                          <td> / </td>
                          <td>{{ produto.quantidade }}</td>
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
import VendaServices from "@/services/VendaServices";
import listaVendaServices from "@/services/listaVendaServices";
import stockServices from "@/services/stockServices"
import AuthenticationService from "@/services/AuthenticationService";
import moment from 'moment'
import { mapState } from 'vuex'

export default {
  data() {
    return {
      data_hoje: new Date().toISOString().substr(0, 10),
      modal: false,
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
  components: {
        Vendedor,
        Admin
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
      this.data_ini = null,
      this.data_fim = null,
      this.total = this.desserts.length
    },
    async pesquisarhoje() {
      this.desserts = (await VendaServices.hoje({
        userId: this.user.id,
        dataHoje: this.data_hoje
      })).data;
      this.total = this.desserts.length
    },
    async pesquisar() {
      //Lista venda
      this.desserts = (await VendaServices.indexTotal({
        userId: this.user.id,
        dataIni: this.data_ini,
        dataFim: this.data_fim
      })).data;
      this.total = this.desserts.length
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
