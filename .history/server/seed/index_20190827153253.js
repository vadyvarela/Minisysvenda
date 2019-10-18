const {
  sequelize,
  User,
  Fornecedores,
  Produtos,
  Cliente,
  Categorias,
  Iva
} = require('../src/models')

const Promise = require('bluebird')
const users = require('./users.json')
const fornecedores = require('./fornecedores.json')
const categorias = require('./categorias.json')
const ivas = require('./iva.json')
const produtos = require('./produtos.json')
const clientes = require('./cliente.json')

sequelize.sync({ force: true })
  .then(async function () {
    await Promise.all(
      users.map(user => {
        User.create(user)
      })
    )

    await Promise.all(
      fornecedores.map(fornecedore => {
        Fornecedores.create(fornecedore)
      })
    )

    await Promise.all(
      categorias.map(categoria => {
        Categorias.create(categoria)
      })
    )

    await Promise.all(
      clientes.map(cliente => {
        Cliente.create(cliente)
      })
    )

    await Promise.all(
      ivas.map(iva => {
        Iva.create(iva)
      })
    )

    await Promise.all(
      produtos.map(produto => {
        Produtos.create(produto)
      })
    )
  })
