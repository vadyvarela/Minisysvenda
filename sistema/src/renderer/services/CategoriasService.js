import Api from '@/services/Api'

export default {
    index () {
        return Api().get('categorias')
    },
    indexImage () {
        return Api().get('categoriasImage')
    },
    post ( categoria ) {
        return Api().post('categorias', categoria)
    },
    put ( categoria ) {
        return Api().put(`categorias`, categoria)
    },
    delete ( categoria ) {
        return Api().delete(`categorias/${categoria.id}`, categoria)
    }
    

}