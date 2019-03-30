const Promise = require('bluebird')
const bcrypt = Promise.promisifyAll(require('bcrypt-nodejs'))

function hashPassword (user, options) {
  const SALT_FACTOR = 8

  if (!user.changed('password')) {
    return
  }

  return bcrypt
    .genSaltAsync(SALT_FACTOR)
    .then(salt => bcrypt.hashAsync(user.password, salt, null))
    .then(hash => {
      user.setDataValue('password', hash)
    })
}

module.exports = (sequelize, DataTypes) => {
  const User = sequelize.define('User', {
    nome: {
      type: DataTypes.STRING,
      unique: true
    },
    usuario: {
      type: DataTypes.STRING,
      unique: true
    },
    password: DataTypes.STRING,
    nivel: DataTypes.INTEGER,
    status: DataTypes.INTEGER
  }, {
    hooks: {
      beforeCreate: hashPassword,
      beforeUpdate: hashPassword
    }
  })

  User.prototype.comparePassword = function (password) {
    return bcrypt.compareAsync(password, this.password)
  }

  User.associate = function (models) {
    User.belongsTo(models.Loja)
  }

  return User
}
