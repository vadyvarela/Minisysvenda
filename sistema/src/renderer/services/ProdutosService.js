import Api from '@/services/Api'

export default {
    index () {
        return Api().get('produtos')
    },
    lastid () {
        return Api().get('produtos')
    },
    post ( produto ) {
        return Api().post('produtos', produto)
    },
    put ( produto ) {
        return Api().put(`produtos/${produto.id}`, produto)
    },
    delete ( produto ) {
        return Api().delete(`produtos/${produto.id}`, produto)
    }
}