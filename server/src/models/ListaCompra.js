module.exports = (sequelize, DataTypes) => {
  const ListaCompra = sequelize.define('ListaCompra', {
    quantidade: DataTypes.INTEGER
  })

  ListaCompra.associate = function (models) {
    ListaCompra.belongsTo(models.Compra)
    ListaCompra.belongsTo(models.Produtos)
  }

  return ListaCompra
}
