<template>
    <panel title="LISTA DE COMPRAS">
      <v-content>
      <v-container>
            <v-snackbar
              v-model="snackbar" :color="color"
              :multi-line="mode === 'multi-line'"
              :timeout="timeout"
              :vertical="mode === 'vertical'"
            >
              {{ text }}
              <v-btn dark flat @click="snackbar = false">Fechar</v-btn>
            </v-snackbar>
            
            <v-dialog v-model="dialog" persistent fullscreen hide-overlay transition="dialog-bottom-transition">
              <v-card>
                <v-toolbar dark color="primary">
                  <v-btn icon dark @click.native="dialog = false">
                    <v-icon>close</v-icon>
                  </v-btn>
                  <v-toolbar-title>Atualizar dados compra</v-toolbar-title>
                  <v-spacer></v-spacer>
                  <v-toolbar-items>
                    <v-btn dark flat @click="sendFile">Salvar</v-btn>
                  </v-toolbar-items>
                </v-toolbar>
                <v-card-text>

                  <v-stepper v-model="e1">
                  <v-stepper-header>
                    <v-stepper-step editable :complete="e1 > 1" step="1"> {{ $t('message.dadosProduto') }} </v-stepper-step>
                    <v-divider></v-divider>
                    <v-stepper-step editable :complete="e1 > 2" step="2"> {{ $t('message.precodevenda') }} </v-stepper-step>
                    <v-divider></v-divider>
                  </v-stepper-header>

                  <v-stepper-items>
                  <v-stepper-content step="1">
                  <v-container grid-list-md>
                  <v-layout wrap>
                  <v-flex xs12 sm4 md4>
                    <v-text-field box color="blue" required :rules="codRules" name="produto_code" v-model="produto.produto_code" :label="$t('message.produto_code')" type="text"></v-text-field>
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
                  <v-flex xs12 sm8 md8>
                  <v-text-field box color="blue" required :rules="nomerecRules" name="produto_nome_rec" v-model="produto.produto_nome_rec" :label="$t('message.produto_nome_rec')" type="text"></v-text-field>
                  </v-flex>
                  <v-flex xs12 sm4 md4>
                    <v-text-field box color="blue" required :rules="precocustoRules" name="produto_preco" v-model="produto.produto_preco" :label="$t('message.produto_preco')" type="number"></v-text-field>
                  </v-flex>
                  <v-flex xs12 sm6 md4>
                  <v-select
                    box color="blue"
                    name="FornecedoreId"
                    v-model="produto.FornecedoreId"
                    :items="FornecedoreId"
                    :label="$t('message.fornecedor_nome')"
                    required
                    :rules="fornecRules"
                    item-text="fornecedor_nome"
                    item-value="id"
                  ></v-select>
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
                  <v-select
                    box color="blue"
                    name="CategoriaId"
                    v-model="produto.CategoriaId"
                    :items="CategoriaId"
                    :label="$t('message.categoria_nome')"
                    required
                    :rules="categoriaRules"
                    item-text="categoria_nome"
                    item-value="id"
                  ></v-select>
                  </v-flex>

                  <v-flex xs12 class="text-xs-center text-sm-center text-md-center text-lg-center">
                      <img :src="imageUrl" height="150" v-if="imageUrl"/>
                      <v-text-field label="Select Image" @click='pickFile' v-model='imageName' prepend-icon='attach_file'></v-text-field>
                      <input
                        type="file"
                        ref="file"
                        @change="onFilePicked"
                        style="display: none"
                        name=""
                        accept="image/*"
                      >
                    </v-flex>
                  </v-layout>
                  </v-container>
                  </v-stepper-content>

                  <v-stepper-content step="2">
                  <v-container grid-list-md>
                      <div v-bind:key="index" v-for="(preco, index) in precos.PVendas">
                        <h5>Preco de venda #{{ index }}</h5>
                        <h2 hidden> {{ preco.ProdutoId = idProduto }}</h2>
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
                  </v-stepper-content>
                  </v-stepper-items>
               </v-stepper>
                </v-card-text>
                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn outline right color="red" flat @click.native="dialog = false">Cancelar</v-btn>
                  <v-btn outline :disabled="!valid" color="green" flat @click="sendFile">Salvar dados</v-btn>
                </v-card-actions>
              </v-card>
            </v-dialog>

            <v-layout justify-end row wrap>
                <v-flex text-lg-left xs6>
                  <v-subheader>{{ $t("message.nossosProdutos") }}</v-subheader>
                </v-flex>
                <v-flex text-lg-right xs6>
                  <v-btn :to="{name: 'createProdutos'}" text-lg-right class="primary"> {{ $t("message.btnNovoProduto") }} </v-btn>
                </v-flex>
            </v-layout>
            <v-card-title>
              <v-spacer></v-spacer>
              <v-text-field
                v-model="search"
                append-icon="search"
                label="Pesquisar"
                single-line
                hide-details
                solo
                placeholder="Pesquisar produto"
              ></v-text-field>
            </v-card-title>
           
            <v-data-table
                :headers="headers"
                :items="desserts"
                :search="search"
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
                <tr style="cursor:pointer" @click="editProduto(props.item)">
                <td>{{ props.item.produto_nome }}</td>
                <td class="text-xs-center ">{{ props.item.produto_preco }}</td>
                <td class="text-xs-left">{{ props.item.Compra.Fornecedore.fornecedor_nome }}</td>
                <td class="text-xs-left">{{ props.item.Stock.quantidade }} </td>
               
                </tr>
                </template>
                <template slot="no-data">
                  <p class="noDataLoading"> {{ noDataLoading }} </p>
                </template>
                <v-alert slot="no-results" :value="true" color="error" icon="warning">
                  Sua pesquisa por "{{ search }}" não encontrou nenhum resultados.
                </v-alert>
            </v-data-table>
        </v-container>
      <v-divider></v-divider>
    </v-content>
    </panel>
