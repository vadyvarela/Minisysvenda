module.exports = (sequelize, DataTypes) => {
  const Cliente = sequelize.define('Cliente', {
    cliente_nome: {
      type: DataTypes.STRING,
      unique: true
    },
    cliente_nif: {
      type: DataTypes.STRING,
      unique: true
    },
    cliente_morada: DataTypes.STRING,
    cliente_telefone: DataTypes.STRING
  })

  return Cliente
}
