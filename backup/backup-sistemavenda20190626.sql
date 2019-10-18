/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: listavendas
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `listavendas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantidade` int(11) DEFAULT NULL,
  `preco_venda` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `ProdutoId` int(11) DEFAULT NULL,
  `VendaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ProdutoId` (`ProdutoId`),
  KEY `VendaId` (`VendaId`),
  CONSTRAINT `listavendas_ibfk_1` FOREIGN KEY (`ProdutoId`) REFERENCES `produtos` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `listavendas_ibfk_2` FOREIGN KEY (`VendaId`) REFERENCES `vendas` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 334 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: categorias
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `categorias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categoria_nome` varchar(255) DEFAULT NULL,
  `categoria_desc` varchar(255) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 6 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: clientes
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cliente_nome` varchar(255) DEFAULT NULL,
  `cliente_nif` varchar(255) DEFAULT NULL,
  `cliente_morada` varchar(255) DEFAULT NULL,
  `cliente_telefone` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cliente_nome` (`cliente_nome`),
  UNIQUE KEY `cliente_nif` (`cliente_nif`)
) ENGINE = InnoDB AUTO_INCREMENT = 7 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: compras
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `compras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_compra` date DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `UserId` int(11) DEFAULT NULL,
  `FornecedoreId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `UserId` (`UserId`),
  KEY `FornecedoreId` (`FornecedoreId`),
  CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `users` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `compras_ibfk_2` FOREIGN KEY (`FornecedoreId`) REFERENCES `fornecedores` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 12 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: fornecedores
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `fornecedores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fornecedor_nome` varchar(255) DEFAULT NULL,
  `fornecedor_nif` int(11) DEFAULT NULL,
  `fornecedor_endereco` varchar(255) DEFAULT NULL,
  `fornecedor_movel` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 7 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: ivas
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `ivas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `iva_valor` int(11) DEFAULT NULL,
  `iva_desc` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 4 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: listacompras
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `listacompras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantidade` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `CompraId` int(11) DEFAULT NULL,
  `ProdutoId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `CompraId` (`CompraId`),
  KEY `ProdutoId` (`ProdutoId`),
  CONSTRAINT `listacompras_ibfk_1` FOREIGN KEY (`CompraId`) REFERENCES `compras` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `listacompras_ibfk_2` FOREIGN KEY (`ProdutoId`) REFERENCES `produtos` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 34 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: cbarras
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `cbarras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cbarra_valor` varchar(255) DEFAULT NULL,
  `cbarra_desc` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: lojas
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `lojas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loja_nome` varchar(255) DEFAULT NULL,
  `loja_nif` varchar(255) DEFAULT NULL,
  `loja_telefone` varchar(255) DEFAULT NULL,
  `loja_endereco` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: meiopagamentos
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `meiopagamentos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipoPagamento` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: produtos
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `produtos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `produto_code` varchar(255) DEFAULT NULL,
  `produto_nome` text,
  `produto_nome_rec` varchar(255) DEFAULT NULL,
  `produto_barcode` varchar(255) DEFAULT NULL,
  `produto_preco` int(11) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `FornecedoreId` int(11) DEFAULT NULL,
  `IvaId` int(11) DEFAULT NULL,
  `CategoriaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FornecedoreId` (`FornecedoreId`),
  KEY `IvaId` (`IvaId`),
  KEY `CategoriaId` (`CategoriaId`),
  CONSTRAINT `produtos_ibfk_1` FOREIGN KEY (`FornecedoreId`) REFERENCES `fornecedores` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `produtos_ibfk_2` FOREIGN KEY (`IvaId`) REFERENCES `ivas` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `produtos_ibfk_3` FOREIGN KEY (`CategoriaId`) REFERENCES `categorias` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 24 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: pvendas
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `pvendas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pvenda_preco` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `ProdutoId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ProdutoId` (`ProdutoId`),
  CONSTRAINT `pvendas_ibfk_1` FOREIGN KEY (`ProdutoId`) REFERENCES `produtos` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 30 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: stocks
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `stocks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantidade` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `ProdutoId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ProdutoId` (`ProdutoId`),
  CONSTRAINT `stocks_ibfk_1` FOREIGN KEY (`ProdutoId`) REFERENCES `produtos` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 25 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: users
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) DEFAULT NULL,
  `usuario` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `nivel` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `LojaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`nome`),
  UNIQUE KEY `usuario` (`usuario`),
  KEY `LojaId` (`LojaId`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`LojaId`) REFERENCES `lojas` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 6 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: vendas
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `vendas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_venda` date DEFAULT NULL,
  `meio_pagamento_dinheiro` varchar(255) DEFAULT NULL,
  `valor_venda_dinheiro` int(11) DEFAULT NULL,
  `meio_pagamento_vint4` varchar(255) DEFAULT NULL,
  `valor_venda_vint4` int(11) DEFAULT NULL,
  `meio_pagamento_cheque` varchar(255) DEFAULT NULL,
  `valor_venda_cheque` int(11) DEFAULT NULL,
  `valor_total` int(11) DEFAULT NULL,
  `valor_iva` int(11) DEFAULT NULL,
  `valor_troco` int(11) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `UserId` int(11) DEFAULT NULL,
  `ClienteId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `UserId` (`UserId`),
  KEY `ClienteId` (`ClienteId`),
  CONSTRAINT `vendas_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `users` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `vendas_ibfk_2` FOREIGN KEY (`ClienteId`) REFERENCES `clientes` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 128 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: listavendas
# ------------------------------------------------------------

INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    1,
    1,
    '200',
    '2019-05-08 17:34:32',
    '2019-05-08 17:34:32',
    1,
    1
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    2,
    1,
    '30',
    '2019-05-08 17:34:32',
    '2019-05-08 17:34:32',
    4,
    1
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    3,
    10,
    '200',
    '2019-05-14 14:17:23',
    '2019-05-14 14:17:23',
    1,
    12
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    5,
    2,
    '30',
    '2019-05-14 14:18:21',
    '2019-05-14 14:18:21',
    4,
    14
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    7,
    1,
    '30',
    '2019-05-14 19:49:53',
    '2019-05-14 19:49:53',
    4,
    17
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    9,
    1,
    '30',
    '2019-05-14 20:08:49',
    '2019-05-14 20:08:49',
    4,
    18
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    10,
    1,
    '200',
    '2019-05-14 20:08:49',
    '2019-05-14 20:08:49',
    1,
    18
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    11,
    1,
    '200',
    '2019-06-04 13:21:58',
    '2019-06-04 13:21:58',
    1,
    25
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    13,
    1,
    '120',
    '2019-06-04 13:21:58',
    '2019-06-04 13:21:58',
    5,
    25
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    14,
    1,
    '200',
    '2019-06-06 18:32:16',
    '2019-06-06 18:32:16',
    1,
    27
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    16,
    1,
    '200',
    '2019-06-06 18:37:25',
    '2019-06-06 18:37:25',
    1,
    28
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    18,
    1,
    '200',
    '2019-06-06 18:37:59',
    '2019-06-06 18:37:59',
    1,
    29
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    20,
    1,
    '200',
    '2019-06-06 18:38:12',
    '2019-06-06 18:38:12',
    1,
    30
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    22,
    1,
    '200',
    '2019-06-06 18:46:55',
    '2019-06-06 18:46:55',
    1,
    32
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    23,
    1,
    '30',
    '2019-06-06 18:46:55',
    '2019-06-06 18:46:55',
    4,
    32
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    25,
    1,
    '200',
    '2019-06-06 18:46:55',
    '2019-06-06 18:46:55',
    1,
    32
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    26,
    1,
    '30',
    '2019-06-06 18:46:55',
    '2019-06-06 18:46:55',
    4,
    32
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    28,
    1,
    '200',
    '2019-06-06 18:47:25',
    '2019-06-06 18:47:25',
    1,
    34
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    29,
    1,
    '30',
    '2019-06-06 18:47:25',
    '2019-06-06 18:47:25',
    4,
    34
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    31,
    1,
    '200',
    '2019-06-06 18:47:51',
    '2019-06-06 18:47:51',
    1,
    35
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    32,
    1,
    '30',
    '2019-06-06 18:47:51',
    '2019-06-06 18:47:51',
    4,
    35
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    34,
    1,
    '200',
    '2019-06-06 18:47:51',
    '2019-06-06 18:47:51',
    1,
    35
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    35,
    1,
    '30',
    '2019-06-06 18:47:51',
    '2019-06-06 18:47:51',
    4,
    35
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    37,
    1,
    '200',
    '2019-06-06 18:56:05',
    '2019-06-06 18:56:05',
    1,
    37
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    39,
    1,
    '200',
    '2019-06-06 18:56:05',
    '2019-06-06 18:56:05',
    1,
    37
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    41,
    1,
    '200',
    '2019-06-06 19:09:10',
    '2019-06-06 19:09:10',
    1,
    39
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    43,
    1,
    '200',
    '2019-06-06 19:09:10',
    '2019-06-06 19:09:10',
    1,
    39
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    45,
    1,
    '200',
    '2019-06-06 19:09:10',
    '2019-06-06 19:09:10',
    1,
    39
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    47,
    1,
    '200',
    '2019-06-06 19:09:10',
    '2019-06-06 19:09:10',
    1,
    39
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    49,
    1,
    '200',
    '2019-06-06 19:09:11',
    '2019-06-06 19:09:11',
    1,
    39
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    51,
    1,
    '200',
    '2019-06-06 19:09:11',
    '2019-06-06 19:09:11',
    1,
    39
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    53,
    1,
    '200',
    '2019-06-06 19:09:11',
    '2019-06-06 19:09:11',
    1,
    39
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    55,
    1,
    '200',
    '2019-06-06 19:09:11',
    '2019-06-06 19:09:11',
    1,
    39
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    57,
    1,
    '200',
    '2019-06-06 19:23:18',
    '2019-06-06 19:23:18',
    1,
    49
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    59,
    1,
    '200',
    '2019-06-06 19:23:18',
    '2019-06-06 19:23:18',
    1,
    49
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    61,
    1,
    '200',
    '2019-06-06 19:23:18',
    '2019-06-06 19:23:18',
    1,
    49
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    63,
    1,
    '200',
    '2019-06-06 19:23:19',
    '2019-06-06 19:23:19',
    1,
    49
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    65,
    1,
    '200',
    '2019-06-06 19:33:42',
    '2019-06-06 19:33:42',
    1,
    53
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    67,
    1,
    '120',
    '2019-06-06 19:33:58',
    '2019-06-06 19:33:58',
    5,
    54
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    69,
    1,
    '120',
    '2019-06-06 19:39:01',
    '2019-06-06 19:39:01',
    5,
    56
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    71,
    1,
    '200',
    '2019-06-06 19:44:13',
    '2019-06-06 19:44:13',
    1,
    57
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    73,
    1,
    '200',
    '2019-06-06 19:54:37',
    '2019-06-06 19:54:37',
    1,
    58
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    75,
    1,
    '200',
    '2019-06-06 19:59:36',
    '2019-06-06 19:59:36',
    1,
    59
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    77,
    1,
    '200',
    '2019-06-06 20:01:14',
    '2019-06-06 20:01:14',
    1,
    60
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    79,
    1,
    '200',
    '2019-06-06 20:01:36',
    '2019-06-06 20:01:36',
    1,
    61
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    81,
    1,
    '200',
    '2019-06-06 20:04:02',
    '2019-06-06 20:04:02',
    1,
    18
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    82,
    1,
    '200',
    '2019-06-26 10:08:44',
    '2019-06-26 10:08:44',
    1,
    66
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    84,
    1,
    '200',
    '2019-06-26 11:07:30',
    '2019-06-26 11:07:30',
    1,
    67
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    86,
    1,
    '200',
    '2019-06-26 11:08:02',
    '2019-06-26 11:08:02',
    1,
    68
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    88,
    1,
    '200',
    '2019-06-26 11:08:19',
    '2019-06-26 11:08:19',
    1,
    69
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    91,
    1,
    '200',
    '2019-06-26 11:17:24',
    '2019-06-26 11:17:24',
    1,
    71
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    93,
    1,
    '200',
    '2019-06-26 11:26:28',
    '2019-06-26 11:26:28',
    1,
    72
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    94,
    1,
    '200',
    '2019-06-26 11:44:11',
    '2019-06-26 11:44:11',
    1,
    73
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    96,
    1,
    '200',
    '2019-06-26 11:45:35',
    '2019-06-26 11:45:35',
    1,
    74
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    98,
    1,
    '200',
    '2019-06-26 12:40:01',
    '2019-06-26 12:40:01',
    1,
    76
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    100,
    1,
    '200',
    '2019-06-26 12:41:35',
    '2019-06-26 12:41:35',
    1,
    77
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    102,
    1,
    '200',
    '2019-06-26 12:57:10',
    '2019-06-26 12:57:10',
    1,
    78
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    104,
    1,
    '200',
    '2019-06-26 12:57:23',
    '2019-06-26 12:57:23',
    1,
    79
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    106,
    1,
    '200',
    '2019-06-26 12:57:47',
    '2019-06-26 12:57:47',
    1,
    80
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    108,
    1,
    '200',
    '2019-06-26 12:59:32',
    '2019-06-26 12:59:32',
    1,
    81
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    110,
    1,
    '200',
    '2019-06-26 13:11:57',
    '2019-06-26 13:11:57',
    1,
    82
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    112,
    1,
    '200',
    '2019-06-26 13:44:12',
    '2019-06-26 13:44:12',
    1,
    84
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    114,
    1,
    '200',
    '2019-06-26 13:47:04',
    '2019-06-26 13:47:04',
    1,
    85
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    116,
    1,
    '200',
    '2019-06-26 13:50:15',
    '2019-06-26 13:50:15',
    1,
    86
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    118,
    1,
    '200',
    '2019-06-26 13:51:18',
    '2019-06-26 13:51:18',
    1,
    87
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    120,
    1,
    '120',
    '2019-06-26 13:59:07',
    '2019-06-26 13:59:07',
    5,
    88
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    121,
    1,
    '200',
    '2019-06-26 13:59:07',
    '2019-06-26 13:59:07',
    1,
    88
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    122,
    1,
    '30',
    '2019-06-26 13:59:07',
    '2019-06-26 13:59:07',
    4,
    88
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    124,
    1,
    '120',
    '2019-06-26 14:00:15',
    '2019-06-26 14:00:15',
    5,
    89
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    126,
    1,
    '120',
    '2019-06-26 14:04:53',
    '2019-06-26 14:04:53',
    5,
    90
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    128,
    1,
    '200',
    '2019-06-26 14:08:35',
    '2019-06-26 14:08:35',
    1,
    91
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    129,
    1,
    '120',
    '2019-06-26 14:08:35',
    '2019-06-26 14:08:35',
    5,
    91
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    130,
    1,
    '300',
    '2019-06-26 14:08:35',
    '2019-06-26 14:08:35',
    2,
    91
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    131,
    1,
    '60',
    '2019-06-26 14:08:35',
    '2019-06-26 14:08:35',
    3,
    91
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    133,
    1,
    '200',
    '2019-06-26 14:11:54',
    '2019-06-26 14:11:54',
    1,
    92
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    134,
    1,
    '300',
    '2019-06-26 14:11:54',
    '2019-06-26 14:11:54',
    2,
    92
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    135,
    1,
    '60',
    '2019-06-26 14:11:54',
    '2019-06-26 14:11:54',
    3,
    92
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    136,
    1,
    '120',
    '2019-06-26 14:11:54',
    '2019-06-26 14:11:54',
    5,
    92
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    138,
    1,
    '200',
    '2019-06-26 14:14:37',
    '2019-06-26 14:14:37',
    1,
    93
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    139,
    3,
    '300',
    '2019-06-26 14:14:37',
    '2019-06-26 14:14:37',
    2,
    93
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    140,
    1,
    '60',
    '2019-06-26 14:14:37',
    '2019-06-26 14:14:37',
    3,
    93
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    141,
    2,
    '120',
    '2019-06-26 14:14:37',
    '2019-06-26 14:14:37',
    5,
    93
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    142,
    1,
    '30',
    '2019-06-26 14:14:37',
    '2019-06-26 14:14:37',
    4,
    93
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    144,
    1,
    '30',
    '2019-06-26 14:17:00',
    '2019-06-26 14:17:00',
    4,
    94
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    145,
    1,
    '200',
    '2019-06-26 14:17:00',
    '2019-06-26 14:17:00',
    1,
    94
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    146,
    1,
    '60',
    '2019-06-26 14:17:00',
    '2019-06-26 14:17:00',
    3,
    94
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    147,
    1,
    '300',
    '2019-06-26 14:17:00',
    '2019-06-26 14:17:00',
    2,
    94
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    149,
    1,
    '200',
    '2019-06-26 14:34:27',
    '2019-06-26 14:34:27',
    1,
    95
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    150,
    1,
    '300',
    '2019-06-26 14:34:27',
    '2019-06-26 14:34:27',
    2,
    95
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    151,
    1,
    '30',
    '2019-06-26 14:34:27',
    '2019-06-26 14:34:27',
    4,
    95
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    153,
    1,
    '60',
    '2019-06-26 14:34:27',
    '2019-06-26 14:34:27',
    3,
    95
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    154,
    1,
    '60',
    '2019-06-26 14:45:27',
    '2019-06-26 14:45:27',
    3,
    96
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    155,
    1,
    '30',
    '2019-06-26 14:45:27',
    '2019-06-26 14:45:27',
    4,
    96
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    156,
    1,
    '300',
    '2019-06-26 14:45:27',
    '2019-06-26 14:45:27',
    2,
    96
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    157,
    1,
    '120',
    '2019-06-26 14:45:27',
    '2019-06-26 14:45:27',
    5,
    96
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    159,
    1,
    '120',
    '2019-06-26 14:49:21',
    '2019-06-26 14:49:21',
    5,
    97
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    161,
    1,
    '60',
    '2019-06-26 14:55:03',
    '2019-06-26 14:55:03',
    3,
    99
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    162,
    1,
    '120',
    '2019-06-26 14:55:03',
    '2019-06-26 14:55:03',
    5,
    99
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    163,
    1,
    '300',
    '2019-06-26 14:55:03',
    '2019-06-26 14:55:03',
    2,
    99
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    164,
    1,
    '30',
    '2019-06-26 14:55:03',
    '2019-06-26 14:55:03',
    4,
    99
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    166,
    1,
    '60',
    '2019-06-26 17:56:27',
    '2019-06-26 17:56:27',
    3,
    104
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    167,
    1,
    '20',
    '2019-06-26 17:56:27',
    '2019-06-26 17:56:27',
    13,
    104
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    168,
    1,
    '120',
    '2019-06-26 17:56:27',
    '2019-06-26 17:56:27',
    5,
    104
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    169,
    1,
    '20',
    '2019-06-26 17:56:27',
    '2019-06-26 17:56:27',
    12,
    104
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    170,
    1,
    '30',
    '2019-06-26 17:56:27',
    '2019-06-26 17:56:27',
    4,
    104
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    171,
    1,
    '300',
    '2019-06-26 17:56:27',
    '2019-06-26 17:56:27',
    2,
    104
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    172,
    1,
    '200',
    '2019-06-26 17:56:27',
    '2019-06-26 17:56:27',
    1,
    104
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    173,
    1,
    '120',
    '2019-06-26 17:56:27',
    '2019-06-26 17:56:27',
    14,
    104
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    174,
    1,
    '500',
    '2019-06-26 17:56:27',
    '2019-06-26 17:56:27',
    15,
    104
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    175,
    1,
    '55',
    '2019-06-26 17:56:27',
    '2019-06-26 17:56:27',
    16,
    104
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    176,
    1,
    '77',
    '2019-06-26 17:56:27',
    '2019-06-26 17:56:27',
    17,
    104
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    177,
    1,
    '47',
    '2019-06-26 17:56:27',
    '2019-06-26 17:56:27',
    18,
    104
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    178,
    1,
    '47',
    '2019-06-26 17:56:27',
    '2019-06-26 17:56:27',
    19,
    104
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    179,
    1,
    '85',
    '2019-06-26 17:56:27',
    '2019-06-26 17:56:27',
    20,
    104
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    180,
    1,
    '5',
    '2019-06-26 17:56:27',
    '2019-06-26 17:56:27',
    21,
    104
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    182,
    1,
    '60',
    '2019-06-26 18:05:55',
    '2019-06-26 18:05:55',
    3,
    106
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    183,
    1,
    '120',
    '2019-06-26 18:05:55',
    '2019-06-26 18:05:55',
    5,
    106
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    184,
    3,
    '20',
    '2019-06-26 18:05:55',
    '2019-06-26 18:05:55',
    12,
    106
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    185,
    3,
    '20',
    '2019-06-26 18:05:55',
    '2019-06-26 18:05:55',
    13,
    106
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    186,
    1,
    '30',
    '2019-06-26 18:05:55',
    '2019-06-26 18:05:55',
    4,
    106
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    187,
    1,
    '300',
    '2019-06-26 18:05:55',
    '2019-06-26 18:05:55',
    2,
    106
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    188,
    2,
    '200',
    '2019-06-26 18:05:55',
    '2019-06-26 18:05:55',
    1,
    106
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    189,
    1,
    '120',
    '2019-06-26 18:05:55',
    '2019-06-26 18:05:55',
    14,
    106
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    190,
    1,
    '500',
    '2019-06-26 18:05:55',
    '2019-06-26 18:05:55',
    15,
    106
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    191,
    1,
    '55',
    '2019-06-26 18:05:55',
    '2019-06-26 18:05:55',
    16,
    106
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    192,
    2,
    '77',
    '2019-06-26 18:05:55',
    '2019-06-26 18:05:55',
    17,
    106
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    193,
    3,
    '47',
    '2019-06-26 18:05:55',
    '2019-06-26 18:05:55',
    18,
    106
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    194,
    1,
    '47',
    '2019-06-26 18:05:55',
    '2019-06-26 18:05:55',
    19,
    106
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    195,
    3,
    '85',
    '2019-06-26 18:05:55',
    '2019-06-26 18:05:55',
    20,
    106
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    196,
    2,
    '5',
    '2019-06-26 18:05:55',
    '2019-06-26 18:05:55',
    21,
    106
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    197,
    1,
    '95000',
    '2019-06-26 18:05:55',
    '2019-06-26 18:05:55',
    22,
    106
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    199,
    1,
    '60',
    '2019-06-26 18:14:16',
    '2019-06-26 18:14:16',
    3,
    107
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    200,
    3,
    '20',
    '2019-06-26 18:14:16',
    '2019-06-26 18:14:16',
    13,
    107
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    201,
    1,
    '120',
    '2019-06-26 18:14:16',
    '2019-06-26 18:14:16',
    5,
    107
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    202,
    3,
    '20',
    '2019-06-26 18:14:16',
    '2019-06-26 18:14:16',
    12,
    107
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    203,
    1,
    '30',
    '2019-06-26 18:14:16',
    '2019-06-26 18:14:16',
    4,
    107
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    204,
    1,
    '300',
    '2019-06-26 18:14:16',
    '2019-06-26 18:14:16',
    2,
    107
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    205,
    1,
    '200',
    '2019-06-26 18:14:16',
    '2019-06-26 18:14:16',
    1,
    107
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    206,
    1,
    '500',
    '2019-06-26 18:14:16',
    '2019-06-26 18:14:16',
    15,
    107
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    207,
    1,
    '55',
    '2019-06-26 18:14:16',
    '2019-06-26 18:14:16',
    16,
    107
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    208,
    1,
    '120',
    '2019-06-26 18:14:16',
    '2019-06-26 18:14:16',
    14,
    107
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    209,
    2,
    '77',
    '2019-06-26 18:14:16',
    '2019-06-26 18:14:16',
    17,
    107
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    210,
    3,
    '47',
    '2019-06-26 18:14:16',
    '2019-06-26 18:14:16',
    18,
    107
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    211,
    1,
    '47',
    '2019-06-26 18:14:16',
    '2019-06-26 18:14:16',
    19,
    107
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    212,
    2,
    '5',
    '2019-06-26 18:14:16',
    '2019-06-26 18:14:16',
    21,
    107
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    213,
    1,
    '95000',
    '2019-06-26 18:14:16',
    '2019-06-26 18:14:16',
    22,
    107
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    214,
    3,
    '85',
    '2019-06-26 18:14:16',
    '2019-06-26 18:14:16',
    20,
    107
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    216,
    1,
    '60',
    '2019-06-26 18:16:18',
    '2019-06-26 18:16:18',
    3,
    108
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    217,
    1,
    '20',
    '2019-06-26 18:16:18',
    '2019-06-26 18:16:18',
    13,
    108
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    218,
    1,
    '120',
    '2019-06-26 18:16:18',
    '2019-06-26 18:16:18',
    5,
    108
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    219,
    1,
    '20',
    '2019-06-26 18:16:18',
    '2019-06-26 18:16:18',
    12,
    108
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    220,
    1,
    '30',
    '2019-06-26 18:16:18',
    '2019-06-26 18:16:18',
    4,
    108
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    221,
    1,
    '300',
    '2019-06-26 18:16:18',
    '2019-06-26 18:16:18',
    2,
    108
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    222,
    1,
    '200',
    '2019-06-26 18:16:18',
    '2019-06-26 18:16:18',
    1,
    108
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    223,
    1,
    '120',
    '2019-06-26 18:16:18',
    '2019-06-26 18:16:18',
    14,
    108
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    224,
    1,
    '500',
    '2019-06-26 18:16:18',
    '2019-06-26 18:16:18',
    15,
    108
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    226,
    1,
    '60',
    '2019-06-26 18:18:19',
    '2019-06-26 18:18:19',
    3,
    109
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    227,
    1,
    '20',
    '2019-06-26 18:18:19',
    '2019-06-26 18:18:19',
    13,
    109
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    228,
    1,
    '120',
    '2019-06-26 18:18:19',
    '2019-06-26 18:18:19',
    5,
    109
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    229,
    1,
    '20',
    '2019-06-26 18:18:19',
    '2019-06-26 18:18:19',
    12,
    109
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    230,
    1,
    '30',
    '2019-06-26 18:18:19',
    '2019-06-26 18:18:19',
    4,
    109
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    232,
    1,
    '60',
    '2019-06-26 18:19:57',
    '2019-06-26 18:19:57',
    3,
    110
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    233,
    1,
    '20',
    '2019-06-26 18:19:57',
    '2019-06-26 18:19:57',
    13,
    110
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    234,
    1,
    '30',
    '2019-06-26 18:19:57',
    '2019-06-26 18:19:57',
    4,
    110
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    235,
    1,
    '120',
    '2019-06-26 18:19:57',
    '2019-06-26 18:19:57',
    5,
    110
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    236,
    1,
    '20',
    '2019-06-26 18:19:57',
    '2019-06-26 18:19:57',
    12,
    110
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    237,
    1,
    '300',
    '2019-06-26 18:19:57',
    '2019-06-26 18:19:57',
    2,
    110
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    239,
    1,
    '60',
    '2019-06-26 18:23:20',
    '2019-06-26 18:23:20',
    3,
    111
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    240,
    1,
    '20',
    '2019-06-26 18:23:20',
    '2019-06-26 18:23:20',
    13,
    111
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    241,
    1,
    '120',
    '2019-06-26 18:23:20',
    '2019-06-26 18:23:20',
    5,
    111
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    242,
    1,
    '20',
    '2019-06-26 18:23:20',
    '2019-06-26 18:23:20',
    12,
    111
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    243,
    1,
    '30',
    '2019-06-26 18:23:20',
    '2019-06-26 18:23:20',
    4,
    111
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    245,
    1,
    '60',
    '2019-06-26 18:24:46',
    '2019-06-26 18:24:46',
    3,
    112
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    246,
    1,
    '20',
    '2019-06-26 18:24:46',
    '2019-06-26 18:24:46',
    13,
    112
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    247,
    1,
    '120',
    '2019-06-26 18:24:46',
    '2019-06-26 18:24:46',
    5,
    112
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    248,
    1,
    '20',
    '2019-06-26 18:24:46',
    '2019-06-26 18:24:46',
    12,
    112
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    249,
    1,
    '30',
    '2019-06-26 18:24:46',
    '2019-06-26 18:24:46',
    4,
    112
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    250,
    1,
    '300',
    '2019-06-26 18:24:46',
    '2019-06-26 18:24:46',
    2,
    112
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    251,
    1,
    '200',
    '2019-06-26 18:24:46',
    '2019-06-26 18:24:46',
    1,
    112
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    252,
    1,
    '120',
    '2019-06-26 18:24:46',
    '2019-06-26 18:24:46',
    14,
    112
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    253,
    1,
    '500',
    '2019-06-26 18:24:46',
    '2019-06-26 18:24:46',
    15,
    112
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    254,
    1,
    '55',
    '2019-06-26 18:24:46',
    '2019-06-26 18:24:46',
    16,
    112
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    255,
    1,
    '77',
    '2019-06-26 18:24:46',
    '2019-06-26 18:24:46',
    17,
    112
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    256,
    1,
    '47',
    '2019-06-26 18:24:46',
    '2019-06-26 18:24:46',
    18,
    112
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    257,
    1,
    '5',
    '2019-06-26 18:24:46',
    '2019-06-26 18:24:46',
    21,
    112
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    258,
    1,
    '85',
    '2019-06-26 18:24:46',
    '2019-06-26 18:24:46',
    20,
    112
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    259,
    1,
    '95000',
    '2019-06-26 18:24:46',
    '2019-06-26 18:24:46',
    22,
    112
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    260,
    1,
    '47',
    '2019-06-26 18:24:46',
    '2019-06-26 18:24:46',
    19,
    112
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    262,
    1,
    '60',
    '2019-06-26 18:26:57',
    '2019-06-26 18:26:57',
    3,
    113
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    264,
    155,
    '60',
    '2019-06-26 18:27:33',
    '2019-06-26 18:27:33',
    3,
    114
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    266,
    155,
    '60',
    '2019-06-26 18:28:34',
    '2019-06-26 18:28:34',
    3,
    115
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    267,
    155,
    '20',
    '2019-06-26 18:28:34',
    '2019-06-26 18:28:34',
    13,
    115
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    269,
    1,
    '60',
    '2019-06-26 18:29:54',
    '2019-06-26 18:29:54',
    3,
    116
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    270,
    1,
    '20',
    '2019-06-26 18:29:54',
    '2019-06-26 18:29:54',
    13,
    116
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    272,
    145,
    '60',
    '2019-06-26 18:30:29',
    '2019-06-26 18:30:29',
    3,
    117
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    273,
    111,
    '20',
    '2019-06-26 18:30:29',
    '2019-06-26 18:30:29',
    13,
    117
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    275,
    1,
    '60',
    '2019-06-26 18:34:13',
    '2019-06-26 18:34:13',
    3,
    118
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    276,
    1,
    '20',
    '2019-06-26 18:34:13',
    '2019-06-26 18:34:13',
    13,
    118
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    277,
    1,
    '120',
    '2019-06-26 18:34:13',
    '2019-06-26 18:34:13',
    5,
    118
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    278,
    1,
    '20',
    '2019-06-26 18:34:13',
    '2019-06-26 18:34:13',
    12,
    118
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    279,
    1,
    '30',
    '2019-06-26 18:34:13',
    '2019-06-26 18:34:13',
    4,
    118
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    280,
    1,
    '300',
    '2019-06-26 18:34:13',
    '2019-06-26 18:34:13',
    2,
    118
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    281,
    1,
    '200',
    '2019-06-26 18:34:13',
    '2019-06-26 18:34:13',
    1,
    118
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    282,
    1,
    '120',
    '2019-06-26 18:34:13',
    '2019-06-26 18:34:13',
    14,
    118
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    283,
    1,
    '500',
    '2019-06-26 18:34:13',
    '2019-06-26 18:34:13',
    15,
    118
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    284,
    1,
    '55',
    '2019-06-26 18:34:13',
    '2019-06-26 18:34:13',
    16,
    118
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    285,
    1,
    '77',
    '2019-06-26 18:34:13',
    '2019-06-26 18:34:13',
    17,
    118
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    286,
    1,
    '47',
    '2019-06-26 18:34:13',
    '2019-06-26 18:34:13',
    18,
    118
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    287,
    1,
    '85',
    '2019-06-26 18:34:13',
    '2019-06-26 18:34:13',
    20,
    118
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    288,
    1,
    '47',
    '2019-06-26 18:34:13',
    '2019-06-26 18:34:13',
    19,
    118
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    289,
    1,
    '5',
    '2019-06-26 18:34:13',
    '2019-06-26 18:34:13',
    21,
    118
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    290,
    1,
    '95000',
    '2019-06-26 18:34:13',
    '2019-06-26 18:34:13',
    22,
    118
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    292,
    1,
    '60',
    '2019-06-26 18:38:18',
    '2019-06-26 18:38:18',
    3,
    119
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    293,
    1,
    '20',
    '2019-06-26 18:38:18',
    '2019-06-26 18:38:18',
    13,
    119
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    294,
    1,
    '120',
    '2019-06-26 18:38:18',
    '2019-06-26 18:38:18',
    5,
    119
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    295,
    1,
    '20',
    '2019-06-26 18:38:18',
    '2019-06-26 18:38:18',
    12,
    119
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    296,
    1,
    '30',
    '2019-06-26 18:38:18',
    '2019-06-26 18:38:18',
    4,
    119
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    297,
    1,
    '300',
    '2019-06-26 18:38:18',
    '2019-06-26 18:38:18',
    2,
    119
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    298,
    1,
    '200',
    '2019-06-26 18:38:18',
    '2019-06-26 18:38:18',
    1,
    119
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    299,
    1,
    '120',
    '2019-06-26 18:38:18',
    '2019-06-26 18:38:18',
    14,
    119
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    300,
    1,
    '500',
    '2019-06-26 18:38:18',
    '2019-06-26 18:38:18',
    15,
    119
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    301,
    1,
    '77',
    '2019-06-26 18:38:18',
    '2019-06-26 18:38:18',
    17,
    119
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    302,
    1,
    '55',
    '2019-06-26 18:38:18',
    '2019-06-26 18:38:18',
    16,
    119
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    303,
    1,
    '47',
    '2019-06-26 18:38:18',
    '2019-06-26 18:38:18',
    18,
    119
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    304,
    1,
    '47',
    '2019-06-26 18:38:18',
    '2019-06-26 18:38:18',
    19,
    119
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    305,
    1,
    '5',
    '2019-06-26 18:38:18',
    '2019-06-26 18:38:18',
    21,
    119
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    306,
    1,
    '85',
    '2019-06-26 18:38:18',
    '2019-06-26 18:38:18',
    20,
    119
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    307,
    1,
    '95000',
    '2019-06-26 18:38:18',
    '2019-06-26 18:38:18',
    22,
    119
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    309,
    1,
    '47',
    '2019-06-26 18:40:48',
    '2019-06-26 18:40:48',
    18,
    120
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    310,
    1,
    '300',
    '2019-06-26 18:40:48',
    '2019-06-26 18:40:48',
    2,
    120
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    311,
    1,
    '120',
    '2019-06-26 18:40:48',
    '2019-06-26 18:40:48',
    5,
    120
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    313,
    1,
    '47',
    '2019-06-26 18:45:06',
    '2019-06-26 18:45:06',
    19,
    121
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    314,
    1,
    '500',
    '2019-06-26 18:45:06',
    '2019-06-26 18:45:06',
    15,
    121
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    315,
    1,
    '120',
    '2019-06-26 18:45:06',
    '2019-06-26 18:45:06',
    5,
    121
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    316,
    1,
    '47',
    '2019-06-26 18:45:06',
    '2019-06-26 18:45:06',
    19,
    121
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    317,
    1,
    '300',
    '2019-06-26 18:45:06',
    '2019-06-26 18:45:06',
    2,
    121
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    319,
    1,
    '300',
    '2019-06-26 18:48:46',
    '2019-06-26 18:48:46',
    2,
    122
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    320,
    2,
    '500',
    '2019-06-26 18:48:46',
    '2019-06-26 18:48:46',
    15,
    122
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    321,
    3,
    '120',
    '2019-06-26 18:48:46',
    '2019-06-26 18:48:46',
    5,
    122
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    322,
    1,
    '95000',
    '2019-06-26 18:48:46',
    '2019-06-26 18:48:46',
    22,
    122
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    324,
    1,
    '85',
    '2019-06-26 18:54:51',
    '2019-06-26 18:54:51',
    23,
    124
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    325,
    1,
    '60',
    '2019-06-26 18:54:51',
    '2019-06-26 18:54:51',
    3,
    124
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    326,
    1,
    '200',
    '2019-06-26 18:54:51',
    '2019-06-26 18:54:51',
    1,
    124
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    327,
    1,
    '47',
    '2019-06-26 18:54:51',
    '2019-06-26 18:54:51',
    18,
    124
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    329,
    1,
    '60',
    '2019-06-26 18:55:33',
    '2019-06-26 18:55:33',
    3,
    125
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    330,
    1,
    '300',
    '2019-06-26 18:55:33',
    '2019-06-26 18:55:33',
    2,
    125
  );
INSERT INTO
  `listavendas` (
    `id`,
    `quantidade`,
    `preco_venda`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`,
    `VendaId`
  )
