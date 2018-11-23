import Api from '@/services/Api'

export default {
    index () {
        return Api().get('listavendas')
    },
    pmaisvendido () {
        return Api().get('listavenda')
    },
    post ( listavendas ) {
        return Api().post('listavendas', listavendas)
    },
    postnewprod ( listavendas ) {
        return Api().post('listavenda', listavendas)
    },
    put ( listavendas ) {
        return Api().put(`listavendas`, listavendas)
    },
    delete ( listavendas ) {
        return Api().delete(`listavendas/${listavendas.id}`, listavendas)
    }
}