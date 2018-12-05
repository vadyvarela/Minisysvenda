module.exports = (sequelize, DataTypes) => {
  const Venda = sequelize.define('Venda', {
    data_venda: DataTypes.DATEONLY,
    meio_pagamento_dinheiro: DataTypes.STRING,
    valor_venda_dinheiro: DataTypes.INTEGER,
    meio_pagamento_vint4: DataTypes.STRING,
    valor_venda_vint4: DataTypes.INTEGER,
    meio_pagamento_cheque: DataTypes.STRING,
    valor_venda_cheque: DataTypes.INTEGER,
    valor_total: DataTypes.INTEGER,
    valor_iva: DataTypes.INTEGER,
    valor_troco: DataTypes.INTEGER,
    status: DataTypes.STRING
  })

  Venda.associate = function (models) {
    // Venda.belongsTo(models.MeioPagamento)
    Venda.hasMany(models.ListaVenda)
    Venda.belongsTo(models.User)
    Venda.belongsTo(models.Cliente)
  }

  return Venda
}
