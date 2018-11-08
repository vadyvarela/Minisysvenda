var Service = require('node-windows').Service

// Create a new service object
var svc = new Service({
  name: 'SistemaVenda',
  description: 'Sistema de venda',
  script: 'C:\\Users\\Vady\\Documents\\PROJETOS\\sistemavenda\\server\\src\\app.js'
})

// Listen for the 'uninstall' event so we know when it is done.
svc.on('uninstall', function () {
  console.log('Uninstall complete.')
  console.log('The service exists: ', svc.exists)
})

// Uninstall the service.
svc.uninstall()
