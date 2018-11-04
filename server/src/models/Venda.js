module.exports = (sequelize, DataTypes) => {
  const Venda = sequelize.define('Venda', {
    data_venda: DataTypes.DATE,
    meio_pagamento_dinheiro: DataTypes.STRING,
    valor_venda_dinheiro: DataTypes.STRING,
    meio_pagamento_vint4: DataTypes.STRING,
    valor_venda_vint4: DataTypes.STRING,
    meio_pagamento_cheque: DataTypes.STRING,
    valor_venda_cheque: DataTypes.STRING,
    status: DataTypes.STRING
  })

  Venda.associate = function (models) {
    // Venda.belongsTo(models.MeioPagamento)
    Venda.hasMany(models.ListaVenda)
    Venda.belongsTo(models.User)
  }

  return Venda
}
