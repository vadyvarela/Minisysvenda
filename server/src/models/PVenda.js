module.exports = (sequelize, DataTypes) => {
  const PVenda = sequelize.define('PVenda', {
    pvenda_preco: DataTypes.INTEGER
  })

  PVenda.associate = function (models) {
    PVenda.belongsTo(models.Produtos)
  }

  return PVenda
}
