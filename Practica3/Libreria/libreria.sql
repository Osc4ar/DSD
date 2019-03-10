-- MySQL dump 10.13  Distrib 5.7.25, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: libreria
-- ------------------------------------------------------
-- Server version	5.7.25-0ubuntu0.18.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary table structure for view `Coordinador`
--

DROP TABLE IF EXISTS `Coordinador`;
/*!50001 DROP VIEW IF EXISTS `Coordinador`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `Coordinador` AS SELECT 
 1 AS `ISBN`,
 1 AS `Nombre`,
 1 AS `Autor`,
 1 AS `Editorial`,
 1 AS `Precio`,
 1 AS `Portada`,
 1 AS `idPedido`,
 1 AS `fecha`,
 1 AS `idUsuario`,
 1 AS `idSesion`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Libro`
--

DROP TABLE IF EXISTS `Libro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Libro` (
  `ISBN` varchar(13) NOT NULL,
  `Nombre` varchar(45) DEFAULT NULL,
  `Autor` varchar(45) DEFAULT NULL,
  `Editorial` varchar(45) DEFAULT NULL,
  `Precio` double DEFAULT NULL,
  `Portada` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Libro`
--

LOCK TABLES `Libro` WRITE;
/*!40000 ALTER TABLE `Libro` DISABLE KEYS */;
INSERT INTO `Libro` VALUES ('0',NULL,NULL,NULL,NULL,NULL),('9788415717843','EL COLOQUIO DE LOS PERROS','MIGUEL DE CERVANTES SAAVEDRA ','NORDICA',15.84,'libro1.jpg'),('9788415937548','LA CIUDAD DE LAS DAMAS','CRISTINA DE PIZAN','SIRUELA',200,'libro11.jpg'),('9788441405295','DON QUIJOTE DE LA MANCHA','MIGUEL DE CERVANTES SAAVEDRA','EDAF',172.04,'quijote.jpg');
/*!40000 ALTER TABLE `Libro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `LibroRandom`
--

DROP TABLE IF EXISTS `LibroRandom`;
/*!50001 DROP VIEW IF EXISTS `LibroRandom`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `LibroRandom` AS SELECT 
 1 AS `ISBN`,
 1 AS `Nombre`,
 1 AS `Autor`,
 1 AS `Editorial`,
 1 AS `Precio`,
 1 AS `Portada`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `LibrosDisponibles`
--

DROP TABLE IF EXISTS `LibrosDisponibles`;
/*!50001 DROP VIEW IF EXISTS `LibrosDisponibles`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `LibrosDisponibles` AS SELECT 
 1 AS `ISBN`,
 1 AS `Nombre`,
 1 AS `Autor`,
 1 AS `Editorial`,
 1 AS `Precio`,
 1 AS `Portada`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Pedido`
--

DROP TABLE IF EXISTS `Pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Pedido` (
  `idPedido` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ISBN` varchar(13) NOT NULL,
  `idUsuario` varchar(30) DEFAULT NULL,
  `idSesion` int(11) NOT NULL,
  PRIMARY KEY (`idPedido`),
  KEY `idUsuario` (`idUsuario`),
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `Pedido_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `Usuario` (`idUsuario`),
  CONSTRAINT `Pedido_ibfk_2` FOREIGN KEY (`idUsuario`) REFERENCES `Usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Pedido_ibfk_3` FOREIGN KEY (`ISBN`) REFERENCES `Libro` (`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pedido`
--

LOCK TABLES `Pedido` WRITE;
/*!40000 ALTER TABLE `Pedido` DISABLE KEYS */;
INSERT INTO `Pedido` VALUES (1,'2019-03-08 04:10:36','9788415717843','Osc4ar',1),(2,'2019-03-08 07:31:35','9788441405295','Osc4ar',1),(7,'2019-03-08 08:09:43','0','Osc4ar',1),(8,'2019-03-08 08:29:37','9788415937548','Osc4ar',1),(37,'2019-03-10 09:23:48','0','Coordinador',2),(38,'2019-03-10 09:23:51','9788415717843','Osc4ar',2),(39,'2019-03-10 09:23:55','9788441405295','Osc4ar',2),(40,'2019-03-10 09:23:57','9788415937548','Osc4ar',2),(41,'2019-03-10 09:23:58','0','Osc4ar',3),(42,'2019-03-10 09:25:32','9788441405295','Osc4ar',3),(43,'2019-03-10 09:25:43','9788415717843','Osc4ar',3),(44,'2019-03-10 09:28:21','0','Coordinador',4),(45,'2019-03-10 09:28:26','9788415717843','Osc4ar',4),(46,'2019-03-10 09:45:21','9788441405295','Osc4ar',4),(47,'2019-03-10 09:51:00','9788415937548','Osc4ar',4),(48,'2019-03-10 09:51:09','0','Osc4ar',5),(49,'2019-03-10 09:57:17','9788415937548','Osc4ar',5),(50,'2019-03-10 09:57:41','9788415717843','Osc4ar',5),(51,'2019-03-10 09:57:48','9788441405295','Osc4ar',5),(52,'2019-03-10 09:57:51','0','Osc4ar',6),(53,'2019-03-10 09:58:58','9788415937548','Osc4ar',6),(54,'2019-03-10 09:59:09','9788441405295','Osc4ar',6),(55,'2019-03-10 09:59:16','9788415717843','Osc4ar',6),(56,'2019-03-10 09:59:17','0','Osc4ar',7);
/*!40000 ALTER TABLE `Pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `PedidosUltimaSesion`
--

DROP TABLE IF EXISTS `PedidosUltimaSesion`;
/*!50001 DROP VIEW IF EXISTS `PedidosUltimaSesion`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `PedidosUltimaSesion` AS SELECT 
 1 AS `idPedido`,
 1 AS `fecha`,
 1 AS `ISBN`,
 1 AS `idUsuario`,
 1 AS `idSesion`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `UltimaSesion`
--

DROP TABLE IF EXISTS `UltimaSesion`;
/*!50001 DROP VIEW IF EXISTS `UltimaSesion`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `UltimaSesion` AS SELECT 
 1 AS `idSesion`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Usuario`
--

DROP TABLE IF EXISTS `Usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Usuario` (
  `idUsuario` varchar(30) NOT NULL,
  `IP` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Usuario`
--

LOCK TABLES `Usuario` WRITE;
/*!40000 ALTER TABLE `Usuario` DISABLE KEYS */;
INSERT INTO `Usuario` VALUES ('Coordinador',':1'),('Osc4ar','192.168.1.44');
/*!40000 ALTER TABLE `Usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `Coordinador`
--

/*!50001 DROP VIEW IF EXISTS `Coordinador`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Coordinador` AS select `L`.`ISBN` AS `ISBN`,`L`.`Nombre` AS `Nombre`,`L`.`Autor` AS `Autor`,`L`.`Editorial` AS `Editorial`,`L`.`Precio` AS `Precio`,`L`.`Portada` AS `Portada`,`P`.`idPedido` AS `idPedido`,`P`.`fecha` AS `fecha`,`P`.`idUsuario` AS `idUsuario`,`P`.`idSesion` AS `idSesion` from (`Libro` `L` join `Pedido` `P`) where ((`L`.`ISBN` = `P`.`ISBN`) and (`P`.`ISBN` <> '0')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `LibroRandom`
--

/*!50001 DROP VIEW IF EXISTS `LibroRandom`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `LibroRandom` AS select `LibrosDisponibles`.`ISBN` AS `ISBN`,`LibrosDisponibles`.`Nombre` AS `Nombre`,`LibrosDisponibles`.`Autor` AS `Autor`,`LibrosDisponibles`.`Editorial` AS `Editorial`,`LibrosDisponibles`.`Precio` AS `Precio`,`LibrosDisponibles`.`Portada` AS `Portada` from `LibrosDisponibles` order by rand() limit 1 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `LibrosDisponibles`
--

/*!50001 DROP VIEW IF EXISTS `LibrosDisponibles`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `LibrosDisponibles` AS select `Libro`.`ISBN` AS `ISBN`,`Libro`.`Nombre` AS `Nombre`,`Libro`.`Autor` AS `Autor`,`Libro`.`Editorial` AS `Editorial`,`Libro`.`Precio` AS `Precio`,`Libro`.`Portada` AS `Portada` from (`Libro` left join `PedidosUltimaSesion` on((`PedidosUltimaSesion`.`ISBN` = `Libro`.`ISBN`))) where isnull(`PedidosUltimaSesion`.`ISBN`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `PedidosUltimaSesion`
--

/*!50001 DROP VIEW IF EXISTS `PedidosUltimaSesion`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `PedidosUltimaSesion` AS select `Pedido`.`idPedido` AS `idPedido`,`Pedido`.`fecha` AS `fecha`,`Pedido`.`ISBN` AS `ISBN`,`Pedido`.`idUsuario` AS `idUsuario`,`Pedido`.`idSesion` AS `idSesion` from `Pedido` where (`Pedido`.`idSesion` = (select `UltimaSesion`.`idSesion` from `UltimaSesion`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `UltimaSesion`
--

/*!50001 DROP VIEW IF EXISTS `UltimaSesion`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `UltimaSesion` AS select `Pedido`.`idSesion` AS `idSesion` from `Pedido` order by `Pedido`.`fecha` desc limit 1 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-03-10 11:43:48
