import Api from '@/services/Api'

export default {
    lastid () {
        return Api().get('filter')
    },
    bynamecompra ( search ) {
        return Api().get(`filter/${search}`, search)
    },
    bynamevenda ( search ) {
        return Api().get(`filters/${search}`, search)
    },
    bycategory ( search ) {
        return Api().get(`filtercat/${search}`, search)
    }
}