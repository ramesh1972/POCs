CREATE DATABASE  IF NOT EXISTS `destiny-limo-db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `destiny-limo-db`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 172.235.16.212    Database: destiny-limo-db
-- ------------------------------------------------------
-- Server version	8.0.39-0ubuntu0.24.04.2

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
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `content` (
  `content_id` int NOT NULL AUTO_INCREMENT,
  `content_type_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `is_public` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` bit(1) DEFAULT b'1',
  `is_deleted` bit(1) DEFAULT b'0',
  PRIMARY KEY (`content_id`),
  KEY `content_type_id` (`content_type_id`),
  CONSTRAINT `content_ibfk_1` FOREIGN KEY (`content_type_id`) REFERENCES `content_type` (`content_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
INSERT INTO `content` VALUES (15,7,'Question 1','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,'2024-08-14 14:34:09','2024-09-03 14:47:57',_binary '',_binary '\0'),(16,7,'Question 2','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,'2024-08-14 14:34:09','2024-08-14 14:34:09',_binary '',_binary '\0'),(17,7,'Question 3','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,'2024-08-14 14:34:09','2024-08-14 14:34:09',_binary '',_binary '\0'),(18,7,'Question 4','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,'2024-08-14 14:34:09','2024-08-14 14:34:09',_binary '',_binary '\0'),(19,7,'Question 5','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,'2024-08-14 14:34:09','2024-08-14 14:34:09',_binary '',_binary '\0'),(20,7,'Question 6','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,'2024-08-14 14:34:09','2024-08-14 14:34:09',_binary '',_binary '\0'),(21,7,'Question 7','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,'2024-08-14 14:34:09','2024-08-14 14:34:09',_binary '',_binary '\0'),(22,7,'Question 8','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,'2024-08-14 14:34:09','2024-08-14 14:34:09',_binary '',_binary '\0'),(23,7,'Question 9','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,'2024-08-14 14:34:09','2024-08-14 14:34:09',_binary '',_binary '\0'),(24,7,'Question 10','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,'2024-08-14 14:34:09','2024-08-14 14:34:09',_binary '',_binary '\0'),(25,2,'Service 1','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,'2024-08-14 14:35:16','2024-09-03 14:40:43',_binary '',_binary '\0'),(26,2,'Service 2','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,'2024-08-14 14:35:16','2024-08-15 05:36:44',_binary '',_binary ''),(27,2,'Service 3','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,'2024-08-14 14:35:16','2024-09-03 14:40:43',_binary '',_binary ''),(28,2,'Service 4','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,'2024-08-14 14:35:16','2024-09-03 14:40:43',_binary '',_binary ''),(29,2,'Service 5','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,'2024-08-14 14:35:16','2024-08-15 06:44:51',_binary '',_binary ''),(30,2,'Service 2','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,'2024-08-14 14:35:16','2024-09-01 20:43:22',_binary '',_binary '\0'),(31,2,'Service 3','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,'2024-08-14 14:35:16','2024-09-01 20:43:22',_binary '\0',_binary '\0'),(32,2,'Service 8','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,'2024-08-14 14:35:16','2024-08-14 14:35:16',_binary '',_binary '\0'),(33,2,'Service 9','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',0,'2024-08-14 14:35:16','2024-08-15 06:44:51',_binary '',_binary '\0'),(34,2,'Service 10','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,'2024-08-14 14:35:16','2024-08-14 14:35:16',_binary '',_binary '\0'),(55,3,'Process 1','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,'2024-08-14 14:39:51','2024-08-14 14:39:51',_binary '',_binary '\0'),(56,3,'Process 2','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,'2024-08-14 14:39:51','2024-08-14 14:39:51',_binary '',_binary '\0'),(57,3,'Process 3','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,'2024-08-14 14:39:51','2024-08-14 14:39:51',_binary '',_binary '\0'),(58,3,'Process 4','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,'2024-08-14 14:39:51','2024-08-14 14:39:51',_binary '',_binary '\0'),(59,3,'Process 5','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,'2024-08-14 14:39:51','2024-08-14 14:39:51',_binary '',_binary '\0'),(60,3,'Process 6','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,'2024-08-14 14:39:51','2024-08-14 14:39:51',_binary '',_binary '\0'),(61,3,'Process 7','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,'2024-08-14 14:39:51','2024-08-14 14:39:51',_binary '',_binary '\0'),(62,3,'Process 8','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,'2024-08-14 14:39:51','2024-08-14 14:39:51',_binary '',_binary '\0'),(63,3,'Process 9','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,'2024-08-14 14:39:51','2024-08-14 14:39:51',_binary '',_binary '\0'),(64,3,'Process 10','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,'2024-08-14 14:39:51','2024-08-14 14:39:51',_binary '',_binary '\0'),(65,6,'Post A','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent mattis nulla sodales lectus imperdiet volutpat. Etiam eget enim a nunc elementum auctor. Donec vitae vestibulum nisi. Fusce ligula justo, fringilla nec varius in, vulputate ac magna. Nunc ut suscipit magna. Phasellus egestas ante eu volutpat consectetur. Nam semper mollis tempus. Aenean vitae tincidunt dolor, id tempus metus. Nunc ultricies nunc ligula, nec porta orci tempus scelerisque. Aliquam ultricies orci et tellus fringilla faucibus. Morbi vel lacus ante. Maecenas viverra sapien urna, porttitor efficitur urna elementum non. Nulla tempor vitae lectus eget cursus. Cras porttitor ante sit amet lacus maximus, in interdum massa pulvinar.',1,'2024-08-14 15:51:08','2024-09-03 14:44:30',_binary '',_binary '\0'),(67,6,'Post B','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse tristique id odio eget blandit. Praesent nisl justo, finibus ornare lorem sit amet, fringilla scelerisque sem. Vivamus malesuada viverra cursus. Integer consequat massa vitae lacinia auctor. Nulla rhoncus mi turpis, vitae malesuada augue pellentesque ut. Ut laoreet viverra massa, a ultrices dolor tempus id. Proin facilisis orci in ligula pharetra fermentum.',0,'2024-08-14 15:51:08','2024-09-03 14:44:30',_binary '',_binary '\0'),(68,6,'Post C','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent mattis nulla sodales lectus imperdiet volutpat. Etiam eget enim a nunc elementum auctor. Donec vitae vestibulum nisi. Fusce ligula justo, fringilla nec varius in, vulputate ac magna. Nunc ut suscipit magna. Phasellus egestas ante eu volutpat consectetur. Nam semper mollis tempus. Aenean vitae tincidunt dolor, id tempus metus. Nunc ultricies nunc ligula, nec porta orci tempus scelerisque. Aliquam ultricies orci et tellus fringilla faucibus. Morbi vel lacus ante. Maecenas viverra sapien urna, porttitor efficitur urna elementum non. Nulla tempor vitae lectus eget cursus. Cras porttitor ante sit amet lacus maximus, in interdum massa pulvinar.',0,'2024-08-14 15:51:08','2024-09-03 14:44:30',_binary '',_binary '\0'),(70,6,'Post D','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse tristique id odio eget blandit. Praesent nisl justo, finibus ornare lorem sit amet, fringilla scelerisque sem. Vivamus malesuada viverra cursus. Integer consequat massa vitae lacinia auctor. Nulla rhoncus mi turpis, vitae malesuada augue pellentesque ut. Ut laoreet viverra massa, a ultrices dolor tempus id. Proin facilisis orci in ligula pharetra fermentum.',0,'2024-08-14 17:46:23','2024-09-03 14:44:30',_binary '',_binary '\0'),(73,6,'Post E','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent mattis nulla sodales lectus imperdiet volutpat. Etiam eget enim a nunc elementum auctor. Donec vitae vestibulum nisi. Fusce ligula justo, fringilla nec varius in, vulputate ac magna. Nunc ut suscipit magna. Phasellus egestas ante eu volutpat consectetur. Nam semper mollis tempus. Aenean vitae tincidunt dolor, id tempus metus. Nunc ultricies nunc ligula, nec porta orci tempus scelerisque. Aliquam ultricies orci et tellus fringilla faucibus. Morbi vel lacus ante. Maecenas viverra sapien urna, porttitor efficitur urna elementum non. Nulla tempor vitae lectus eget cursus. Cras porttitor ante sit amet lacus maximus, in interdum massa pulvinar.',1,'2024-08-14 22:17:00','2024-09-03 14:44:30',_binary '',_binary '\0'),(74,6,'Post F','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse tristique id odio eget blandit. Praesent nisl justo, finibus ornare lorem sit amet, fringilla scelerisque sem. Vivamus malesuada viverra cursus. Integer consequat massa vitae lacinia auctor. Nulla rhoncus mi turpis, vitae malesuada augue pellentesque ut. Ut laoreet viverra massa, a ultrices dolor tempus id. Proin facilisis orci in ligula pharetra fermentum.',0,'2024-08-14 22:27:22','2024-09-03 14:44:30',_binary '',_binary '\0'),(75,2,'Service 11','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',0,'2024-08-15 05:36:44','2024-09-03 14:40:43',_binary '',_binary '\0');
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content_type`
--

DROP TABLE IF EXISTS `content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `content_type` (
  `content_type_id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) NOT NULL,
  PRIMARY KEY (`content_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_type`
--

LOCK TABLES `content_type` WRITE;
/*!40000 ALTER TABLE `content_type` DISABLE KEYS */;
INSERT INTO `content_type` VALUES (2,'Service Description'),(3,'Process Description'),(6,'Post'),(7,'FAQ');
/*!40000 ALTER TABLE `content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) NOT NULL,
  `is_deleted` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin',0),(2,'driver',0),(3,'client',0);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_material`
--

DROP TABLE IF EXISTS `training_material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `training_material` (
  `material_id` int NOT NULL AUTO_INCREMENT,
  `material_type_id` int NOT NULL,
  `material_category_id` int DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT '0',
  `is_active` tinyint DEFAULT '1',
  `is_deleted` tinyint DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `title` varchar(1024) DEFAULT NULL,
  `description` text,
  `thumbnail` blob,
  `background_img` text,
  PRIMARY KEY (`material_id`),
  KEY `material_type_id` (`material_type_id`),
  KEY `material_category_id` (`material_category_id`),
  CONSTRAINT `training_material_ibfk_1` FOREIGN KEY (`material_type_id`) REFERENCES `training_material_type` (`material_type_id`) ON DELETE CASCADE,
  CONSTRAINT `training_material_ibfk_2` FOREIGN KEY (`material_category_id`) REFERENCES `training_material_category` (`material_category_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_material`
--

LOCK TABLES `training_material` WRITE;
/*!40000 ALTER TABLE `training_material` DISABLE KEYS */;
INSERT INTO `training_material` VALUES (9,4,10,0,1,0,'2024-08-15 04:21:43','2024-09-02 02:09:11',NULL,'description',NULL,NULL),(10,4,13,0,1,0,'2024-08-15 04:21:43','2024-09-02 02:10:26',NULL,'description',NULL,NULL),(11,4,15,1,1,0,'2024-08-15 04:21:43','2024-09-02 02:11:44','What should be checked before starting a limousine trip?','description',NULL,NULL),(12,4,15,0,1,0,'2024-08-15 04:21:43','2024-09-02 02:09:11',NULL,'description',NULL,NULL),(13,4,16,1,1,0,'2024-08-15 04:21:43','2024-09-02 02:11:44',NULL,'description',NULL,NULL),(14,4,10,0,1,0,'2024-08-15 04:21:43','2024-09-02 02:10:26',NULL,'description',NULL,NULL),(15,4,13,0,1,0,'2024-08-15 04:21:43','2024-09-02 02:10:26',NULL,'description',NULL,NULL),(16,4,14,1,1,0,'2024-08-15 04:21:43','2024-09-02 02:11:44',NULL,'description',NULL,NULL),(17,4,15,0,1,0,'2024-08-15 04:21:43','2024-09-02 02:10:26',NULL,'description',NULL,NULL),(18,4,16,0,1,0,'2024-08-15 04:21:43','2024-09-02 02:10:26',NULL,'description',NULL,NULL),(59,4,10,1,1,0,'2024-08-15 07:27:18','2024-09-02 02:11:44','Title 1','Description for material 1',NULL,NULL),(60,4,15,0,1,0,'2024-08-15 07:27:18','2024-09-02 02:10:26','Title 2','Description for material 2Description for material 2Description for material 2Description for material 2Description for material 2Description for material 2Description for material 2Description for material 2Description for material 2Description for material 2Description for material 2Description for material 2',NULL,NULL),(61,4,20,0,1,0,'2024-08-15 07:27:18','2024-09-02 02:10:26','Title 3','Description for material 3',NULL,NULL),(62,4,13,1,1,0,'2024-08-15 07:27:18','2024-09-02 02:11:44','Title 4','Description for material 4',NULL,NULL),(63,4,19,0,1,0,'2024-08-15 07:27:18','2024-09-02 02:10:26','Title 5','Description for material 5',NULL,NULL),(64,4,22,1,1,0,'2024-08-15 07:27:18','2024-09-02 02:11:44','Title 6','Description for material 6',NULL,NULL),(65,4,13,0,1,0,'2024-08-15 07:27:18','2024-09-02 02:10:26','Title 7','Description for material 7',NULL,NULL),(66,4,17,0,1,0,'2024-08-15 07:27:18','2024-09-02 02:10:26','Title 8','Description for material 8',NULL,NULL),(67,4,10,1,1,0,'2024-08-15 07:27:18','2024-09-02 02:11:44','Title 9','Description for material 9',NULL,NULL),(68,4,21,0,1,0,'2024-08-15 07:27:18','2024-09-02 02:10:26','Title 10','Description for material 10',NULL,NULL),(69,4,18,0,1,0,'2024-08-15 07:27:18','2024-09-02 02:10:26','Title 11','Description for material 11',NULL,NULL),(70,4,14,1,1,0,'2024-08-15 07:27:18','2024-09-02 02:11:44','Title 12','Description for material 12',NULL,NULL),(71,4,16,0,1,0,'2024-08-15 07:27:18','2024-09-02 02:10:26','Title 13','Description for material 13',NULL,NULL),(72,4,10,0,1,0,'2024-08-15 07:27:18','2024-09-02 02:10:26','Title 14','Description for material 14',NULL,NULL),(73,4,10,1,1,0,'2024-08-15 07:27:18','2024-09-02 02:11:44','Title 15','Description for material 15',NULL,NULL),(74,4,10,0,1,0,'2024-08-15 07:27:18','2024-09-02 02:10:26','Title 16','Description for material 16',NULL,NULL),(75,4,20,0,1,0,'2024-08-15 07:27:18','2024-09-02 02:10:26','Title 17','Description for material 17',NULL,NULL),(76,4,22,1,1,0,'2024-08-15 07:27:18','2024-09-02 02:11:44','Title 18','Description for material 18',NULL,NULL),(77,4,13,0,1,0,'2024-08-15 07:27:18','2024-09-02 02:10:26','Title 19','Description for material 19',NULL,NULL),(78,4,15,0,1,0,'2024-08-15 07:27:18','2024-09-02 02:10:26','Title 20','Description for material 20',NULL,NULL),(79,4,13,1,1,0,'2024-08-15 07:31:49','2024-09-02 02:11:44','Title 21','Description for material 21',NULL,NULL),(80,5,10,0,1,0,'2024-08-15 08:42:19','2024-08-15 09:11:51','Luxury Limo Service Training','Comprehensive training material for luxury limo service providers.',NULL,''),(81,5,13,1,1,0,'2024-08-15 08:42:19','2024-09-02 02:11:44','Advanced Chauffeur Training','Advanced training materials for professional limo chauffeurs.',NULL,''),(82,5,15,0,1,0,'2024-08-15 08:42:19','2024-08-15 09:11:51','Customer Service Excellence','Material focused on delivering exceptional customer service.',NULL,''),(83,5,20,0,1,0,'2024-08-15 08:42:19','2024-08-15 09:11:51','Fleet Management Best Practices','Guide on managing a fleet of luxury limousines.',NULL,''),(84,2,23,1,1,0,'2024-08-15 09:35:20','2024-09-21 10:47:06','Limousine Training 101','Basic training for limousine drivers.',NULL,NULL),(85,2,15,1,1,0,'2024-08-15 09:35:20','2024-09-02 02:11:44','Advanced Limousine Maneuvers','Learn advanced driving techniques for limousine services.',NULL,NULL),(86,2,18,1,1,0,'2024-08-15 09:35:20','2024-09-21 10:47:06','Customer Service Excellence','How to provide exceptional customer service in the limousine industry.',NULL,NULL),(87,2,21,1,1,0,'2024-08-15 09:35:20','2024-09-02 02:11:44','Limousine Maintenance Essentials','Essential maintenance tips for limousine services.',NULL,NULL),(88,2,13,1,1,0,'2024-08-15 09:35:20','2024-09-21 10:47:06','Safety Protocols for Limousine Drivers','Critical safety protocols for limousine operators.',NULL,NULL),(89,1,10,0,1,0,'2024-08-15 10:10:36','2024-09-03 20:23:54','Title 1','This is the description for file 1',NULL,NULL),(90,1,13,1,1,0,'2024-08-15 10:10:36','2024-09-03 20:23:54','Title 2','This is the description for file 2',NULL,NULL),(91,1,14,0,1,0,'2024-08-15 10:10:36','2024-09-03 20:23:54','Title 3','This is the description for file 3',NULL,NULL),(92,1,15,0,1,0,'2024-08-15 10:10:36','2024-09-03 20:23:54','Title 4','This is the description for file 4',NULL,NULL),(93,1,16,1,1,0,'2024-08-15 10:10:36','2024-09-03 20:23:54','Title 5','This is the description for file 5',NULL,NULL),(94,1,17,1,1,0,'2024-08-15 10:10:36','2024-09-20 02:27:18','Title 6','This is the description for file 6',NULL,NULL),(95,1,18,0,1,0,'2024-08-15 10:10:36','2024-09-03 20:23:54','Title 7','This is the description for file 7',NULL,NULL),(96,1,19,1,1,0,'2024-08-15 10:10:36','2024-09-03 20:23:54','Title 8','This is the description for file 8',NULL,NULL),(97,1,20,0,1,0,'2024-08-15 10:10:36','2024-09-03 20:23:54','Title 9','This is the description for file 9',NULL,NULL),(98,1,20,1,1,0,'2024-08-15 10:10:36','2024-09-20 03:15:36','Title 10','This is the description for file 10',NULL,NULL),(99,1,15,0,1,0,'2024-09-21 09:07:20','2024-09-21 09:07:20','GHG','GFGH',NULL,NULL),(100,1,25,0,1,0,'2024-09-21 09:12:06','2024-09-21 09:12:06','AAA','AAAAAA',NULL,NULL),(101,1,28,0,1,0,'2024-09-21 09:16:28','2024-09-21 09:16:28','DFG','DFGHHH',NULL,NULL),(102,2,26,1,1,0,'2024-09-21 10:46:11','2024-09-21 10:47:06','NEWVID','ABC',NULL,NULL),(103,1,25,0,1,0,'2024-09-21 10:47:41','2024-09-21 10:47:41','NEWDOC','NEWDOCDESC',NULL,NULL);
/*!40000 ALTER TABLE `training_material` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_material_category`
--

DROP TABLE IF EXISTS `training_material_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `training_material_category` (
  `material_category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) NOT NULL,
  `category_description` text,
  `is_active` bit(1) DEFAULT b'1',
  `is_deleted` bit(1) DEFAULT b'0',
  PRIMARY KEY (`material_category_id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_material_category`
--

LOCK TABLES `training_material_category` WRITE;
/*!40000 ALTER TABLE `training_material_category` DISABLE KEYS */;
INSERT INTO `training_material_category` VALUES (10,'Category 1','Courses in this category cover emergency response and safety procedures, teaching drivers how to handle breakdowns, accidents, and other unexpected situations.',_binary '',_binary '\0'),(13,'Category 2','Comprehensive training materials for luxury limo chauffeurs, covering driving etiquette, customer service, and safety protocol',_binary '',_binary '\0'),(14,'Category 3','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu felis eu neque sodales varius.',_binary '',_binary '\0'),(15,'Category 4','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu felis eu neque sodales varius.',_binary '',_binary '\0'),(16,'Category 5','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu felis eu neque sodales varius.',_binary '',_binary '\0'),(17,'Category 6','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu felis eu neque sodales varius.',_binary '',_binary '\0'),(18,'Category 7','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu felis eu neque sodales varius.',_binary '',_binary '\0'),(19,'Category 8','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu felis eu neque sodales varius.',_binary '',_binary '\0'),(20,'Category 9','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu felis eu neque sodales varius.',_binary '',_binary '\0'),(21,'Category 10','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu felis eu neque sodales varius.',_binary '',_binary '\0'),(22,'Category 11','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu felis eu neque sodales varius.',_binary '',_binary '\0'),(23,'Category 12','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu felis eu neque sodales varius.',_binary '',_binary '\0'),(24,'Category 13','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu felis eu neque sodales varius.',_binary '',_binary '\0'),(25,'Category 14','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu felis eu neque sodales varius.',_binary '',_binary '\0'),(26,'Category 15','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu felis eu neque sodales varius.',_binary '',_binary '\0'),(27,'Category 16','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu felis eu neque sodales varius.',_binary '',_binary '\0'),(28,'Category 17','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu felis eu neque sodales varius.',_binary '',_binary '\0');
/*!40000 ALTER TABLE `training_material_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_material_files`
--

DROP TABLE IF EXISTS `training_material_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `training_material_files` (
  `file_id` int NOT NULL AUTO_INCREMENT,
  `material_id` int NOT NULL,
  `file_name` varchar(255) NOT NULL,
  PRIMARY KEY (`file_id`),
  KEY `material_id` (`material_id`),
  CONSTRAINT `training_material_files_ibfk_1` FOREIGN KEY (`material_id`) REFERENCES `training_material` (`material_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_material_files`
--

LOCK TABLES `training_material_files` WRITE;
/*!40000 ALTER TABLE `training_material_files` DISABLE KEYS */;
INSERT INTO `training_material_files` VALUES (3,98,'file-example_PDF_1MB.pdf'),(4,90,'file-sample_100kB.docx'),(5,91,'file-example_PDF_1MB.pdf'),(6,92,'file_example_XLSX_10.xlsx'),(7,93,'Screenshot 2024-08-16 193137.png'),(15,94,'Screenshot 2024-09-06 175238.png'),(16,99,'IMG_20220219_150438_629.jpg'),(17,100,'IMG_20220219_150438_629.jpg'),(18,101,'Compare (7).docx'),(19,103,'rameshv-me-bg1.jpg');
/*!40000 ALTER TABLE `training_material_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_material_mcqs`
--

DROP TABLE IF EXISTS `training_material_mcqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `training_material_mcqs` (
  `question_id` int NOT NULL AUTO_INCREMENT,
  `material_id` int NOT NULL,
  `question_text` text NOT NULL,
  `answer_1` text NOT NULL,
  `answer_2` text NOT NULL,
  `answer_3` text NOT NULL,
  `answer_4` text NOT NULL,
  `correct_1` tinyint(1) DEFAULT '0',
  `correct_2` tinyint(1) DEFAULT '0',
  `correct_3` tinyint(1) DEFAULT '0',
  `correct_4` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`question_id`),
  KEY `training_material_mcqs` (`material_id`),
  CONSTRAINT `training_material_mcqs` FOREIGN KEY (`material_id`) REFERENCES `training_material` (`material_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_material_mcqs`
--

LOCK TABLES `training_material_mcqs` WRITE;
/*!40000 ALTER TABLE `training_material_mcqs` DISABLE KEYS */;
INSERT INTO `training_material_mcqs` VALUES (31,10,'What is the most important aspect of providing luxury limousine services?','Timeliness','Safety','Comfort','Professionalism',0,1,0,1),(32,11,'What should be checked before starting a limousine trip?','Oil levels in house','Tire pressure','Cleanliness of the vehicle','All of the above',0,0,0,1),(33,12,'How should a chauffeur greet a VIP client?','Handshake','Smile and open the door','Simply nod','Wait silently',0,1,0,0),(34,13,'What is the ideal temperature range inside a luxury limousine?','65-70°F','70-75°F','75-80°F','80-85°F',0,1,0,0),(35,14,'How often should the limousine be serviced?','Every 3 months','Every 6 months','After every 10,000 miles','According to manufacturer recommendations',0,0,0,1),(36,15,'What are the most common amenities provided in a luxury limousine?','Minibar and entertainment system','Wi-Fi and plush seating','Privacy partition','All of the above',0,0,0,1),(37,16,'How should the chauffeur respond if a client requests a route change?','Follow the GPS','Politely agree and confirm','Consult with the dispatcher','Refuse',0,1,0,0),(38,17,'What should be done if the limousine gets a flat tire during service?','Call roadside assistance','Replace the tire','Ask the client to wait for another vehicle','Drive to the nearest service station',1,0,0,0),(39,18,'How should a chauffeur handle client confidentiality?','Never discuss client details','Only discuss details with colleagues','Share details on social media','Discuss openly',1,0,0,0),(40,59,'What is the appropriate way to manage client luggage?','Let the client handle it','Handle with care and load it','Ask the client to assist','Leave it in the car',0,1,0,0),(41,60,'What is the best route planning strategy for a luxury limousine service?','Use the shortest route','Follow client instructions','Use a combination of fastest and scenic routes','Follow the GPS strictly',0,0,1,0),(42,61,'What should a chauffeur do in case of an emergency on the road?','Panic','Call the dispatcher','Safely stop and assist','Ignore and keep driving',0,0,1,0),(43,62,'How can a chauffeur ensure client comfort during the ride?','Adjust temperature as requested','Play loud music','Engage in conversation constantly','Offer beverages',1,0,0,1),(44,63,'When should a limousine be cleaned?','Only when dirty','After every service','Once a week','Twice a month',0,1,0,0),(45,64,'What should a chauffeur wear during service?','Casual clothes','Formal suit and tie','Jeans and a T-shirt','Traditional chauffeur uniform',0,1,0,0),(46,65,'What is the appropriate way to handle tips from clients?','Refuse politely','Accept and thank the client','Demand more','Ignore',0,1,0,0),(47,66,'How should a chauffeur drive when transporting a VIP client?','As fast as possible','According to traffic laws and smoothly','Aggressively','Carelessly',0,1,0,0),(48,67,'What should be done if the client is running late?','Leave the client','Wait patiently and communicate','Cancel the service','Charge extra immediately',0,1,0,0),(49,68,'How should a chauffeur manage a client who is intoxicated?','Ignore the situation','Politely assist and ensure safety','Argue with the client','Report to authorities immediately',0,1,0,0),(50,69,'What is the best practice for using in-car entertainment systems?','Let the client control it','Set it according to the client’s preferences','Keep it off','Use it for personal use',0,1,0,0),(51,70,'How should a chauffeur handle road rage incidents?','Engage in the confrontation','Ignore and drive safely','Speed away','Report to the dispatcher',0,1,0,1),(52,71,'What is the ideal response if the client makes an unreasonable request?','Refuse immediately','Politely explain limitations','Agree reluctantly','Complain to management',0,1,0,0),(53,72,'What should be done if the client leaves personal belongings in the limousine?','Keep it as a tip','Return it immediately','Ignore it','Report to lost and found',0,1,0,1),(54,73,'What type of music should be played during the ride?','Loud music','Client’s preference','Driver’s choice','No music at all',0,1,0,0),(55,74,'What is the appropriate action when the limousine is low on fuel during a service?','Stop immediately','Inform the client and refuel','Ignore it','Ask the client to pay for fuel',0,1,0,0),(56,75,'How often should a chauffeur check their driving license and insurance validity?','Once a year','Before every service','When it expires','Every month',0,1,0,0),(57,76,'What is the proper way to handle a client who is constantly on the phone?','Interrupt the conversation','Respect the client’s privacy','Ask them to stop','Discuss it with the client',0,1,0,0),(58,77,'How should a chauffeur manage their personal time while waiting for a client?','Sleep in the car','Stay alert and ready','Leave the vehicle','Engage in personal activities',0,1,0,0),(59,78,'What should a chauffeur do if they suspect the client is involved in illegal activities?','Ignore it','Report to the authorities','Ask the client to leave','Confront the client',0,1,0,0),(60,79,'How should a chauffeur manage their vehicle’s cleanliness?','Only clean when dirty','Clean after every service','Never clean it','Wait for the client to request cleaning',0,1,0,0);
/*!40000 ALTER TABLE `training_material_mcqs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_material_text`
--

DROP TABLE IF EXISTS `training_material_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `training_material_text` (
  `text_id` int NOT NULL AUTO_INCREMENT,
  `material_id` int NOT NULL,
  `text` text NOT NULL,
  PRIMARY KEY (`text_id`),
  KEY `training_material_text` (`material_id`),
  CONSTRAINT `training_material_text` FOREIGN KEY (`material_id`) REFERENCES `training_material` (`material_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_material_text`
--

LOCK TABLES `training_material_text` WRITE;
/*!40000 ALTER TABLE `training_material_text` DISABLE KEYS */;
INSERT INTO `training_material_text` VALUES (3,80,'This material provides a comprehensive overview of the luxury limo service industry. You will explore the fundamentals of delivering a premium experience to your clients, from maintaining the highest standards of vehicle cleanliness to understanding the nuances of customer service that set luxury services apart from standard offerings. Additionally, you will learn about the legal and regulatory requirements that govern the luxury transportation industry. The course includes practical tips on how to market and position your services to attract high-end clientele. By the end of this training, you will have the knowledge and skills necessary to establish and grow a successful luxury limo business.'),(4,81,'This advanced chauffeur training program is designed for those who are already in the industry and wish to take their skills to the next level. The program covers advanced driving techniques, including evasive maneuvers and defensive driving strategies that are essential for ensuring the safety and comfort of VIP clients. You will also delve into the art of discretion and confidentiality, learning how to manage sensitive information and maintain client privacy at all times. The course offers insights into the latest in-vehicle technologies that enhance the client experience, as well as guidance on personal grooming and professional demeanor, ensuring that you present yourself as a top-tier chauffeur.'),(5,83,'Customer service is the cornerstone of any successful luxury limo business. This training material focuses on the advanced techniques needed to provide exceptional service that not only meets but exceeds client expectations. You will learn how to personalize services for each client, anticipating their needs before they even ask. The material covers how to handle difficult situations with grace and professionalism, ensuring that every client leaves with a positive impression. There are modules dedicated to understanding client psychology and how to use this knowledge to build lasting relationships. Additionally, you will explore the best practices for receiving and acting on client feedback to continually improve your service.'),(6,82,'Managing a fleet of luxury vehicles requires not only logistical expertise but also an understanding of the specific challenges that come with operating high-end vehicles. This guide provides you with the best practices for scheduling, dispatching, and maintaining a fleet of luxury limousines. You will learn about the latest fleet management software that can help you optimize operations, reduce downtime, and ensure that your vehicles are always in top condition. The material also covers the financial aspects of fleet management, including cost-saving strategies and budgeting tips. Whether you are managing a small fleet or a large operation, this training will equip you with the tools and knowledge needed to run a smooth and efficient service.');
/*!40000 ALTER TABLE `training_material_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_material_type`
--

DROP TABLE IF EXISTS `training_material_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `training_material_type` (
  `material_type_id` int NOT NULL AUTO_INCREMENT,
  `material_type_name` varchar(255) NOT NULL,
  PRIMARY KEY (`material_type_id`),
  UNIQUE KEY `material_type_name` (`material_type_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_material_type`
--

LOCK TABLES `training_material_type` WRITE;
/*!40000 ALTER TABLE `training_material_type` DISABLE KEYS */;
INSERT INTO `training_material_type` VALUES (1,'Files'),(4,'MCQ'),(3,'Q&A'),(5,'Text'),(2,'Video');
/*!40000 ALTER TABLE `training_material_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_material_videos`
--

DROP TABLE IF EXISTS `training_material_videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `training_material_videos` (
  `video_id` int NOT NULL AUTO_INCREMENT,
  `material_id` int NOT NULL,
  `url` text NOT NULL,
  `is_vimeo` tinyint DEFAULT '0',
  PRIMARY KEY (`video_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_material_videos`
--

LOCK TABLES `training_material_videos` WRITE;
/*!40000 ALTER TABLE `training_material_videos` DISABLE KEYS */;
INSERT INTO `training_material_videos` VALUES (3,84,'1stcut.mp4',0),(4,85,'https://lf9-dp-fe-cms-tos.byteorg.com/obj/bit-cloud/VTable/media/pigeon.mp4',0),(5,86,'https://lf9-dp-fe-cms-tos.byteorg.com/obj/bit-cloud/VTable/media/pigeon.mp4',1),(6,87,'https://lf9-dp-fe-cms-tos.byteorg.com/obj/bit-cloud/VTable/media/pigeon.mp4',0),(7,88,'https://lf9-dp-fe-cms-tos.byteorg.com/obj/bit-cloud/VTable/media/pigeon.mp4',1),(8,102,'small video - Made with Clipchamp.mp4',0);
/*!40000 ALTER TABLE `training_material_videos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_asked_questions`
--

DROP TABLE IF EXISTS `user_asked_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_asked_questions` (
  `user_question_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `asked_question` text NOT NULL,
  `admin_user_id` int DEFAULT NULL,
  `admin_answer` text,
  `is_public` tinyint DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `date_asked` datetime DEFAULT CURRENT_TIMESTAMP,
  `date_answered` datetime DEFAULT NULL,
  `is_deleted` tinyint DEFAULT '0',
  `is_active` tinyint DEFAULT '1',
  PRIMARY KEY (`user_question_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_asked_questions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_asked_questions`
--

LOCK TABLES `user_asked_questions` WRITE;
/*!40000 ALTER TABLE `user_asked_questions` DISABLE KEYS */;
INSERT INTO `user_asked_questions` VALUES (2,3,'how much do i get paid per kilometer?',1,'depends',0,'2024-07-27 13:48:16','2024-09-03 15:31:34','2024-08-24 07:02:17','2024-08-24 07:03:22',0,1),(4,5,'How many hours of training are needed to drive a limo?',1,'Typically, 20 hours of training is required.',1,'2024-08-24 01:30:01','2024-08-24 01:34:30','2024-08-24 07:02:17','2024-08-24 07:03:22',0,1),(6,5,'Can I drive a limo with my current driver’s license?',1,'yes',0,'2024-08-24 01:30:01','2024-09-03 15:31:34','2024-08-24 07:02:17',NULL,0,1),(7,2,'Are there any special rules for driving limos in the city?',1,'Yes, there are specific regulations depending on the city.',0,'2024-08-24 01:30:01','2024-08-24 01:30:01','2024-08-24 07:02:17',NULL,0,1),(8,5,'How do I get certified to drive a limo?',1,'You need to pass a written test and a driving test.',1,'2024-08-24 01:30:01','2024-08-24 01:34:30','2024-08-24 07:02:17','2024-08-24 07:03:22',0,1),(10,5,'What are the safety protocols for driving limos?',1,'Safety protocols include regular vehicle checks and driver training.',0,'2024-08-24 01:30:01','2024-08-24 01:30:01','2024-08-24 07:02:17',NULL,0,1),(11,2,'Can I drive a limo part-time?',1,'yes',0,'2024-08-24 01:30:01','2024-09-03 15:31:34','2024-08-24 07:02:17','2024-08-24 07:03:22',0,1),(12,5,'Do I need to renew my limo driver’s certification?',1,'Yes, certification needs to be renewed every two years.',1,'2024-08-24 01:30:01','2024-08-24 01:30:01','2024-08-24 07:02:17',NULL,0,1),(28,2,'what?',0,'',0,'2024-08-24 05:18:16','2024-09-03 15:32:39','2024-08-24 05:18:16','0001-01-01 00:00:00',0,1),(29,2,'when?',0,'today even',0,'2024-08-24 05:24:46','2024-09-13 11:03:54','2024-08-24 05:24:47','0001-01-01 00:00:00',0,1),(30,2,'how?',0,NULL,0,'2024-08-24 05:26:15','2024-09-03 15:32:39','2024-08-24 05:26:16','0001-01-01 00:00:00',0,1),(31,2,'is it true that?',0,'ffrf',0,'2024-08-24 05:27:28','2024-09-13 11:16:06','2024-08-24 05:27:29','0001-01-01 00:00:00',0,1),(32,2,'how much is enough?',0,'ik',0,'2024-08-24 05:27:55','2024-09-13 11:16:06','2024-08-24 05:27:55','0001-01-01 00:00:00',0,1),(33,2,'will you?',0,NULL,0,'2024-08-24 05:29:34','2024-09-03 15:32:39','2024-08-24 05:29:34','0001-01-01 00:00:00',0,1),(34,2,'why did you?',0,NULL,0,'2024-08-24 05:30:20','2024-09-03 15:32:39','2024-08-24 05:30:20','0001-01-01 00:00:00',0,1),(36,2,'Hello',0,NULL,0,'2024-09-27 19:30:43','2024-09-27 19:30:43','2024-09-27 19:30:43',NULL,0,1);
/*!40000 ALTER TABLE `user_asked_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_exam_answers`
--

DROP TABLE IF EXISTS `user_exam_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_exam_answers` (
  `exam_question_id` int NOT NULL AUTO_INCREMENT,
  `exam_id` int NOT NULL,
  `mcq_id` int NOT NULL,
  `choice_3_answer` tinyint DEFAULT '0',
  `choice_4_answer` tinyint DEFAULT '0',
  `choice_2_answer` tinyint DEFAULT '0',
  `choice_1_answer` tinyint DEFAULT '0',
  `attempted` tinyint DEFAULT '0',
  `is_correct` tinyint DEFAULT '0',
  PRIMARY KEY (`exam_question_id`),
  KEY `qa_id` (`mcq_id`),
  KEY `exam_id_idx` (`exam_id`),
  CONSTRAINT `exam_id` FOREIGN KEY (`exam_id`) REFERENCES `user_exams` (`exam_id`)
) ENGINE=InnoDB AUTO_INCREMENT=658 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_exam_answers`
--

LOCK TABLES `user_exam_answers` WRITE;
/*!40000 ALTER TABLE `user_exam_answers` DISABLE KEYS */;
INSERT INTO `user_exam_answers` VALUES (1,1,1,0,0,NULL,0,0,0),(2,1,32,1,0,1,1,0,0),(3,2,45,0,1,0,1,0,0),(4,1,50,1,1,0,0,0,0),(5,2,33,0,0,1,1,0,0),(6,1,37,1,0,1,0,0,0),(7,2,52,0,1,0,1,0,0),(8,1,40,1,1,0,0,0,0),(9,2,46,0,0,1,1,0,0),(10,1,34,1,0,1,1,0,0),(11,2,58,0,1,0,0,0,0),(12,1,42,1,0,1,0,0,0),(13,2,36,0,1,1,1,0,0),(14,1,53,1,0,0,1,0,0),(15,2,39,0,1,1,0,0,0),(16,1,47,1,1,0,0,0,0),(17,2,60,0,0,1,1,0,0),(18,1,31,1,1,1,0,0,0),(19,2,55,0,0,0,1,0,0),(20,1,38,1,0,1,1,0,0),(21,2,44,0,1,0,0,0,0),(22,1,59,1,0,1,1,0,0),(23,2,51,0,1,1,0,0,0),(24,1,35,1,1,0,0,0,0),(25,2,57,0,0,1,1,0,0),(26,1,41,1,0,0,1,0,0),(27,2,54,0,1,1,0,0,0),(28,1,48,1,0,1,0,0,0),(29,2,43,0,1,0,1,0,0),(30,1,49,1,1,1,0,0,0),(31,2,56,0,0,0,1,0,0),(32,1,32,1,0,1,0,0,0),(33,2,45,0,1,0,1,0,0),(34,1,50,1,1,1,0,0,0),(35,2,33,0,0,1,1,0,0),(36,1,37,1,0,1,0,0,0),(37,2,52,0,1,1,0,0,0),(38,1,40,1,0,0,1,0,0),(39,2,46,0,1,1,0,0,0),(40,1,34,1,0,1,1,0,0),(41,2,58,0,1,0,0,0,0),(42,1,42,1,0,1,0,0,0),(43,2,36,0,1,1,0,0,0),(44,1,53,1,1,1,0,0,0),(45,2,39,0,0,1,1,0,0),(46,1,47,1,0,1,0,0,0),(47,2,60,0,1,0,1,0,0),(48,1,31,1,1,0,0,0,0),(49,2,55,0,0,1,1,0,0),(50,1,38,1,0,0,1,0,0),(51,2,44,0,1,1,0,0,0),(52,1,59,1,1,1,0,0,0),(53,2,51,0,0,1,1,0,0),(54,1,35,1,0,0,1,0,0),(55,2,57,0,1,1,0,0,0),(56,1,41,1,0,1,0,0,0),(57,2,54,0,1,0,1,0,0),(628,88,50,0,0,0,1,1,0),(629,88,42,0,0,0,0,0,0),(630,88,51,0,0,0,0,0,0),(631,88,38,0,0,0,0,0,0),(632,88,57,0,0,0,0,0,0),(633,88,34,0,0,0,0,0,0),(634,88,44,0,0,0,0,0,0),(635,88,52,0,0,0,0,0,0),(636,88,49,0,0,0,0,0,0),(637,88,53,0,0,0,0,0,0),(638,88,37,0,0,0,0,0,0),(639,88,55,0,0,0,0,0,0),(640,88,60,0,0,0,0,0,0),(641,88,46,0,0,0,0,0,0),(642,88,32,0,0,0,0,0,0),(643,89,33,0,0,1,0,1,1),(644,89,40,0,0,1,0,1,1),(645,89,37,0,0,0,0,0,0),(646,89,32,0,0,0,0,0,0),(647,89,47,0,0,0,0,0,0),(648,89,38,0,0,0,0,0,0),(649,89,55,0,0,0,0,0,0),(650,89,41,0,0,0,0,0,0),(651,89,56,0,0,0,0,0,0),(652,89,36,0,0,0,0,0,0),(653,89,52,0,0,0,0,0,0),(654,89,50,0,0,0,0,0,0),(655,89,58,0,0,0,0,0,0),(656,89,49,0,0,0,0,0,0),(657,89,60,0,0,0,0,0,0);
/*!40000 ALTER TABLE `user_exam_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_exams`
--

DROP TABLE IF EXISTS `user_exams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_exams` (
  `exam_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `date_created` datetime DEFAULT CURRENT_TIMESTAMP,
  `date_started` datetime DEFAULT NULL,
  `date_completed` datetime DEFAULT NULL,
  `score` int DEFAULT NULL,
  `result` tinyint DEFAULT '0',
  `certificate_url` varchar(255) DEFAULT NULL,
  `num_questions` int DEFAULT NULL,
  `num_attempted` int DEFAULT NULL,
  `num_correct` int DEFAULT NULL,
  `num_wrong` int DEFAULT NULL,
  `min_correct_answers_for_pass` int DEFAULT NULL,
  PRIMARY KEY (`exam_id`),
  KEY `user_id` (`user_id`),
  KEY `result_type_id` (`result`),
  CONSTRAINT `user_exams_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_exams`
--

LOCK TABLES `user_exams` WRITE;
/*!40000 ALTER TABLE `user_exams` DISABLE KEYS */;
INSERT INTO `user_exams` VALUES (1,2,NULL,'2024-01-15 00:00:00','2024-01-15 00:00:00',85,1,'https://example.com/certificates/driver1_cert.pdf',NULL,NULL,NULL,NULL,NULL),(2,2,NULL,'2024-08-01 00:00:00','2024-08-01 00:00:00',9,1,'http://example.com/certificate/1',NULL,NULL,NULL,NULL,NULL),(83,4,'2024-08-28 09:51:11',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL),(84,5,'2024-08-28 09:51:16',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL),(85,3,'2024-08-28 10:02:59',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL),(86,6,'2024-08-28 10:02:59',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL),(87,5,'2024-08-28 10:03:06',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL),(88,2,'2024-09-03 21:37:44','2024-09-21 11:23:47','2024-09-21 11:23:50',0,0,NULL,15,1,0,15,7),(89,2,'0001-01-01 00:00:00','2024-09-23 18:46:30','2024-09-23 18:46:38',2,0,NULL,15,2,2,13,7),(90,2,'2024-09-27 19:31:21','0001-01-01 00:00:00','0001-01-01 00:00:00',0,0,NULL,0,0,0,0,0);
/*!40000 ALTER TABLE `user_exams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_profiles`
--

DROP TABLE IF EXISTS `user_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_profiles` (
  `profile_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `avatar` varchar(1024) DEFAULT '"',
  `address` varchar(255) DEFAULT '',
  `phone_number` varchar(20) NOT NULL DEFAULT '',
  `dob` datetime DEFAULT NULL,
  `license_number` varchar(255) DEFAULT NULL,
  `license_issue_date` datetime DEFAULT NULL,
  `license_expiry_date` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`profile_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_profiles`
--

LOCK TABLES `user_profiles` WRITE;
/*!40000 ALTER TABLE `user_profiles` DISABLE KEYS */;
INSERT INTO `user_profiles` VALUES (1,1,'Admin User','','1.jpg','123 Admin St.','123-456-7890',NULL,NULL,NULL,NULL,'2024-08-14 13:24:14','2024-09-20 00:29:03'),(2,2,'Driver One','Ramesh Viswam','rameshv-me-bg1.jpg','456 Driver Ave. 456 Driver Ave. 456 Driver Ave.456 Driver Ave.','234-567-8901','1985-05-09 00:00:00','D1234567','2016-07-09 00:00:00','2026-07-09 00:00:00','2024-08-14 13:24:14','2024-09-21 15:44:26'),(3,3,'Client One','','3.jpg','789 Client Rd.','345-678-9012',NULL,NULL,NULL,NULL,'2024-08-14 13:24:14','2024-09-20 00:29:03'),(4,5,'John Driver','Doe','4.jpg','123 Elm Street, Springfield, IL','555-1234','1985-05-15 00:00:00','D1234567','2015-06-20 00:00:00','2025-06-20 00:00:00','2024-08-28 04:30:36','2024-09-20 00:29:03'),(5,6,'Jane Driver','Smith','5.jpg','456 Oak Avenue, Metropolis, NY','555-5678','1990-09-25 00:00:00','S9876543','2016-07-15 00:00:00','2026-07-15 00:00:00','2024-08-28 04:30:36','2024-09-20 00:29:03'),(7,4,'XYZ Driver','ABC','3.jpg','789 Client Rd.','345-678-9012',NULL,NULL,NULL,NULL,'2024-09-03 15:35:23','2024-09-20 00:29:03'),(10,9,'s','d','IMG_20220219_150438_629.jpg','ads','123','2024-09-03 00:00:00','asdfss','2024-09-19 00:00:00','2024-09-23 00:00:00','2024-09-21 15:45:22','2024-09-21 15:46:49');
/*!40000 ALTER TABLE `user_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `user_role_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `role_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_role_id`),
  KEY `user_id` (`user_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES (1,1,1,'2024-07-27 13:32:54','2024-07-27 13:32:54'),(2,2,2,'2024-07-27 13:32:54','2024-07-27 13:32:54'),(3,3,2,'2024-07-27 13:32:54','2024-09-14 13:06:55'),(4,4,2,'2024-09-03 14:51:12','2024-09-03 14:51:12'),(5,5,2,'2024-09-03 14:51:12','2024-09-03 14:51:12'),(6,6,2,'2024-09-03 14:51:12','2024-09-03 14:51:12'),(9,9,2,'2024-09-21 15:45:22','2024-09-21 15:45:22');
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `is_approved` tinyint DEFAULT '0',
  `approved_rejected_by` int DEFAULT '-1',
  `approved_rejected_reason` varchar(255) DEFAULT NULL,
  `approved_rejected_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_locked` tinyint NOT NULL DEFAULT '0',
  `is_deleted` tinyint DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','admin','admin@example.com',1,-1,NULL,'2024-08-14 18:52:17',0,0,'2024-07-27 13:31:23','2024-09-10 15:53:52'),(2,'driver1','driver1','driver1@example.com',1,-1,NULL,'2024-08-14 18:52:17',0,0,'2024-07-27 13:31:23','2024-09-10 15:53:52'),(3,'driver6','driver6','client1@example.com',1,-1,NULL,'2024-08-14 18:52:17',0,0,'2024-07-27 13:31:23','2024-09-20 02:30:44'),(4,'driver3','hashed_password1','driver3@example12323455.com',1,0,'invalid ok','2024-09-20 03:13:58',1,0,'2024-07-27 13:32:02','2024-09-20 03:14:00'),(5,'driver2','hashed_password2','driver2@example.com',1,0,NULL,'2024-09-20 08:56:15',1,0,'2024-07-27 13:32:02','2024-09-20 08:56:18'),(6,'driver4','hashed_password3','driver3@example.com',0,-1,NULL,'2024-08-14 18:52:17',1,1,'2024-07-27 13:32:02','2024-09-10 15:53:52'),(9,'newUser','New1234','ddd@d',0,0,'','2024-09-27 19:32:27',0,0,'2024-09-21 15:45:22','2024-09-27 19:32:27');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-13 14:59:49
