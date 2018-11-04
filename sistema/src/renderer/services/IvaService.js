import Api from '@/services/Api'

export default {
    index () {
        return Api().get('iva')
    },
    post ( iva ) {
        return Api().post('iva', iva)
    },
    put ( iva ) {
        return Api().put(`iva/${iva.id}`, iva)
    },
    delete ( iva ) {
        return Api().delete(`iva/${iva.id}`, iva)
    }
}