VALUES
  (
    332,
    1,
    '20',
    '2019-06-26 18:56:29',
    '2019-06-26 18:56:29',
    13,
    126
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: categorias
# ------------------------------------------------------------

INSERT INTO
  `categorias` (
    `id`,
    `categoria_nome`,
    `categoria_desc`,
    `filename`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    3,
    'Alimentares',
    'Alimentares',
    NULL,
    '2019-02-09 13:46:11',
    '2019-05-08 20:16:37'
  );
INSERT INTO
  `categorias` (
    `id`,
    `categoria_nome`,
    `categoria_desc`,
    `filename`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    4,
    'banana',
    'banana',
    NULL,
    '2019-02-09 13:56:50',
    '2019-05-08 20:16:40'
  );
INSERT INTO
  `categorias` (
    `id`,
    `categoria_nome`,
    `categoria_desc`,
    `filename`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    5,
    'Teste update',
    'Teste Update',
    NULL,
    '2019-06-26 17:32:13',
    '2019-06-26 17:33:44'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: clientes
# ------------------------------------------------------------

INSERT INTO
  `clientes` (
    `id`,
    `cliente_nome`,
    `cliente_nif`,
    `cliente_morada`,
    `cliente_telefone`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    1,
    'VD',
    '',
    '',
    '',
    '2018-12-30 23:20:35',
    '2018-12-30 23:20:35'
  );
INSERT INTO
  `clientes` (
    `id`,
    `cliente_nome`,
    `cliente_nif`,
    `cliente_morada`,
    `cliente_telefone`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    2,
    'Vadnir Vieira',
    '263646737',
    'Terra Branca',
    '5845777',
    '2019-05-13 14:19:19',
    '2019-05-13 14:24:26'
  );
INSERT INTO
  `clientes` (
    `id`,
    `cliente_nome`,
    `cliente_nif`,
    `cliente_morada`,
    `cliente_telefone`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    3,
    'teste',
    '535545445',
    'ttrt',
    '54545',
    '2019-05-13 14:28:56',
    '2019-05-13 14:31:40'
  );
INSERT INTO
  `clientes` (
    `id`,
    `cliente_nome`,
    `cliente_nif`,
    `cliente_morada`,
    `cliente_telefone`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    4,
    NULL,
    NULL,
    NULL,
    NULL,
    '2019-05-13 14:39:57',
    '2019-05-13 14:39:57'
  );
INSERT INTO
  `clientes` (
    `id`,
    `cliente_nome`,
    `cliente_nif`,
    `cliente_morada`,
    `cliente_telefone`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    5,
    'teer',
    '344344334',
    'rerere',
    '43434',
    '2019-05-13 14:40:55',
    '2019-05-13 14:40:55'
  );
INSERT INTO
  `clientes` (
    `id`,
    `cliente_nome`,
    `cliente_nif`,
    `cliente_morada`,
    `cliente_telefone`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    6,
    'Merda',
    '123435667',
    'Merda',
    '1212121',
    '2019-05-13 14:41:15',
    '2019-05-13 14:41:15'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: compras
# ------------------------------------------------------------

INSERT INTO
  `compras` (
    `id`,
    `data_compra`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `FornecedoreId`
  )
VALUES
  (
    1,
    '2019-05-08',
    '2019-05-08 19:53:31',
    '2019-05-08 19:53:31',
    1,
    2
  );
INSERT INTO
  `compras` (
    `id`,
    `data_compra`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `FornecedoreId`
  )
VALUES
  (
    2,
    '2019-05-08',
    '2019-05-08 20:34:11',
    '2019-05-08 20:34:11',
    1,
    2
  );
INSERT INTO
  `compras` (
    `id`,
    `data_compra`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `FornecedoreId`
  )
VALUES
  (
    3,
    '2019-06-04',
    '2019-06-04 12:59:04',
    '2019-06-04 12:59:04',
    1,
    2
  );
INSERT INTO
  `compras` (
    `id`,
    `data_compra`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `FornecedoreId`
  )
VALUES
  (
    4,
    '2019-06-04',
    '2019-06-04 13:01:44',
    '2019-06-04 13:01:44',
    1,
    2
  );
INSERT INTO
  `compras` (
    `id`,
    `data_compra`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `FornecedoreId`
  )
VALUES
  (
    5,
    '2019-06-04',
    '2019-06-04 13:05:44',
    '2019-06-04 13:05:44',
    1,
    2
  );
INSERT INTO
  `compras` (
    `id`,
    `data_compra`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `FornecedoreId`
  )
VALUES
  (
    6,
    '2019-06-04',
    '2019-06-04 13:06:09',
    '2019-06-04 13:06:09',
    1,
    2
  );
INSERT INTO
  `compras` (
    `id`,
    `data_compra`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `FornecedoreId`
  )
VALUES
  (
    7,
    '2019-06-04',
    '2019-06-04 13:07:56',
    '2019-06-04 13:07:56',
    1,
    2
  );
INSERT INTO
  `compras` (
    `id`,
    `data_compra`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `FornecedoreId`
  )
VALUES
  (
    8,
    '2019-06-04',
    '2019-06-04 13:08:29',
    '2019-06-04 13:08:29',
    1,
    2
  );
INSERT INTO
  `compras` (
    `id`,
    `data_compra`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `FornecedoreId`
  )
VALUES
  (
    9,
    '2019-06-26',
    '2019-06-26 16:06:15',
    '2019-06-26 16:06:15',
    1,
    2
  );
INSERT INTO
  `compras` (
    `id`,
    `data_compra`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `FornecedoreId`
  )
VALUES
  (
    10,
    '2019-06-26',
    '2019-06-26 17:52:38',
    '2019-06-26 17:52:38',
    1,
    2
  );
INSERT INTO
  `compras` (
    `id`,
    `data_compra`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `FornecedoreId`
  )
VALUES
  (
    11,
    '2019-06-26',
    '2019-06-26 18:54:18',
    '2019-06-26 18:54:18',
    1,
    2
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: fornecedores
# ------------------------------------------------------------

INSERT INTO
  `fornecedores` (
    `id`,
    `fornecedor_nome`,
    `fornecedor_nif`,
    `fornecedor_endereco`,
    `fornecedor_movel`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    2,
    'Hernani Vieira',
    243546756,
    'Plateau, cabo verde',
    '5467564',
    '2018-12-30 23:20:35',
    '2018-12-30 23:20:35'
  );
INSERT INTO
  `fornecedores` (
    `id`,
    `fornecedor_nome`,
    `fornecedor_nif`,
    `fornecedor_endereco`,
    `fornecedor_movel`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    4,
    'vady',
    233431434,
    'Praia',
    '434343',
    '2019-02-09 16:22:24',
    '2019-02-09 16:22:24'
  );
INSERT INTO
  `fornecedores` (
    `id`,
    `fornecedor_nome`,
    `fornecedor_nif`,
    `fornecedor_endereco`,
    `fornecedor_movel`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    5,
    'tehhgh',
    556565656,
    'fdgfggfg',
    '565656',
    '2019-06-26 16:05:45',
    '2019-06-26 16:05:45'
  );
INSERT INTO
  `fornecedores` (
    `id`,
    `fornecedor_nome`,
    `fornecedor_nif`,
    `fornecedor_endereco`,
    `fornecedor_movel`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    6,
    '33',
    333333333,
    '33',
    '333333',
    '2019-06-26 16:06:02',
    '2019-06-26 16:06:02'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: ivas
# ------------------------------------------------------------

INSERT INTO
  `ivas` (
    `id`,
    `iva_valor`,
    `iva_desc`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    1,
    0,
    '0% cobrado sobre o produto',
    '2018-12-30 23:20:35',
    '2018-12-30 23:20:35'
  );
INSERT INTO
  `ivas` (
    `id`,
    `iva_valor`,
    `iva_desc`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    2,
    15,
    '15% cobrado sobre o produto',
    '2018-12-30 23:20:35',
    '2018-12-30 23:20:35'
  );
INSERT INTO
  `ivas` (
    `id`,
    `iva_valor`,
    `iva_desc`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    3,
    12,
    'dfdf',
    '2019-06-26 16:47:01',
    '2019-06-26 16:47:01'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: listacompras
# ------------------------------------------------------------

INSERT INTO
  `listacompras` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `CompraId`,
    `ProdutoId`
  )
VALUES
  (
    1,
    120,
    '2019-05-08 19:53:46',
    '2019-05-08 20:03:23',
    1,
    2
  );
INSERT INTO
  `listacompras` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `CompraId`,
    `ProdutoId`
  )
VALUES
  (
    2,
    100,
    '2019-05-08 19:53:46',
    '2019-05-08 19:53:46',
    1,
    4
  );
INSERT INTO
  `listacompras` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `CompraId`,
    `ProdutoId`
  )
VALUES
  (
    5,
    50,
    '2019-05-08 20:02:58',
    '2019-05-08 20:02:58',
    1,
    1
  );
INSERT INTO
  `listacompras` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `CompraId`,
    `ProdutoId`
  )
VALUES
  (
    6,
    4,
    '2019-05-08 20:03:26',
    '2019-05-08 20:03:26',
    1,
    3
  );
INSERT INTO
  `listacompras` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `CompraId`,
    `ProdutoId`
  )
VALUES
  (
    7,
    5,
    '2019-05-08 20:20:46',
    '2019-05-08 20:20:46',
    1,
    1
  );
INSERT INTO
  `listacompras` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `CompraId`,
    `ProdutoId`
  )
