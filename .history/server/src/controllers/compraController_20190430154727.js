const { Compra, ListaCompra, Fornecedores, Produtos, User } = require('../models')

module.exports = {
  async index (req, res) {
    try {
      const compra = await Compra.findAll({
        include: [
          { model: Fornecedores },
          { model: ListaCompra, include: [{ model: Produtos }], include: [ { model: User } ] }
        ],
        order: [ ['id', 'DESC'] ]
      })
      res.send(compra)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar dados de venda'
      })
    }
  },
  async lastid (req, res) {
    try {
      const compra = await Compra.findAll({
        limit: 1,
        order: [ ['id', 'DESC'] ]
      })
      res.send(compra)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar ultimo id de compra', err
      })
    }
  },
  async post (req, res) {
    try {
      const compra = await Compra.create(req.body)
      res.send(compra)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar cadastrar compra'
      })
    }
  }
}
