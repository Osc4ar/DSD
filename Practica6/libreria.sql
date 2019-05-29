-- MySQL dump 10.13  Distrib 5.7.26, for Linux (x86_64)
--
-- Host: localhost    Database: libreria
-- ------------------------------------------------------
-- Server version	5.7.26-0ubuntu0.18.04.1

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
 1 AS `IP`,
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
INSERT INTO `Libro` VALUES ('9788415717843','EL COLOQUIO DE LOS PERROS','MIGUEL DE CERVANTES SAAVEDRA ','NORDICA',15.84,'libro1.jpg'),('9788415937548','LA CIUDAD DE LAS DAMAS','CRISTINA DE PIZAN','SIRUELA',200,'libro11.jpg'),('9788441405295','DON QUIJOTE DE LA MANCHA','MIGUEL DE CERVANTES SAAVEDRA','EDAF',172.04,'quijote.jpg');
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
  `Tiempo` int(10) DEFAULT '0',
  PRIMARY KEY (`idPedido`),
  KEY `idUsuario` (`idUsuario`),
  KEY `ISBN` (`ISBN`),
  KEY `idSesion` (`idSesion`),
  CONSTRAINT `Pedido_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `Usuario` (`idUsuario`),
  CONSTRAINT `Pedido_ibfk_2` FOREIGN KEY (`idUsuario`) REFERENCES `Usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Pedido_ibfk_3` FOREIGN KEY (`ISBN`) REFERENCES `Libro` (`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Pedido_ibfk_4` FOREIGN KEY (`idSesion`) REFERENCES `Sesion` (`idSesion`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=183 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pedido`
--

