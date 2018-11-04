module.exports = (sequelize, DataTypes) => {
  const Stock = sequelize.define('Stock', {
    quantidade: DataTypes.INTEGER
  })

  Stock.associate = function (models) {
    Stock.belongsTo(models.Produtos)
  }

  return Stock
}
