const { Stock, ListaVenda, Sequelize } = require('../models')

module.exports = {
  async index (req, res) {
    try {
      const stock = await Stock.findAll({})
      res.send(stock)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar valor iva'
      })
    }
  },
  async soma (req, res) {
    try {
      const stock = await Stock.findAll({
        attributes: [[Sequelize.fn('sum', Sequelize.col('quantidade')), 'total']]
      })
      res.send(stock)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar valor iva'
      })
    }
  },
  async post (req, res) {
    try {
      const stock = await Stock.create(req.body)
      res.send(stock)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar cadastrar quantidade no stock'
      })
    }
  },

  // Remove do stock quando um produto é vendido
  putvendas (req, res) {
    const dados = req.body
    for (var key in dados) {
      if (dados.hasOwnProperty(key)) {
        let value = dados[key]
        try {
          Stock.update({ quantidade: Sequelize.literal('quantidade -' + value.quantidade) }, { where: { ProdutoId: value.ProdutoId } })
        } catch (err) {
          res.status(500).send({
            error: 'Um erro ocoreu ao tentar update STOCK'
          })
        }
      }
    }
    res.send(dados)
  },

  // Adiciona ou remove stock de acordo com quantidade seleciona na edicao de venda
  async putstockaddremove (req, res) {
    const dados = req.body
    let value = dados
    const listavendas = await ListaVenda.findOne({
      where: {
        ProdutoId: value.ProdutoId,
        vendaId: value.idSearch
      }
    })
    console.log('QUANTIDADE ATUAL --- ', listavendas.quantidade)
    console.log('QUANTIDADE NOVO --- ', value.quantidade)
    if (listavendas.quantidade > value.quantidade) {
      console.log('ADICIONAR')
      try {
        const qtd = listavendas.quantidade - value.quantidade
        console.log('RES ----- ', qtd)
        Stock.update({ quantidade: Sequelize.literal('quantidade + ' + qtd) }, { where: { ProdutoId: value.ProdutoId } })
        ListaVenda.update({ quantidade: value.quantidade }, { where: { ProdutoId: value.ProdutoId, vendaId: value.idSearch } })
      } catch (err) {
        res.status(500).send({
          error: 'Um erro ocoreu ao tentar update STOCK'
        })
      }
      res.send(dados)
    } else {
      console.log('REMOVER')
      try {
        const qtd = value.quantidade - listavendas.quantidade
        console.log('RES ----- ', qtd)
        Stock.update({ quantidade: Sequelize.literal('quantidade - ' + qtd) }, { where: { ProdutoId: value.ProdutoId } })
        ListaVenda.update({ quantidade: value.quantidade }, { where: { ProdutoId: value.ProdutoId, vendaId: value.idSearch } })
      } catch (err) {
        res.status(500).send({
          error: 'Um erro ocoreu ao tentar update STOCK'
        })
      }
      res.send(dados)
    }
  },
  // Adiciona na stock quando um produto e removido da lista de venda
  putstockvenda (req, res) {
    const dados = req.body
    let value = dados
    try {
      Stock.update({ quantidade: Sequelize.literal('quantidade + ' + value.quantidade) }, { where: { ProdutoId: value.ProdutoId } })
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar update STOCK'
      })
    }
    res.send(dados)
  },

  // Adiciona produtos no stock quando é efetuado uma compra
  putcompras (req, res) {
    const dados = req.body
    for (var key in dados) {
      if (dados.hasOwnProperty(key)) {
        let value = dados[key]
        // console.log(value.quantidade)
        try {
          Stock.update({ quantidade: Sequelize.literal('quantidade + ' + value.quantidade) }, { where: { ProdutoId: value.ProdutoId } })
        } catch (err) {
          res.status(500).send({
            error: 'Um erro ocoreu ao tentar update STOCK'
          })
        }
      }
    }
    res.send(dados)
  },
  async delete (req, res) {
    try {
      const { stockId } = req.params
      const stock = await Stock.findById(stockId)
      await stock.destroy()
      res.send(stock)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar apagar valor do iva'
      })
    }
  }
}
