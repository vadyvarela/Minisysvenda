const { CBarra } = require('../models')

module.exports = {
  async index (req, res) {
    try {
      const cbarra = await CBarra.findAll({})
      res.send(cbarra)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar listar código de barra'
      })
    }
  },
  async post (req, res) {
    try {
      const cbarra = await CBarra.create(req.body)
      res.send(cbarra)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar cadastrar c+odigo de barra'
      })
    }
  },
  async put (req, res) {
    try {
      await CBarra.update(req.body, {
        where: {
          id: req.params.cbarraId
        }
      })
      res.send(req.body)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar atualizar código de barra'
      })
    }
  },
  async delete (req, res) {
    try {
      const { cbarraId } = req.params
      const cbarra = await CBarra.findById(cbarraId)
      await cbarra.destroy()
      res.send(cbarra)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar apagar código de barra'
      })
    }
  }
}
