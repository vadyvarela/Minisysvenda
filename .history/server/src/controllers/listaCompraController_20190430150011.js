const { ListaCompra, Produtos, Compra, Fornecedores, User } = require('../models')

module.exports = {
  async index (req, res) {
    try {
      const listacompra = await ListaCompra.findAll({
        include: [
          { model: Produtos, required: true },
          { model: Compra, include: [ { model: Fornecedores, include: [ { model: User } ] } ] }
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
  }
}
