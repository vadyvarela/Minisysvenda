import Api from '@/services/Api'

export default {
    index () {
        return Api().get('stock')
    },
    post ( stock ) {
        return Api().post('stock', stock)
    },
    putcompras ( stock ) {
        return Api().put(`stock`, stock)
    },
    putvendas ( stock ) {
        return Api().put(`stocks`, stock)
    },
    delete ( stock ) {
        return Api().delete(`stock/${stock.id}`, stock)
    }
}