module.exports = (sequelize, DataTypes) => {
  const Produtos = sequelize.define('Produtos', {
    produto_code: DataTypes.STRING,
    produto_nome: DataTypes.TEXT,
    produto_nome_rec: DataTypes.STRING,
    produto_barcode: DataTypes.STRING,
    produto_preco: DataTypes.INTEGER
  })

  Produtos.associate = function (models) {
    Produtos.belongsTo(models.Fornecedores)
    Produtos.belongsTo(models.Iva)
    Produtos.belongsTo(models.Categorias)
    Produtos.hasOne(models.Stock)
    Produtos.hasMany(models.PVenda)
    Produtos.hasMany(models.ListaVenda)
  }

  return Produtos
}
