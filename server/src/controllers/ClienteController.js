const { Cliente } = require('../models')

module.exports = {
  async index (req, res) {
    try {
      const cliente = await Cliente.findAll({})
      res.send(cliente)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar listar cliente'
      })
    }
  },
  async byname (req, res) {
    try {
      const { search } = req.params
      const result = await Cliente.findAll({
        where: {
          $or: [
            'cliente_nome'
          ].map(key => ({
            [key]: search
          }))
        }
      })
      res.send(result)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar os clientes', err
      })
    }
  },
  async post (req, res) {
    try {
      const cliente = await Cliente.create(req.body)
      res.send(cliente)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar cadastrar cliente'
      })
    }
  },
  async put (req, res) {
    try {
      await Cliente.update(req.body, {
        where: {
          id: req.params.clienteId
        }
      })
      res.send(req.body)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar atualizar cliente'
      })
    }
  },
  async delete (req, res) {
    try {
      const { clienteId } = req.params
      const cliente = await Cliente.findById(clienteId)
      await cliente.destroy()
      res.send(cliente)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar apagar cliente'
      })
    }
  }
}
