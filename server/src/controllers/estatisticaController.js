const { Stock } = require('../models')

module.exports = {
  async index (req, res) {
    try {
      const stock = await Stock.findAll({})
      res.send(stock)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar valor iva'
      })
    }
  }
}
