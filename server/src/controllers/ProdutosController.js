const { Produtos, Fornecedores, Categorias, Iva, Stock, PVenda } = require('../models')
module.exports = {
  async index (req, res) {
    try {
      const produtos = await Produtos.findAll({
        include: [
          { model: Fornecedores, required: true },
          { model: Categorias, required: true },
          { model: Iva, required: true },
          { model: Stock, required: true, order: [ ['quantidade', 'ASC'] ] },
          { model: PVenda, required: true, order: [ ['id', 'ASC'] ] }
        ],
        order: [ ['id', 'DESC'] ]
      })
      res.send(produtos)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar os produtos', err
      })
    }
  },
  async indexByCat (req, res) {
    const { CategoriaId } = req.query
    try {
      const produtos = await Produtos.findAll({
        include: [
          { model: Fornecedores, required: true },
          { model: Categorias, required: true },
          { model: Iva, required: true },
          { model: Stock, required: true },
          { model: PVenda, required: true, order: [ ['id', 'ASC'] ] }
        ],
        where: {
          CategoriaId: CategoriaId,
          filename: {
            $ne: null
          }
        },
        order: [ ['id', 'DESC'] ]
      })
      res.send(produtos)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar os produtos', err
      })
    }
  },
  async lastid (req, res) {
    try {
      await Produtos.findAll({
      })
      res.send(Produtos)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar os produtos', err
      })
    }
  },
  async post (req, res) {
    try {
      const produtos = await Produtos.create(req.body).then(result => console.log(result.id))
      console.log(produtos)
      res.send(produtos)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar cadastrar produto'
      })
    }
  },
  async put (req, res) {
    try {
      await Produtos.update(req.body, {
        where: {
          id: req.params.produtoId
        }
      })
      res.send(req.body)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar atualizar dados de produto'
      })
    }
  },
  async delete (req, res) {
    try {
      const { produtoId } = req.params
      const produtos = await Produtos.findById(produtoId)
      await produtos.destroy()
      res.send(produtos)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar apagar dados de produto'
      })
    }
  }
}
