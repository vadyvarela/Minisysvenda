const escpos = require('escpos')
// Select the adapter based on your printer type
const device = new escpos.USB()
const options = { encoding: 'utf-8' }

const printer = new escpos.Printer(device, options)
device.open(function () {
  printer
    .font('b')
    .align('ct')
    .style('bu')
    .size(1.6, 1)
    .text('MINISYSVENDA')
    .text('QT  PRODUTO                  P. UNIT  IVA  TOTAL')
    .text('------------------------------------------------')
    .close()
    .cut()
})
