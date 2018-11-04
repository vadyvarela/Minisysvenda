module.exports = (sequelize, DataTypes) => {
  const ListaVenda = sequelize.define('ListaVenda', {
    quantidade: DataTypes.INTEGER,
    preco_venda: DataTypes.STRING
  })

  ListaVenda.associate = function (models) {
    ListaVenda.belongsTo(models.Produtos)
  }

  return ListaVenda
}
