import Api from '@/services/Api'

export default {
    register (credentials) {
        return Api().post('register', credentials)
    },
    login (credentials) {
        return Api().post('login', credentials)
    },
    put ( user ) {
        return Api().put(`usuarios/${user.id}`, user)
    },
    ativar ( user ) {
        return Api().put(`auser/${user.id}`, user)
    },
    inativar ( user ) {
        return Api().put(`inauser/${user.id}`, user)
    },
    putsenha ( credentials ) {
        return Api().put(`usuario`, credentials)
    }
}