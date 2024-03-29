const { User } = require('../models')
const jwt = require('jsonwebtoken')
const config = require('../config/config')

function jwtSignUser (user) {
  const ONE_WEEK = 60 * 60 * 24 * 7
  return jwt.sign(user, config.authentication.jwtSecret, {
    expiresIn: ONE_WEEK
  })
}

module.exports = {
  async register (req, res) {
    try {
      const user = await User.create(req.body)
      console.log('=======================================', user)
      const userJson = user.toJSON()
      console.log('»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»', userJson)
      res.send({
        user: userJson,
        token: jwtSignUser(userJson)
      })
    } catch (err) {
      res.status(400).send({
        error: 'Esse usuario ja se encontra cadastrado no nosso sistema.'
      })
    }
  },
  putsenha (req, res) {
    const dados = req.body
    try {
      User.update({
        nome: dados.nome,
        usuario: dados.usuario,
        password: dados.password
      }, { where: { id: req.params.userId }, individualHooks: true })
      res.send(req.body)
    } catch (err) {
      res.status(500).send({
        error: err + 'Um erro ocoreu ao tentar atualizar dados do usuario'
      })
    }
  },
  async put (req, res) {
    try {
      await User.update(req.body, {
        where: {
          id: req.params.userId
        }
      })
      res.send(req.body)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar atualizar dados do usuario' + err
      })
    }
  },
  async inativar (req, res) {
    const dados = req.body
    console.log('================================:::::::::::::::::::::::::::: ============================================', dados)
    try {
      User.update({
        status: 2
      }, { where: { id: req.params.userId } })
      res.send(req.body)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar inativar usuario'
      })
    }
  },
  async ativar (req, res) {
    const dados = req.body
    console.log('================================:::::::::::::::::::::::::::: ============================================', dados)
    try {
      User.update({
        status: 1
      }, { where: { id: req.params.userId } })
      res.send(req.body)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar ativar usuario'
      })
    }
  },
  async login (req, res) {
    try {
      const { usuario, password } = req.body
      const user = await User.findOne({
        where: {
          usuario: usuario
        }
      })

      if (!user) {
        return res.status(403).send({
          error: 'Informações de login estão incoretos! Tente Novamente '
        })
      }

      const isPasswordValid = await user.comparePassword(password)
      if (!isPasswordValid) {
        return res.status(403).send({
          error: 'Informações de login estão incoretos! Tente novamente'
        })
      }

      const userJson = user.toJSON()
      res.send({
        user: userJson,
        token: jwtSignUser(userJson)
      })
    } catch (err) {
      res.status(500).send({
        error: err + 'Ocoreu um erro ao tenta efetuar login'
      })
    }
  }
}