VALUES
  (
    8,
    1,
    '2019-05-08 20:35:05',
    '2019-05-08 20:35:05',
    2,
    4
  );
INSERT INTO
  `listacompras` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `CompraId`,
    `ProdutoId`
  )
VALUES
  (
    9,
    1,
    '2019-05-08 20:35:05',
    '2019-05-08 20:35:05',
    2,
    3
  );
INSERT INTO
  `listacompras` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `CompraId`,
    `ProdutoId`
  )
VALUES
  (
    10,
    1,
    '2019-05-08 20:35:05',
    '2019-05-08 20:35:05',
    2,
    1
  );
INSERT INTO
  `listacompras` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `CompraId`,
    `ProdutoId`
  )
VALUES
  (
    11,
    1,
    '2019-06-04 13:08:10',
    '2019-06-04 13:08:10',
    7,
    1
  );
INSERT INTO
  `listacompras` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `CompraId`,
    `ProdutoId`
  )
VALUES
  (
    12,
    1,
    '2019-06-04 13:08:10',
    '2019-06-04 13:08:10',
    7,
    5
  );
INSERT INTO
  `listacompras` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `CompraId`,
    `ProdutoId`
  )
VALUES
  (
    13,
    1500,
    '2019-06-26 16:06:32',
    '2019-06-26 16:06:32',
    9,
    5
  );
