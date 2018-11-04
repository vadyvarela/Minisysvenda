module.exports = (sequelize, DataTypes) => {
  const Fornecedores = sequelize.define('Fornecedores', {
    fornecedor_nome: DataTypes.STRING,
    fornecedor_nif: DataTypes.INTEGER,
    fornecedor_endereco: DataTypes.STRING,
    fornecedor_movel: DataTypes.STRING
  })

  return Fornecedores
}
