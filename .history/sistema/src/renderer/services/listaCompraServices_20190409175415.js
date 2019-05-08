import Api from '@/services/Api'

export default {
    index () {
        return Api().get('listacompras')
    },
    post ( listacompras ) {
        return Api().post('listacompras', listacompras)
    },
    put ( listacompras ) {
        return Api().put(`listacompras`, listacompras)
    }
}