<template>
<div>

 <div v-if="isOnline">
    <div v-if="user.nivel == 1">
      <v-navigation-drawer fixed v-model="drawer" :dark="dark" app>
          <v-toolbar flat class="transparent">
            <v-list class="pa-0">
              <v-list-tile avatar>
                <v-list-tile-avatar>
                  <v-icon>account_circle</v-icon>
                </v-list-tile-avatar>
                <v-list-tile-content>
                  <v-list-tile-title class="text-uppercase font-weight-bold" > {{ user.usuario }} </v-list-tile-title>
                </v-list-tile-content>
              </v-list-tile>
            </v-list>
          </v-toolbar>
          <v-divider></v-divider>
          <v-list dense>
            <v-list-tile router-link to="dashboard">
              <v-list-tile-action>
                <v-icon>dashboard</v-icon>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>{{ $t("message.dashboard") }}</v-list-tile-title>
              </v-list-tile-content>
            </v-list-tile>

            <v-list dense>
              <template>
                <v-list-group>
                  <v-list-tile slot="activator">
                    <v-list-tile-action>
                      <v-icon>folder_open</v-icon>
                    </v-list-tile-action>
                    <v-list-tile-content>
                      <v-list-tile-title>
                        {{ $t("message.produtos") }}
                      </v-list-tile-title>
                    </v-list-tile-content>
                  </v-list-tile>
                  <v-list-tile router-link to="createProdutos">
                    <v-list-tile-action>
                      <v-icon>add</v-icon>
                    </v-list-tile-action>
                    <v-list-tile-content>
                      <v-list-tile-title>
                        {{ $t("message.btnNovoProduto") }}
                      </v-list-tile-title>
                    </v-list-tile-content>
                  </v-list-tile>
                  <v-list-tile router-link to="produtos">
                    <v-list-tile-action>
                      <v-icon>add</v-icon>
                    </v-list-tile-action>
                    <v-list-tile-content>
                      <v-list-tile-title>
                        {{ $t("message.listaproduto") }}
                      </v-list-tile-title>
                    </v-list-tile-content>
                  </v-list-tile>
                  <v-list-tile router-link to="categorias">
                    <v-list-tile-action>
                      <v-icon>add</v-icon>
                    </v-list-tile-action>
                    <v-list-tile-content>
                      <v-list-tile-title>
                        {{ $t("message.Categoria") }}
                      </v-list-tile-title>
                    </v-list-tile-content>
                  </v-list-tile>
                  <v-list-tile router-link to="iva">
                    <v-list-tile-action>
                      <v-icon>add</v-icon>
                    </v-list-tile-action>
                    <v-list-tile-content>
                      <v-list-tile-title>
                        {{ $t("message.valorIva") }}
                      </v-list-tile-title>
                    </v-list-tile-content>
                  </v-list-tile>
                </v-list-group>
              </template>
            </v-list>

            <v-list dense>
              <template>
                <v-list-group>
                  <v-list-tile slot="activator">
                    <v-list-tile-action>
                      <v-icon>add</v-icon>
                    </v-list-tile-action>
                    <v-list-tile-content>
                      <v-list-tile-title>
                        <v-list-tile-title> {{ $t("message.gstock") }} </v-list-tile-title>
                      </v-list-tile-title>
                    </v-list-tile-content>
                  </v-list-tile>
                  <v-list-tile router-link to="compras">
                    <v-list-tile-content>
                      <v-list-tile-title>
                        {{ $t("message.regCompra") }}
                      </v-list-tile-title>
                    </v-list-tile-content>
                  </v-list-tile>
                  <v-list-tile router-link to="listarcompras">
                    <v-list-tile-content>
                      <v-list-tile-title>
                        Listar Compras
                      </v-list-tile-title>
                    </v-list-tile-content>
                  </v-list-tile>
                  <v-list-tile router-link to="listacompras">
                    <v-list-tile-content>
                      <v-list-tile-title>
                        {{ $t("message.inventarioProd") }}
                      </v-list-tile-title>
                    </v-list-tile-content>
                  </v-list-tile>
                </v-list-group>
              </template>
            </v-list>

            <v-list dense>
              <template>
                <v-list-group>
                  <v-list-tile slot="activator">
                    <v-list-tile-action>
                      <v-icon>add</v-icon>
                    </v-list-tile-action>
                    <v-list-tile-content>
                      <v-list-tile-title>
                        <v-list-tile-title> {{ $t("message.vendas") }} </v-list-tile-title>
                      </v-list-tile-title>
                    </v-list-tile-content>
                  </v-list-tile>
                  <v-list-tile router-link to="vendedor">
                    <v-list-tile-content>
                      <v-list-tile-title>
                        {{ $t("message.registrarvendas") }}
                      </v-list-tile-title>
                    </v-list-tile-content>
                  </v-list-tile>
                  <v-list-tile router-link to="listavendas">
                    <v-list-tile-content>
                      <v-list-tile-title>
                        {{ $t("message.listavendas") }}
                      </v-list-tile-title>
                    </v-list-tile-content>
                  </v-list-tile>
                  <v-list-tile router-link to="fechodiario">
                    <v-list-tile-content>
                      <v-list-tile-title>
                        Fecho Diário
                      </v-list-tile-title>
                    </v-list-tile-content>
                  </v-list-tile>
                </v-list-group>
              </template>
            </v-list>

            <v-list dense>
              <template>
                <v-list-group>
                  <v-list-tile slot="activator">
                    <v-list-tile-action>
                      <v-icon>assessment</v-icon>
                    </v-list-tile-action>
                    <v-list-tile-content>
                      <v-list-tile-title>
                        <v-list-tile-title> Relatórios </v-list-tile-title>
                      </v-list-tile-title>
                    </v-list-tile-content>
                  </v-list-tile>
                  <v-list-tile router-link to="relatorios">
                    <v-list-tile-content>
                      <v-list-tile-title>
                        Relatórios IVA
                      </v-list-tile-title>
                    </v-list-tile-content>
                  </v-list-tile>
                </v-list-group>
              </template>
            </v-list>

            <v-list-tile router-link to="fornecedores">
              <v-list-tile-action>
                <v-icon>people_outline</v-icon>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>{{ $t("message.fornecedores") }}</v-list-tile-title>
              </v-list-tile-content>
            </v-list-tile>

            <v-list-tile router-link to="clientes">
              <v-list-tile-action>
                <v-icon>people</v-icon>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title> Clientes </v-list-tile-title>
              </v-list-tile-content>
            </v-list-tile>
            
            <v-list-tile router-link to="usuarios">
              <v-list-tile-action>
                <v-icon>account_circle</v-icon>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title> {{ $t("message.usuarios") }}</v-list-tile-title>
              </v-list-tile-content>
            </v-list-tile>
            <v-list-tile @click="logout">
              <v-list-tile-action>
                <v-icon>exit_to_app</v-icon>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title> {{ $t("message.sair") }}</v-list-tile-title>
              </v-list-tile-content>
            </v-list-tile>
            <v-divider></v-divider>
            <v-list-tile class="pt-4">
              <v-list-tile-content>

              <v-switch
                :label="(!dark ? 'Light' : 'Dark') + ' Theme'"
                v-model="dark"
                :dark="dark"
                hide-details
              ></v-switch>
              </v-list-tile-content>
            </v-list-tile>
          </v-list>
        </v-navigation-drawer>
      <v-toolbar color="primary" dark fixed app>
          <v-toolbar-side-icon @click.stop="drawer = !drawer"></v-toolbar-side-icon>
          <v-toolbar-title> {{ title }}</v-toolbar-title>
          <v-spacer></v-spacer>
          <v-menu offset-y>
          <v-btn
            fab
            small
            outline
            slot="activator"
          >
            <v-icon>language</v-icon>
          </v-btn>
          <v-list light>
            <v-list-tile v-on:click="switchLocalePt()">
              <img style="margin-right:8px" src="/static/portugal.png" alt="MiniSysVenda" width="30" height="30">
              <v-list-tile-title> PORTUGUES</v-list-tile-title>
            </v-list-tile>
          </v-list>
          <v-divider></v-divider>
          <v-list light>
            <v-list-tile v-on:click="switchLocaleCh()">
              <img style="margin-right:8px" src="/static/china.png" alt="MiniSysVenda" width="30" height="30">
              <v-list-tile-title> CHINES</v-list-tile-title>
            </v-list-tile>
          </v-list>
        </v-menu>
          <!--<v-btn deep-orange class="deep-orange" v-on:click="switchLocale()"><v-icon>language </v-icon>  {{ displayLocale }}</v-btn>-->
        </v-toolbar>
    </div>

    <div v-if="user.nivel == 2">
      <vendedor/>
    </div>

    <div class="pl-4 pr-4 pt-2 pb-2">
      <slot>
        No slot content defined.
      </slot>
    </div>
  </div> 
  <div v-if="isOffline" >
    <conexao/>
  </div>

