import Api from '@/services/Api'

export default {
    index () {
        return Api().get('cbarra')
    },
    post ( cbarra ) {
        return Api().post('cbarra', cbarra)
    },
    put ( cbarra ) {
        return Api().put(`cbarra/${cbarra.id}`, cbarra)
    },
    delete ( cbarra ) {
        return Api().delete(`cbarra/${cbarra.id}`, cbarra)
    }
}