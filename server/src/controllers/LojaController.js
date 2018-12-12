const { Loja } = require('../models')
module.exports = {
  async index (req, res) {
    try {
      const loja = await Loja.findAll({
        order: [ ['id', 'DESC'] ]
      })
      res.send(loja)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar lojas', err
      })
    }
  },
  async lastid (req, res) {
    try {
      const loja = await Loja.findAll({
        limit: 1,
        order: [ ['id', 'DESC'] ]
      })
      res.send(loja)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar os ultimo loja cadastrado', err
      })
    }
  },
  async post (req, res) {
    try {
      const loja = await Loja.create(req.body)
      res.send(loja)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar cadastrar loja'
      })
    }
  },
  async put (req, res) {
    try {
      await Loja.update(req.body, {
        where: {
          id: req.params.lojaId
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
      const { lojaId } = req.params
      const loja = await Loja.findById(lojaId)
      await loja.destroy()
      res.send(loja)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar apagar dados de produto'
      })
    }
  }
}
