const Joi = require('joi')

module.exports = {
  register (req, res, next) {
    const schema = {
      usuario: Joi.string().required(),
      nivel: Joi.number().integer(),
      id: Joi.number().integer(),
      password: Joi.string().regex(
        new RegExp('^[a-zA-Z0-9]{4,32}$')
      )
    }

    const { error } = Joi.validate(req.body, schema)

    if (error) {
      switch (error.details[0].context.key) {
        case 'usuario':
          res.status(400).send({
            error: 'Por favor informe um usuario valido. Caracter Min (3)'
          })
          break

        case 'nivel':
          res.status(400).send({
            error: 'Favor selecione o nivel do usuario'
          })
          break

        case 'password':
          res.status(400).send({
            error: `Informe uma palavra passe de acordo com nossa exigencias
            <br>
            1 - Deve conter apenas caracteres Maiusculas ou minusculas
            <br>
            2 - Minimo 4 caracteres e maximo 32 caracteres`
          })
          break

        default:
          res.status(400).send({
            error: 'Informacoes para registro invalido'
          })
      }
    } else {
      next()
    }
  }
}
