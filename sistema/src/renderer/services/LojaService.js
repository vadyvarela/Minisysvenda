import Api from '@/services/Api'

export default {
    index () {
        return Api().get('loja')
    },
    lastid () {
        return Api().get('lojas')
    },
    post ( loja ) {
        return Api().post('loja', loja)
    },
    put ( loja ) {
        return Api().put(`loja/${loja.id}`, loja)
    },
    delete ( loja ) {
        return Api().delete(`loja/${loja.id}`, loja)
    }
}