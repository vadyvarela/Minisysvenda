import Api from '@/services/Api'

export default {
    index () {
        return Api().get('categorias')
    },
    post ( categoria ) {
        return Api().post('categorias', categoria)
    },
    put ( categoria ) {
        return Api().put(`categorias/${categoria.id}`, categoria)
    },
    delete ( categoria ) {
        return Api().delete(`categorias/${categoria.id}`, categoria)
    }
    

}