import Api from '@/services/Api'

export default {
    index () {
        return Api().get('compras')
    },
    lastid () {
        return Api().get('compras')
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