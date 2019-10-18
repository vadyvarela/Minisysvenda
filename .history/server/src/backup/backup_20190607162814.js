// var cron = require('node-cron');
// cron.schedule('* * * * *', () => {
// console.log('will execute every minute until stopped');
const mysqldump = require('mysqldump')
mysqldump({
  connection: {
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'sistemavenda',
  },
  dumpToFile: 'backup-sistemavenda' + new Date().toISOString().slice(0, 10).replace(/-/g, '') + '.sql',
})
// });


