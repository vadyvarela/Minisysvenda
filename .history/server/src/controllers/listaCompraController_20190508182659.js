const { ListaCompra, Produtos, Compra, Stock, Sequelize, Fornecedores } = require('../models')

module.exports = {
  async index (req, res) {
    try {
      const listacompra = await ListaCompra.findAll({
        include: [
          { model: Produtos, required: true },
          { model: Compra, include: [ { model: Fornecedores } ] }
        ],
        order: [ ['id', 'DESC'] ]
      })
      res.send(listacompra)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar dados da lista de compra'
      })
    }
  },
  post (req, res) {
    const dados = req.body
    for (var key in dados) {
      if (dados.hasOwnProperty(key)) {
        let value = dados[key]
        try {
          ListaCompra.create(value)
        } catch (err) {
          res.status(500).send({
            error: 'Um erro ocoreu ao tentar cadastrar lista de compras'
          })
        }
      }
    }
    res.send(dados)
  },

  // Novos produtos adicionado ao editar compra
  postnewprod (req, res) {
    const dados = req.body
    for (var key in dados) {
      let value = dados[key]
      if (value.idSearch == null) {
        console.log('PARA CADASTRAR - ')
        for (var index in dados) {
          if (dados.hasOwnProperty(index)) {
            let value = dados[index]
            if (value.idSearch === null) {
              try {
                Stock.update({ quantidade: Sequelize.literal('quantidade -' + value.quantidade) }, { where: { ProdutoId: value.ProdutoId } })
              } catch (err) {
                res.status(500).send({
                  error: 'Um erro ocoreu ao tentar update STOCK'
                })
              }
            } else {
              console.log('Nao podem ser atualizados - ')
            }
          }
        }
        try {
          console.log(value)
          ListaCompra.create(value)
        } catch (err) {
          res.status(500).send({
            error: 'Um erro ocoreu ao tentar cadastrar lista de vendas'
          })
        }
      } else {
        console.log('JA CADASTRADO - ')
      }
    }
    res.send(dados)
  },

  async delete (req, res) {
    try {
      const { listacomprasId } = req.params
      console.log('MEUS DADOS - ', req.params)
      const listacompra = await ListaCompra.findById(listacomprasId)
      await listacompra.destroy()
      res.send(listacompra)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar apagar Item da lista de compra'
      })
    }
  }
}
