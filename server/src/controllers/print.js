const escpos = require('escpos')
// Select the adapter based on your printer type
const device = new escpos.USB()
const options = { encoding: 'iso-8859-1' }
// encoding is optional

var texto = 'Testo'

const printer = new escpos.Printer(device, options)
device.open(function () {
  const dinheiro = '2345'
  const vint4 = '1200'
  const cheque = '5199'
  let entregado = ''

  // const dataVenda = this.venda.data_venda
  if (dinheiro !== '') {
    entregado = dinheiro
  } else if (vint4 !== '') {
    entregado = vint4
  } else {
    entregado = cheque
  }
  printer
    .cut()
    .text('DINHEIRO' + entregado)
    .text('CHEQUE' + entregado)
    .font('b')
    .align('ct')
    .style('bu')
    .size(1, 1)
    .text('MINISYSVENDA')
    .text(texto)
    .text('NIF: 2565896584')
    .close()
})
