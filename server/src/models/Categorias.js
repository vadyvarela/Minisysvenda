module.exports = (sequelize, DataTypes) => {
  const Categorias = sequelize.define('Categorias', {
    categoria_nome: DataTypes.STRING,
    categoria_desc: DataTypes.STRING
  })

  return Categorias
}
