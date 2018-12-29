import Api from '@/services/Api'

export default {
    total () {
        return Api().get(`vendasTotal`)
    },
    index (params) {
        return Api().get(`vendas`, {
            params: params
        })
    },
    hoje (params) {
        return Api().get(`vendashoje`, {
            params: params
        })
    },
    lastid () {
        return Api().get('venda')
    },
    DadosGeral (params) {
        return Api().get('vendT', { 
            params: params 
        })
    },
    indexTotal (params) {
        return Api().get('vend', { 
            params: params 
        })
    },
    byVendedor (params) {
        return Api().get('vendPorVendedor', { 
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
    // Fitro por datas
    semanal () {
        return Api().get('vendasemanal')
    },
    diario () {
        return Api().get('vendadiario')
    },
    mensal () {
        return Api().get('vendamensal')
    },
    trimestral () {
        return Api().get('vendatrimestral')
    },
}