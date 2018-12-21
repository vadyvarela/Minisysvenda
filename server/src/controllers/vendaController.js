const moment = require('moment')
const { Venda, ListaVenda, User, Produtos, Iva, PVenda, Cliente } = require('../models')

module.exports = {
  async index (req, res) {
    try {
      const { userId } = req.query
      const venda = await Venda.findAll({
        include: [
          { model: Cliente },
          { model: User },
          { model: ListaVenda, include: [ { model: Produtos, include: [ { model: Iva } ] } ] }
        ],
        where: {
          UserId: userId,
          status: 'vendido',
          meio_pagamento_dinheiro: {
            $ne: null
          }
        },
        order: [ ['id', 'DESC'] ]
      })
      res.send(venda)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar dados de venda'
      })
    }
  },
  async hoje (req, res) {
    try {
      const { userId, dataHoje } = req.query
      console.log('DATAS ================================================================== : ', dataHoje)
      const venda = await Venda.findAll({
        include: [
          { model: Cliente },
          { model: User },
          { model: ListaVenda, include: [ { model: Produtos, include: [ { model: Iva } ] } ] }
        ],
        where: {
          data_venda: dataHoje,
          UserId: userId,
          status: 'vendido',
          meio_pagamento_dinheiro: {
            $ne: null
          }
        },
        order: [ ['id', 'DESC'] ]
      })
      res.send(venda)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar dados de venda'
      })
    }
  },
  async byIdVenda (req, res) {
    try {
      const { userId, idSearch } = req.query
      console.log('MEU ID: ', idSearch)
      const venda = await Venda.findAll({
        include: [
          { model: User },
          { model: ListaVenda, include: [ { model: Produtos, include: [ { model: Iva }, { model: PVenda } ] } ] }
        ],
        where: {
          UserId: userId,
          status: 'vendido',
          id: idSearch,
          meio_pagamento_dinheiro: {
            $ne: null
          }
        }
      })
      res.send(venda)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar dados de venda PESQUISA BY ID'
      })
    }
  },
  async DadosGeral (req, res) {
    try {
      const { dataIni, dataFim } = req.query
      console.log('DATAS: ', dataIni, dataFim)
      const venda = await Venda.findAll({
        include: [
          { model: User },
          { model: ListaVenda, include: [ { model: Produtos, include: [ { model: Iva } ] } ] }
        ],
        where: {
          status: 'vendido',
          data_venda: {
            $between: [dataIni, dataFim]
          },
          meio_pagamento_dinheiro: {
            $ne: null
          }
        },
        order: [ ['data_venda', 'DESC'] ]
      })
      res.send(venda)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar dados de venda total'
      })
    }
  },
  async indexTotal (req, res) {
    try {
      const { userId, dataIni, dataFim } = req.query
      console.log('DATAS: ', dataIni, dataFim)
      const venda = await Venda.findAll({
        include: [
          { model: User },
          { model: ListaVenda, include: [ { model: Produtos, include: [ { model: Iva } ] } ] }
        ],
        where: {
          UserId: userId,
          status: 'vendido',
          data_venda: {
            $between: [dataIni, dataFim]
          },
          meio_pagamento_dinheiro: {
            $ne: null
          }
        },
        order: [ ['data_venda', 'DESC'] ]
      })
      res.send(venda)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar dados de venda total'
      })
    }
  },
  async lastid (req, res) {
    try {
      const venda = await Venda.findAll({
        limit: 1,
        order: [ ['id', 'DESC'] ]
      })
      res.send(venda)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar ultimo id de venda', err
      })
    }
  },
  async post (req, res) {
    try {
      const venda = await Venda.create(req.body)
      res.send(venda)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar cadastrar venda'
      })
    }
  },
  async put (req, res) {
    const dados = req.body
    // console.log(dados)
    try {
      const venda = Venda.update({ status: 'anulado' }, { where: { id: dados.id } })
      res.send(venda)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar cadastrar venda'
      })
    }
  },
  async putidpagamento (req, res) {
    const dados = req.body
    // console.log(dados)
    try {
      const venda = Venda.update({
        meio_pagamento_dinheiro: dados.dinheiro,
        valor_venda_dinheiro: dados.valorentregado,
        meio_pagamento_vint4: dados.vint4,
        valor_venda_vint4: dados.valorentregadovint4,
        meio_pagamento_cheque: dados.cheque,
        valor_venda_cheque: dados.valorentregadocheque,
        valor_total: dados.tapagar,
        valor_iva: dados.tapagariva,
        valor_troco: dados.troco,
        ClienteId: dados.ClienteId
      }, { where: { id: dados.VendaId } })
      res.send(venda)
    } catch (err) {
      res.status(500).send({
        error: 'Um erro ocoreu ao tentar cadastrar venda'
      })
    }
  },
  // Dados relatorio
  async semanal (req, res) {
    try {
      const venda = await Venda.findAll({
        include: [
          { model: User },
          { model: ListaVenda, include: [ { model: Produtos, include: [ { model: Iva } ] } ] }
        ],
        where: {
          status: 'vendido',
          data_venda: {
            $gte: moment().subtract(7, 'days').toDate()
          },
          meio_pagamento_dinheiro: {
            $ne: null
          }
        },
        order: [ ['data_venda', 'DESC'] ]
      })
      res.send(venda)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar vendad dos ultimos 7 dias', err
      })
    }
  },
  async diario (req, res) {
    try {
      const venda = await Venda.findAll({
        include: [
          { model: User },
          { model: ListaVenda, include: [ { model: Produtos, include: [ { model: Iva } ] } ] }
        ],
        where: {
          status: 'vendido',
          data_venda: {
            $gte: moment().subtract(0, 'days').toDate()
          },
          meio_pagamento_dinheiro: {
            $ne: null
          }
        },
        order: [ ['data_venda', 'DESC'] ]
      })
      res.send(venda)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar vendad dos ultimos 1 dias', err
      })
    }
  },
  async mensal (req, res) {
    try {
      const venda = await Venda.findAll({
        include: [
          { model: User },
          { model: ListaVenda, include: [ { model: Produtos, include: [ { model: Iva } ] } ] }
        ],
        where: {
          status: 'vendido',
          data_venda: {
            $gte: moment().subtract(30, 'days').toDate()
          },
          meio_pagamento_dinheiro: {
            $ne: null
          }
        },
        order: [ ['data_venda', 'DESC'] ]
      })
      res.send(venda)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar vendad dos ultimos 30 dias', err
      })
    }
  },
  async trimestral (req, res) {
    try {
      const venda = await Venda.findAll({
        include: [
          { model: User },
          { model: ListaVenda, include: [ { model: Produtos, include: [ { model: Iva } ] } ] }
        ],
        where: {
          status: 'vendido',
          data_venda: {
            $gte: moment().subtract(90, 'days').toDate()
          },
          meio_pagamento_dinheiro: {
            $ne: null
          }
        },
        order: [ ['data_venda', 'DESC'] ]
      })
      res.send(venda)
    } catch (err) {
      res.status(500).send({
        error: 'Ocoreu um erro ao tentar pegar vendad dos ultimos 90 dias', err
      })
    }
  }
}
