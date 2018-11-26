const AuthenticationController = require('./controllers/AuthenticationController')
const AuthenticationControllerPolicy = require('./polices/AuthenticationControllerPolicy')
const ProdutosController = require('./controllers/ProdutosController')
const UsuariosController = require('./controllers/UsuariosController')
const FornecedoresController = require('./controllers/FornecedoresController')
const CategoriasController = require('./controllers/CategoriasController')
const IvaController = require('./controllers/IvaController')
const PVendaController = require('./controllers/PVendaController')
const CBarraController = require('./controllers/CBarraController')
const filterController = require('./controllers/filterController')
const stockController = require('./controllers/stockController')
const compraController = require('./controllers/compraController')
const listaCompraController = require('./controllers/listaCompraController')
const vendaController = require('./controllers/vendaController')
const listaVendaController = require('./controllers/listaVendaController')
const metodoPagamentoController = require('./controllers/metodoPagamentoController')
const ClienteController = require('./controllers/ClienteController')

module.exports = (app) => {
  // Rotas Efetuar Login
  app.post('/login',
    AuthenticationController.login)

  // Rotas criar usuarios e registrar
  app.get('/usuarios',
    UsuariosController.index)
  app.post('/register',
    AuthenticationControllerPolicy.register,
    AuthenticationController.register)
  app.put('/usuarios/:userId',
    AuthenticationControllerPolicy.register,
    AuthenticationController.put)
  app.delete('/usuarios/:userId',
    UsuariosController.delete)

  // Rotas criar clientes e registrar
  app.get('/clientes',
    ClienteController.index)
  app.get('/cliente',
    ClienteController.lastid)
  app.get('/cliente/:search',
    ClienteController.byname)
  app.post('/clientes',
    ClienteController.post)
  app.put('/clientes/:clienteId',
    ClienteController.put)
  app.delete('/clientes/:clienteId',
    ClienteController.delete)

  // Rotas produtos
  app.get('/produtos',
    ProdutosController.index)
  app.post('/produtos',
    ProdutosController.post)
  app.put('/produtos/:produtoId',
    ProdutosController.put)
  app.delete('/produtos/:produtoId',
    ProdutosController.delete)

  // Rotas fornecedores
  app.get('/fornecedores',
    FornecedoresController.index)
  app.post('/fornecedores',
    FornecedoresController.post)
  app.put('/fornecedores/:fornecedorId',
    FornecedoresController.put)
  app.delete('/fornecedores/:fornecedorId',
    FornecedoresController.delete)

  // Rotas categorias
  app.get('/categorias',
    CategoriasController.index)
  app.post('/categorias',
    CategoriasController.post)
  app.put('/categorias/:categoriaId',
    CategoriasController.put)
  app.delete('/categorias/:categoriaId',
    CategoriasController.delete)

  // Rotas IVA
  app.get('/iva',
    IvaController.index)
  app.post('/iva',
    IvaController.post)
  app.put('/iva/:ivaId',
    IvaController.put)
  app.delete('/iva/:ivaId',
    IvaController.delete)

  // Rotas Preco de venda
  app.get('/pvenda',
    PVendaController.index)
  app.post('/pvenda',
    PVendaController.post)
  app.put('/pvenda/:pvendaId',
    PVendaController.put)
  app.delete('/pvenda/:pvendaId',
    PVendaController.delete)

  // Rotas codigo de barra
  app.get('/cbarra',
    CBarraController.index)
  app.post('/cbarra',
    CBarraController.post)
  app.put('/cbarra/:cbarraId',
    CBarraController.put)
  app.delete('/cbarra/:cbarraId',
    CBarraController.delete)

  // Rotas Pesquisa
  app.get('/filter',
    filterController.lastid)
  app.get('/filter/:search',
    filterController.bynamecompra)
  app.get('/filters/:search',
    filterController.bynamevenda)
  app.get('/filtercat/:search',
    filterController.bycategory)

  // Rotas Compras
  app.get('/compras',
    compraController.lastid)
  app.post('/compras',
    compraController.post)

  // Rotas Lista Compras
  app.get('/listacompras',
    listaCompraController.index)
  app.post('/listacompras',
    listaCompraController.post)

  // Rotas Lista Metodo pagamento
  app.get('/metodopagamento',
    metodoPagamentoController.index)
  app.post('/metodopagamento',
    metodoPagamentoController.post)

  // Rotas Vendas
  app.get('/vendas',
    vendaController.index)
  app.get('/vend',
    vendaController.indexTotal)
  app.get('/ven',
    vendaController.byIdVenda)
  app.get('/venda',
    vendaController.lastid)
  app.post('/vendas',
    vendaController.post)
  app.put('/vendas',
    vendaController.put)
  app.put('/venda',
    vendaController.putidpagamento)

  // Rotas Lista Vendas
  app.get('/listavendas',
    listaVendaController.index)
  app.get('/listavenda',
    listaVendaController.pmaisvendido)
  app.post('/listavendas',
    listaVendaController.post)
  app.post('/listavenda',
    listaVendaController.postnewprod)
  app.delete('/listavendas/:listavendasId',
    listaVendaController.delete)

  // Rotas Stock
  app.get('/stock',
    stockController.index)
  app.post('/stock',
    stockController.post)
  app.put('/stock',
    stockController.putcompras)
  app.put('/stoc',
    stockController.putstockvenda)
  app.put('/sto',
    stockController.putstockaddremove)
  app.put('/stocks',
    stockController.putvendas)
  app.delete('/stock/:stockId',
    stockController.delete)
}
