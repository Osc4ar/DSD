-- MySQL dump 10.13  Distrib 5.7.25, for Linux (x86_64)
--
-- Host: localhost    Database: libreria
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
  PRIMARY KEY (`idPedido`),
  KEY `idUsuario` (`idUsuario`),
  KEY `ISBN` (`ISBN`),
  KEY `idSesion` (`idSesion`),
  CONSTRAINT `Pedido_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `Usuario` (`idUsuario`),
  CONSTRAINT `Pedido_ibfk_2` FOREIGN KEY (`idUsuario`) REFERENCES `Usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Pedido_ibfk_3` FOREIGN KEY (`ISBN`) REFERENCES `Libro` (`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Pedido_ibfk_4` FOREIGN KEY (`idSesion`) REFERENCES `Sesion` (`idSesion`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pedido`
--

LOCK TABLES `Pedido` WRITE;
/*!40000 ALTER TABLE `Pedido` DISABLE KEYS */;
INSERT INTO `Pedido` VALUES (1,'2019-04-06 04:37:02','9788415937548','Osc4ar',2),(2,'2019-04-06 05:18:36','9788441405295','Osc4ar',2),(3,'2019-04-06 05:20:07','9788415717843','Osc4ar',2),(4,'2019-04-06 05:26:16','9788415717843','Osc4ar',3),(5,'2019-04-06 05:26:28','9788415937548','Osc4ar',3),(6,'2019-04-06 05:26:29','9788441405295','Osc4ar',3),(7,'2019-04-06 05:33:12','9788415937548','Osc4ar',4),(8,'2019-04-06 05:33:17','9788415717843','Osc4ar',4),(9,'2019-04-06 05:33:18','9788441405295','Osc4ar',4),(10,'2019-04-06 05:35:50','9788441405295','Osc4ar',5),(11,'2019-04-06 05:35:52','9788415937548','Osc4ar',5),(12,'2019-04-06 05:35:53','9788415717843','Osc4ar',5),(13,'2019-04-06 05:37:34','9788441405295','Osc4ar',6),(14,'2019-04-06 05:37:35','9788415937548','Osc4ar',6),(15,'2019-04-06 05:37:35','9788415717843','Osc4ar',6),(16,'2019-04-06 05:45:08','9788415937548','Osc4ar',7),(17,'2019-04-06 05:45:09','9788441405295','Osc4ar',7),(18,'2019-04-06 05:45:10','9788415717843','Osc4ar',7),(19,'2019-04-06 05:47:16','9788415937548','Osc4ar',8),(20,'2019-04-06 05:47:17','9788441405295','Osc4ar',8),(21,'2019-04-06 05:47:18','9788415717843','Osc4ar',8),(22,'2019-04-06 05:49:31','9788441405295','Osc4ar',9),(23,'2019-04-06 05:49:40','9788415717843','Osc4ar',9),(24,'2019-04-06 05:49:41','9788415937548','Osc4ar',9),(25,'2019-04-06 05:52:22','9788441405295','Osc4ar',10),(26,'2019-04-06 05:52:56','9788415717843','Osc4ar',10),(27,'2019-04-06 05:52:57','9788415937548','Osc4ar',10),(28,'2019-04-06 05:58:15','9788441405295','Osc4ar',11),(29,'2019-04-06 05:58:16','9788415717843','Osc4ar',11),(30,'2019-04-06 05:58:17','9788415937548','Osc4ar',11),(31,'2019-04-06 06:07:44','9788441405295','Osc4ar',12),(32,'2019-04-06 06:08:17','9788415717843','Osc4ar',12),(33,'2019-04-06 06:08:20','9788415937548','Osc4ar',12),(34,'2019-04-06 06:59:57','9788415937548','Osc4ar',13),(35,'2019-04-06 07:00:05','9788415717843','Osc4ar',13),(36,'2019-04-06 07:00:06','9788441405295','Osc4ar',13),(37,'2019-04-06 07:03:37','9788415717843','Osc4ar',15),(38,'2019-04-06 07:03:38','9788415937548','Osc4ar',15),(39,'2019-04-06 07:03:39','9788441405295','Osc4ar',15),(40,'2019-04-06 07:04:53','9788441405295','Osc4ar',16),(41,'2019-04-06 07:04:57','9788415937548','Osc4ar',16),(42,'2019-04-06 07:05:01','9788415717843','Osc4ar',16),(43,'2019-04-06 07:09:12','9788415937548','Osc4ar',17),(44,'2019-04-06 07:09:13','9788441405295','Osc4ar',17),(45,'2019-04-06 07:09:14','9788415717843','Osc4ar',17),(46,'2019-04-06 07:09:58','9788415937548','Osc4ar',18),(47,'2019-04-06 07:09:58','9788415717843','Osc4ar',18),(48,'2019-04-06 07:09:59','9788441405295','Osc4ar',18),(49,'2019-04-06 07:10:27','9788415717843','Osc4ar',19),(50,'2019-04-06 07:10:28','9788441405295','Osc4ar',19),(51,'2019-04-06 07:10:29','9788415937548','Osc4ar',19),(52,'2019-04-06 07:10:55','9788441405295','Osc4ar',20),(53,'2019-04-06 07:10:56','9788415717843','Osc4ar',20),(54,'2019-04-06 07:10:57','9788415937548','Osc4ar',20),(55,'2019-04-06 07:12:38','9788441405295','Osc4ar',21),(56,'2019-04-06 07:12:39','9788415937548','Osc4ar',21),(57,'2019-04-06 07:12:40','9788415717843','Osc4ar',21),(58,'2019-04-06 07:14:18','9788415937548','Osc4ar',22),(59,'2019-04-06 07:14:19','9788415717843','Osc4ar',22),(60,'2019-04-06 07:14:19','9788441405295','Osc4ar',22),(61,'2019-04-06 07:14:42','9788441405295','Osc4ar',23),(62,'2019-04-06 07:14:43','9788415937548','Osc4ar',23),(63,'2019-04-06 07:14:43','9788415717843','Osc4ar',23),(64,'2019-04-06 07:15:10','9788415937548','Osc4ar',24),(65,'2019-04-06 07:15:10','9788441405295','Osc4ar',24),(66,'2019-04-06 07:15:11','9788415717843','Osc4ar',24),(67,'2019-04-06 07:17:14','9788415937548','Osc4ar',25),(68,'2019-04-06 07:17:16','9788441405295','Osc4ar',25),(69,'2019-04-06 07:17:17','9788415717843','Osc4ar',25),(70,'2019-04-06 07:18:28','9788415717843','Osc4ar',26),(71,'2019-04-06 07:18:28','9788441405295','Osc4ar',26),(72,'2019-04-06 07:18:29','9788415937548','Osc4ar',26),(73,'2019-04-09 21:14:27','9788415937548','Front',27),(74,'2019-04-09 22:39:22','9788441405295','Front',27),(75,'2019-04-10 01:57:13','9788415717843','Front',27),(76,'2019-04-10 02:05:30','9788415717843','Osc4ar',28),(77,'2019-04-10 02:19:50','9788415937548','Osc4ar',29),(78,'2019-04-10 02:20:29','9788415717843','Osc4ar',30),(79,'2019-04-10 02:27:11','9788441405295','Front',30),(80,'2019-04-10 02:28:02','9788415937548','Front',30),(81,'2019-04-10 02:28:55','9788441405295','Front',31),(82,'2019-04-10 04:14:14','9788415937548','Osc4ar',31),(83,'2019-04-10 04:14:33','9788415717843','Osc4ar',31),(84,'2019-04-10 04:15:08','9788441405295','Osc4ar',32),(85,'2019-04-10 04:15:47','9788415937548','Osc4ar',32),(86,'2019-04-10 04:39:28','9788415717843','Osc4ar',32),(87,'2019-04-10 04:51:55','9788415717843','Osc4ar',33),(88,'2019-04-10 22:18:58','9788415937548','Front',33),(89,'2019-04-10 22:20:36','9788441405295','Front',33),(90,'2019-04-10 22:21:48','9788441405295','Front',34),(91,'2019-04-10 22:22:59','9788415937548','Front',34),(92,'2019-04-10 22:23:37','9788415717843','Front',34),(93,'2019-04-10 22:24:07','9788415717843','Front',35),(94,'2019-04-10 22:25:23','9788441405295','Front',35),(95,'2019-04-10 10:26:58','9788415937548','Front',35),(96,'2019-04-10 10:00:00','9788415937548','Front',36),(97,'2019-04-10 10:00:00','9788415717843','Front',36),(98,'2019-04-10 10:00:00','9788441405295','Front',36),(99,'2019-04-10 10:00:00','9788415937548','Front',37),(100,'2019-04-10 10:00:00','9788441405295','Front',37),(101,'2019-04-10 10:00:00','9788415717843','Front',37),(102,'2019-04-10 10:00:00','9788415937548','Front',38),(103,'2019-04-10 10:00:00','9788415717843','Front',38),(104,'2019-04-10 10:00:00','9788441405295','Front',38),(105,'2019-04-10 10:00:00','9788415937548','Front',39),(106,'2019-04-10 10:00:00','9788415717843','Front',39),(107,'2019-04-10 10:00:00','9788441405295','Front',39),(108,'2019-04-10 10:00:00','9788415717843','Front',40),(109,'2019-04-10 10:00:00','9788441405295','Front',40),(110,'2019-04-10 10:00:00','9788415937548','Front',40),(111,'2019-04-10 10:00:00','9788415937548','Front',41),(112,'2019-04-10 10:00:00','9788415717843','Front',41),(113,'2019-04-10 05:51:30','9788441405295','Front',41),(114,'2019-04-10 05:52:13','9788415717843','Front',42),(115,'2019-04-10 23:54:48','9788415937548','Osc4ar',42),(116,'2019-04-10 23:55:39','9788441405295','Osc4ar',42),(117,'2019-04-12 00:06:10','9788415717843','Osc4ar',43),(118,'2019-04-12 00:06:10','9788415937548','Osc4ar',43),(119,'2019-04-12 00:06:10','9788415937548','Osc4ar',43),(120,'2019-04-12 00:06:10','9788441405295','Osc4ar',43),(121,'2019-04-12 00:20:37','9788441405295','Osc4ar',44),(122,'2019-04-12 00:20:42','9788415937548','Osc4ar',44),(123,'2019-04-12 00:20:46','9788415717843','Osc4ar',44),(124,'2019-04-12 00:23:13','9788415717843','Osc4ar',45),(125,'2019-04-12 00:23:15','9788441405295','Osc4ar',45),(126,'2019-04-12 00:27:15','9788415937548','Osc4ar',45),(127,'2019-04-12 00:27:21','9788441405295','Osc4ar',46),(128,'2019-04-12 00:29:13','9788415937548','Osc4ar',46),(129,'2019-04-12 00:29:15','9788415717843','Osc4ar',46),(130,'2019-04-12 00:32:18','9788441405295','Osc4ar',47),(131,'2019-04-12 00:32:22','9788415717843','Osc4ar',47),(132,'2019-04-12 00:38:25','9788441405295','Osc4ar',48),(133,'2019-04-12 02:38:03','9788415717843','Osc4ar',48),(134,'2019-04-12 02:38:05','9788415937548','Osc4ar',48),(135,'2019-04-12 02:47:17','9788441405295','Osc4ar',49),(136,'2019-04-12 02:47:19','9788415937548','Osc4ar',49),(137,'2019-04-12 02:47:21','9788415717843','Osc4ar',49),(138,'2019-04-12 03:02:20','9788415717843','Osc4ar',50),(139,'2019-04-12 03:02:22','9788415937548','Osc4ar',50),(140,'2019-04-12 03:02:22','9788441405295','Osc4ar',50),(141,'2019-04-12 03:03:58','9788415937548','Osc4ar',51),(142,'2019-04-12 03:04:03','9788415717843','Osc4ar',51),(143,'2019-04-12 03:05:09','9788441405295','Osc4ar',51),(144,'2019-04-12 03:05:27','9788441405295','Osc4ar',52),(145,'2019-04-12 03:05:58','9788415937548','Osc4ar',52),(146,'2019-04-12 03:05:59','9788415717843','Osc4ar',52),(147,'2019-04-12 03:06:55','9788415937548','Osc4ar',53),(148,'2019-04-12 03:06:59','9788441405295','Osc4ar',53),(149,'2019-04-12 03:07:09','9788415717843','Osc4ar',54),(150,'2019-04-12 03:08:14','9788441405295','Osc4ar',54),(151,'2019-04-12 03:08:44','9788415937548','Osc4ar',54),(152,'2019-04-12 03:08:55','9788415717843','Osc4ar',55),(153,'2019-04-12 03:17:43','9788441405295','Osc4ar',55),(154,'2019-04-12 03:17:44','9788415937548','Osc4ar',55),(155,'2019-04-12 03:17:52','9788415717843','Osc4ar',56),(156,'2019-04-12 03:17:53','9788415937548','Osc4ar',56),(157,'2019-04-12 03:17:54','9788441405295','Osc4ar',56),(158,'2019-04-12 03:17:57','9788415717843','Osc4ar',57),(159,'2019-04-11 16:11:50','9788415937548','Carmen',57),(160,'2019-04-11 16:11:51','9788441405295','Carmen',57),(161,'2019-04-11 16:11:54','9788415937548','Carmen',58),(162,'2019-04-11 16:11:55','9788415717843','Carmen',58),(163,'2019-04-11 16:11:55','9788441405295','Carmen',58),(164,'2019-04-11 16:11:58','9788415937548','Carmen',59),(165,'2019-04-11 18:13:17','9788441405295','Carmen',59),(166,'2019-04-11 18:13:55','9788415717843','Carmen',59);
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
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sesion`
--

LOCK TABLES `Sesion` WRITE;
/*!40000 ALTER TABLE `Sesion` DISABLE KEYS */;
INSERT INTO `Sesion` VALUES (2,'2019-03-24 18:13:02','2019-03-24 18:28:42'),(3,'2019-04-06 05:25:34','2019-04-06 05:25:34'),(4,'2019-04-06 05:32:54','2019-04-06 05:33:20'),(5,'2019-04-06 05:33:20','2019-04-06 05:35:54'),(6,'2019-04-06 05:35:54','2019-04-06 05:37:37'),(7,'2019-04-06 05:37:37','2019-04-06 05:37:37'),(8,'2019-04-06 05:45:12','2019-04-06 05:45:12'),(9,'2019-04-06 05:47:19','2019-04-06 05:49:43'),(10,'2019-04-06 05:49:43','2019-04-06 05:49:43'),(11,'2019-04-06 05:57:49','2019-04-06 05:58:18'),(12,'2019-04-06 05:58:18','2019-04-06 06:08:22'),(13,'2019-04-06 06:08:22','2019-04-06 07:00:08'),(14,'2019-04-06 07:00:08','2019-04-06 07:02:08'),(15,'2019-04-06 07:02:08','2019-04-06 07:02:08'),(16,'2019-04-06 07:04:01','2019-04-06 07:05:08'),(17,'2019-04-06 07:05:08','2019-04-06 07:09:15'),(18,'2019-04-06 07:09:15','2019-04-06 07:10:00'),(19,'2019-04-06 07:10:00','2019-04-06 07:10:00'),(20,'2019-04-06 07:10:30','2019-04-06 07:10:58'),(21,'2019-04-06 07:10:58','2019-04-06 07:12:41'),(22,'2019-04-06 07:12:41','2019-04-06 07:14:21'),(23,'2019-04-06 07:14:21','2019-04-06 07:14:44'),(24,'2019-04-06 07:14:44','2019-04-06 07:15:12'),(25,'2019-04-06 07:15:12','2019-04-06 07:17:24'),(26,'2019-04-06 07:17:24','2019-04-06 07:17:24'),(27,'2019-04-06 07:18:30','2019-04-10 01:57:16'),(28,'2019-04-10 01:57:16','2019-04-10 02:05:51'),(29,'2019-04-10 02:05:51','2019-04-10 02:20:04'),(30,'2019-04-10 02:20:04','2019-04-10 02:20:04'),(31,'2019-04-10 02:28:03','2019-04-10 04:14:35'),(32,'2019-04-10 04:14:35','2019-04-10 04:39:31'),(33,'2019-04-10 04:39:31','2019-04-10 05:20:40'),(34,'2019-04-10 05:20:40','2019-04-10 05:23:40'),(35,'2019-04-10 05:23:40','2019-04-10 05:27:01'),(36,'2019-04-10 05:27:01','2019-04-10 05:36:41'),(37,'2019-04-10 05:36:41','2019-04-10 05:36:41'),(38,'2019-04-10 05:41:34','2019-04-10 05:41:34'),(39,'2019-04-10 05:43:11','2019-04-10 05:44:44'),(40,'2019-04-10 05:44:44','2019-04-10 05:48:57'),(41,'2019-04-10 05:48:57','2019-04-10 05:48:57'),(42,'2019-04-10 05:51:33','2019-04-10 23:55:42'),(43,'2019-04-10 23:55:42','2019-04-10 23:55:42'),(44,'2019-04-11 00:20:00','2019-04-11 00:20:48'),(45,'2019-04-11 00:20:48','2019-04-11 00:27:17'),(46,'2019-04-11 00:27:17','2019-04-11 00:29:17'),(47,'2019-04-11 00:29:17','2019-04-11 00:32:23'),(48,'2019-04-11 00:32:23','2019-04-11 00:32:23'),(49,'2019-04-11 02:38:08','2019-04-11 02:47:23'),(50,'2019-04-11 02:47:23','2019-04-11 03:02:23'),(51,'2019-04-11 03:02:23','2019-04-11 03:05:10'),(52,'2019-04-11 03:05:10','2019-04-11 03:06:01'),(53,'2019-04-11 03:06:01','2019-04-11 03:07:31'),(54,'2019-04-11 03:07:31','2019-04-11 03:08:46'),(55,'2019-04-11 03:08:46','2019-04-11 03:17:46'),(56,'2019-04-11 03:17:46','2019-04-11 03:17:56'),(57,'2019-04-11 03:17:56','2019-04-11 03:17:56'),(58,'2019-04-11 21:10:56','2019-04-11 21:10:56'),(59,'2019-04-11 21:11:00','2019-04-11 21:16:18'),(60,'2019-04-11 21:16:18','2019-04-11 21:16:18');
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
INSERT INTO `Usuario` VALUES ('Carmen','::ffff:127.0.0.1'),('Celular','::ffff:10.0.0.6'),('Coordinador',':1'),('Front','::ffff:127.0.0.1'),('Osc4ar','::ffff:127.0.0.1');
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

-- Dump completed on 2019-04-12 15:53:27
