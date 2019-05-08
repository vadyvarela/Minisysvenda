import Api from '@/services/Api'

export default {
    index () {
        return Api().get('listacompras')
    },
    post ( listacompras ) {
        return Api().post('listacompras', listacompras)
    },
    postnewprod ( listacompras ) {
        return Api().post('listacompra', listacompras)
    },
    put ( listacompras ) {
        return Api().put(`listacompras`, listacompras)
    },
    delete ( listacompras ) {
        return Api().delete(`listacompras/${listacompras.id}`, listacompras)
    }
}