</div>
</template>

<script>
import Vendedor from "@/components/componentes/Vendedor";
import Admin from "@/components/componentes/Admin";
import Conexao from "@/components/componentes/Conexao";
import { mapState } from 'vuex'
export default {
  components: {
    Vendedor,
    Admin,
    Conexao
  },
  data: () => ({
    dark: true,
    errors: null,
    isDark: false,
    drawer: false,
  }),
  methods: {
    switchLocale () {
      if (this.$i18n.locale === 'pt') {
        this.$i18n.locale = 'en'
      } else if (this.$i18n.locale === 'en') {
        this.$i18n.locale = 'ch'
      } else {
        this.$i18n.locale = 'pt'
      }
    },
    switchLocalePt () {
      this.$i18n.locale = 'pt'
    },
    switchLocaleCh () {
      this.$i18n.locale = 'ch'
    },
    logout () {
      this.$store.dispatch('setToken', null)
      this.$store.dispatch('setUser', null)
      //TODO: redirect to login page
      this.$router.push({
        name: 'login'
      })
    }
  },
  computed: {
    networkStatus () {
        return this.isOnline ? 'My network is fine' : 'I am offline'
    },
    ...mapState([
      'isUserLoggedIn',
      'user'
    ]),
    displayLocale () {
      let other = 'Portugues'
      if (this.$i18n.locale === 'pt') {
        other = 'Ingles'
      } else if (this.$i18n.locale === 'en') {
        other = 'Chines'
      }
      return other
    }
  },
  async mounted() {
    this.errors.record(error.response);
    console.log("ERRO" + this.errors)
  },
  props: [
    'title'
  ]
  
}
</script>

<style scoped>
.v-list>div {
    padding: 5px !important;
}
.v-list--dense .v-list__tile:not(.v-list__tile--avatar) {
  height: 60px !important;
}
.v-list__tile__title {
    font-size: 1.2em !important;
}
.v-list__group__items>div {
    display: block;
    padding: 7px !important;
}
</style>

