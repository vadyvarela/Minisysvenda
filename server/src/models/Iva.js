module.exports = (sequelize, DataTypes) => {
  const Iva = sequelize.define('Iva', {
    iva_valor: DataTypes.INTEGER,
    iva_desc: DataTypes.STRING
  })

  return Iva
}
