const { Fornecedores } = require('../models')

module.exports = {
  async index (req, res) {
    try {
      const fornecedores = await Fornecedores.findAll({})
      res.send(fornecedores)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar os fornecedores'
      })
    }
  },
  async post (req, res) {
    try {
      const fornecedores = await Fornecedores.findOrCreate({
        where: {
          fornecedor_nome: req.body.fornecedor_nome
        },
        defaults: {
          fornecedor_nome: req.body.fornecedor_nome,
          fornecedor_nif: req.body.fornecedor_nif,
          fornecedor_endereco: req.body.fornecedor_endereco,
          fornecedor_movel: req.body.fornecedor_movel
        }
      })
      res.send(fornecedores)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar cadastrar fornecedor'
      })
    }
  },
  async put (req, res) {
    try {
      await Fornecedores.update(req.body, {
        where: {
          id: req.params.fornecedorId
        }
      })
      res.send(req.body)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar atualizar o fornecedor'
      })
    }
  },
  async delete (req, res) {
    try {
      const { fornecedorId } = req.params
      const fornecedor = await Fornecedores.findById(fornecedorId)
      await fornecedor.destroy()
      res.send(fornecedor)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar apagar o fornecedor'
      })
    }
  }
}