INSERT INTO
  `listacompras` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `CompraId`,
    `ProdutoId`
  )
VALUES
  (
    15,
    15,
    '2019-06-26 17:55:04',
    '2019-06-26 17:55:04',
    10,
    22
  );
INSERT INTO
  `listacompras` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `CompraId`,
    `ProdutoId`
  )
VALUES
  (
    16,
    15,
    '2019-06-26 17:55:04',
    '2019-06-26 17:55:04',
    10,
    21
  );
INSERT INTO
  `listacompras` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `CompraId`,
    `ProdutoId`
  )
VALUES
  (
    17,
    15,
    '2019-06-26 17:55:04',
    '2019-06-26 17:55:04',
    10,
    18
  );
INSERT INTO
  `listacompras` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `CompraId`,
    `ProdutoId`
  )
VALUES
  (
    18,
    15,
    '2019-06-26 17:55:04',
    '2019-06-26 17:55:04',
    10,
    20
  );
INSERT INTO
  `listacompras` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `CompraId`,
    `ProdutoId`
  )
VALUES
  (
    19,
    15,
    '2019-06-26 17:55:04',
    '2019-06-26 17:55:04',
    10,
    19
  );
INSERT INTO
  `listacompras` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `CompraId`,
    `ProdutoId`
  )
