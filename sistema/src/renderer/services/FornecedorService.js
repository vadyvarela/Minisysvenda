import Api from '@/services/Api'

export default {
    index () {
        return Api().get('fornecedores')
    },
    post ( fornecedor ) {
        return Api().post('fornecedores', fornecedor)
    },
    put ( fornecedor ) {
        return Api().put(`fornecedores/${fornecedor.id}`, fornecedor)
    },
    delete ( fornecedor ) {
        return Api().delete(`fornecedores/${fornecedor.id}`, fornecedor)
    }
    

}