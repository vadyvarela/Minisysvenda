import Api from '@/services/Api'

export default {
    index () {
        return Api().get('metodopagamento')
    },
    post ( metodopagamento ) {
        return Api().post('metodopagamento', metodopagamento)
    }
}