VALUES
  (
    20,
    15,
    '2019-06-26 17:55:04',
    '2019-06-26 17:55:04',
    10,
    17
  );
INSERT INTO
  `listacompras` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `CompraId`,
    `ProdutoId`
  )
VALUES
  (
    21,
    15,
    '2019-06-26 17:55:04',
    '2019-06-26 17:55:04',
    10,
    16
  );
INSERT INTO
  `listacompras` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `CompraId`,
    `ProdutoId`
  )
VALUES
  (
    22,
    15,
    '2019-06-26 17:55:04',
    '2019-06-26 17:55:04',
    10,
    15
  );
INSERT INTO
  `listacompras` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `CompraId`,
    `ProdutoId`
  )
VALUES
  (
    23,
    15,
    '2019-06-26 17:55:04',
    '2019-06-26 17:55:04',
    10,
    14
  );
INSERT INTO
  `listacompras` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `CompraId`,
    `ProdutoId`
  )
VALUES
  (
    24,
    15,
    '2019-06-26 17:55:04',
    '2019-06-26 17:55:04',
    10,
    1
  );
INSERT INTO
  `listacompras` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `CompraId`,
    `ProdutoId`
  )
VALUES
  (
    25,
    15,
    '2019-06-26 17:55:04',
    '2019-06-26 17:55:04',
    10,
    2
  );
INSERT INTO
  `listacompras` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `CompraId`,
    `ProdutoId`
  )
VALUES
  (
    26,
    15,
    '2019-06-26 17:55:04',
    '2019-06-26 17:55:04',
    10,
    4
  );
INSERT INTO
  `listacompras` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `CompraId`,
    `ProdutoId`
  )
VALUES
  (
    27,
    15,
    '2019-06-26 17:55:04',
    '2019-06-26 17:55:04',
    10,
    12
  );
INSERT INTO
  `listacompras` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `CompraId`,
    `ProdutoId`
  )
VALUES
  (
    28,
    15,
    '2019-06-26 17:55:04',
    '2019-06-26 17:55:04',
    10,
    5
  );
INSERT INTO
  `listacompras` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `CompraId`,
    `ProdutoId`
  )
VALUES
  (
    29,
    15,
    '2019-06-26 17:55:04',
    '2019-06-26 17:55:04',
    10,
    13
  );
INSERT INTO
  `listacompras` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `CompraId`,
    `ProdutoId`
  )
VALUES
  (
    30,
    5,
    '2019-06-26 17:55:04',
    '2019-06-26 17:55:04',
    10,
    3
  );
INSERT INTO
  `listacompras` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `CompraId`,
    `ProdutoId`
  )
VALUES
  (
    32,
    19,
    '2019-06-26 18:54:28',
    '2019-06-26 18:54:28',
    11,
    23
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: cbarras
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: lojas
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: meiopagamentos
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: produtos
# ------------------------------------------------------------

INSERT INTO
  `produtos` (
    `id`,
    `produto_code`,
    `produto_nome`,
    `produto_nome_rec`,
    `produto_barcode`,
    `produto_preco`,
    `filename`,
    `createdAt`,
    `updatedAt`,
    `FornecedoreId`,
    `IvaId`,
    `CategoriaId`
  )
VALUES
  (
    1,
    '10',
    'xxxxxxxxxx',
    'xxxxxxxxxx',
    '522532555335',
    200,
    'file-1557346716803-WwW.ThePiRaTeFiLmEs.CoM.jpg',
    '2019-02-07 22:25:12',
    '2019-06-26 17:41:59',
    2,
    2,
    3
  );
INSERT INTO
  `produtos` (
    `id`,
    `produto_code`,
    `produto_nome`,
    `produto_nome_rec`,
    `produto_barcode`,
    `produto_preco`,
    `filename`,
    `createdAt`,
    `updatedAt`,
    `FornecedoreId`,
    `IvaId`,
    `CategoriaId`
  )
VALUES
  (
    2,
    '9',
    'xxxxxxxxx',
    'pera verde',
    'null',
    100,
    NULL,
    '2019-02-08 23:34:21',
    '2019-06-26 17:41:40',
    2,
    1,
    4
  );
INSERT INTO
  `produtos` (
    `id`,
    `produto_code`,
    `produto_nome`,
    `produto_nome_rec`,
    `produto_barcode`,
    `produto_preco`,
    `filename`,
    `createdAt`,
    `updatedAt`,
    `FornecedoreId`,
    `IvaId`,
    `CategoriaId`
  )
VALUES
  (
    3,
    '4',
    'xxxx',
    'xxxx',
    'null',
    50,
    NULL,
    '2019-02-09 00:07:46',
    '2019-06-26 17:40:23',
    4,
    1,
    3
  );
INSERT INTO
  `produtos` (
    `id`,
    `produto_code`,
    `produto_nome`,
    `produto_nome_rec`,
    `produto_barcode`,
    `produto_preco`,
    `filename`,
    `createdAt`,
    `updatedAt`,
    `FornecedoreId`,
    `IvaId`,
    `CategoriaId`
  )
VALUES
  (
    4,
    '8',
    'xxxxxxxx',
    'xxxxxxxx',
    '525252525252',
    10,
    NULL,
    '2019-02-13 09:53:36',
    '2019-06-26 17:41:21',
    2,
    1,
    3
  );
INSERT INTO
  `produtos` (
    `id`,
    `produto_code`,
    `produto_nome`,
    `produto_nome_rec`,
    `produto_barcode`,
    `produto_preco`,
    `filename`,
    `createdAt`,
    `updatedAt`,
    `FornecedoreId`,
    `IvaId`,
    `CategoriaId`
  )
VALUES
  (
    5,
    '6',
    'xxxxxx',
    'banana',
    'null',
    120,
    NULL,
    '2019-05-08 20:36:26',
    '2019-06-26 17:41:02',
    4,
    2,
    3
  );
INSERT INTO
  `produtos` (
    `id`,
    `produto_code`,
    `produto_nome`,
    `produto_nome_rec`,
    `produto_barcode`,
    `produto_preco`,
    `filename`,
    `createdAt`,
    `updatedAt`,
    `FornecedoreId`,
    `IvaId`,
    `CategoriaId`
  )
VALUES
  (
    12,
    '7',
    'xxxxxxx',
    'xxxxxxx',
    NULL,
    10,
    NULL,
    '2019-06-26 16:30:08',
    '2019-06-26 17:39:40',
    2,
    1,
    3
  );
INSERT INTO
  `produtos` (
    `id`,
    `produto_code`,
    `produto_nome`,
    `produto_nome_rec`,
    `produto_barcode`,
    `produto_preco`,
    `filename`,
    `createdAt`,
    `updatedAt`,
    `FornecedoreId`,
    `IvaId`,
    `CategoriaId`
  )
VALUES
  (
    13,
    '5',
    'xxxxx',
    'xxxxx',
    '',
    20,
    NULL,
    '2019-06-26 17:37:45',
    '2019-06-26 17:40:37',
    2,
    2,
    3
  );
INSERT INTO
  `produtos` (
    `id`,
    `produto_code`,
    `produto_nome`,
    `produto_nome_rec`,
    `produto_barcode`,
    `produto_preco`,
    `filename`,
    `createdAt`,
    `updatedAt`,
    `FornecedoreId`,
    `IvaId`,
    `CategoriaId`
  )
VALUES
  (
    14,
    '11',
    'xxxxxxxxxxx',
    'xxxxxxxxxxx',
    NULL,
    120,
    NULL,
    '2019-06-26 17:42:31',
    '2019-06-26 17:42:31',
    2,
    2,
    4
  );
INSERT INTO
  `produtos` (
    `id`,
    `produto_code`,
    `produto_nome`,
    `produto_nome_rec`,
    `produto_barcode`,
    `produto_preco`,
    `filename`,
    `createdAt`,
    `updatedAt`,
    `FornecedoreId`,
    `IvaId`,
    `CategoriaId`
  )
VALUES
  (
    15,
    '12',
    'xxxxxxxxxxxx',
    'galinha perna 18g',
    NULL,
    500,
    NULL,
    '2019-06-26 17:44:34',
    '2019-06-26 17:44:34',
    5,
    1,
    3
  );
INSERT INTO
  `produtos` (
    `id`,
    `produto_code`,
    `produto_nome`,
    `produto_nome_rec`,
    `produto_barcode`,
    `produto_preco`,
    `filename`,
    `createdAt`,
    `updatedAt`,
    `FornecedoreId`,
    `IvaId`,
    `CategoriaId`
  )
VALUES
  (
    16,
    '13',
    'xxxxxxxxxxxxx',
    'xxxxxxxxxxxxx',
    NULL,
    55,
    NULL,
    '2019-06-26 17:44:59',
    '2019-06-26 17:44:59',
    2,
    1,
    4
  );
INSERT INTO
  `produtos` (
    `id`,
    `produto_code`,
    `produto_nome`,
    `produto_nome_rec`,
    `produto_barcode`,
    `produto_preco`,
    `filename`,
    `createdAt`,
    `updatedAt`,
    `FornecedoreId`,
    `IvaId`,
    `CategoriaId`
  )
VALUES
  (
    17,
    '14',
    'xxxxxxxxxxxxxx',
    'xxxxxxxxxxxxxx',
    NULL,
    77,
    NULL,
    '2019-06-26 17:45:59',
    '2019-06-26 17:45:59',
    5,
    1,
    5
  );
INSERT INTO
  `produtos` (
    `id`,
    `produto_code`,
    `produto_nome`,
    `produto_nome_rec`,
    `produto_barcode`,
    `produto_preco`,
    `filename`,
    `createdAt`,
    `updatedAt`,
    `FornecedoreId`,
    `IvaId`,
    `CategoriaId`
  )
VALUES
  (
    18,
    '15',
    'xxxxxxxxxxxxxxx',
    'xxxxxxxxxxxxxxx',
    NULL,
    45,
    NULL,
    '2019-06-26 17:47:13',
    '2019-06-26 17:47:13',
    5,
    1,
    5
  );
INSERT INTO
  `produtos` (
    `id`,
    `produto_code`,
    `produto_nome`,
    `produto_nome_rec`,
    `produto_barcode`,
    `produto_preco`,
    `filename`,
    `createdAt`,
    `updatedAt`,
    `FornecedoreId`,
    `IvaId`,
    `CategoriaId`
  )
VALUES
  (
    19,
    '16',
    'xxxxxxxxxxxxxxxx',
    'xxxxxxxxxxxxxxxx',
    NULL,
    45,
    NULL,
    '2019-06-26 17:48:45',
    '2019-06-26 17:48:45',
    5,
    1,
    5
  );
INSERT INTO
  `produtos` (
    `id`,
    `produto_code`,
    `produto_nome`,
    `produto_nome_rec`,
    `produto_barcode`,
    `produto_preco`,
    `filename`,
    `createdAt`,
    `updatedAt`,
    `FornecedoreId`,
    `IvaId`,
    `CategoriaId`
  )
VALUES
  (
    20,
    '17',
    'xxxxxxxxxxxxxxxxx',
    'xxxxxxxxxxxxxxxxx',
    NULL,
    85,
    NULL,
    '2019-06-26 17:49:21',
    '2019-06-26 17:49:21',
    2,
    1,
    3
  );
INSERT INTO
  `produtos` (
    `id`,
    `produto_code`,
    `produto_nome`,
    `produto_nome_rec`,
    `produto_barcode`,
    `produto_preco`,
    `filename`,
    `createdAt`,
    `updatedAt`,
    `FornecedoreId`,
    `IvaId`,
    `CategoriaId`
  )
VALUES
  (
    21,
    '18',
    'xxxxxxxxxxxxxxxxxx',
    'xxxxxxxxxxxxxxxxxx',
    NULL,
    5,
    NULL,
    '2019-06-26 17:50:22',
    '2019-06-26 17:50:22',
    2,
    3,
    3
  );
INSERT INTO
  `produtos` (
    `id`,
    `produto_code`,
    `produto_nome`,
    `produto_nome_rec`,
    `produto_barcode`,
    `produto_preco`,
    `filename`,
    `createdAt`,
    `updatedAt`,
    `FornecedoreId`,
    `IvaId`,
    `CategoriaId`
  )
VALUES
  (
    22,
    '19',
    'xxxxxxxxxxxxxxxxxxx',
    'xxxxxxxxxxxxxxxxxxx',
    NULL,
    90000,
    NULL,
    '2019-06-26 17:50:48',
    '2019-06-26 17:50:48',
    4,
    1,
    4
  );
INSERT INTO
  `produtos` (
    `id`,
    `produto_code`,
    `produto_nome`,
    `produto_nome_rec`,
    `produto_barcode`,
    `produto_preco`,
    `filename`,
    `createdAt`,
    `updatedAt`,
    `FornecedoreId`,
    `IvaId`,
    `CategoriaId`
  )
VALUES
  (
    23,
    '20',
    'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
    'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
    '\\',
    45,
    NULL,
    '2019-06-26 18:54:02',
    '2019-06-26 18:54:02',
    2,
    1,
    3
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: pvendas
# ------------------------------------------------------------

INSERT INTO
  `pvendas` (
    `id`,
    `pvenda_preco`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    1,
    200,
    '2019-02-07 22:25:26',
    '2019-06-26 17:41:58',
    1
  );
INSERT INTO
  `pvendas` (
    `id`,
    `pvenda_preco`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    2,
    300,
    '2019-02-07 22:25:26',
    '2019-06-26 17:41:58',
    1
  );
INSERT INTO
  `pvendas` (
    `id`,
    `pvenda_preco`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    3,
    300,
    '2019-02-08 23:34:24',
    '2019-06-26 17:41:40',
    2
  );
INSERT INTO
  `pvendas` (
    `id`,
    `pvenda_preco`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    4,
    60,
    '2019-02-09 00:07:51',
    '2019-06-26 17:40:23',
    3
  );
INSERT INTO
  `pvendas` (
    `id`,
    `pvenda_preco`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    5,
    30,
    '2019-02-13 09:53:40',
    '2019-06-26 17:41:21',
    4
  );
INSERT INTO
  `pvendas` (
    `id`,
    `pvenda_preco`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    6,
    20,
    '2019-02-13 09:56:29',
    '2019-02-13 09:56:29',
    NULL
  );
INSERT INTO
  `pvendas` (
    `id`,
    `pvenda_preco`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    7,
    120,
    '2019-05-08 20:38:31',
    '2019-06-26 17:41:01',
    5
  );
INSERT INTO
  `pvendas` (
    `id`,
    `pvenda_preco`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    8,
    130,
    '2019-05-08 20:38:31',
    '2019-06-26 17:41:01',
    5
  );
INSERT INTO
  `pvendas` (
    `id`,
    `pvenda_preco`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    9,
    50,
    '2019-06-26 15:03:37',
    '2019-06-26 17:41:01',
    5
  );
INSERT INTO
  `pvendas` (
    `id`,
    `pvenda_preco`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    10,
    50,
    '2019-06-26 15:04:38',
    '2019-06-26 17:41:01',
    5
  );
INSERT INTO
  `pvendas` (
    `id`,
    `pvenda_preco`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    11,
    50,
    '2019-06-26 15:05:30',
    '2019-06-26 17:41:01',
    5
  );
INSERT INTO
  `pvendas` (
    `id`,
    `pvenda_preco`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    12,
    20,
    '2019-06-26 15:06:36',
    '2019-06-26 17:41:01',
    5
  );
INSERT INTO
  `pvendas` (
    `id`,
    `pvenda_preco`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    13,
    20,
    '2019-06-26 15:07:57',
    '2019-06-26 17:41:01',
    5
  );
INSERT INTO
  `pvendas` (
    `id`,
    `pvenda_preco`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    14,
    30,
    '2019-06-26 15:08:42',
    '2019-06-26 17:41:01',
    5
  );
INSERT INTO
  `pvendas` (
    `id`,
    `pvenda_preco`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    15,
    454,
    '2019-06-26 15:59:37',
    '2019-06-26 15:59:37',
    NULL
  );
INSERT INTO
  `pvendas` (
    `id`,
    `pvenda_preco`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    16,
    20,
    '2019-06-26 16:38:15',
    '2019-06-26 17:39:40',
    12
  );
INSERT INTO
  `pvendas` (
    `id`,
    `pvenda_preco`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    17,
    20,
    '2019-06-26 17:37:53',
    '2019-06-26 17:40:37',
    13
  );
INSERT INTO
  `pvendas` (
    `id`,
    `pvenda_preco`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    18,
    120,
    '2019-06-26 17:42:36',
    '2019-06-26 17:42:36',
    14
  );
INSERT INTO
  `pvendas` (
    `id`,
    `pvenda_preco`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    19,
    500,
    '2019-06-26 17:43:13',
    '2019-06-26 17:43:13',
    14
  );
INSERT INTO
  `pvendas` (
    `id`,
    `pvenda_preco`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    20,
    500,
    '2019-06-26 17:44:39',
    '2019-06-26 17:44:39',
    15
  );
INSERT INTO
  `pvendas` (
    `id`,
    `pvenda_preco`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    21,
    55,
    '2019-06-26 17:45:01',
    '2019-06-26 17:45:01',
    16
  );
INSERT INTO
  `pvendas` (
    `id`,
    `pvenda_preco`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    22,
    77,
    '2019-06-26 17:46:01',
    '2019-06-26 17:46:01',
    17
  );
INSERT INTO
  `pvendas` (
    `id`,
    `pvenda_preco`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    23,
    47,
    '2019-06-26 17:47:20',
    '2019-06-26 17:47:20',
    18
  );
INSERT INTO
  `pvendas` (
    `id`,
    `pvenda_preco`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    24,
    47,
    '2019-06-26 17:47:25',
    '2019-06-26 17:47:25',
    18
  );
INSERT INTO
  `pvendas` (
    `id`,
    `pvenda_preco`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    25,
    47,
    '2019-06-26 17:48:48',
    '2019-06-26 17:48:48',
    19
  );
INSERT INTO
  `pvendas` (
    `id`,
    `pvenda_preco`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    26,
    85,
    '2019-06-26 17:49:25',
    '2019-06-26 17:49:25',
    20
  );
INSERT INTO
  `pvendas` (
    `id`,
    `pvenda_preco`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    27,
    5,
    '2019-06-26 17:50:25',
    '2019-06-26 17:50:25',
    21
  );
INSERT INTO
  `pvendas` (
    `id`,
    `pvenda_preco`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    28,
    95000,
    '2019-06-26 17:50:57',
    '2019-06-26 17:50:57',
    22
  );
INSERT INTO
  `pvendas` (
    `id`,
    `pvenda_preco`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    29,
    85,
    '2019-06-26 18:54:07',
    '2019-06-26 18:54:07',
    23
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: stocks
# ------------------------------------------------------------

INSERT INTO
  `stocks` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    1,
    7,
    '2019-02-07 22:25:28',
    '2019-06-26 18:54:51',
    1
  );
INSERT INTO
  `stocks` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    2,
    114,
    '2019-02-08 23:34:25',
    '2019-06-26 18:55:33',
    2
  );
INSERT INTO
  `stocks` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    3,
    -421,
    '2019-02-09 00:07:52',
    '2019-06-26 18:55:33',
    3
  );
