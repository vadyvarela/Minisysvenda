const { Produtos, Fornecedores, Categorias, Iva, Stock, PVenda } = require('../models')
module.exports = {
  async lastid (req, res) {
    try {
      const result = await Produtos.findAll({
        limit: 1,
        order: [ ['id', 'DESC'] ]
      })
      res.send(result)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar os produtos', err
      })
    }
  },
  async bynamecompra (req, res) {
    try {
      const { search } = req.params
      const result = await Produtos.findAll({
        include: [
          { model: Fornecedores, required: true },
          { model: Categorias, required: true },
          { model: Iva, required: true },
          { model: Stock, required: true },
          { model: PVenda }
        ],
        where: {
          $or: [
            'produto_code', 'produto_barcode', 'produto_nome'
          ].map(key => ({
            [key]: search
          }))
        }
      })
      res.send(result)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar os produtos', err
      })
    }
  },
  async bynamevenda (req, res) {
    try {
      const { search } = req.params
      let songs = null
      songs = await Produtos.findAll({
        include: [
          // { model: Fornecedores, required: true },
          // { model: Categorias, required: true },
          { model: Iva, required: true },
          // { model: Stock, required: true },
          { model: PVenda, order: [ ['id', 'ASC'] ] }
        ],
        where: {
          $or: [
            'produto_code', 'produto_barcode', 'produto_nome'
          ].map(key => ({
            [key]: search
          }))
        }
      })
      res.send(result)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar os produtos', err
      })
    }
  },
  async bycategory (req, res) {
    try {
      const { search } = req.params
      const result = await Produtos.findAll({
        include: [
          { model: Fornecedores, required: true },
          { model: Categorias, required: true },
          { model: Iva, required: true },
          { model: Stock, required: true }
        ],
        where: {
          $or: [
            'CategoriaId'
          ].map(key => ({
            [key]: search
          }))
        }
      })
      res.send(result)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar os produtos', err
      })
    }
  }
}
