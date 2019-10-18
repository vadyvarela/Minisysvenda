<template>
    <panel :title="$t('message.cadProduto')">
      <v-content>
        <v-layout justify-end row wrap>
            <v-flex text-lg-right xs6>
              <v-btn router-link to="produtos" text-lg-right class="primary"> {{ $t('message.btnMostrarProduto') }} </v-btn>
            </v-flex>
            <v-snackbar
              v-model="snackbar" :color="color"
              :multi-line="mode === 'multi-line'"
              :timeout="timeout"
              :vertical="mode === 'vertical'"
            >
              {{ text }}
              <v-btn dark flat @click="snackbar = false">Fechar</v-btn>
            </v-snackbar>
        </v-layout>

        <v-snackbar
        v-model="snackbarnorow"
        :color="colornorow"
        :multi-line="mode === 'multi-line'"
        :timeout="timeout"
        :vertical="mode === 'vertical'">
        {{ textnorow }}
        <v-btn
          dark
          flat
          @click="snackbarnorow = false">
          Fechar
        </v-btn>
      </v-snackbar>
        <v-divider></v-divider>

        <v-stepper v-model="e1">
        <v-stepper-header>
          <v-stepper-step editable :complete="e1 > 1" step="1"> {{ $t('message.dadosProduto') }} </v-stepper-step>
          <v-divider></v-divider>
          <v-stepper-step editable :complete="e1 > 2" step="2"> {{ $t('message.precodevenda') }} </v-stepper-step>
          <v-divider></v-divider>
          <v-stepper-step step="3"> {{ $t('message.finalizar') }} </v-stepper-step>
        </v-stepper-header>

        <v-stepper-items>
        <v-stepper-content step="1">
        <v-layout align-center justify-center>
          <v-flex xs12 sm8 md8>
            <v-card class="elevation-0">
              <v-card-text>
                <v-form @submit.prevent="submit" ref="form" name="cadastar" autocomplete="off" lazy-validation>
                  <v-container grid-list-md>
                  <v-layout wrap>
                   
                    
                  <v-flex xs12 sm4 md4>
                    <v-text-field box color="blue" autofocus required :rules="codRules" v-on:keyup.enter="pesquisar" name="produto_code" v-model="produto.produto_code" :label="$t('message.produto_code')" type="text"></v-text-field>
                  </v-flex>
                  <v-flex xs12 sm8 md8>
                    <v-text-field box color="blue" name="produto_barcode" v-model="produto.produto_barcode" :label="$t('message.produto_barcode')"  type="text"></v-text-field>
                  </v-flex>
                  <v-flex xs12 sm12 md12>
                  <v-textarea
                    box
                    :rules="nomeRules"
                    color="blue"
                    name="produto_nome"
                    :label="$t('message.produto_nome')"
                    v-model="produto.produto_nome"
                  ></v-textarea>
                  </v-flex>
                  <v-flex xs12 sm7 md7>
                  <v-text-field box color="blue" required :rules="nomerecRules" name="produto_nome_rec" v-model="produto.produto_nome_rec" :label="$t('message.produto_nome_rec')" type="text"></v-text-field>
                  </v-flex>
                  <v-flex xs12 sm2 md2>
                    <v-text-field box color="blue" required v-model="produto.quantidade" label="Stock" type="number"></v-text-field>
                  </v-flex>
                  <v-flex xs12 sm3 md3>
                    <v-text-field box color="blue" required :rules="precocustoRules" name="produto_preco" v-model="produto.produto_preco" :label="$t('message.produto_preco')" type="number"></v-text-field>
                  </v-flex>
                  <v-flex xs12 sm6 md4>
                  <v-autocomplete
                    box
                    :items="FornecedoreId"
                    color="white"
                    v-model="produto.FornecedoreId"
                    item-text="fornecedor_nome"
                    item-value="id"
                    :label="$t('message.fornecedor_nome')"
                    required
                    :rules="fornecRules"
                  ></v-autocomplete>
                  <input name="" v-model="produto.FornecedoreId" type="hidden"/>   
                  </v-flex>

                  <v-flex xs12 sm6 md4>
                    <v-select
                      box color="blue"
                      name="IvaId"
                      v-model="produto.IvaId"
                      :items="IvaId"
                      :label="$t('message.iva_valor')"
                      required
                      :rules="ivaRules"
                      item-text="iva_valor"
                      item-value="id"
                    ></v-select>
                  </v-flex>

                  <v-flex xs12 sm6 md4>
                    <v-autocomplete
                      box color="blue"
                      name="CategoriaId"
                      v-model="produto.CategoriaId"
                      :items="CategoriaId"
                      :label="$t('message.categoria_nome')"
                      required
                      :rules="categoriaRules"
                      item-text="categoria_nome"
                      item-value="id"
                      ></v-autocomplete>
                      <input name="" v-model="produto.CategoriaId" type="hidden"/>   
                  </v-flex>
                  <!-- <v-flex xs12 class="text-xs-center text-sm-center text-md-center text-lg-center">
                      <img :src="imageUrl" height="150" v-if="imageUrl"/>
                      <v-text-field box label="Select Image" @click='pickFile' v-model='imageName' append-icon='attach_file'></v-text-field>
                      <input
                        type="file"
                        ref="file"
                        @change="onFilePicked"
                        style="display: none"
                        name=""
                        accept="image/*"
                      >
                    </v-flex> -->
                  </v-layout>
                  </v-container>
                  <v-spacer></v-spacer>
                  <v-card-actions>
                    <v-spacer></v-spacer>
                    <!--<v-btn v-shortkey="['enter']" @shortkey="create" :disabled="!valid" class="primary" @click="create">Cadastrar produto</v-btn>-->
                    <v-btn v-if="this.produto.id !== undefined" color="success" :disabled="!formIsValid" @click="e1 = 2"> {{ $t('message.btnContinuar') }} </v-btn>
                    <v-btn v-else color="primary" :disabled="!formIsValid" @click="sendFile(), e1 = 2"> {{ $t('message.btnContinuar') }} </v-btn>
                  
                  </v-card-actions>
              </v-form>
              </v-card-text>
            </v-card>
          </v-flex>
        </v-layout>
      </v-stepper-content>
      <v-stepper-content step="2">
        <v-layout align-center justify-center>
          <v-flex xs12 sm12 md12>
              <v-btn v-if="this.produto.id === undefined" small fab class="primary" v-shortkey="['ctrl','n']" @shortkey="addNewPrice" @click="addNewPrice"><v-icon>add</v-icon></v-btn>
                <v-form ref="form" name="cadastar" autocomplete="off" lazy-validation>
                  <h2 style="text-align:center; font-size: 1.6em; color: #1976d2;"> {{ $t('message.precoProd') }}: {{ produto.produto_preco }} CVE</h2>
                  
                  <v-container v-if="this.produto.id !== undefined">
                     <h2 >ID {{ ProdutoId = this.produto.id }}</h2>
                      <div v-bind:key="index" v-for="(preco, index) in this.produto.PVendas">
                        <h5>Preco de venda #{{ index }}</h5>
                       <h2 >ID {{ preco.ProdutoId = ProdutoId }}</h2>
                        <span hidden v-if="produto.IvaId === 2"> {{ totalIva = produto.produto_preco * (1 + 0 / 100 ) }}</span>
                        <span hidden v-else> {{ totalIva = produto.produto_preco * (1 + 15 / 100 ) }}</span>
                        <span hidden> {{ total = (( preco.pvenda_preco - produto.produto_preco) / preco.pvenda_preco) * 100 }}</span>
                          <v-layout>
                            <v-flex xs12 sm4 md4>
                              <v-text-field box name="pvenda_preco" v-model="preco.pvenda_preco" label="Preço de venda" type="number"></v-text-field>
                            </v-flex>
                            <v-flex xs12 sm4 md4>
                              <v-text-field box name="" :value="totalIva" label="Preço C/IVA" type="number"></v-text-field>
                            </v-flex>
                            <v-flex xs12 sm4 md4>
                              <v-text-field box readonly :value="total" label="Margem de lucro (%)" name="" type="number"></v-text-field>
                            </v-flex>
                            <input name="ProdutoId" v-model="preco.ProdutoId" type="hidden"/>
                          </v-layout>
                        </div>
                  </v-container>
                  <v-container v-else>
                      <v-container v-bind:key="index" v-for="(preco, index) in precos" grid-list-md>
                      <h5>Preco de venda #{{ index }}</h5> 
                      <span hidden v-if="produto.IvaId === 2"> {{ totalIva = produto.produto_preco * (1 + 0 / 100 ) }}</span>
                      <span hidden v-else> {{ totalIva = produto.produto_preco * (1 + 15 / 100 ) }}</span>
                      <span hidden> {{ total = (( preco.pvenda_preco - produto.produto_preco) / preco.pvenda_preco) * 100 }}</span>
                      <h2 hidden>{{ preco.ProdutoId = idProduto }}</h2>
                        <v-layout>
                          <v-flex xs12 sm6 md6>
                            <v-text-field box name="pvenda_preco" v-model="preco.pvenda_preco" :label="$t('message.precodevenda')" type="number"></v-text-field>
                          </v-flex>
                          <v-flex xs12 sm6 md6>
                            <v-text-field box readonly :value="total" :label="$t('message.marLucro')" name="" type="number"></v-text-field>
                          </v-flex>
                          <input name="ProdutoId" v-model="preco.ProdutoId" type="hidden"/>
                          <v-flex xs12 sm1 md1>
                            <v-btn small left fab outline @click="removeNewPrice(index)" class="red"><v-icon>remove</v-icon></v-btn>
                          </v-flex>
                        </v-layout>
                      </v-container>
                  </v-container>
                  
                  <v-spacer></v-spacer>
                  <v-card-actions>
                    <v-spacer></v-spacer>
                    <div v-if="this.produto.id !== undefined" class="text-xs-center">
                      <v-btn color="success" large @click="updateProd()"> Atualizar dados  </v-btn>
                    </div>
                    <div v-else class="text-xs-center">
                      <v-btn color="primary" large :disabled="!PVendaIsValid" @click="createPrecos(), cadProd()"> {{ $t('message.btnContinuar') }}  </v-btn>
                    </div>
                    
                  </v-card-actions>
                </v-form>
              
            </v-flex>
        </v-layout>
      </v-stepper-content>
      <v-stepper-content step="3">
        <v-layout align-center justify-center>
        <v-flex center xs12 sm6 md6>
        <v-card class="centarlizar elevation-0">
            <v-card-text>
              <h2 class="meutitulo green--text "> {{ $t('message.finalizarcprod') }} </h2>
              <p></p>
              <!--<h2 hidden>{{ stock.ProdutoId = idProduto }}</h2>-->
              <v-form @submit.prevent="submit" ref="form" name="cadastar" autocomplete="off" lazy-validation>
              <!--<v-layout>
                <v-flex hidden xs12 sm12 md12>
                  <input name="stock_quantidade" v-model="stock.quantidade" type="hidden"/>
                </v-flex>
                <input name="produto_id" v-model="stock.ProdutoId" type="hidden"/>
              </v-layout>-->
              <v-spacer></v-spacer>
              
              <div v-if="this.produto.id !== undefined" class="text-xs-center">
                <v-btn center color="primary textbutton" large @click="updateProd()"> <v-icon>add</v-icon> Atualizar </v-btn>
              </div>
              <div v-else class="text-xs-center">
                <v-btn center color="success textbutton" large @click="cadProd"> <v-icon>add</v-icon> {{ $t('message.cadProduto') }}  </v-btn>
              </div>
              </v-form>
            </v-card-text>
        </v-card>
        </v-flex>
        </v-layout>
        </v-stepper-content>
      </v-stepper-items>
    </v-stepper>

    <v-dialog
      v-model="meuloading"
      hide-overlay
      persistent
      width="300"
    >
      <v-card
        color="primary"
        dark
      >
        <v-card-text>
          Realizando cadastro, Aguarde...
          <v-progress-linear
            indeterminate
            color="white"
            class="mb-0"
          ></v-progress-linear>
        </v-card-text>
      </v-card>
    </v-dialog>

    <v-dialog v-model="dialogProdExiste" persistent max-width="550px" @keydown.esc="dialogProdExiste = false">
      <v-card align-center justify-center>
        <v-card-text>
          <v-container grid-list-md>
            <v-layout wrap>
              <v-flex xs12>
                <h4 class="red--text text-md-center" style="font-size:2em;"> Esse produto já se encontra cadastrado no sistema!  </h4>
              </v-flex>
            </v-layout>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn center large color="primary darken-1" @click.native="dialogProdExiste = false; reload()">OK</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>

    </v-content>
    </panel>
