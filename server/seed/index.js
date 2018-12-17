const {
  sequelize,
  User,
  MeioPagamento,
  Cliente
  /* Fornecedores,
  Produtos,
  Categorias,
  Iva */
} = require('../src/models')

const Promise = require('bluebird')
const users = require('./users.json')
const cliente = require('./cliente.json')
const meiopagamento = require('./meiopagamento.json')
/* const categorias = require('./categorias.json')
const ivas = require('./iva.json') */

sequelize.sync({ force: true })
  .then(async function () {
    await Promise.all(
      users.map(user => {
        User.create(user)
      })
    )

    await Promise.all(
      cliente.map(cliente => {
        Cliente.create(cliente)
      })
    )

    await Promise.all(
      meiopagamento.map(meiopagamento => {
        MeioPagamento.create(meiopagamento)
      })
    )

    /* await Promise.all(
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
