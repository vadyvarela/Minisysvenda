<template>
    <div>
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
                        Listar produto
                      </v-list-tile-title>
                    </v-list-tile-content>
                  </v-list-tile>
                  <v-list-tile router-link to="categorias">
                    <v-list-tile-action>
                      <v-icon>add</v-icon>
                    </v-list-tile-action>
                    <v-list-tile-content>
                      <v-list-tile-title>
                        Categoria
                      </v-list-tile-title>
                    </v-list-tile-content>
                  </v-list-tile>
                  <v-list-tile router-link to="iva">
                    <v-list-tile-action>
                      <v-icon>add</v-icon>
                    </v-list-tile-action>
                    <v-list-tile-content>
                      <v-list-tile-title>
                        Valores IVA
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
                        <v-list-tile-title> Gestão de Stock </v-list-tile-title>
                      </v-list-tile-title>
                    </v-list-tile-content>
                  </v-list-tile>
                  <v-list-tile router-link to="compras">
                    <v-list-tile-content>
                      <v-list-tile-title>
                        Registar Compra
                      </v-list-tile-title>
                    </v-list-tile-content>
                  </v-list-tile>
                  <v-list-tile router-link to="listacompras">
                    <v-list-tile-content>
                      <v-list-tile-title>
                        Inventário de produtos
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
                        <v-list-tile-title> Vendas </v-list-tile-title>
                      </v-list-tile-title>
                    </v-list-tile-content>
                  </v-list-tile>
                  <v-list-tile router-link to="vendedor">
                    <v-list-tile-content>
                      <v-list-tile-title>
                        Registar Venda
                      </v-list-tile-title>
                    </v-list-tile-content>
                  </v-list-tile>
                  <v-list-tile router-link to="listavendas">
                    <v-list-tile-content>
                      <v-list-tile-title>
                        Listar vendas
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

            <v-list-tile router-link to="relatorios">
              <v-list-tile-action>
                <v-icon>assessment</v-icon>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title> Relatorios </v-list-tile-title>
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
              <img style="margin-right:8px" src="http://minisys.innovatmedialab.com/server/img/portugal.png" alt="MiniSysVenda" width="30" height="30">
              <v-list-tile-title> PORTUGUES</v-list-tile-title>
            </v-list-tile>
          </v-list>
          <v-divider></v-divider>
          <v-list light>
            <v-list-tile v-on:click="switchLocaleCh()">
              <img style="margin-right:8px" src="http://minisys.innovatmedialab.com/server/img/china.png" alt="MiniSysVenda" width="30" height="30">
              <v-list-tile-title> CHINES</v-list-tile-title>
            </v-list-tile>
          </v-list>
        </v-menu>
          <!--<v-btn deep-orange class="deep-orange" v-on:click="switchLocale()"><v-icon>language </v-icon>  {{ displayLocale }}</v-btn>-->
        </v-toolbar>
    </div>
</template>
<script>

import { mapState } from 'vuex'
export default {
  data: () => ({
    dark: false,
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
  props: [
    'title'
  ]
  
}
</script>