</template>
<script>
import ProdutosService from "@/services/ProdutosService";
import FornecedoresService from "@/services/FornecedorService";
import CategoriasService from "@/services/CategoriasService";
import IvaService from "@/services/IvaService";
import PVendaServices from "@/services/PVendaServices";
import filterServices from "@/services/filterServices";
import StockServices from "@/services/StockServices";
import CBarraService from "@/services/CBarraService";

export default {
  data() {
    return {
      dialogProdExiste: false,
      meuloading: false,
      imageName: '',
      imageUrl: '',
      imageFile: '',
      snackbarnorow: false,
      colornorow: 'error',
      textnorow: 'Erro ao ligar a base de dados! Verifica sua conexão com a internet!',
      e1: "",
      dialogPesquisa: false,
      snackbar: false,
      color: "error",
      mode: "",
      timeout: 6000,
      text: "Nenhum produto encontrado!",
      idProduto: [],
      precos: [
        {
          pvenda_preco: "",
          ProdutoId: "",
          total: ''
        }
      ],
      /*stock: {
        quantidade: "0",
        //ProdutoId: ""
      },*/
      valid: true,
      CategoriaId: [],
      barcode: [],
      IvaId: [],
      FornecedoreId: [],
      codRules: [v => !!v || "Campo código produto é obrigatorio"],
      precovendaRules: [v => !!v || "Campo preço de venda é obrigatorio"],
      nomerecRules: [v => !!v || "Campo nome é obrigatorio"],
      nomeRules: [v => !!v || "Descrisão do produto é obrigatorio"],
      categoriaRules: [v => !!v || "Campo categoria do produto é obrigatorio"],
      ivaRules: [v => !!v || "Campo IVA é obrigatorio"],
      fornecRules: [v => !!v || "Campo fornecedor é obrigatório"],
      precocustoRules: [v => !!v || "Campo preço de custo é obrigatório"],
      // quantidadeRules: [v => !!v || "Campo quantidade stock é obrigatório"],
      // pvendaRules: [v => !!v || "Campo preço de venda é obrigatório"],
      produto_nome: "",
      produto_code: "",
      produto_barcode: "",
      produto_preco: "",
      produto: {
        produto_code: null,
        produto_nome: null,
        produto_nome_rec: null,
        produto_preco: null,
        produto_barcode: null,
        FornecedoreId: "",
        quantidade: '1',
        IvaId: "",
        // PVendaId: "",
        CategoriaId: ""
      },
      error: null,
      drawer: null
    };
  },
  methods: {
    // onFilePicked (e) {
    //   this.produto.produto_file = this.$refs.file.files[0]
		// 	const files = e.target.files
		// 	if(files[0] !== undefined) {
		// 		this.imageName = files[0].name
		// 		if(this.imageName.lastIndexOf('.') <= 0) {
		// 			return
		// 		}
		// 		const fr = new FileReader ()
		// 		fr.readAsDataURL(files[0])
		// 		fr.addEventListener('load', () => {
		// 			this.imageUrl = fr.result
		// 			this.imageFile = files[0]
		// 		})
		// 	} else {
		// 		this.imageName = ''
		// 		this.imageFile = ''
		// 		this.imageUrl = ''
		// 	}
		// },
    // pickFile () {
    //   this.$refs.file.click ()
    // },
    async pesquisar (){
      console.log("teste pesquisa", this.produto.produto_code);
      try {
        this.search = this.produto.produto_code
        if (this.search !== '') {
          this.meuloading = true
          this.produto.idProduto = (await filterServices.bynamevenda(this.search)).data
          this.meuloading = false
          console.log("PROD-----", this.produto.idProduto)
          Object.keys(this.produto.idProduto).forEach(key => {
            this.produto.idProduto = this.produto.idProduto[key];
          });
          this.produto = Object.assign({}, this.produto.idProduto)
          console.log("DADOS VADY", this.produto.id)
          if (this.produto.idProduto === '') {
            this.snackbar = true;
            this.produto = {
              produto_code: null,
              produto_nome: null,
              produto_nome_rec: null,
              produto_preco: null,
              produto_barcode: null,
              FornecedoreId: "",
              quantidade: '1',
              IvaId: "",
              CategoriaId: ""
            }
          }
        }
      } catch (error) {
        if (!error.response) {
          this.meuloading = false
          console.log(error)
          this.snackbarintenet = true
        }
      }
    },
    openPriceModal() {
      this.dialog = true;
      console.log("Testando");
    },
    async addNewPrice() {
      this.precos.push({
        pvenda_preco: "",
        ProdutoId: "",
        total: ''
      });
    },
    removeNewPrice(index) {
      this.precos.splice(index, 1);
    },
    async sendFile() {
      // const formData = new FormData()
      // formData.append('file', this.produto.produto_file)
      // formData.append('produto_code', this.produto.produto_code)
      // formData.append('produto_nome', this.produto.produto_nome)
      // formData.append('produto_nome_rec', this.produto.produto_nome_rec)
      // formData.append('produto_preco', this.produto.produto_preco)
      // formData.append('produto_barcode', this.produto.produto_barcode)
      // formData.append('FornecedoreId', this.produto.FornecedoreId)
      // formData.append('IvaId', this.produto.IvaId)
      // formData.append('CategoriaId', this.produto.CategoriaId)

      try {
        await ProdutosService.post(this.produto).then((result)=>{
          if (result.data.error == '1') {
            this.dialogProdExiste = true
          }
            console.log('::::::::::::::::::::::: teste ::::: ---- ', result.data.error)
        },(error)=>{
            console.log('EROO ::::::::::::::::::::::::::::::::', error)
        });
        
        this.idProduto = (await filterServices.lastid()).data[0].id;
        this.alert = false;
      } catch (error) {
        this.error = error.response.data.error;
        this.alert = true;
      }
    },
    async reload() {
      this.e1 = 1
      this.produto = {
        produto_code: '',
        produto_nome: '',
        produto_nome_rec: '',
        produto_preco: '',
        produto_barcode: '',
        FornecedoreId: "",
        IvaId: "",
        // PVendaId: "",
        CategoriaId: ""
      }      
    },
    async updateProd() {
      try {
        //this.dialog = false;
        this.pv = this.produto.PVendas
        await PVendaServices.put(this.vadyy);
        //await ProdutosService.put(this.produto)
        // this.snackbar = true
        // this.$router.push({
        //   name: "produtos"
        // });
        console.log("testetetteftgdffhgdg", this.produto.PVendas)
        //Object.assign(this.desserts[this.editedIndex], this.produto);
      } catch (err) {
        console.log("Merda",err);
        //this.alert = true;
      }
    },
    async cadProd() {
      try {
        this.meuloading = true
        // await StockServices.post(this.stock);
        // this.snackbar = true;
        // this.meuloading = false
        this.$toast.success({
          title: "Sucesso",
          message: "Produto cadastrado com sucesso"
        });
        this.$router.push({
          name: "produtos"
        });
      } catch (err) {
        console.log(err);
      }
    },
    async createPrecos() {
      try {
        console.log("Precos", this.precos)
        await PVendaServices.post(this.precos);
        // this.snackbar = true
      } catch (err) {
        console.log(err);
      }
    },
    /* async create() {
      try {
        await ProdutosService.post(this.produto);
        this.idProduto = (await filterServices.lastid()).data[0].id;
         this.$toast.success({
          title: "Sucesso",
          message: "Produto cadastrado com sucesso"
        }) 
      } catch (err) {
        console.log(err);
      }
    } */
  },
  computed: {
    formIsValid() {
      return (
        this.produto.produto_code &&
        this.produto.produto_nome &&
        this.produto.produto_nome_rec &&
        this.produto.produto_preco &&
        this.produto.CategoriaId &&
        this.produto.FornecedoreId &&
        this.produto.IvaId
      );
    },
    /*stockIsValid() {
      return this.stock.quantidade;
    },*/
    PVendaIsValid() {
      return this.precos[0].pvenda_preco;
    }
  },
  async mounted() {
    try{
    // Fazer requisicao para pegar todas os fornecedores
    this.FornecedoreId = (await FornecedoresService.index()).data;
    this.IvaId = (await IvaService.index()).data;
    this.CategoriaId = (await CategoriasService.index()).data;
    this.PVendaId = (await PVendaServices.index()).data;
    this.barcode = (await CBarraService.index()).data;
    }catch (error) {
      if (!error.response) {
        // network error
        this.meuloading = false
        this.snackbarnorow = true
      }
    }
  }
};
</script>

<style scoped>
.meutitulo {
  text-transform: uppercase;
  font-size: 2.6em;
  text-align: center
}
.centarlizar{
  text-align: center;
  margin: 0 auto;
}
.textbutton{
  letter-spacing: 2px;
}
</style>