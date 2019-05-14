import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'login',
      component: require('@/components/Login').default
    },
    {
      path: '/registrarLoja',
      name: 'registrarLoja',
      component: require('@/components/Registro').default
    },
    {
      path: '/register',
      name: 'register',
      component: require('@/components/Registrar').default
    },
    {
      path: '/dashboard',
      name: 'dashboard',
      component: require('@/components/Dashboard').default
    },
    {
      path: '/vendedor',
      name: 'vendedor',
      component: require('@/components/Vendedor').default
    },
    {
      path: '/produtos',
      name: 'produtos',
      component: require('@/components/Produtos').default
    },
    {
      path: '/createProdutos',
      name: 'createProdutos',
      component: require('@/components/createProduto').default
    },
    {
      path: '/usuarios',
      name: 'usuarios',
      component: require('@/components/Usuarios').default
    },
    {
      path: '/cadCategorias',
      name: 'cadCategorias',
      component: require('@/components/createCategorias').default
    },
    {
      path: '/categorias',
      name: 'categorias',
      component: require('@/components/Categorias').default
    },
    {
      path: '/cadIva',
      name: 'cadIva',
      component: require('@/components/createIva').default
    },
    {
      path: '/iva',
      name: 'iva',
      component: require('@/components/Iva').default
    },
    {
      path: '/cadFornecedores',
      name: 'cadFornecedores',
      component: require('@/components/createFornecedores').default
    },
    {
      path: '/fornecedores',
      name: 'fornecedores',
      component: require('@/components/Fornecedores').default
    },
    {
      path: '/pvenda',
      name: 'pvenda',
      component: require('@/components/PVenda').default
    },
    {
      path: '/cadPVenda',
      name: 'cadPVenda',
      component: require('@/components/createPrecoVenda').default
    },
    {
      path: '/relatorios',
      name: 'relatorios',
      component: require('@/components/Relatorios').default
    },
    {
      path: '/cbarra',
      name: 'cbarra',
      component: require('@/components/CBarra').default
    },
    {
      path: '/cadCBarra',
      name: 'cadCBarra',
      component: require('@/components/createCBarra').default
    },
    {
      path: '/compras',
      name: 'compras',
      component: require('@/components/createCompra').default
    },
    {
      path: '/listacompras',
      name: 'listacompras',
      component: require('@/components/ListaCompra').default
    },
    {
      path: '/listarcompras',
      name: 'listarcompras',
      component: require('@/components/ListarCompras').default
    },
    {
      path: '/listavendas',
      name: 'listavendas',
      component: require('@/components/ListaVenda').default
    },
    {
      path: '/clientes',
      name: 'clientes',
      component: require('@/components/Clientes').default
    },
    /*{
      path: '/cadCliente',
      name: 'cadCliente',
      component: require('@/components/ListaCliente').default
    },*/
    {
      path: '/vendas',
      name: 'vendas',
      component: require('@/components/createVenda').default
    },
    {
      path: '*',
      redirect: '/'
    }
  ]
})
