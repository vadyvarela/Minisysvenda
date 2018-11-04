module.exports = (sequelize, DataTypes) => {
  const Compra = sequelize.define('Compra', {
    data_compra: DataTypes.DATE
  })

  Compra.associate = function (models) {
    Compra.belongsTo(models.User)
    Compra.belongsTo(models.Fornecedores)
  }

  return Compra
}