</template>

<script>
import listaCompraServices from "@/services/listaCompraServices";
import ProdutosService from "@/services/ProdutosService";
import FornecedoresService from "@/services/FornecedorService";
import CategoriasService from "@/services/CategoriasService";
import IvaService from "@/services/IvaService";
import PVendaServices from "@/services/PVendaServices";

export default {
  data() {
    return {
      noDataLoading: 'Carregando os dados aguarde',
      imageName: '',
      imageUrl: '',
      imageFile: '',
      e1: "",
      search: '',
      snackbar: false,
      color: "success",
      mode: "",
      timeout: 6000,
      text: "Produto foi atualizado com sucesso no sistema",
      snackbarnewprice: false,
      textnewprod: "Novos preços de venda adicionado com sucesso no sistema",
      error: null,
      alert: false,
      dialog: false,
      dialogNewPreco: false,
      valid: true,
      codRules: [v => !!v || "Campo código produto é obrigatorio"],
      precovendaRules: [v => !!v || "Campo preço de venda é obrigatorio"],
      nomerecRules: [v => !!v || "Campo nome é obrigatorio"],
      nomeRules: [v => !!v || "Descrisão do produto é obrigatorio"],
      categoriaRules: [v => !!v || "Campo categoria do produto é obrigatorio"],
      ivaRules: [v => !!v || "Campo IVA é obrigatorio"],
      fornecRules: [v => !!v || "Campo fornecedor é obrigatório"],
      precocustoRules: [v => !!v || "Campo preço de custo é obrigatório"],
      quantidadeRules: [v => !!v || "Campo quantidade stock é obrigatório"],
      produto_nome: "",
      produto_preco: "",
      idProduto: [],
      CategoriaId: [],
      IvaId: [],
      FornecedoreId: [],
      produto: {
        produto_nome: null,
        produto_preco: null,
        FornecedoreId: null,
        IvaId: null,
        CategoriaId: null,
      },
      precos: [
        {
          pvenda_preco: "",
          ProdutoId: "",
          total: ''
        }
      ],
      headers: [
        { text: "Nome produto", value: "produto_nome", align: "left", sortable: true },
        { text: "Preço", value: "produto_preco", sortable: true },
        { text: "Fornecedor", sortable: false },
        { text: "Quantidade ", sortable: false }
      ],
      desserts: []
    };
  },
  methods: {
    onFilePicked (e) {
      this.produto.produto_file = this.$refs.file.files[0]
			const files = e.target.files
			if(files[0] !== undefined) {
				this.imageName = files[0].name
				if(this.imageName.lastIndexOf('.') <= 0) {
					return
				}
				const fr = new FileReader ()
				fr.readAsDataURL(files[0])
				fr.addEventListener('load', () => {
					this.imageUrl = fr.result
					this.imageFile = files[0]
				})
			} else {
				this.imageName = ''
				this.imageFile = ''
				this.imageUrl = ''
			}
		},
    pickFile () {
      this.$refs.file.click ()
    },
    editProduto: function(item) {
      this.editedIndex = this.desserts.indexOf(item);
      this.produto = Object.assign({}, item)
      this.precos = Object.assign({}, item)
      this.idProduto = this.produto.id;
      console.log("Preco", this.idProduto)
      this.dialog = true
    },
    async createPrecos() {
      try {
        await PVendaServices.post(this.precos);
        this.dialogNewPreco = false;
        this.snackbarnewprice = true
      } catch (err) {
        console.log(err);
      }
    },
    async sendFile() {
      const formData = new FormData()
      formData.append('file', this.produto.produto_file)
      formData.append('id', this.produto.id)
      formData.append('produto_code', this.produto.produto_code)
      formData.append('produto_nome', this.produto.produto_nome)
      formData.append('produto_nome_rec', this.produto.produto_nome_rec)
      formData.append('produto_preco', this.produto.produto_preco)
      formData.append('produto_barcode', this.produto.produto_barcode)
      formData.append('FornecedoreId', this.produto.FornecedoreId)
      formData.append('IvaId', this.produto.IvaId)
      formData.append('CategoriaId', this.produto.CategoriaId)
      try {
        this.dialog = false;
        await PVendaServices.put(this.precos.PVendas);
        await ProdutosService.put(formData)
        // this.idProduto = (await filterServices.lastid()).data[0].id;
        this.snackbar = true
        this.$router.push({
          name: "produtos"
        });
        Object.assign(this.desserts[this.editedIndex], this.produto);
      } catch (error) {
        this.error = error.response.data.error;
        this.alert = true;
      }
    },
    /*async update() {
        try {
          this.dialog = false;
          console.log(this.produto)
          console.log("Precos", this.precos.PVendas)
          await ProdutosService.put(this.produto);
          await PVendaServices.put(this.precos.PVendas);
          this.snackbar = true
          this.$router.push({
            name: "produtos"
          });
          Object.assign(this.desserts[this.editedIndex], this.produto);
        } catch (err) {
          console.log(err);
        }
    }*/
  },
  async mounted() {
    // Fazer requisicao para pegar todas os produtos
    this.desserts = (await listaCompraServices.index()).data;
    console.log(this.desserts)

    this.FornecedoreId = (await FornecedoresService.index()).data;
    this.IvaId = (await IvaService.index()).data;
    this.CategoriaId = (await CategoriasService.index()).data;
  }
};
</script>

<style lang="css" scoped>
.noDataLoading{
  padding: 30px;
  font-size: 1.2em;
  text-align: center;
  color: #c37f2a;
}
</style>
