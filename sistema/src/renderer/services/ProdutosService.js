import Api from '@/services/Api'

export default {
    index () {
        return Api().get('produtos')
    },
    indexByCat (params) {
        return Api().get('produtosByCat', {
            params: params
        })
    },
    lastid () {
        return Api().get('produtos')
    },
    post ( produto ) {
        return Api().post('produtos', produto)
    },
    put ( produto ) {
        // return Api().put(`produtos/${produto.id}`, produto)
        return Api().put(`produtos`, produto)
    },
    delete ( produto ) {
        return Api().delete(`produtos/${produto.id}`, produto)
    }
}