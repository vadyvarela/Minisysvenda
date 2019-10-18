module.exports = {
  port: process.env.PORT || 8023,
  db: {
    database: process.env.DB_NAME || 'minsysvenda',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASS || '',
    options: {
      dialect: process.env.DIALECT || 'mysql',
      host: process.env.HOST || '127.0.0.1'
      // logging: false
    }
  },
  authentication: {
    jwtSecret: process.env.JWT_SECRET || 'secret'
  }
}
