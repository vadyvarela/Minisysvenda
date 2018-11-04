const {
  sequelize,
  User,
  MeioPagamento
  /* Fornecedores,
  Produtos,
  Categorias,
  Iva */
} = require('../src/models')

const Promise = require('bluebird')
const users = require('./users.json')
const meiopagamento = require('./meiopagamento.json')
/* const produtos = require('./produtos.json')
const categorias = require('./categorias.json')
const ivas = require('./iva.json') */

sequelize.sync({ force: true })
  .then(async function () {
    await Promise.all(
      users.map(user => {
        User.create(user)
      })
    )

    await Promise.all(
      meiopagamento.map(meiopagamento => {
        MeioPagamento.create(meiopagamento)
      })
    )

    /* await Promise.all(
      produtos.map(produto => {
        Produtos.create(produto)
      })
    )

    await Promise.all(
      categorias.map(categoria => {
        Categorias.create(categoria)
      })
    )

    await Promise.all(
      ivas.map(iva => {
        Iva.create(iva)
      })
    ) */
  })
