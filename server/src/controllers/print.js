const escpos = require('escpos')
// Select the adapter based on your printer type
const device = new escpos.USB()
const options = { encoding: 'iso-8859-1' }

const printer = new escpos.Printer(device, options)
device.open(function () {
  printer
    .font('b')
    .align('ct')
    .style('bu')
    .size(1, 1)
    .text('MINISYSVENDA')
    .text('Vadnir José Vrela Vieira')
    .text('Teste')
    .close()
    .cut()
})
