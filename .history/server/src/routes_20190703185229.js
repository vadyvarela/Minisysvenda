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
const LojaController = require('./controllers/LojaController')
const multer = require('multer')
const path = require('path')
const { Categorias, Produtos, Stock } = require('./models')

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/')
  },
  filename: (req, file, cb) => {
    cb(null, file.fieldname + '-' + Date.now() + '-' + file.originalname)
  }
})

const upload = multer({
  storage,
  limits: { fileSize: 10000000 },
  fileFilter: function (req, file, cb) {
    checkFileType(file, cb)
  }
}).single('file')

const errorType = 'Error: Images Only'
// Verificar tipo arquivo
function checkFileType (file, cb) {
  // Estecao permitidas
  const filetypes = /jpeg|jpg|png/
  // Verificar estencao
  const extname = filetypes.test(path.extname(file.originalname).toLowerCase())
  // Verificar Mimetypes
  const mimetype = filetypes.test(file.mimetype)

  if (mimetype && extname) {
    return cb(null, true)
  } else {
    cb(errorType)
  }
}

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
  app.put('/usersenha/:userId',
    AuthenticationControllerPolicy.register,
    AuthenticationController.putsenha)
  app.put('/auser/:userId',
    AuthenticationController.ativar)
  app.put('/inauser/:userId',
    AuthenticationController.inativar)
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

  // Rotas Lojas
  app.get('/loja',
    LojaController.index)
  app.get('/lojas',
    LojaController.lastid)
  app.post('/loja',
    LojaController.post)
  app.put('/loja/:lojaId',
    LojaController.put)
  app.delete('/loja/:lojaId',
    LojaController.delete)

  // Rotas produtos
  app.get('/produtos',
    ProdutosController.index)
  app.get('/produtosByCat',
    ProdutosController.indexByCat)
  /* app.post('/produtos',
    ProdutosController.post) */
  app.post('/produtos', (req, res) => {
    upload(req, res, (err) => {
      if (err) {
        return res.status(403).send({
          error: err
        })
      } else {
        if (req.file === undefined) {
          try {
            Produtos.findOrCreate({
              where: {
                $or: [ { produto_code: req.body.produto_code }, { produto_nome: req.body.produto_nome } ]
              },
              defaults: {
                produto_code: req.body.produto_code,
                produto_nome: req.body.produto_nome,
                produto_nome_rec: req.body.produto_nome_rec,
                produto_preco: req.body.produto_preco,
                produto_barcode: req.body.produto_barcode,
                FornecedoreId: req.body.FornecedoreId,
                CategoriaId: req.body.CategoriaId,
                IvaId: req.body.IvaId
              }
            }).then(function (result) {
              /* PEGA ULTIMO ID */
              console.log('----------------------- RESULTADO -', result[0].id)
              const stock = Stock.create({
                quantidade: req.body.quantidade,
                ProdutoId: result[0].id
              })
              res.send(stock)
              console.log('DADOS STCOK ==================', stock)
              /* END PEGAR ID ULTIMO */
              var created = result[1]
              if (!created) {
                res.status(200).json({ 'error': '1' })
              }
            })
            // res.send(produtos)
          } catch (err) {
            res.status(500).send({
              error: 'Um erro ocoreu ao tentar cadastrar categoria'
            })
          }
          /* return res.status(403).send({
            error: 'ERRO: Favor selecione uma imagem'
          }) */
        } else {
          try {
            Produtos.findOrCreate({
              where: {
                $or: [ { produto_code: req.body.produto_code }, { produto_nome: req.body.produto_nome } ]
              },
              defaults: {
                produto_code: req.body.produto_code,
                produto_nome: req.body.produto_nome,
                produto_nome_rec: req.body.produto_nome_rec,
                produto_preco: req.body.produto_preco,
                produto_barcode: req.body.produto_barcode,
                FornecedoreId: req.body.FornecedoreId,
                CategoriaId: req.body.CategoriaId,
                IvaId: req.body.IvaId,
                filename: req.file.filename
              }
            }).then(function (result) {
              /* PEGA ULTIMO ID */
              console.log('----------------------- RESULTADO -', result[0].id)
              const stock = Stock.create({
                quantidade: 0,
                ProdutoId: result[0].id
              })
              res.send(stock)
              console.log('DADOS STCOK ==================', stock)
              /* END PEGAR ID ULTIMO */
              var created = result[1]
              if (!created) {
                res.status(200).json({ 'error': '1' })
              }
            })
            // res.send(produtos)
          } catch (err) {
            res.status(500).send({
              error: 'Um erro ocoreu ao tentar cadastrar categoria'
            })
          }
        }
      }
    })
  })
  /* app.put('/produtos/:produtoId',
    ProdutosController.put) */
  app.put('/produtos', (req, res) => {
    upload(req, res, (err) => {
      if (err) {
        return res.status(403).send({
          error: err
        })
      } else {
        if (req.file === undefined) {
          try {
            const produtos = Produtos.update({
              produto_code: req.body.produto_code,
              produto_nome: req.body.produto_nome,
              produto_nome_rec: req.body.produto_nome_rec,
              produto_preco: req.body.produto_preco,
              produto_barcode: req.body.produto_barcode,
              FornecedoreId: req.body.FornecedoreId,
              CategoriaId: req.body.CategoriaId,
              IvaId: req.body.IvaId
            }, { where: { id: req.body.id }
            })
            res.send(produtos)
          } catch (err) {
            res.status(500).send({
              error: 'Um erro ocoreu ao tentar cadastrar categoria'
            })
          }
        } else {
          try {
            const produtos = Produtos.update({
              produto_code: req.body.produto_code,
              produto_nome: req.body.produto_nome,
              produto_nome_rec: req.body.produto_nome_rec,
              produto_preco: req.body.produto_preco,
              produto_barcode: req.body.produto_barcode,
              FornecedoreId: req.body.FornecedoreId,
              CategoriaId: req.body.CategoriaId,
              IvaId: req.body.IvaId,
              filename: req.file.filename
            }, { where: { id: req.body.id }
            })
            res.send(produtos)
          } catch (err) {
            res.status(500).send({
              error: 'Um erro ocoreu ao tentar cadastrar categoria'
            })
          }
        // console.log('IMG ---- ', req.file, req.body)
        }
      }
    })
  })
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
  app.get('/categoriasImage',
    CategoriasController.indexImage)
  app.post('/categorias', (req, res) => {
    upload(req, res, (err) => {
      if (err) {
        return res.status(403).send({
          error: err
        })
      } else {
        if (req.file === undefined) {
          try {
            const categorias = Categorias.findOrCreate({
              where: {
                categoria_nome: req.body.categoria_nome
              },
              defaults: {
                categoria_nome: req.body.categoria_nome,
                categoria_desc: req.body.categoria_desc
              }
            })
            res.send(categorias)
          } catch (err) {
            res.status(500).send({
              error: 'Um erro ocoreu ao tentar cadastrar categoria'
            })
          }
        } else {
          try {
            const categorias = Categorias.findOrCreate({
              where: {
                categoria_nome: req.body.categoria_nome
              },
              defaults: {
                categoria_nome: req.body.categoria_nome,
                categoria_desc: req.body.categoria_desc,
                filename: req.file.filename
              }
            })
            res.send(categorias)
          } catch (err) {
            res.status(500).send({
              error: 'Um erro ocoreu ao tentar cadastrar categoria'
            })
          }
        // console.log('IMG ---- ', req.file, req.body)
        }
      }
    })
  })
  // app.post('/categorias', upload.single('file'), CategoriasController.post)
  /* app.put('/categorias/:categoriaId',
    CategoriasController.put) */
  app.put('/categorias/', (req, res) => {
    upload(req, res, (err) => {
      if (err) {
        return res.status(403).send({
          error: err
        })
      } else {
        if (req.file === undefined) {
          try {
            const categorias = Categorias.update({
              categoria_nome: req.body.categoria_nome,
              categoria_desc: req.body.categoria_desc
            }, { where: { id: req.body.id }
            })
            res.send(categorias)
          } catch (err) {
            res.status(500).send({
              error: 'Um erro ocoreu ao tentar cadastrar categoria'
            })
          }
          /* return res.status(403).send({
            error: 'ERRO: Favor selecione uma imagem'
          }) */
        } else {
          try {
            const categorias = Categorias.update({
              categoria_nome: req.body.categoria_nome,
              categoria_desc: req.body.categoria_desc,
              filename: req.file.filename
            }, { where: { id: req.body.id }
            })
            res.send(categorias)
          } catch (err) {
            res.status(500).send({
              error: 'Um erro ocoreu ao tentar cadastrar categoria'
            })
          }
        // console.log('IMG ---- ', req.file, req.body)
        }
      }
    })
  })
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
  app.get('/compraTotal',
    compraController.index)
  app.get('/compra',
    compraController.indexTotal)
  app.get('/compras',
    compraController.lastid)
  app.post('/compras',
    compraController.post)

  // Rotas Lista Compras
  app.get('/listacompras',
    listaCompraController.index)
  app.post('/listacompras',
    listaCompraController.post)
  app.post('/listacompra',
    listaCompraController.postnewprod)
  app.delete('/listacompras/:listacomprasId',
    listaCompraController.delete)

  // Rotas Lista Metodo pagamento
  app.get('/metodopagamento',
    metodoPagamentoController.index)
  app.post('/metodopagamento',
    metodoPagamentoController.post)

  // Rotas Vendas
  app.get('/vendTotal',
    vendaController.total)
  app.get('/vendas',
    vendaController.index)
  app.get('/vendashoje',
    vendaController.hoje)
  app.get('/vend',
    vendaController.indexTotal)
  app.get('/vendPorVendedor',
    vendaController.byVendedor)
  app.get('/vendT',
    vendaController.DadosGeral)
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
  // Dados relatorios
  app.get('/vendasemanal',
    vendaController.semanal)
  app.get('/vendadiario',
    vendaController.diario)
  app.get('/vendamensal',
    vendaController.mensal)
  app.get('/vendatrimestral',
    vendaController.trimestral)

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
  app.get('/stocks',
    stockController.soma)
  app.post('/stock',
    stockController.post)
  app.put('/stock',
    stockController.putcompras)
  app.put('/stoc',
    stockController.putstockvenda)
  app.put('/stocompra',
    stockController.putstockcompra)
  app.put('/sto',
    stockController.putstockaddremove)
  app.put('/st',
    stockController.putstockaddremovecompra)
  app.put('/stocks',
    stockController.putvendas)
  app.delete('/stock/:stockId',
    stockController.delete)
}
