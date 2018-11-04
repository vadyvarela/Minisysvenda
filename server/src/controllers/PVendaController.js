const { PVenda } = require('../models')

module.exports = {
  async index (req, res) {
    try {
      const pvenda = await PVenda.findAll({})
      res.send(pvenda)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar listar preço venda'
      })
    }
  },
  post (req, res) {
    const dados = req.body
    for (var key in dados) {
      if (dados.hasOwnProperty(key)) {
        let value = dados[key]
        try {
          const result = PVenda.create(value) // .then(result => console.log('Last id:', result.id))
          console.log(result)
        } catch (err) {
          res.status(500).send({
            error: 'Um erro ocoreu ao tentar cadastrar preço de venda'
          })
        }
      }
    }
    res.send(dados)
  },
  async put (req, res) {
    const dados = req.body
    for (var key in dados) {
      if (dados.hasOwnProperty(key)) {
        let value = dados[key]
        console.log(value)
        try {
          PVenda.update({ pvenda_preco: value.pvenda_preco, ProdutoId: value.ProdutoId }, { where: { id: value.id } })
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
      const { pvendaId } = req.params
      const pvenda = await PVenda.findById(pvendaId)
      await pvenda.destroy()
      res.send(pvenda)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar apagar preço de venda'
      })
    }
  }
}
