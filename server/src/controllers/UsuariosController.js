const { User } = require('../models')

module.exports = {
  async index (req, res) {
    try {
      const user = await User.findAll({})
      res.send(user)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar os Usuarios'
      })
    }
  },
  async delete (req, res) {
    try {
      const { userId } = req.params
      const user = await User.findById(userId)
      await user.destroy()
      res.send(user)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar apagar dados do usuario'
      })
    }
  }
}
