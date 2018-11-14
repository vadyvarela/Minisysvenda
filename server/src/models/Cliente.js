module.exports = (sequelize, DataTypes) => {
  const Cliente = sequelize.define('Cliente', {
    cliente_nome: DataTypes.TEXT,
    cliente_nif: DataTypes.STRING,
    cliente_morada: DataTypes.STRING,
    cliente_telefone: DataTypes.STRING
  })

  return Cliente
}
