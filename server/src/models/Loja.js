module.exports = (sequelize, DataTypes) => {
  const Loja = sequelize.define('Loja', {
    loja_nome: DataTypes.STRING,
    loja_nif: DataTypes.STRING,
    loja_telefone: DataTypes.STRING,
    loja_endereco: DataTypes.STRING
  })

  return Loja
}
