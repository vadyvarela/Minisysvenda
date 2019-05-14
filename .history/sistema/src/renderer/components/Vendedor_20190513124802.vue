<template>
    <panel title=""> 
    <v-content>
    <v-container fluid fill-heightgrid-list-md>

      <v-dialog
        v-model="meuloading"
        persistent
        width="300">
        <v-card color="primary" dark>
          <v-card-text>
            Carregando seu ambiente de venda, Aguarde...
            <v-progress-linear
              indeterminate
              color="white"
              class="mb-0"
            ></v-progress-linear>
          </v-card-text>
        </v-card>
      </v-dialog>

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


    <section class="section">
        <p class="time" v-text="currentTime"></p>
        <p class="date" v-text="currentDate"></p>
    </section>

    <section class="margin"></section>

    <v-layout wrap align-center justify-center>
        <v-form ref="form" name="cadastar" autocomplete="off" lazy-validation>
            <v-container grid-list-md>
                <v-layout wrap>
                    
                    <span hidden>{{ venda.data_venda = Date() | moment("DD-MM-YYYY HH:mm:ss") }}</span>
                    <span hidden>{{ venda.UserId = user.id }}</span>
                    <input name="produto_id" v-model="venda.UserId" type="hidden"/>
                    <input name="data_venda" v-model="venda.data_venda" type="hidden"/>
                
                </v-layout>
            </v-container>
        </v-form>
        <v-btn class="primary btnmy meubtn" v-shortkey="['enter']" @shortkey="createVenda()" @click="createVenda()"> {{ $t('message.iniciarVenda') }} </v-btn>
    </v-layout>
    </v-container>
    
    </v-content>
    </panel>
</template>

<script>
// import offline from 'v-offline';
import { mapState } from 'vuex'
import VendaServices from "@/services/VendaServices"
import moment from 'moment'
export default {
    data() {
        return {
            snackbarnorow: false,
            colornorow: 'error',
            textnorow: 'Erro ao ligar a base de dados! Verifica sua conexão com a internet!',
            mode: '',
      timeout: 6000,
            meuloading: false,
            currentTime: null,
            currentDate: null,
            venda: {
                data_venda: '',
                UserId: '',
                status: 'vendido'
            }
        }
    },
    /*components: {
        offline
    },*/
    methods: {
        /* handleConnectivityChange(status) {
            console.log("MEU STATUS NA INTERNET", status);
        }, */
        async createVenda() {
            try{
                this.meuloading = true;
                console.log(this.venda)
                await VendaServices.post(this.venda);
                this.idVenda = (await VendaServices.lastid()).data[0].id;
                console.log("ID: ", this.idVenda)
                this.meuloading = false;
                this.$router.push({
                    name: 'vendas'
                })
            }catch (error) {
                if (!error.response) {
                    this.meuloading = false
                    this.snackbarnorow = true
                }
            }
        },
        updateCurrentTime() {
            this.currentTime = moment().format('LTS');
        }
    },
    created() {
        this.currentTime = moment().format('LTS');
        this.currentDate = moment().format('l'),
        setInterval(() => this.updateCurrentTime(), 1 * 1000);
    },
    computed: {
    ...mapState([
        'user'
    ])
    }
}
</script>

<style>
section.section {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding-top: 15px;
    background: transparent;
}
section.margin {
    padding-top: 70px;
}

h3.is-3, p.date {
    color: rgb(9, 145, 122);
}
h3.is-3, p.time {
    color: rgb(9, 145, 122);
}

h3.is-3:not(:last-child) {
    margin: 0;
    padding: 0;
}

.time {
    font-size: 4em;
}
.date {
    font-size: 1.8em;
}

.meubtn{
    height: 130px !important;
    padding: 25px 140px !important;
    font-size: 3em !important;
    font-weight: bold !important;
    text-transform: uppercase !important;
}

</style>