LOCK TABLES `Pedido` WRITE;
/*!40000 ALTER TABLE `Pedido` DISABLE KEYS */;
INSERT INTO `Pedido` VALUES (1,'2019-04-06 04:37:02','9788415937548','Osc4ar',2,0),(2,'2019-04-06 05:18:36','9788441405295','Osc4ar',2,0),(3,'2019-04-06 05:20:07','9788415717843','Osc4ar',2,0),(4,'2019-04-06 05:26:16','9788415717843','Osc4ar',3,0),(5,'2019-04-06 05:26:28','9788415937548','Osc4ar',3,0),(6,'2019-04-06 05:26:29','9788441405295','Osc4ar',3,0),(7,'2019-04-06 05:33:12','9788415937548','Osc4ar',4,0),(8,'2019-04-06 05:33:17','9788415717843','Osc4ar',4,0),(9,'2019-04-06 05:33:18','9788441405295','Osc4ar',4,0),(10,'2019-04-06 05:35:50','9788441405295','Osc4ar',5,0),(11,'2019-04-06 05:35:52','9788415937548','Osc4ar',5,0),(12,'2019-04-06 05:35:53','9788415717843','Osc4ar',5,0),(13,'2019-04-06 05:37:34','9788441405295','Osc4ar',6,0),(14,'2019-04-06 05:37:35','9788415937548','Osc4ar',6,0),(15,'2019-04-06 05:37:35','9788415717843','Osc4ar',6,0),(16,'2019-04-06 05:45:08','9788415937548','Osc4ar',7,0),(17,'2019-04-06 05:45:09','9788441405295','Osc4ar',7,0),(18,'2019-04-06 05:45:10','9788415717843','Osc4ar',7,0),(19,'2019-04-06 05:47:16','9788415937548','Osc4ar',8,0),(20,'2019-04-06 05:47:17','9788441405295','Osc4ar',8,0),(21,'2019-04-06 05:47:18','9788415717843','Osc4ar',8,0),(22,'2019-04-06 05:49:31','9788441405295','Osc4ar',9,0),(23,'2019-04-06 05:49:40','9788415717843','Osc4ar',9,0),(24,'2019-04-06 05:49:41','9788415937548','Osc4ar',9,0),(25,'2019-04-06 05:52:22','9788441405295','Osc4ar',10,0),(26,'2019-04-06 05:52:56','9788415717843','Osc4ar',10,0),(27,'2019-04-06 05:52:57','9788415937548','Osc4ar',10,0),(28,'2019-04-06 05:58:15','9788441405295','Osc4ar',11,0),(29,'2019-04-06 05:58:16','9788415717843','Osc4ar',11,0),(30,'2019-04-06 05:58:17','9788415937548','Osc4ar',11,0),(31,'2019-04-06 06:07:44','9788441405295','Osc4ar',12,0),(32,'2019-04-06 06:08:17','9788415717843','Osc4ar',12,0),(33,'2019-04-06 06:08:20','9788415937548','Osc4ar',12,0),(34,'2019-04-06 06:59:57','9788415937548','Osc4ar',13,0),(35,'2019-04-06 07:00:05','9788415717843','Osc4ar',13,0),(36,'2019-04-06 07:00:06','9788441405295','Osc4ar',13,0),(37,'2019-04-06 07:03:37','9788415717843','Osc4ar',15,0),(38,'2019-04-06 07:03:38','9788415937548','Osc4ar',15,0),(39,'2019-04-06 07:03:39','9788441405295','Osc4ar',15,0),(40,'2019-04-06 07:04:53','9788441405295','Osc4ar',16,0),(41,'2019-04-06 07:04:57','9788415937548','Osc4ar',16,0),(42,'2019-04-06 07:05:01','9788415717843','Osc4ar',16,0),(43,'2019-04-06 07:09:12','9788415937548','Osc4ar',17,0),(44,'2019-04-06 07:09:13','9788441405295','Osc4ar',17,0),(45,'2019-04-06 07:09:14','9788415717843','Osc4ar',17,0),(46,'2019-04-06 07:09:58','9788415937548','Osc4ar',18,0),(47,'2019-04-06 07:09:58','9788415717843','Osc4ar',18,0),(48,'2019-04-06 07:09:59','9788441405295','Osc4ar',18,0),(49,'2019-04-06 07:10:27','9788415717843','Osc4ar',19,0),(50,'2019-04-06 07:10:28','9788441405295','Osc4ar',19,0),(51,'2019-04-06 07:10:29','9788415937548','Osc4ar',19,0),(52,'2019-04-06 07:10:55','9788441405295','Osc4ar',20,0),(53,'2019-04-06 07:10:56','9788415717843','Osc4ar',20,0),(54,'2019-04-06 07:10:57','9788415937548','Osc4ar',20,0),(55,'2019-04-06 07:12:38','9788441405295','Osc4ar',21,0),(56,'2019-04-06 07:12:39','9788415937548','Osc4ar',21,0),(57,'2019-04-06 07:12:40','9788415717843','Osc4ar',21,0),(58,'2019-04-06 07:14:18','9788415937548','Osc4ar',22,0),(59,'2019-04-06 07:14:19','9788415717843','Osc4ar',22,0),(60,'2019-04-06 07:14:19','9788441405295','Osc4ar',22,0),(61,'2019-04-06 07:14:42','9788441405295','Osc4ar',23,0),(62,'2019-04-06 07:14:43','9788415937548','Osc4ar',23,0),(63,'2019-04-06 07:14:43','9788415717843','Osc4ar',23,0),(64,'2019-04-06 07:15:10','9788415937548','Osc4ar',24,0),(65,'2019-04-06 07:15:10','9788441405295','Osc4ar',24,0),(66,'2019-04-06 07:15:11','9788415717843','Osc4ar',24,0),(67,'2019-04-06 07:17:14','9788415937548','Osc4ar',25,0),(68,'2019-04-06 07:17:16','9788441405295','Osc4ar',25,0),(69,'2019-04-06 07:17:17','9788415717843','Osc4ar',25,0),(70,'2019-04-06 07:18:28','9788415717843','Osc4ar',26,0),(71,'2019-04-06 07:18:28','9788441405295','Osc4ar',26,0),(72,'2019-04-06 07:18:29','9788415937548','Osc4ar',26,0),(73,'2019-04-09 21:14:27','9788415937548','Front',27,0),(74,'2019-04-09 22:39:22','9788441405295','Front',27,0),(75,'2019-04-10 01:57:13','9788415717843','Front',27,0),(76,'2019-04-10 02:05:30','9788415717843','Osc4ar',28,0),(77,'2019-04-10 02:19:50','9788415937548','Osc4ar',29,0),(78,'2019-04-10 02:20:29','9788415717843','Osc4ar',30,0),(79,'2019-04-10 02:27:11','9788441405295','Front',30,0),(80,'2019-04-10 02:28:02','9788415937548','Front',30,0),(81,'2019-04-10 02:28:55','9788441405295','Front',31,0),(82,'2019-04-10 04:14:14','9788415937548','Osc4ar',31,0),(83,'2019-04-10 04:14:33','9788415717843','Osc4ar',31,0),(84,'2019-04-10 04:15:08','9788441405295','Osc4ar',32,0),(85,'2019-04-10 04:15:47','9788415937548','Osc4ar',32,0),(86,'2019-04-10 04:39:28','9788415717843','Osc4ar',32,0),(87,'2019-04-10 04:51:55','9788415717843','Osc4ar',33,0),(88,'2019-04-10 22:18:58','9788415937548','Front',33,0),(89,'2019-04-10 22:20:36','9788441405295','Front',33,0),(90,'2019-04-10 22:21:48','9788441405295','Front',34,0),(91,'2019-04-10 22:22:59','9788415937548','Front',34,0),(92,'2019-04-10 22:23:37','9788415717843','Front',34,0),(93,'2019-04-10 22:24:07','9788415717843','Front',35,0),(94,'2019-04-10 22:25:23','9788441405295','Front',35,0),(95,'2019-04-10 10:26:58','9788415937548','Front',35,0),(96,'2019-04-10 10:00:00','9788415937548','Front',36,0),(97,'2019-04-10 10:00:00','9788415717843','Front',36,0),(98,'2019-04-10 10:00:00','9788441405295','Front',36,0),(99,'2019-04-10 10:00:00','9788415937548','Front',37,0),(100,'2019-04-10 10:00:00','9788441405295','Front',37,0),(101,'2019-04-10 10:00:00','9788415717843','Front',37,0),(102,'2019-04-10 10:00:00','9788415937548','Front',38,0),(103,'2019-04-10 10:00:00','9788415717843','Front',38,0),(104,'2019-04-10 10:00:00','9788441405295','Front',38,0),(105,'2019-04-10 10:00:00','9788415937548','Front',39,0),(106,'2019-04-10 10:00:00','9788415717843','Front',39,0),(107,'2019-04-10 10:00:00','9788441405295','Front',39,0),(108,'2019-04-10 10:00:00','9788415717843','Front',40,0),(109,'2019-04-10 10:00:00','9788441405295','Front',40,0),(110,'2019-04-10 10:00:00','9788415937548','Front',40,0),(111,'2019-04-10 10:00:00','9788415937548','Front',41,0),(112,'2019-04-10 10:00:00','9788415717843','Front',41,0),(113,'2019-04-10 05:51:30','9788441405295','Front',41,0),(114,'2019-04-10 05:52:13','9788415717843','Front',42,0),(115,'2019-04-10 23:54:48','9788415937548','Osc4ar',42,0),(116,'2019-04-10 23:55:39','9788441405295','Osc4ar',42,0),(117,'2019-04-12 00:06:10','9788415717843','Osc4ar',43,0),(118,'2019-04-12 00:06:10','9788415937548','Osc4ar',43,0),(119,'2019-04-12 00:06:10','9788415937548','Osc4ar',43,0),(120,'2019-04-12 00:06:10','9788441405295','Osc4ar',43,0),(121,'2019-04-12 00:20:37','9788441405295','Osc4ar',44,0),(122,'2019-04-12 00:20:42','9788415937548','Osc4ar',44,0),(123,'2019-04-12 00:20:46','9788415717843','Osc4ar',44,0),(124,'2019-04-12 00:23:13','9788415717843','Osc4ar',45,0),(125,'2019-04-12 00:23:15','9788441405295','Osc4ar',45,0),(126,'2019-04-12 00:27:15','9788415937548','Osc4ar',45,0),(127,'2019-04-12 00:27:21','9788441405295','Osc4ar',46,0),(128,'2019-04-12 00:29:13','9788415937548','Osc4ar',46,0),(129,'2019-04-12 00:29:15','9788415717843','Osc4ar',46,0),(130,'2019-04-12 00:32:18','9788441405295','Osc4ar',47,0),(131,'2019-04-12 00:32:22','9788415717843','Osc4ar',47,0),(132,'2019-04-12 00:38:25','9788441405295','Osc4ar',48,0),(133,'2019-04-12 02:38:03','9788415717843','Osc4ar',48,0),(134,'2019-04-12 02:38:05','9788415937548','Osc4ar',48,0),(135,'2019-04-12 02:47:17','9788441405295','Osc4ar',49,0),(136,'2019-04-12 02:47:19','9788415937548','Osc4ar',49,0),(137,'2019-04-12 02:47:21','9788415717843','Osc4ar',49,0),(138,'2019-04-12 03:02:20','9788415717843','Osc4ar',50,0),(139,'2019-04-12 03:02:22','9788415937548','Osc4ar',50,0),(140,'2019-04-12 03:02:22','9788441405295','Osc4ar',50,0),(141,'2019-04-12 03:03:58','9788415937548','Osc4ar',51,0),(142,'2019-04-12 03:04:03','9788415717843','Osc4ar',51,0),(143,'2019-04-12 03:05:09','9788441405295','Osc4ar',51,0),(144,'2019-04-12 03:05:27','9788441405295','Osc4ar',52,0),(145,'2019-04-12 03:05:58','9788415937548','Osc4ar',52,0),(146,'2019-04-12 03:05:59','9788415717843','Osc4ar',52,0),(147,'2019-04-12 03:06:55','9788415937548','Osc4ar',53,0),(148,'2019-04-12 03:06:59','9788441405295','Osc4ar',53,0),(149,'2019-04-12 03:07:09','9788415717843','Osc4ar',54,0),(150,'2019-04-12 03:08:14','9788441405295','Osc4ar',54,0),(151,'2019-04-12 03:08:44','9788415937548','Osc4ar',54,0),(152,'2019-04-12 03:08:55','9788415717843','Osc4ar',55,0),(153,'2019-04-12 03:17:43','9788441405295','Osc4ar',55,0),(154,'2019-04-12 03:17:44','9788415937548','Osc4ar',55,0),(155,'2019-04-12 03:17:52','9788415717843','Osc4ar',56,0),(156,'2019-04-12 03:17:53','9788415937548','Osc4ar',56,0),(157,'2019-04-12 03:17:54','9788441405295','Osc4ar',56,0),(158,'2019-04-12 03:17:57','9788415717843','Osc4ar',57,0),(159,'2019-04-11 16:11:50','9788415937548','Carmen',57,0),(160,'2019-04-11 16:11:51','9788441405295','Carmen',57,0),(161,'2019-04-11 16:11:54','9788415937548','Carmen',58,0),(162,'2019-04-11 16:11:55','9788415717843','Carmen',58,0),(163,'2019-04-11 16:11:55','9788441405295','Carmen',58,0),(164,'2019-04-11 16:11:58','9788415937548','Carmen',59,0),(165,'2019-04-11 18:13:17','9788441405295','Carmen',59,0),(166,'2019-04-11 18:13:55','9788415717843','Carmen',59,0),(167,'2019-04-19 20:07:02','9788415717843','Osc4ar',60,0),(168,'2019-04-19 20:09:50','9788441405295','Osc4ar',60,0),(169,'2019-04-19 20:09:51','9788415937548','Osc4ar',60,0),(170,'2019-04-19 20:09:54','9788415937548','Osc4ar',61,0),(171,'2019-04-19 20:13:28','9788441405295','Osc4ar',61,0),(172,'2019-05-27 05:57:41','9788415717843','Osc4ar',61,0),(173,'2019-05-27 05:57:56','9788415937548','Osc4ar',62,0),(174,'2019-05-27 05:59:04','9788415717843','Osc4ar',62,0),(175,'2019-05-27 05:59:12','9788441405295','Osc4ar',62,0),(176,'2019-05-27 05:59:40','9788415937548','Osc4ar',63,0),(177,'2019-05-27 07:01:00','9788441405295','Osc4ar',63,0),(178,'2019-05-27 07:01:27','9788415717843','Osc4ar',63,0),(179,'2019-05-27 07:03:33','9788415717843','Osc4ar',64,0),(180,'2019-05-27 13:31:51','9788441405295','Osc4ar',64,7),(181,'2019-05-27 13:37:22','9788415937548','Osc4ar',64,82),(182,'2019-05-27 13:43:25','9788415937548','Osc4ar',65,174);
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
-- Table structure for table `Sesion`
--

