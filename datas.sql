-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: pizzeria_management
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `id_account` int NOT NULL AUTO_INCREMENT,
  `password` varchar(255) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `tel` varchar(20) NOT NULL,
  `create_time` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `id_address` int NOT NULL,
  `id_role` int NOT NULL,
  PRIMARY KEY (`id_account`),
  KEY `id_address_idx` (`id_address`),
  KEY `id_role_idx` (`id_role`),
  CONSTRAINT `id_account_address` FOREIGN KEY (`id_address`) REFERENCES `address` (`id_address`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `id_account_role` FOREIGN KEY (`id_role`) REFERENCES `role` (`id_role`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,'VeryGoodPassword','Tester','John','06.06.06.06.06','2023-04-06 22:27:12.970',1,1),(2,'otherverygoodpassword','Cust','Omer','06.06.06.06.07','2023-04-06 22:50:34.646',1,4);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `id_address` int NOT NULL AUTO_INCREMENT,
  `street_number` varchar(10) DEFAULT NULL,
  `street_or_district_name` varchar(255) NOT NULL,
  `postal_code` varchar(10) NOT NULL,
  `city_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id_address`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'25','Rue du testeur','38383','Testborough'),(2,'1','Rue de la pizzeria','38383','Testborough');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `command`
--

DROP TABLE IF EXISTS `command`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `command` (
  `id_command` int NOT NULL AUTO_INCREMENT,
  `create_time` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `status` varchar(150) NOT NULL,
  `is_payed` tinyint NOT NULL DEFAULT '0',
  `id_client` int NOT NULL,
  `id_pizzeria` int NOT NULL,
  `id_deliverer` int DEFAULT NULL,
  PRIMARY KEY (`id_command`),
  KEY `id_client_idx` (`id_client`),
  KEY `id_order_pizzeria_idx` (`id_pizzeria`),
  KEY `id_deliverer_idx` (`id_deliverer`),
  CONSTRAINT `id_client` FOREIGN KEY (`id_client`) REFERENCES `account` (`id_account`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `id_deliverer` FOREIGN KEY (`id_deliverer`) REFERENCES `account` (`id_account`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `id_order_pizzeria` FOREIGN KEY (`id_pizzeria`) REFERENCES `pizzeria` (`id_pizzeria`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `command`
--

LOCK TABLES `command` WRITE;
/*!40000 ALTER TABLE `command` DISABLE KEYS */;
INSERT INTO `command` VALUES (1,'2023-04-06 22:51:33.801','En préparation',1,2,1,NULL);
/*!40000 ALTER TABLE `command` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `command_line`
--

DROP TABLE IF EXISTS `command_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `command_line` (
  `id_command_line` int NOT NULL AUTO_INCREMENT,
  `id_pizza` int NOT NULL,
  `id_command` int NOT NULL,
  `pizza_quantity` int NOT NULL,
  `comments` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_command_line`),
  KEY `id_command_pizza_idx` (`id_pizza`),
  KEY `id_command_command_idx` (`id_command`),
  CONSTRAINT `id_line_command` FOREIGN KEY (`id_command`) REFERENCES `command` (`id_command`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `id_line_pizza` FOREIGN KEY (`id_pizza`) REFERENCES `pizza` (`id_pizza`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `command_line`
--

LOCK TABLES `command_line` WRITE;
/*!40000 ALTER TABLE `command_line` DISABLE KEYS */;
INSERT INTO `command_line` VALUES (1,1,1,1,'supplément sauce piquante');
/*!40000 ALTER TABLE `command_line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredient`
--

DROP TABLE IF EXISTS `ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredient` (
  `id_ingredient` int NOT NULL AUTO_INCREMENT,
  `name_ingredient` varchar(150) NOT NULL,
  `capacity` varchar(20) NOT NULL,
  `price` decimal(4,2) NOT NULL,
  PRIMARY KEY (`id_ingredient`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredient`
--

LOCK TABLES `ingredient` WRITE;
/*!40000 ALTER TABLE `ingredient` DISABLE KEYS */;
INSERT INTO `ingredient` VALUES (1,'farine','1 kg',1.67),(2,'sauce tomate','1 L',2.00),(3,'mozzarella','125 g',1.15),(4,'sel','1 kg',0.60),(5,'huile d\'olive','1 L',8.70);
/*!40000 ALTER TABLE `ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredient_stock`
--

DROP TABLE IF EXISTS `ingredient_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredient_stock` (
  `id_ingredient` int NOT NULL,
  `id_pizzeria` int NOT NULL,
  `stock_quantity` int DEFAULT '0',
  PRIMARY KEY (`id_ingredient`,`id_pizzeria`),
  KEY `id_pizzeria_stock_idx` (`id_pizzeria`),
  KEY `id_ingredient_stock_idx` (`id_ingredient`),
  CONSTRAINT `id_ingredient_stock` FOREIGN KEY (`id_ingredient`) REFERENCES `ingredient` (`id_ingredient`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `id_pizzeria_stock` FOREIGN KEY (`id_pizzeria`) REFERENCES `pizzeria` (`id_pizzeria`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredient_stock`
--

LOCK TABLES `ingredient_stock` WRITE;
/*!40000 ALTER TABLE `ingredient_stock` DISABLE KEYS */;
INSERT INTO `ingredient_stock` VALUES (1,1,3);
/*!40000 ALTER TABLE `ingredient_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pizza`
--

DROP TABLE IF EXISTS `pizza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pizza` (
  `id_pizza` int NOT NULL AUTO_INCREMENT,
  `name_pizza` varchar(150) NOT NULL,
  `description` varchar(255) NOT NULL,
  `picture` blob,
  `price` decimal(4,2) NOT NULL,
  PRIMARY KEY (`id_pizza`),
  UNIQUE KEY `name_pizza_UNIQUE` (`name_pizza`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pizza`
--

LOCK TABLES `pizza` WRITE;
/*!40000 ALTER TABLE `pizza` DISABLE KEYS */;
INSERT INTO `pizza` VALUES (1,'pizza mozza','pizza à la mozza',NULL,8.40);
/*!40000 ALTER TABLE `pizza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pizzeria`
--

DROP TABLE IF EXISTS `pizzeria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pizzeria` (
  `id_pizzeria` int NOT NULL AUTO_INCREMENT,
  `pizzeria_name` varchar(20) NOT NULL,
  `is_open` tinyint NOT NULL DEFAULT '0',
  `tel` varchar(20) NOT NULL,
  `id_address` int NOT NULL,
  PRIMARY KEY (`id_pizzeria`),
  KEY `id_address_idx` (`id_address`),
  CONSTRAINT `id_pizzeria_address` FOREIGN KEY (`id_address`) REFERENCES `address` (`id_address`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pizzeria`
--

LOCK TABLES `pizzeria` WRITE;
/*!40000 ALTER TABLE `pizzeria` DISABLE KEYS */;
INSERT INTO `pizzeria` VALUES (1,'la pizzeria',1,'07.07.07.07.07',2);
/*!40000 ALTER TABLE `pizzeria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe`
--

DROP TABLE IF EXISTS `recipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe` (
  `id_pizza` int NOT NULL,
  `id_ingredient` int NOT NULL,
  `ingredient_quantity` int NOT NULL,
  PRIMARY KEY (`id_pizza`,`id_ingredient`),
  KEY `recipe_id_ingredient_idx` (`id_ingredient`),
  CONSTRAINT `recipe_id_ingredient` FOREIGN KEY (`id_ingredient`) REFERENCES `ingredient` (`id_ingredient`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `recipe_id_pizza` FOREIGN KEY (`id_pizza`) REFERENCES `pizza` (`id_pizza`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe`
--

LOCK TABLES `recipe` WRITE;
/*!40000 ALTER TABLE `recipe` DISABLE KEYS */;
INSERT INTO `recipe` VALUES (1,1,2);
/*!40000 ALTER TABLE `recipe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id_role` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(255) NOT NULL,
  `right_lvl` int NOT NULL,
  PRIMARY KEY (`id_role`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Manager','Managing one or more pizzerias',1),(2,'Pizaiolo','Preparing pizzas for one pizzeria',2),(3,'Deliverer','Deliver pizzas for one pizzeria',2),(4,'Customer','Create account and place orders',3);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-07  0:55:06
