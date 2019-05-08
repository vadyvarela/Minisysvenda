import Api from '@/services/Api'

export default {
    index () {
        return Api().get('stock')
    },
    soma () {
        return Api().get('stocks')
    },
    post ( stock ) {
        return Api().post('stock', stock)
    },
    putcompras ( stock ) {
        return Api().put(`stock`, stock)
    },
    putstockvenda ( stock ) {
        return Api().put(`stoc`, stock)
    },
    putstockcompra ( stock ) {
        return Api().put(`stocompra`, stock)
    },
    putstockaddremove ( stock ) {
        return Api().put(`sto`, stock)
    },
    putstockaddremovecompra( stock ) {
        return Api().put(`st`, stock)
    },
    putvendas ( stock ) {
        return Api().put(`stocks`, stock)
    },
    delete ( stock ) {
        return Api().delete(`stock/${stock.id}`, stock)
    }
}