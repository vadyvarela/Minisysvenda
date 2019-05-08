import Api from '@/services/Api'

export default {
    index () {
        return Api().get('compraTotal')
    },
    lastid () {
        return Api().get('compras')
    },
    indexTotal (params) {
        return Api().get('compra', { 
            params: params 
        })
    },
    post ( compra ) {
        return Api().post('compras', compra)
    },
    put ( compra ) {
        return Api().put(`compras/${compra.id}`, compra)
    },
    delete ( compra ) {
        return Api().delete(`compras/${compra.id}`, compra)
    }
}