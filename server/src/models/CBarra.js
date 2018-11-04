module.exports = (sequelize, DataTypes) => {
  const CBarra = sequelize.define('CBarra', {
    cbarra_valor: DataTypes.STRING,
    cbarra_desc: DataTypes.STRING
  })

  return CBarra
}
