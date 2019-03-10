CREATE TABLE `Usuario` (
  `idUsuario` varchar(10) NOT NULL,
  `IP` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idUsuario`)
);

CREATE TABLE `Libro` (
  `ISBN` varchar(13) NOT NULL,
  `Nombre` varchar(45) DEFAULT NULL,
  `Autor` varchar(45) DEFAULT NULL,
  `Editorial` varchar(45) DEFAULT NULL,
  `Precio` double DEFAULT NULL,
  `Portada` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ISBN`)
);

CREATE TABLE `Pedido` (
  `idPedido` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ISBN` varchar(13) NOT NULL,
  `idUsuario` varchar(10) NOT NULL,
  `idSesion` int(11) NOT NULL,
  PRIMARY KEY (`idPedido`),
  KEY `idUsuario` (`idUsuario`),
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `Pedido_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `Usuario` (`idUsuario`),
  CONSTRAINT `Pedido_ibfk_2` FOREIGN KEY (`idUsuario`) REFERENCES `Usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Pedido_ibfk_3` FOREIGN KEY (`ISBN`) REFERENCES `Libro` (`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE VIEW `UltimaSesion` AS select `Pedido`.`idSesion` AS `idSesion` from `Pedido` order by `Pedido`.`fecha` desc limit 1

CREATE VIEW `PedidosUltimaSesion` AS select `Pedido`.`idPedido` AS `idPedido`,`Pedido`.`fecha` AS `fecha`,`Pedido`.`ISBN` AS `ISBN`,`Pedido`.`idUsuario` AS `idUsuario`,`Pedido`.`idSesion` AS `idSesion` from `Pedido` where (`Pedido`.`idSesion` = (select `UltimaSesion`.`idSesion` from `UltimaSesion`))

CREATE VIEW `LibrosDisponibles` AS select `Libro`.`ISBN` AS `ISBN`,`Libro`.`Nombre` AS `Nombre`,`Libro`.`Autor` AS `Autor`,`Libro`.`Editorial` AS `Editorial`,`Libro`.`Precio` AS `Precio`,`Libro`.`Portada` AS `Portada` from (`Libro` left join `PedidosUltimaSesion` on((`PedidosUltimaSesion`.`ISBN` = `Libro`.`ISBN`))) where isnull(`PedidosUltimaSesion`.`ISBN`);

CREATE VIEW `LibroRandom` AS select `LibrosDisponibles`.`ISBN` AS `ISBN`,`LibrosDisponibles`.`Nombre` AS `Nombre`,`LibrosDisponibles`.`Autor` AS `Autor`,`LibrosDisponibles`.`Editorial` AS `Editorial`,`LibrosDisponibles`.`Precio` AS `Precio`,`LibrosDisponibles`.`Portada` AS `Portada` from `LibrosDisponibles` order by rand() limit 1;

+---------------+---------------------------+-------------------------------+-----------+--------+-------------+
| ISBN          | Nombre                    | Autor                         | Editorial | Precio | Portada     |
+---------------+---------------------------+-------------------------------+-----------+--------+-------------+
| 9788415717843 | EL COLOQUIO DE LOS PERROS | MIGUEL DE CERVANTES SAAVEDRA  | NORDICA   |  15.84 | perros.png  |
| 9788415937548 | LA CIUDAD DE LAS DAMAS    | CRISTINA DE PIZAN             | SIRUELA   |    200 | ciudad.png  |
| 9788441405295 | DON QUIJOTE DE LA MANCHA  | MIGUEL DE CERVANTES SAAVEDRA  | EDAF      | 172.04 | quijote.png |
+---------------+---------------------------+-------------------------------+-----------+--------+-------------+