DROP TABLE IF EXISTS `Sesion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Sesion` (
  `idSesion` int(11) NOT NULL AUTO_INCREMENT,
  `inicio` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fin` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idSesion`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sesion`
--

LOCK TABLES `Sesion` WRITE;
/*!40000 ALTER TABLE `Sesion` DISABLE KEYS */;
INSERT INTO `Sesion` VALUES (2,'2019-03-24 18:13:02','2019-03-24 18:28:42'),(3,'2019-04-06 05:25:34','2019-04-06 05:25:34'),(4,'2019-04-06 05:32:54','2019-04-06 05:33:20'),(5,'2019-04-06 05:33:20','2019-04-06 05:35:54'),(6,'2019-04-06 05:35:54','2019-04-06 05:37:37'),(7,'2019-04-06 05:37:37','2019-04-06 05:37:37'),(8,'2019-04-06 05:45:12','2019-04-06 05:45:12'),(9,'2019-04-06 05:47:19','2019-04-06 05:49:43'),(10,'2019-04-06 05:49:43','2019-04-06 05:49:43'),(11,'2019-04-06 05:57:49','2019-04-06 05:58:18'),(12,'2019-04-06 05:58:18','2019-04-06 06:08:22'),(13,'2019-04-06 06:08:22','2019-04-06 07:00:08'),(14,'2019-04-06 07:00:08','2019-04-06 07:02:08'),(15,'2019-04-06 07:02:08','2019-04-06 07:02:08'),(16,'2019-04-06 07:04:01','2019-04-06 07:05:08'),(17,'2019-04-06 07:05:08','2019-04-06 07:09:15'),(18,'2019-04-06 07:09:15','2019-04-06 07:10:00'),(19,'2019-04-06 07:10:00','2019-04-06 07:10:00'),(20,'2019-04-06 07:10:30','2019-04-06 07:10:58'),(21,'2019-04-06 07:10:58','2019-04-06 07:12:41'),(22,'2019-04-06 07:12:41','2019-04-06 07:14:21'),(23,'2019-04-06 07:14:21','2019-04-06 07:14:44'),(24,'2019-04-06 07:14:44','2019-04-06 07:15:12'),(25,'2019-04-06 07:15:12','2019-04-06 07:17:24'),(26,'2019-04-06 07:17:24','2019-04-06 07:17:24'),(27,'2019-04-06 07:18:30','2019-04-10 01:57:16'),(28,'2019-04-10 01:57:16','2019-04-10 02:05:51'),(29,'2019-04-10 02:05:51','2019-04-10 02:20:04'),(30,'2019-04-10 02:20:04','2019-04-10 02:20:04'),(31,'2019-04-10 02:28:03','2019-04-10 04:14:35'),(32,'2019-04-10 04:14:35','2019-04-10 04:39:31'),(33,'2019-04-10 04:39:31','2019-04-10 05:20:40'),(34,'2019-04-10 05:20:40','2019-04-10 05:23:40'),(35,'2019-04-10 05:23:40','2019-04-10 05:27:01'),(36,'2019-04-10 05:27:01','2019-04-10 05:36:41'),(37,'2019-04-10 05:36:41','2019-04-10 05:36:41'),(38,'2019-04-10 05:41:34','2019-04-10 05:41:34'),(39,'2019-04-10 05:43:11','2019-04-10 05:44:44'),(40,'2019-04-10 05:44:44','2019-04-10 05:48:57'),(41,'2019-04-10 05:48:57','2019-04-10 05:48:57'),(42,'2019-04-10 05:51:33','2019-04-10 23:55:42'),(43,'2019-04-10 23:55:42','2019-04-10 23:55:42'),(44,'2019-04-11 00:20:00','2019-04-11 00:20:48'),(45,'2019-04-11 00:20:48','2019-04-11 00:27:17'),(46,'2019-04-11 00:27:17','2019-04-11 00:29:17'),(47,'2019-04-11 00:29:17','2019-04-11 00:32:23'),(48,'2019-04-11 00:32:23','2019-04-11 00:32:23'),(49,'2019-04-11 02:38:08','2019-04-11 02:47:23'),(50,'2019-04-11 02:47:23','2019-04-11 03:02:23'),(51,'2019-04-11 03:02:23','2019-04-11 03:05:10'),(52,'2019-04-11 03:05:10','2019-04-11 03:06:01'),(53,'2019-04-11 03:06:01','2019-04-11 03:07:31'),(54,'2019-04-11 03:07:31','2019-04-11 03:08:46'),(55,'2019-04-11 03:08:46','2019-04-11 03:17:46'),(56,'2019-04-11 03:17:46','2019-04-11 03:17:56'),(57,'2019-04-11 03:17:56','2019-04-11 03:17:56'),(58,'2019-04-11 21:10:56','2019-04-11 21:10:56'),(59,'2019-04-11 21:11:00','2019-04-11 21:16:18'),(60,'2019-04-11 21:16:18','2019-04-19 20:09:05'),(61,'2019-04-19 20:09:05','2019-04-19 20:09:05'),(62,'2019-05-28 00:58:03','2019-05-28 00:58:35'),(63,'2019-05-28 00:58:35','2019-05-28 00:59:49'),(64,'2019-05-28 00:59:49','2019-05-28 02:14:36'),(65,'2019-05-28 02:14:36','2019-05-28 02:14:36');
/*!40000 ALTER TABLE `Sesion` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `Usuario` VALUES ('Carmen','::ffff:127.0.0.1'),('Celular','::ffff:10.0.0.6'),('Coordinador',':1'),('Front','::ffff:127.0.0.1'),('Osc4ar','::ffff:10.0.0.19');
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
/*!50001 VIEW `Coordinador` AS select `L`.`ISBN` AS `ISBN`,`L`.`Nombre` AS `Nombre`,`L`.`Autor` AS `Autor`,`L`.`Editorial` AS `Editorial`,`L`.`Precio` AS `Precio`,`L`.`Portada` AS `Portada`,`P`.`idPedido` AS `idPedido`,`P`.`fecha` AS `fecha`,`P`.`idUsuario` AS `idUsuario`,`U`.`IP` AS `IP`,`P`.`idSesion` AS `idSesion` from ((`Libro` `L` join `Pedido` `P`) join `Usuario` `U`) where ((`L`.`ISBN` = `P`.`ISBN`) and (`U`.`idUsuario` = `P`.`idUsuario`) and (`L`.`ISBN` <> '0')) order by `P`.`fecha` desc */;
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
/*!50001 VIEW `UltimaSesion` AS select `Sesion`.`idSesion` AS `idSesion` from `Sesion` order by `Sesion`.`inicio` desc limit 1 */;
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

-- Dump completed on 2019-05-27 21:24:23
