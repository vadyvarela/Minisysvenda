<template>
<div>
    <v-content>
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
    </v-content>
</div>
</template>

<script>
export default {
  data() {
    return {
      snackbarnorow: false,
      colornorow: 'error',
      textnorow: 'Erro ao ligar a base de dados! Verifica sua conexão com a internet!',
      mode: '',
      timeout: 6000,
    };
  },
  methods: {
    
  }
};
</script>