INSERT INTO
  `stocks` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    4,
    90,
    '2019-02-13 09:53:41',
    '2019-06-26 18:38:18',
    4
  );
INSERT INTO
  `stocks` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    5,
    1502,
    '2019-05-08 20:36:26',
    '2019-06-26 18:48:46',
    5
  );
INSERT INTO
  `stocks` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    6,
    0,
    '2019-06-26 15:59:30',
    '2019-06-26 15:59:30',
    NULL
  );
INSERT INTO
  `stocks` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    7,
    0,
    '2019-06-26 16:21:26',
    '2019-06-26 16:21:26',
    NULL
  );
INSERT INTO
  `stocks` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    8,
    0,
    '2019-06-26 16:23:01',
    '2019-06-26 16:23:01',
    NULL
  );
INSERT INTO
  `stocks` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    9,
    0,
    '2019-06-26 16:23:20',
    '2019-06-26 16:23:20',
    NULL
  );
INSERT INTO
  `stocks` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    10,
    0,
    '2019-06-26 16:23:26',
    '2019-06-26 16:23:26',
    NULL
  );
INSERT INTO
  `stocks` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    11,
    0,
    '2019-06-26 16:28:56',
    '2019-06-26 16:28:56',
    NULL
  );
INSERT INTO
  `stocks` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    12,
    1,
    '2019-06-26 16:30:08',
    '2019-06-26 18:38:18',
    12
  );
INSERT INTO
  `stocks` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    13,
    -267,
    '2019-06-26 17:37:45',
    '2019-06-26 18:56:29',
    13
  );
INSERT INTO
  `stocks` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    14,
    8,
    '2019-06-26 17:42:32',
    '2019-06-26 18:38:18',
    14
  );
INSERT INTO
  `stocks` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    15,
    8,
    '2019-06-26 17:43:07',
    '2019-06-26 18:38:18',
    14
  );
INSERT INTO
  `stocks` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    16,
    5,
    '2019-06-26 17:44:34',
    '2019-06-26 18:48:46',
    15
  );
INSERT INTO
  `stocks` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    17,
    9,
    '2019-06-26 17:44:59',
    '2019-06-26 18:38:18',
    16
  );
INSERT INTO
  `stocks` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    18,
    7,
    '2019-06-26 17:45:59',
    '2019-06-26 18:38:18',
    17
  );
INSERT INTO
  `stocks` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    19,
    3,
    '2019-06-26 17:47:13',
    '2019-06-26 18:54:51',
    18
  );
INSERT INTO
  `stocks` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    20,
    7,
    '2019-06-26 17:48:45',
    '2019-06-26 18:45:07',
    19
  );
INSERT INTO
  `stocks` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    21,
    5,
    '2019-06-26 17:49:21',
    '2019-06-26 18:38:18',
    20
  );
INSERT INTO
  `stocks` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    22,
    7,
    '2019-06-26 17:50:22',
    '2019-06-26 18:38:18',
    21
  );
INSERT INTO
  `stocks` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    23,
    9,
    '2019-06-26 17:50:48',
    '2019-06-26 18:48:46',
    22
  );
INSERT INTO
  `stocks` (
    `id`,
    `quantidade`,
    `createdAt`,
    `updatedAt`,
    `ProdutoId`
  )
