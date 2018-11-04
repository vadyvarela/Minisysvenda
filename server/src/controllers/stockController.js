const { Stock, Sequelize } = require('../models')

module.exports = {
  async index (req, res) {
    try {
      const stock = await Stock.findAll({})
      res.send(stock)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar valor iva'
      })
    }
  },
  async post (req, res) {
    try {
      const stock = await Stock.create(req.body)
      res.send(stock)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar cadastrar quantidade no stock'
      })
    }
  },
  putvendas (req, res) {
    const dados = req.body
    for (var key in dados) {
      if (dados.hasOwnProperty(key)) {
        let value = dados[key]
        // console.log(value.quantidade)
        try {
          Stock.update({ quantidade: Sequelize.literal('quantidade -' + value.quantidade) }, { where: { ProdutoId: value.ProdutoId } })
        } catch (err) {
          res.status(500).send({
            error: 'Um erro ocoreu ao tentar update STOCK'
          })
        }
      }
    }
    res.send(dados)
  },
  /* putcompras (req, res) {
    const dados = req.body
    for (var key in dados) {
      if (dados.hasOwnProperty(key)) {
        let value = dados[key]
        // console.log(value.quantidade)
        try {
          Stock.update({ quantidade: Sequelize.literal('quantidade +' + value.quantidade) }, { where: { ProdutoId: value.ProdutoId } })
        } catch (err) {
          res.status(500).send({
            error: 'Um erro ocoreu ao tentar update STOCK'
          })
        }
      }
    }
    res.send(dados)
  }, */
  putcompras (req, res) {
    const dados = req.body
    for (var key in dados) {
      if (dados.hasOwnProperty(key)) {
        let value = dados[key]
        // console.log(value.quantidade)
        try {
          Stock.update({ quantidade: Sequelize.literal('quantidade + ' + value.quantidade) }, { where: { ProdutoId: value.ProdutoId } })
        } catch (err) {
          res.status(500).send({
            error: 'Um erro ocoreu ao tentar update STOCK'
          })
        }
      }
    }
    res.send(dados)
  },
  async delete (req, res) {
    try {
      const { stockId } = req.params
      const stock = await Stock.findById(stockId)
      await stock.destroy()
      res.send(stock)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar apagar valor do iva'
      })
    }
  }
}
