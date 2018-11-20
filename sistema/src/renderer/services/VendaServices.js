import Api from '@/services/Api'

export default {
    index (params) {
        return Api().get(`vendas`, {
            params: params
        })
    },
    lastid () {
        return Api().get('venda')
    },
    indexTotal (params) {
        return Api().get('vend', { 
            params: params 
        })
    },
    byIdVenda ( params ) {
        return Api().get('ven', { 
            params: params 
        })
    },
    post ( venda ) {
        return Api().post('vendas', venda)
    },
    put ( venda ) {
        return Api().put(`vendas`, venda)
    },
    putidpagamento ( venda ) {
        return Api().put('venda', venda)
    },
    delete ( venda ) {
        return Api().delete(`vendas/${venda.id}`, venda)
    }
}