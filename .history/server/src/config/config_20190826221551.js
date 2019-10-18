const path = require('path')
module.exports = {
  port: process.env.PORT || 8030,
  db: {
    database: process.env.DB_NAME || 'sysvenda',
    user: process.env.DB_USER || 'sysvenda',
    password: process.env.DB_PASS || 'sysvenda',
    options: {
      // dialect: process.env.DIALECT || 'mysql',
      // host: process.env.HOST || '127.0.0.1'
      // logging: false
      dialect: process.env.DIALECT || 'sqlite',
      host: process.env.HOST || 'localhost',
      storage: path.resolve(__dirname, './sysvenda.sqlite')
    }
  },
  authentication: {
    jwtSecret: process.env.JWT_SECRET || 'secret'
  }
}
