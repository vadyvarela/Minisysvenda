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
      const fornecedores = await Fornecedores.create(req.body)
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
