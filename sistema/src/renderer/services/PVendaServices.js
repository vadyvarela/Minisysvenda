import Api from '@/services/Api'

export default {
    index () {
        return Api().get('pvenda')
    },
    post ( pvenda ) {
        return Api().post('pvenda', pvenda)
    },
    put ( precos ) {
        return Api().put(`pvenda/${precos[0].ProdutoId}`, precos)
    },
    delete ( pvenda ) {
        return Api().delete(`pvenda/${pvenda.id}`, pvenda)
    }
}