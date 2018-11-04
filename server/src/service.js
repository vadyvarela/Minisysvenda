var Service = require('node-windows').Service

// Create a new service object
var svc = new Service({
  name: 'MiniSysVenda',
  description: 'Teste de sistema de venda',
  script: 'C:\\Users\\Vady\\Documents\\PROJETOS\\sistemavenda\\server\\src\\app.js'
})

// Listen for the "install" event, which indicates the
// process is available as a service.
svc.on('install', function () {
  svc.start()
})

svc.install()
