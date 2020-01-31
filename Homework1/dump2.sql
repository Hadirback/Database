-- MySQL dump 10.13  Distrib 8.0.15, for Win64 (x86_64)
--
-- Host: localhost    Database: mysql
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `help_keyword`
--

DROP TABLE IF EXISTS `help_keyword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `help_keyword` (
  `help_keyword_id` int(10) unsigned NOT NULL,
  `name` char(64) NOT NULL,
  PRIMARY KEY (`help_keyword_id`),
  UNIQUE KEY `name` (`name`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 COMMENT='help keywords';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help_keyword`
--
-- WHERE:  true limit 100

LOCK TABLES `help_keyword` WRITE;
/*!40000 ALTER TABLE `help_keyword` DISABLE KEYS */;
INSERT INTO `help_keyword` VALUES (0,'(JSON'),(1,'->'),(2,'->>'),(3,'<>'),(4,'ACCOUNT'),(5,'ACTION'),(6,'ADD'),(7,'ADMIN'),(8,'AES_DECRYPT'),(9,'AES_ENCRYPT'),(10,'AFTER'),(11,'AGAINST'),(12,'AGGREGATE'),(13,'ALGORITHM'),(14,'ALL'),(15,'ALTER'),(16,'ANALYZE'),(17,'AND'),(18,'ANY_VALUE'),(19,'ARCHIVE'),(20,'AS'),(21,'ASC'),(22,'AT'),(23,'AUTOCOMMIT'),(24,'AUTOEXTEND_SIZE'),(25,'AUTO_INCREMENT'),(26,'AVG_ROW_LENGTH'),(27,'BACKUP'),(28,'BEFORE'),(29,'BEGIN'),(30,'BETWEEN'),(31,'BIGINT'),(32,'BINARY'),(33,'BINLOG'),(34,'BIN_TO_UUID'),(35,'BOOL'),(36,'BOOLEAN'),(37,'BOTH'),(38,'BTREE'),(39,'BY'),(40,'BYTE'),(41,'CACHE'),(42,'CALL'),(43,'CAN_ACCESS_COLUMN'),(44,'CAN_ACCESS_DATABASE'),(45,'CAN_ACCESS_TABLE'),(46,'CAN_ACCESS_VIEW'),(47,'CASCADE'),(48,'CASE'),(49,'CATALOG_NAME'),(50,'CEIL'),(51,'CEILING'),(52,'CHAIN'),(53,'CHANGE'),(54,'CHANNEL'),(55,'CHAR'),(56,'CHARACTER'),(57,'CHARSET'),(58,'CHECK'),(59,'CHECKSUM'),(60,'CIPHER'),(61,'CLASS_ORIGIN'),(62,'CLIENT'),(63,'CLOSE'),(64,'COALESCE'),(65,'CODE'),(66,'COLLATE'),(67,'COLLATION'),(68,'COLUMN'),(69,'COLUMNS'),(70,'COLUMN_NAME'),(71,'COMMENT'),(72,'COMMIT'),(73,'COMMITTED'),(74,'COMPACT'),(75,'COMPLETION'),(76,'COMPONENT'),(77,'COMPRESSED'),(78,'COMPRESSION'),(79,'CONCURRENT'),(80,'CONDITION'),(81,'CONNECTION'),(82,'CONSISTENT'),(83,'CONSTRAINT'),(84,'CONSTRAINT_CATALOG'),(85,'CONSTRAINT_NAME'),(86,'CONSTRAINT_SCHEMA'),(87,'CONTINUE'),(88,'CONVERT'),(89,'COUNT'),(90,'CREATE'),(91,'CREATE_DH_PARAMETERS'),(92,'CROSS'),(93,'CSV'),(94,'CUME_DIST'),(95,'CURRENT'),(96,'CURRENT_ROLE'),(97,'CURRENT_USER'),(98,'CURSOR'),(99,'CURSOR_NAME');
/*!40000 ALTER TABLE `help_keyword` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-02-01  2:40:16
