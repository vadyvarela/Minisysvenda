const { ListaVenda, Produtos, Stock, Sequelize } = require('../models')

module.exports = {
  async index (req, res) {
    try {
      const listavenda = await ListaVenda.findAll({
        include: [
          { model: Produtos, required: true }
        ],
        order: [ ['id', 'DESC'] ]
      })
      res.send(listavenda)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar dados da lista de venda'
      })
    }
  },
  // consulta os produtos mais vendidos
  async pmaisvendido (req, res) {
    try {
      const listavenda = await ListaVenda.findAll({
        include: [
          { model: Produtos, required: true }
        ],
        attributes: [
          [Sequelize.literal('COUNT(ProdutoId)'), 'quantidade']
        ],
        group: 'produto_nome'
      })
      res.send(listavenda)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar ultimo id de venda', err
      })
    }
  },
  // adiciona os produtos na lista de vendas quando efetuar uma venda
  post (req, res) {
    const dados = req.body
    for (var key in dados) {
      if (dados.hasOwnProperty(key)) {
        let value = dados[key]
        try {
          ListaVenda.create(value)
        } catch (err) {
          res.status(500).send({
            error: 'Um erro ocoreu ao tentar cadastrar lista de vendas'
          })
        }
      }
    }
    res.send(dados)
  },
  // Novos produtos adicionado ao editar venda
  postnewprod (req, res) {
    const dados = req.body
    for (var key in dados) {
      let value = dados[key]
      if (value.idSearch == null) {
        console.log('PARA CADASTRAR - ')

        for (var index in dados) {
          if (dados.hasOwnProperty(index)) {
            let value = dados[index]
            if (value.idSearch == null) {
              try {
                Stock.update({ quantidade: Sequelize.literal('quantidade -' + value.quantidade) }, { where: { ProdutoId: value.ProdutoId } })
              } catch (err) {
                res.status(500).send({
                  error: 'Um erro ocoreu ao tentar update STOCK'
                })
              }
            } else {
              console.log('Nao podem ser atualizados - ')
            }
          }
        }

        try {
          ListaVenda.create(value)
        } catch (err) {
          res.status(500).send({
            error: 'Um erro ocoreu ao tentar cadastrar lista de vendas'
          })
        }
      } else {
        console.log('JA CADASTRADO - ')
      }
    }
    res.send(dados)
  },
  async delete (req, res) {
    try {
      const { listavendasId } = req.params
      console.log('MEUS DADOS - ', req.params)
      const listavenda = await ListaVenda.findById(listavendasId)
      await listavenda.destroy()
      res.send(listavenda)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar apagar Item da lista de venda'
      })
    }
  }
}
