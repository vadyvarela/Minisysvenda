const { ListaVenda, Produtos, Sequelize } = require('../models')

module.exports = {
  async index (req, res) {
    try {
      const listavenda = await ListaVenda.findAll({
        include: [
          { model: Produtos, required: true }
        ],
        order: [ ['id', 'DESC'] ]
      })
      res.send(listavenda)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar dados da lista de venda'
      })
    }
  },
  async pmaisvendido (req, res) {
    try {
      const listavenda = await ListaVenda.findAll({
        include: [
          { model: Produtos, required: true }
        ],
        attributes: [
          [Sequelize.literal('COUNT(ProdutoId)'), 'quantidade']
        ],
        group: 'produto_nome'
      })
      res.send(listavenda)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar ultimo id de venda', err
      })
    }
  },
  post (req, res) {
    const dados = req.body
    for (var key in dados) {
      if (dados.hasOwnProperty(key)) {
        let value = dados[key]
        try {
          ListaVenda.create(value)
        } catch (err) {
          res.status(500).send({
            error: 'Um erro ocoreu ao tentar cadastrar lista de vendas'
          })
        }
      }
    }
    res.send(dados)
  }
}
