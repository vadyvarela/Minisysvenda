const { MeioPagamento } = require('../models')

module.exports = {
  async index (req, res) {
    try {
      const meiopagamento = await MeioPagamento.findAll({})
      res.send(meiopagamento)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar as metodos pagamento'
      })
    }
  },
  async post (req, res) {
    try {
      const meiopagamento = await MeioPagamento.create(req.body)
      res.send(meiopagamento)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar cadastrar metodo pagamento'
      })
    }
  }
}
