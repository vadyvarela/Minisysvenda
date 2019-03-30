const { Iva } = require('../models')

module.exports = {
  async index (req, res) {
    try {
      const iva = await Iva.findAll({})
      res.send(iva)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar valor iva'
      })
    }
  },
  async post (req, res) {
    try {
      const iva = await Iva.findOrCreate({
        where: {
          iva_valor: req.body.iva_valor
        },
        defaults: {
          iva_valor: req.body.iva_valor,
          iva_desc: req.body.iva_desc
        }
      })
      res.send(iva)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar cadastrar valor do iva'
      })
    }
  },
  async put (req, res) {
    try {
      await Iva.update(req.body, {
        where: {
          id: req.params.ivaId
        }
      })
      res.send(req.body)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar atualizar valor do iva'
      })
    }
  },
  async delete (req, res) {
    try {
      const { ivaId } = req.params
      const iva = await Iva.findById(ivaId)
      await iva.destroy()
      res.send(iva)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar apagar valor do iva'
      })
    }
  }
}
