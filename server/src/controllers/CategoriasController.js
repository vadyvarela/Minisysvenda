const { Categorias } = require('../models')

module.exports = {
  async index (req, res) {
    try {
      const categorias = await Categorias.findAll({})
      res.send(categorias)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar as categorias'
      })
    }
  },
  async post (req, res) {
    console.log('Dados enviados ---- ', req.body)
    console.log('IMG enviados ---- ', req.file)
    /* try {
      const categorias = await Categorias.create(req.body)
      console.log('Dados enviados ---- ', req.body, req.file)
      res.send(categorias)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar cadastrar categoria'
      })
    } */
  },
  async put (req, res) {
    try {
      await Categorias.update(req.body, {
        where: {
          id: req.params.categoriaId
        }
      })
      res.send(req.body)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar atualizar categorias'
      })
    }
  },
  async delete (req, res) {
    try {
      const { categoriaId } = req.params
      const categorias = await Categorias.findById(categoriaId)
      await categorias.destroy()
      res.send(categorias)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar apagar a categoria'
      })
    }
  }
}