VALUES
  (
    24,
    18,
    '2019-06-26 18:54:02',
    '2019-06-26 18:54:51',
    23
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: users
# ------------------------------------------------------------

INSERT INTO
  `users` (
    `id`,
    `nome`,
    `usuario`,
    `password`,
    `nivel`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `LojaId`
  )
VALUES
  (
    1,
    'Administrador do sistema',
    'admin',
    '$2a$08$nBZrD6RScGMPzJ/EEjaUdOSlRt1R0A3QC0afrLpYPlNbLeUEkZSVK',
    1,
    1,
    '2018-12-30 23:20:34',
    '2018-12-30 23:20:34',
    NULL
  );
INSERT INTO
  `users` (
    `id`,
    `nome`,
    `usuario`,
    `password`,
    `nivel`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `LojaId`
  )
VALUES
  (
    2,
    'Vendedor do sistema',
    'vendedor',
    '$2a$08$4VgnZ.OfrTBMhehiTRL6PuP61Cef6wr52IGxE5fSU64zToKeO135y',
    2,
    1,
    '2018-12-30 23:20:34',
    '2018-12-30 23:20:34',
    NULL
  );
INSERT INTO
  `users` (
    `id`,
    `nome`,
    `usuario`,
    `password`,
    `nivel`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `LojaId`
  )
VALUES
  (
    3,
    'Adilson de brito',
    'teste',
    '$2a$08$Tez29sZ1U6TVzQMHVpTxVe46sqppKIzmhbmaZVcxj4fBpXEURVYIq',
    1,
    1,
    '2018-12-30 23:22:12',
    '2018-12-30 23:23:10',
    NULL
  );
INSERT INTO
  `users` (
    `id`,
    `nome`,
    `usuario`,
    `password`,
    `nivel`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `LojaId`
  )
VALUES
  (
    4,
    'fgg',
    'fgfgf',
    '$2a$08$Igl4vh7k5nyTc/XlICQC/OPdabvBRtjSMC/Oyrmc4OcTeTTunCjZW',
    1,
    1,
    '2019-05-14 19:19:01',
    '2019-05-14 19:19:01',
    NULL
  );
INSERT INTO
  `users` (
    `id`,
    `nome`,
    `usuario`,
    `password`,
    `nivel`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `LojaId`
  )
VALUES
  (
    5,
    'dddd',
    'dddd',
    '$2a$08$tSLJjGMpiiTMzEmZJUi3Je5.DuaTa/9I0l58V/amZonqGBznT0B.i',
    1,
    1,
    '2019-06-26 16:45:26',
    '2019-06-26 16:45:26',
    NULL
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: vendas
# ------------------------------------------------------------

INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    1,
    '2019-05-08',
    'Dinheiro',
    250,
    'Vint4',
    0,
    'Cheque',
    0,
    230,
    30,
    20,
    'vendido',
    '2019-05-08 17:33:31',
    '2019-05-08 17:34:32',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    2,
    '2019-05-08',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-05-08 17:34:32',
    '2019-05-08 17:34:32',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    3,
    '2019-05-08',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-05-08 20:13:05',
    '2019-05-08 20:13:05',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    4,
    '2019-05-08',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-05-08 20:46:23',
    '2019-05-08 20:46:23',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    11,
    '2019-05-13',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-05-13 14:04:25',
    '2019-05-13 14:04:25',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    12,
    '2019-05-14',
    'Dinheiro',
    2000,
    'Vint4',
    0,
    'Cheque',
    0,
    2000,
    30,
    0,
    'vendido',
    '2019-05-14 14:17:05',
    '2019-05-14 14:17:23',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    13,
    '2019-05-14',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-05-14 14:17:23',
    '2019-05-14 14:17:23',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    14,
    '2019-05-14',
    'Dinheiro',
    100,
    'Vint4',
    0,
    'Cheque',
    0,
    60,
    0,
    40,
    'vendido',
    '2019-05-14 14:18:00',
    '2019-05-14 14:18:21',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    15,
    '2019-05-14',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-05-14 14:18:21',
    '2019-05-14 14:18:21',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    16,
    '2019-05-14',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-05-14 19:25:53',
    '2019-05-14 19:25:53',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    17,
    '2019-05-14',
    'Dinheiro',
    50,
    'Vint4',
    0,
    'Cheque',
    0,
    30,
    0,
    20,
    'vendido',
    '2019-05-14 19:49:39',
    '2019-05-14 19:49:53',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    18,
    '2019-05-14',
    'Dinheiro',
    500,
    'Vint4',
    0,
    'Cheque',
    0,
    430,
    60,
    70,
    'vendido',
    '2019-05-14 19:49:53',
    '2019-06-06 20:04:02',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    19,
    '2019-05-14',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-05-14 20:08:49',
    '2019-05-14 20:08:49',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    20,
    '2019-05-29',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-05-29 15:42:30',
    '2019-05-29 15:42:30',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    21,
    '2019-05-29',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-05-29 15:46:45',
    '2019-05-29 15:46:45',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    22,
    '2019-06-04',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-04 12:50:25',
    '2019-06-04 12:50:25',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    23,
    '2019-06-04',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-04 12:53:57',
    '2019-06-04 12:53:57',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    24,
    '2019-06-04',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-04 13:08:21',
    '2019-06-04 13:08:21',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    25,
    '2019-06-04',
    'Dinheiro',
    400,
    'Vint4',
    0,
    'Cheque',
    0,
    320,
    48,
    80,
    'vendido',
    '2019-06-04 13:21:32',
    '2019-06-04 13:21:58',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    26,
    '2019-06-04',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-04 13:21:58',
    '2019-06-04 13:21:58',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    27,
    '2019-06-06',
    'Dinheiro',
    1000,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    800,
    'vendido',
    '2019-06-06 18:04:12',
    '2019-06-06 18:32:16',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    28,
    '2019-06-06',
    'Dinheiro',
    500,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    300,
    'vendido',
    '2019-06-06 18:32:16',
    '2019-06-06 18:37:25',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    29,
    '2019-06-06',
    'Dinheiro',
    200,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    0,
    'vendido',
    '2019-06-06 18:37:25',
    '2019-06-06 18:37:59',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    30,
    '2019-06-06',
    'Dinheiro',
    1000,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    800,
    'vendido',
    '2019-06-06 18:37:59',
    '2019-06-06 18:38:12',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    31,
    '2019-06-06',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-06 18:38:12',
    '2019-06-06 18:38:12',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    32,
    '2019-06-06',
    'Dinheiro',
    500,
    'Vint4',
    0,
    'Cheque',
    0,
    230,
    30,
    270,
    'vendido',
    '2019-06-06 18:46:23',
    '2019-06-06 18:46:55',
    2,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    33,
    '2019-06-06',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-06 18:46:55',
    '2019-06-06 18:46:55',
    2,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    34,
    '2019-06-06',
    'Dinheiro',
    300,
    'Vint4',
    0,
    'Cheque',
    0,
    230,
    30,
    70,
    'vendido',
    '2019-06-06 18:46:55',
    '2019-06-06 18:47:25',
    2,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    35,
    '2019-06-06',
    'Dinheiro',
    400,
    'Vint4',
    0,
    'Cheque',
    0,
    230,
    30,
    170,
    'vendido',
    '2019-06-06 18:47:25',
    '2019-06-06 18:47:51',
    2,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    36,
    '2019-06-06',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-06 18:47:51',
    '2019-06-06 18:47:51',
    2,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    37,
    '2019-06-06',
    'Dinheiro',
    200,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    0,
    'vendido',
    '2019-06-06 18:47:51',
    '2019-06-06 18:56:05',
    2,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    38,
    '2019-06-06',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-06 18:56:05',
    '2019-06-06 18:56:05',
    2,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    39,
    '2019-06-06',
    'Dinheiro',
    200,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    0,
    'vendido',
    '2019-06-06 18:56:05',
    '2019-06-06 19:09:12',
    2,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    40,
    '2019-06-06',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-06 19:09:10',
    '2019-06-06 19:09:10',
    2,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    41,
    '2019-06-06',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-06 19:09:10',
    '2019-06-06 19:09:10',
    2,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    42,
    '2019-06-06',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-06 19:09:10',
    '2019-06-06 19:09:10',
    2,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    43,
    '2019-06-06',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-06 19:09:11',
    '2019-06-06 19:09:11',
    2,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    44,
    '2019-06-06',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-06 19:09:11',
    '2019-06-06 19:09:11',
    2,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    45,
    '2019-06-06',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-06 19:09:11',
    '2019-06-06 19:09:11',
    2,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    46,
    '2019-06-06',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-06 19:09:11',
    '2019-06-06 19:09:11',
    2,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    47,
    '2019-06-06',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-06 19:09:11',
    '2019-06-06 19:09:11',
    2,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    48,
    '2019-06-06',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-06 19:22:50',
    '2019-06-06 19:22:50',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    49,
    '2019-06-06',
    'Dinheiro',
    300,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    100,
    'vendido',
    '2019-06-06 19:23:04',
    '2019-06-06 19:23:19',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    50,
    '2019-06-06',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-06 19:23:18',
    '2019-06-06 19:23:18',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    51,
    '2019-06-06',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-06 19:23:18',
    '2019-06-06 19:23:18',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    52,
    '2019-06-06',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-06 19:23:18',
    '2019-06-06 19:23:18',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    53,
    '2019-06-06',
    'Dinheiro',
    300,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    100,
    'vendido',
    '2019-06-06 19:23:19',
    '2019-06-06 19:33:42',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    54,
    '2019-06-06',
    'Dinheiro',
    0,
    'Vint4',
    0,
    'Cheque',
    0,
    120,
    18,
    NULL,
    'vendido',
    '2019-06-06 19:33:42',
    '2019-06-06 19:33:58',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    55,
    '2019-06-06',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-06 19:33:58',
    '2019-06-06 19:33:58',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    56,
    '2019-06-06',
    'Dinheiro',
    0,
    'Vint4',
    0,
    'Cheque',
    0,
    120,
    18,
    NULL,
    'vendido',
    '2019-06-06 19:38:38',
    '2019-06-06 19:39:01',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    57,
    '2019-06-06',
    'Dinheiro',
    0,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    NULL,
    'vendido',
    '2019-06-06 19:39:01',
    '2019-06-06 19:44:13',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    58,
    '2019-06-06',
    'Dinheiro',
    20,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    -180,
    'vendido',
    '2019-06-06 19:44:13',
    '2019-06-06 19:54:37',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    59,
    '2019-06-06',
    'Dinheiro',
    20,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    -180,
    'vendido',
    '2019-06-06 19:54:37',
    '2019-06-06 19:59:36',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    60,
    '2019-06-06',
    'Dinheiro',
    300,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    100,
    'vendido',
    '2019-06-06 19:59:36',
    '2019-06-06 20:01:14',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    61,
    '2019-06-06',
    'Dinheiro',
    300,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    100,
    'vendido',
    '2019-06-06 20:01:14',
    '2019-06-06 20:01:36',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    62,
    '2019-06-06',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-06 20:01:36',
    '2019-06-06 20:01:36',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    63,
    '2019-06-06',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-06 20:04:02',
    '2019-06-06 20:04:02',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    64,
    '2019-06-06',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-06 20:15:48',
    '2019-06-06 20:15:48',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    65,
    '2019-06-06',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-06 20:29:14',
    '2019-06-06 20:29:14',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    66,
    '2019-06-26',
    'Dinheiro',
    201,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    1,
    'vendido',
    '2019-06-26 10:08:15',
    '2019-06-26 10:08:44',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    67,
    '2019-06-26',
    'Dinheiro',
    300,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    100,
    'vendido',
    '2019-06-26 10:08:44',
    '2019-06-26 11:07:30',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    68,
    '2019-06-26',
    'Dinheiro',
    300,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    100,
    'vendido',
    '2019-06-26 11:07:30',
    '2019-06-26 11:08:02',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    69,
    '2019-06-26',
    'Dinheiro',
    300,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    100,
    'vendido',
    '2019-06-26 11:08:02',
    '2019-06-26 11:08:19',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    70,
    '2019-06-26',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-26 11:08:19',
    '2019-06-26 11:08:19',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    71,
    '2019-06-26',
    'Dinheiro',
    300,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    100,
    'vendido',
    '2019-06-26 11:17:09',
    '2019-06-26 11:17:25',
    2,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    72,
    '2019-06-26',
    'Dinheiro',
    300,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    100,
    'vendido',
    '2019-06-26 11:17:25',
    '2019-06-26 11:26:28',
    2,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    73,
    '2019-06-26',
    'Dinheiro',
    300,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    100,
    'vendido',
    '2019-06-26 11:26:28',
    '2019-06-26 11:44:11',
    2,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    74,
    '2019-06-26',
    'Dinheiro',
    300,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    100,
    'vendido',
    '2019-06-26 11:44:11',
    '2019-06-26 11:45:35',
    2,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    75,
    '2019-06-26',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-26 11:45:35',
    '2019-06-26 11:45:35',
    2,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    76,
    '2019-06-26',
    'Dinheiro',
    300,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    100,
    'vendido',
    '2019-06-26 12:39:53',
    '2019-06-26 12:40:01',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    77,
    '2019-06-26',
    'Dinheiro',
    300,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    100,
    'vendido',
    '2019-06-26 12:40:01',
    '2019-06-26 12:41:35',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    78,
    '2019-06-26',
    'Dinheiro',
    300,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    100,
    'vendido',
    '2019-06-26 12:41:35',
    '2019-06-26 12:57:10',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    79,
    '2019-06-26',
    'Dinheiro',
    300,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    100,
    'vendido',
    '2019-06-26 12:57:10',
    '2019-06-26 12:57:23',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    80,
    '2019-06-26',
    'Dinheiro',
    300,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    100,
    'vendido',
    '2019-06-26 12:57:23',
    '2019-06-26 12:57:46',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    81,
    '2019-06-26',
    'Dinheiro',
    300,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    100,
    'vendido',
    '2019-06-26 12:57:47',
    '2019-06-26 12:59:32',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    82,
    '2019-06-26',
    'Dinheiro',
    300,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    100,
    'vendido',
    '2019-06-26 12:59:32',
    '2019-06-26 13:11:57',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    83,
    '2019-06-26',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-26 13:11:57',
    '2019-06-26 13:11:57',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    84,
    '2019-06-26',
    'Dinheiro',
    300,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    100,
    'vendido',
    '2019-06-26 13:44:04',
    '2019-06-26 13:44:12',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    85,
    '2019-06-26',
    'Dinheiro',
    300,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    100,
    'vendido',
    '2019-06-26 13:44:12',
    '2019-06-26 13:47:04',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    86,
    '2019-06-26',
    'Dinheiro',
    300,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    100,
    'vendido',
    '2019-06-26 13:47:04',
    '2019-06-26 13:50:15',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    87,
    '2019-06-26',
    'Dinheiro',
    3000,
    'Vint4',
    0,
    'Cheque',
    0,
    200,
    30,
    2800,
    'vendido',
    '2019-06-26 13:50:15',
    '2019-06-26 13:51:18',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    88,
    '2019-06-26',
    'Dinheiro',
    400,
    'Vint4',
    0,
    'Cheque',
    0,
    350,
    48,
    50,
    'vendido',
    '2019-06-26 13:51:18',
    '2019-06-26 13:59:07',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    89,
    '2019-06-26',
    'Dinheiro',
    12000,
    'Vint4',
    0,
    'Cheque',
    0,
    120,
    18,
    11880,
    'vendido',
    '2019-06-26 13:59:07',
    '2019-06-26 14:00:15',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    90,
    '2019-06-26',
    'Dinheiro',
    12000,
    'Vint4',
    0,
    'Cheque',
    0,
    120,
    18,
    11880,
    'vendido',
    '2019-06-26 14:00:15',
    '2019-06-26 14:04:53',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    91,
    '2019-06-26',
    'Dinheiro',
    1000,
    'Vint4',
    0,
    'Cheque',
    0,
    680,
    48,
    320,
    'vendido',
    '2019-06-26 14:04:53',
    '2019-06-26 14:08:35',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    92,
    '2019-06-26',
    'Dinheiro',
    1000,
    'Vint4',
    0,
    'Cheque',
    0,
    680,
    48,
    320,
    'vendido',
    '2019-06-26 14:08:35',
    '2019-06-26 14:11:54',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    93,
    '2019-06-26',
    'Dinheiro',
    1500,
    'Vint4',
    0,
    'Cheque',
    0,
    1430,
    48,
    70,
    'vendido',
    '2019-06-26 14:11:54',
    '2019-06-26 14:14:37',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    94,
    '2019-06-26',
    'Dinheiro',
    900,
    'Vint4',
    0,
    'Cheque',
    0,
    590,
    30,
    310,
    'vendido',
    '2019-06-26 14:14:37',
    '2019-06-26 14:17:00',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    95,
    '2019-06-26',
    'Dinheiro',
    590,
    'Vint4',
    0,
    'Cheque',
    0,
    590,
    30,
    0,
    'vendido',
    '2019-06-26 14:17:00',
    '2019-06-26 14:34:27',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    96,
    '2019-06-26',
    'Dinheiro',
    1000,
    'Vint4',
    0,
    'Cheque',
    0,
    510,
    18,
    490,
    'vendido',
    '2019-06-26 14:34:27',
    '2019-06-26 14:45:27',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    97,
    '2019-06-26',
    'Dinheiro',
    60000,
    'Vint4',
    0,
    'Cheque',
    0,
    120,
    18,
    59880,
    'vendido',
    '2019-06-26 14:45:27',
    '2019-06-26 14:49:21',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    98,
    '2019-06-26',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-26 14:49:21',
    '2019-06-26 14:49:21',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    99,
    '2019-06-26',
    'Dinheiro',
    1000,
    'Vint4',
    0,
    'Cheque',
    0,
    510,
    18,
    490,
    'vendido',
    '2019-06-26 14:51:42',
    '2019-06-26 14:55:03',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    100,
    '2019-06-26',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-26 14:55:03',
    '2019-06-26 14:55:03',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    101,
    '2019-06-26',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-26 14:55:59',
    '2019-06-26 14:55:59',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    102,
    '2019-06-26',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-26 15:55:17',
    '2019-06-26 15:55:17',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    103,
    '2019-06-26',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-26 17:52:07',
    '2019-06-26 17:52:07',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    104,
    '2019-06-26',
    'Dinheiro',
    20000,
    'Vint4',
    0,
    'Cheque',
    0,
    1686,
    70,
    18314,
    'vendido',
    '2019-06-26 17:55:21',
    '2019-06-26 17:56:27',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    105,
    '2019-06-26',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-26 17:56:27',
    '2019-06-26 17:56:27',
    1,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    106,
    '2019-06-26',
    'Dinheiro',
    98000,
    'Vint4',
    0,
    'Cheque',
    0,
    97312,
    70,
    688,
    'vendido',
    '2019-06-26 17:58:12',
    '2019-06-26 18:05:55',
    2,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    107,
    '2019-06-26',
    'Dinheiro',
    99000,
    'Vint4',
    0,
    'Cheque',
    0,
    97112,
    70,
    1888,
    'vendido',
    '2019-06-26 18:05:56',
    '2019-06-26 18:14:16',
    2,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    108,
    '2019-06-26',
    'Dinheiro',
    5200,
    'Vint4',
    0,
    'Cheque',
    0,
    1370,
    69,
    3830,
    'vendido',
    '2019-06-26 18:14:16',
    '2019-06-26 18:16:18',
    2,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    109,
    '2019-06-26',
    'Dinheiro',
    1000,
    'Vint4',
    0,
    'Cheque',
    0,
    250,
    21,
    750,
    'vendido',
    '2019-06-26 18:16:18',
    '2019-06-26 18:18:19',
    2,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    110,
    '2019-06-26',
    'Dinheiro',
    600,
    'Vint4',
    0,
    'Cheque',
    0,
    550,
    21,
    50,
    'vendido',
    '2019-06-26 18:18:19',
    '2019-06-26 18:19:57',
    2,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    111,
    '2019-06-26',
    'Dinheiro',
    300,
    'Vint4',
    0,
    'Cheque',
    0,
    250,
    21,
    50,
    'vendido',
    '2019-06-26 18:19:57',
    '2019-06-26 18:23:20',
    2,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    112,
    '2019-06-26',
    'Dinheiro',
    100000,
    'Vint4',
    0,
    'Cheque',
    0,
    96686,
    70,
    3314,
    'vendido',
    '2019-06-26 18:23:20',
    '2019-06-26 18:24:46',
    2,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    113,
    '2019-06-26',
    'Dinheiro',
    60,
    'Vint4',
    0,
    'Cheque',
    0,
    60,
    0,
    0,
    'vendido',
    '2019-06-26 18:24:46',
    '2019-06-26 18:26:57',
    2,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    114,
    '2019-06-26',
    'Dinheiro',
    10000,
    'Vint4',
    0,
    'Cheque',
    0,
    9300,
    0,
    700,
    'vendido',
    '2019-06-26 18:26:57',
    '2019-06-26 18:27:33',
    2,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    115,
    '2019-06-26',
    'Dinheiro',
    15000,
    'Vint4',
    0,
    'Cheque',
    0,
    12400,
    3,
    2600,
    'vendido',
    '2019-06-26 18:27:33',
    '2019-06-26 18:28:34',
    2,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    116,
    '2019-06-26',
    'Dinheiro',
    90,
    'Vint4',
    0,
    'Cheque',
    0,
    80,
    3,
    10,
    'vendido',
    '2019-06-26 18:28:34',
    '2019-06-26 18:29:54',
    2,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    117,
    '2019-06-26',
    'Dinheiro',
    11000,
    'Vint4',
    0,
    'Cheque',
    0,
    10920,
    3,
    80,
    'vendido',
    '2019-06-26 18:29:54',
    '2019-06-26 18:30:29',
    2,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    118,
    '2019-06-26',
    'Dinheiro',
    99000,
    'Vint4',
    0,
    'Cheque',
    0,
    96686,
    70,
    2314,
    'vendido',
    '2019-06-26 18:30:29',
    '2019-06-26 18:34:13',
    2,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    119,
    '2019-06-26',
    'Dinheiro',
    99000,
    'Vint4',
    0,
    'Cheque',
    0,
    96686,
    70,
    2314,
    'vendido',
    '2019-06-26 18:34:13',
    '2019-06-26 18:38:18',
    2,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    120,
    '2019-06-26',
    'Dinheiro',
    500,
    'Vint4',
    0,
    'Cheque',
    0,
    467,
    18,
    33,
    'vendido',
    '2019-06-26 18:38:18',
    '2019-06-26 18:40:48',
    2,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    121,
    '2019-06-26',
    'Dinheiro',
    1200,
    'Vint4',
    0,
    'Cheque',
    0,
    1014,
    18,
    186,
    'vendido',
    '2019-06-26 18:40:48',
    '2019-06-26 18:45:07',
    2,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    122,
    '2019-06-26',
    'Dinheiro',
    97000,
    'Vint4',
    0,
    'Cheque',
    0,
    96660,
    18,
    340,
    'vendido',
    '2019-06-26 18:45:07',
    '2019-06-26 18:48:46',
    2,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    123,
    '2019-06-26',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-26 18:48:46',
    '2019-06-26 18:48:46',
    2,
    NULL
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    124,
    '2019-06-26',
    'Dinheiro',
    400,
    'Vint4',
    0,
    'Cheque',
    0,
    392,
    30,
    8,
    'vendido',
    '2019-06-26 18:54:38',
    '2019-06-26 18:54:51',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    125,
    '2019-06-26',
    'Dinheiro',
    360,
    'Vint4',
    0,
    'Cheque',
    0,
    360,
    0,
    0,
    'vendido',
    '2019-06-26 18:54:51',
    '2019-06-26 18:55:33',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    126,
    '2019-06-26',
    'Dinheiro',
    20,
    'Vint4',
    0,
    'Cheque',
    0,
    20,
    3,
    0,
    'vendido',
    '2019-06-26 18:55:33',
    '2019-06-26 18:56:29',
    1,
    1
  );
INSERT INTO
  `vendas` (
    `id`,
    `data_venda`,
    `meio_pagamento_dinheiro`,
    `valor_venda_dinheiro`,
    `meio_pagamento_vint4`,
    `valor_venda_vint4`,
    `meio_pagamento_cheque`,
    `valor_venda_cheque`,
    `valor_total`,
    `valor_iva`,
    `valor_troco`,
    `status`,
    `createdAt`,
    `updatedAt`,
    `UserId`,
    `ClienteId`
  )
VALUES
  (
    127,
    '2019-06-26',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'vendido',
    '2019-06-26 18:56:29',
    '2019-06-26 18:56:29',
    1,
    NULL
  );

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
