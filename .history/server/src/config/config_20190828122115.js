// const path = require('path')
module.exports = {
  port: process.env.PORT || 8024,
  db: {
    database: process.env.DB_NAME || 'sistemavenda',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASS || '',
    options: {

      /* CONEXAO POSTGRESS */
      /* dialect: process.env.DIALECT || 'postgres',
      host: process.env.HOST || '127.0.0.1', */

      /* CONECAO MYSQL */
      dialect: process.env.DIALECT || 'mysql',
      host: process.env.HOST || '127.0.0.1',
      // logging: false

      pool: {
        max: 100,
        min: 0,
        idle: 20000,
        acquire: 100 * 1000
      }

      /* CONECAO SQLLITE */
      // dialect: process.env.DIALECT || 'sqlite',
      // host: process.env.HOST || 'localhost',
      // storage: path.resolve(__dirname, './ivenda.sqlite')
    }
  },
  authentication: {
    jwtSecret: process.env.JWT_SECRET || 'secret'
  }
}
