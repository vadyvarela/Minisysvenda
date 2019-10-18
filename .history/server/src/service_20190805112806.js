var Service = require('node-windows').Service

// Create a new service object
var svc = new Service({
  name: 'IVENDA',
  description: 'Sistema de venda Ivenda',
  script: 'C:\\xampp\\htdocs\\Ivenda\\server\\src\\app.js'
})

// Listen for the "install" event, which indicates the
// process is available as a service.
svc.on('install', function () {
  svc.start()
})
console.log("servico criado")
svc.install()
