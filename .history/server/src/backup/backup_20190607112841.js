const mysqldump = require('mysqldump')
// dump the result straight to a file
mysqldump({
    connection: {
        host: 'localhost',
        user: 'imediasysvenda',
        password: 'imedia2019Venda',
        database: 'minisysvenda',
    },
    dumpToFile: 'backup-minisysvenda' + new Date().toISOString().slice(0, 10).replace(/-/g, '') + '.sql',
})