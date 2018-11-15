import Api from '@/services/Api'

export default {
    index () {
        return Api().get('clientes')
    },
    byname ( search ) {
        return Api().get(`cliente/${search}`, search)
    },
    post ( cliente ) {
        return Api().post('clientes', cliente)
    },
    put ( cliente ) {
        return Api().put(`clientes/${cliente.id}`, cliente)
    },
    delete ( cliente ) {
        return Api().delete(`clientes/${cliente.id}`, cliente)
    }
}