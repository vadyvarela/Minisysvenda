import Api from '@/services/Api'

export default {
    index () {
        return Api().get('usuarios')
    },
    put ( user ) {
        return Api().put(`usuarios/${user.id}`, user)
    },
    delete ( user ) {
        return Api().delete(`usuarios/${user.id}`, user)
    }
}