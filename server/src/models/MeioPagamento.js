module.exports = (sequelize, DataTypes) => {
  const MeioPagamento = sequelize.define('MeioPagamento', {
    tipoPagamento: DataTypes.STRING
  })

  return MeioPagamento
}
