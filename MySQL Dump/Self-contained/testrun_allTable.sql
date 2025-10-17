-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: testrun
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `status` enum('ACTIVE','NON_ACTIVE') DEFAULT 'ACTIVE',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=1000011 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1000000,'Wong Kim Ching','kimching.admin@email.com','0129876300','$2b$10$mNamalA6Hx0mrUVtJtP9punjzsHvSXCnt8Q1/oKWCJtB6Cyd0yBpq','ACTIVE'),(1000010,'Alice','alice.admin.@email.com','0162543214','$2b$10$93WDMa.KaYlSbuEjhuk3feyBaJKSjVPm/TR1C9Kd4u6nXyYgnDh1.','ACTIVE');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bill`
--

DROP TABLE IF EXISTS `bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill` (
  `bill_id` int NOT NULL AUTO_INCREMENT,
  `description` text NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `case_id` int DEFAULT NULL,
  PRIMARY KEY (`bill_id`),
  KEY `case_id` (`case_id`),
  CONSTRAINT `bill_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `cases` (`case_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6000017 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill`
--

LOCK TABLES `bill` WRITE;
/*!40000 ALTER TABLE `bill` DISABLE KEYS */;
INSERT INTO `bill` VALUES (6000000,'Case1',60.00,4000000),(6000001,'I want to Clean my laptop, the heat is so high',0.00,4000001),(6000002,'Laptop Cleaning',0.00,4000002),(6000003,'OS install',80.00,4000003),(6000004,'Data Recovery',0.00,4000004),(6000005,'Virus',0.00,4000005),(6000006,'Clean Laptop',60.00,4000006),(6000007,'Data Backup',0.00,4000007),(6000008,'Data Recovery',0.00,4000008),(6000009,'Virus Removal',0.00,4000009),(6000010,'Window Installing',0.00,4000010),(6000011,'Laptop Diagnostic',0.00,4000011),(6000012,'Motherboard Repair',0.00,4000012),(6000013,'Fan Cleaning',60.00,4000013),(6000014,'Data Backup',120.00,4000014),(6000015,'Battery Replace',0.00,4000015),(6000016,'Repair Motherboard',400.00,4000016);
/*!40000 ALTER TABLE `bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `billitem`
--

DROP TABLE IF EXISTS `billitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billitem` (
  `bill_id` int NOT NULL,
  `item_id` int NOT NULL,
  PRIMARY KEY (`bill_id`,`item_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `billitem_ibfk_1` FOREIGN KEY (`bill_id`) REFERENCES `bill` (`bill_id`),
  CONSTRAINT `billitem_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billitem`
--

LOCK TABLES `billitem` WRITE;
/*!40000 ALTER TABLE `billitem` DISABLE KEYS */;
INSERT INTO `billitem` VALUES (6000000,5000000),(6000001,5000000),(6000002,5000000),(6000006,5000000),(6000003,5000001),(6000010,5000001),(6000004,5000002),(6000007,5000002),(6000008,5000002),(6000014,5000002),(6000005,5000003),(6000009,5000003),(6000012,5000006),(6000016,5000006),(6000015,5000007),(6000013,5000008),(6000011,5000009);
/*!40000 ALTER TABLE `billitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `casecomment`
--

DROP TABLE IF EXISTS `casecomment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `casecomment` (
  `comment_id` int NOT NULL AUTO_INCREMENT,
  `case_id` int NOT NULL,
  `user_id` int NOT NULL,
  `user_role` enum('admin','technician','customer') NOT NULL,
  `content` text NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`),
  KEY `case_id` (`case_id`),
  CONSTRAINT `casecomment_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `cases` (`case_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8000006 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `casecomment`
--

LOCK TABLES `casecomment` WRITE;
/*!40000 ALTER TABLE `casecomment` DISABLE KEYS */;
INSERT INTO `casecomment` VALUES (8000000,4000000,1000000,'admin','test','2025-09-26 10:08:24'),(8000001,4000000,2000000,'technician','test','2025-09-26 10:08:33'),(8000002,4000000,3000000,'customer','test','2025-09-26 10:08:41'),(8000003,4000012,2000005,'technician','Arrived customer side','2025-09-29 18:33:46'),(8000004,4000015,2000005,'technician','Arrived customer side','2025-09-29 18:51:09'),(8000005,4000015,3000000,'customer','Thank you!','2025-09-29 18:52:05');
/*!40000 ALTER TABLE `casecomment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cases`
--

DROP TABLE IF EXISTS `cases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cases` (
  `case_id` int NOT NULL AUTO_INCREMENT,
  `description` text NOT NULL,
  `type` enum('warranty','non-warranty') DEFAULT NULL,
  `status` enum('DRAFT','ASSIGNED','IN_PROGRESS','COMPLETE','CANCELED','PAID') NOT NULL,
  `draft_status` datetime DEFAULT NULL,
  `assigned_status` datetime DEFAULT NULL,
  `progress_status` datetime DEFAULT NULL,
  `complete_status` datetime DEFAULT NULL,
  `canceled_status` datetime DEFAULT NULL,
  `paid_status` datetime DEFAULT NULL,
  `priority` enum('LOW','MEDIUM','HIGH','CRITICAL') DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `admin_id` int DEFAULT NULL,
  PRIMARY KEY (`case_id`),
  KEY `customer_id` (`customer_id`),
  KEY `admin_id` (`admin_id`),
  CONSTRAINT `cases_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`user_id`),
  CONSTRAINT `cases_ibfk_2` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4000017 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cases`
--

LOCK TABLES `cases` WRITE;
/*!40000 ALTER TABLE `cases` DISABLE KEYS */;
INSERT INTO `cases` VALUES (4000000,'Case1','non-warranty','PAID','2025-09-26 10:06:41','2025-09-26 10:07:32','2025-09-26 10:08:02','2025-09-26 10:09:46',NULL,'2025-09-26 10:10:12','MEDIUM',3000000,1000000),(4000001,'I want to Clean my laptop, the heat is so high','warranty','CANCELED','2025-09-29 17:02:46',NULL,NULL,NULL,'2025-09-29 17:04:09',NULL,NULL,3000000,NULL),(4000002,'Laptop Cleaning','warranty','DRAFT','2025-09-29 17:04:37',NULL,NULL,NULL,NULL,NULL,NULL,3000000,NULL),(4000003,'OS install','non-warranty','ASSIGNED','2025-09-29 17:10:14','2025-09-29 18:48:40',NULL,NULL,NULL,NULL,'MEDIUM',3000000,1000000),(4000004,'Data Recovery','warranty','DRAFT','2025-09-29 17:10:31',NULL,NULL,NULL,NULL,NULL,NULL,3000000,NULL),(4000005,'Virus','warranty','DRAFT','2025-09-29 17:10:46',NULL,NULL,NULL,NULL,NULL,NULL,3000000,NULL),(4000006,'Clean Laptop','non-warranty','DRAFT','2025-09-29 17:11:26',NULL,NULL,NULL,NULL,NULL,NULL,3000002,NULL),(4000007,'Data Backup','warranty','DRAFT','2025-09-29 17:31:06',NULL,NULL,NULL,NULL,NULL,NULL,3000002,NULL),(4000008,'Data Recovery','warranty','DRAFT','2025-09-29 17:31:17',NULL,NULL,NULL,NULL,NULL,NULL,3000002,NULL),(4000009,'Virus Removal','warranty','ASSIGNED','2025-09-29 17:31:23','2025-09-29 18:31:05',NULL,NULL,NULL,NULL,'MEDIUM',3000002,1000000),(4000010,'Window Installing','warranty','ASSIGNED','2025-09-29 17:31:37','2025-09-29 18:22:20',NULL,NULL,NULL,NULL,'MEDIUM',3000002,1000000),(4000011,'Laptop Diagnostic','warranty','DRAFT','2025-09-29 17:35:01',NULL,NULL,NULL,NULL,NULL,NULL,3000002,NULL),(4000012,'Motherboard Repair','warranty','PAID','2025-09-29 17:35:13','2025-09-29 18:29:39','2025-09-29 18:32:58','2025-09-29 18:48:23',NULL,'2025-09-29 18:48:23','MEDIUM',3000002,1000000),(4000013,'Fan Cleaning','non-warranty','DRAFT','2025-09-29 18:42:41',NULL,NULL,NULL,NULL,NULL,NULL,3000019,NULL),(4000014,'Data Backup','non-warranty','ASSIGNED','2025-09-29 18:47:07','2025-09-29 18:47:48',NULL,NULL,NULL,NULL,'MEDIUM',3000000,1000000),(4000015,'Battery Replace','warranty','PAID','2025-09-29 18:49:31','2025-09-29 18:50:14','2025-09-29 18:50:41','2025-09-29 18:53:24',NULL,'2025-09-29 18:53:24','MEDIUM',3000000,1000000),(4000016,'Repair Motherboard','non-warranty','PAID','2025-09-29 18:54:03','2025-09-29 18:54:15','2025-09-29 18:54:21','2025-09-29 18:54:42',NULL,'2025-09-29 19:03:18','MEDIUM',3000000,1000000);
/*!40000 ALTER TABLE `cases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company` (
  `company_id` int NOT NULL AUTO_INCREMENT,
  `company_name` varchar(100) NOT NULL,
  `company_location` varchar(100) NOT NULL,
  `company_ssn` varchar(100) NOT NULL,
  PRIMARY KEY (`company_id`),
  UNIQUE KEY `company_ssn` (`company_ssn`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES (1,'WKY','A15, Lorong Bukit Setongkol Perdana 1, Kampung Tanah Putih Darat Makbar, 25200 Kuantan','200403151802');
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=3000020 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (3000000,'Lee Xiao Bai','cust1@email.com','01234567890','$2b$10$RnOjPCJS2o5j63TwU8Qf2OjdOPUXAxa1/WcM9rHAvq9lUo5sXnVdK','No. 23, Jalan Indera Mahkota 8, Indera Mahkota, 25200 Kuantan, Pahang','Pahang'),(3000002,'Lee D Bai','cust2@email.com','01234567891','$2b$10$s4J95/jwi7z0nlBJJfzue../P5ZzBKrkGh0u6MqoOxnNDra3H1x2q','No. 31, Jalan Bukit Sekilau, Taman Bukit Sekilau, 25200 Kuantan, Pahang','Pahang'),(3000019,'Lee Zhong Bai','zhongbai@email.com','0185632545','$2b$10$Ztad3/DLB83yTbGMFg.OMe/u5FcgJk/PKIFFKhUdw9n9t7ILV9YRO','No. 52, Jalan Batu, Taman Batu, 25200 Kuantan, Pahang','Pahang');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `item_name` varchar(255) NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `item_name` (`item_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5000013 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (5000000,'Laptop Cleaning Service',60.00),(5000001,'Operating System Installation',80.00),(5000002,'Data Backup & Recovery',120.00),(5000003,'Virus & Malware Removal',70.00),(5000006,'Motherboard Repair',400.00),(5000007,'Battery Replacement',180.00),(5000008,'Fan Cleaning Service',60.00),(5000009,'Laptop Diagnostic Service',50.00);
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `description` text NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` enum('PENDING','COMPLETE','FAILED','REFUNDED') DEFAULT NULL,
  `pending_status` datetime DEFAULT NULL,
  `complete_status` datetime DEFAULT NULL,
  `failed_status` datetime DEFAULT NULL,
  `refunded_status` datetime DEFAULT NULL,
  `transaction_date` datetime DEFAULT NULL,
  `bill_id` int DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `bill_id` (`bill_id`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`bill_id`) REFERENCES `bill` (`bill_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7000004 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (7000000,'Case1',60.00,'COMPLETE',NULL,'2025-09-26 10:10:12',NULL,NULL,'2025-09-26 10:10:12',6000000),(7000001,'Motherboard Repair -warranty',0.00,'COMPLETE',NULL,'2025-09-29 18:48:23',NULL,NULL,'2025-09-29 18:48:23',6000012),(7000002,'Battery Replace -warranty',0.00,'COMPLETE',NULL,'2025-09-29 18:53:24',NULL,NULL,'2025-09-29 18:53:24',6000015),(7000003,'Repair Motherboard',400.00,'COMPLETE',NULL,'2025-09-29 19:03:18',NULL,NULL,'2025-09-29 19:03:18',6000016);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skill`
--

DROP TABLE IF EXISTS `skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skill` (
  `technician_id` int NOT NULL,
  `item_id` int NOT NULL,
  PRIMARY KEY (`technician_id`,`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skill`
--

LOCK TABLES `skill` WRITE;
/*!40000 ALTER TABLE `skill` DISABLE KEYS */;
INSERT INTO `skill` VALUES (2000000,5000000),(2000000,5000001),(2000001,5000003),(2000001,5000007),(2000005,5000000),(2000005,5000002),(2000005,5000006),(2000005,5000007);
/*!40000 ALTER TABLE `skill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `technician`
--

DROP TABLE IF EXISTS `technician`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `technician` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `last_location` varchar(100) DEFAULT NULL,
  `status` enum('ON_DUTY','TAKE_BREAK','OFF_DUTY','NON_ACTIVE') NOT NULL DEFAULT 'OFF_DUTY',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=2000006 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `technician`
--

LOCK TABLES `technician` WRITE;
/*!40000 ALTER TABLE `technician` DISABLE KEYS */;
INSERT INTO `technician` VALUES (2000000,'Wong Yu Cheng','tech1@email.com','0129233028','$2b$10$9C8QhwE2.CefUci8J/oHFOtd/FMa1qzrVUvnuP9pbUgyvM8VE1Zva',NULL,'ON_DUTY'),(2000001,'Chiew Jin Xiong','tech2@email.com','0172142227','$2b$10$ClmyHmzQ8p/w1ZHwfseUC.fsMDktrHcVtV7X/Tl2sxvJb7e7d.Swa',NULL,'ON_DUTY'),(2000002,'Wong Yi Suen','tech3@email.com','0163279526','$2b$10$J6O//oo0YTUJ1RaAZL/rEuGUnaiIvHCIU9g0YjD7hrWROUXrTZry6',NULL,'OFF_DUTY'),(2000005,'John','john.tech@email.com','0123546258','$2b$10$7ILpmYyXsL3EzirBhXRuwe.1xUNPjeL6sPAHErRjm.TDJpwQ8HiaK',NULL,'ON_DUTY');
/*!40000 ALTER TABLE `technician` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `technician_case`
--

DROP TABLE IF EXISTS `technician_case`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `technician_case` (
  `technician_id` int NOT NULL,
  `case_id` int NOT NULL,
  PRIMARY KEY (`technician_id`,`case_id`),
  KEY `case_id` (`case_id`),
  CONSTRAINT `technician_case_ibfk_1` FOREIGN KEY (`technician_id`) REFERENCES `technician` (`user_id`),
  CONSTRAINT `technician_case_ibfk_2` FOREIGN KEY (`case_id`) REFERENCES `cases` (`case_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `technician_case`
--

LOCK TABLES `technician_case` WRITE;
/*!40000 ALTER TABLE `technician_case` DISABLE KEYS */;
INSERT INTO `technician_case` VALUES (2000000,4000000),(2000000,4000003),(2000001,4000009),(2000000,4000010),(2000005,4000012),(2000005,4000014),(2000005,4000015),(2000005,4000016);
/*!40000 ALTER TABLE `technician_case` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_case_search`
--

DROP TABLE IF EXISTS `vw_case_search`;
/*!50001 DROP VIEW IF EXISTS `vw_case_search`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_case_search` AS SELECT 
 1 AS `case_id`,
 1 AS `description`,
 1 AS `type`,
 1 AS `status`,
 1 AS `priority`,
 1 AS `draft_status`,
 1 AS `assigned_status`,
 1 AS `progress_status`,
 1 AS `complete_status`,
 1 AS `canceled_status`,
 1 AS `paid_status`,
 1 AS `customer_id`,
 1 AS `customer_name`,
 1 AS `admin_id`,
 1 AS `admin_name`,
 1 AS `admin_email`,
 1 AS `bill_id`,
 1 AS `bill_amount`,
 1 AS `item_id`,
 1 AS `item_name`,
 1 AS `technicians`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_case_search`
--

/*!50001 DROP VIEW IF EXISTS `vw_case_search`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_case_search` AS select `c`.`case_id` AS `case_id`,`c`.`description` AS `description`,`c`.`type` AS `type`,`c`.`status` AS `status`,`c`.`priority` AS `priority`,`c`.`draft_status` AS `draft_status`,`c`.`assigned_status` AS `assigned_status`,`c`.`progress_status` AS `progress_status`,`c`.`complete_status` AS `complete_status`,`c`.`canceled_status` AS `canceled_status`,`c`.`paid_status` AS `paid_status`,`c`.`customer_id` AS `customer_id`,`cu`.`name` AS `customer_name`,`c`.`admin_id` AS `admin_id`,`a`.`name` AS `admin_name`,`a`.`email` AS `admin_email`,`b`.`bill_id` AS `bill_id`,`b`.`amount` AS `bill_amount`,`bi`.`item_id` AS `item_id`,`i`.`item_name` AS `item_name`,group_concat(distinct `t`.`name` order by `t`.`name` ASC separator ', ') AS `technicians` from (((((((`cases` `c` left join `customer` `cu` on((`cu`.`user_id` = `c`.`customer_id`))) left join `admin` `a` on((`a`.`user_id` = `c`.`admin_id`))) left join `bill` `b` on((`b`.`case_id` = `c`.`case_id`))) left join `billitem` `bi` on((`bi`.`bill_id` = `b`.`bill_id`))) left join `item` `i` on((`i`.`item_id` = `bi`.`item_id`))) left join `technician_case` `tc` on((`tc`.`case_id` = `c`.`case_id`))) left join `technician` `t` on((`t`.`user_id` = `tc`.`technician_id`))) group by `c`.`case_id`,`c`.`description`,`c`.`type`,`c`.`status`,`c`.`priority`,`c`.`draft_status`,`c`.`assigned_status`,`c`.`progress_status`,`c`.`complete_status`,`c`.`canceled_status`,`c`.`paid_status`,`c`.`customer_id`,`cu`.`name`,`c`.`admin_id`,`a`.`name`,`a`.`email`,`b`.`bill_id`,`b`.`amount`,`bi`.`item_id`,`i`.`item_name` */;
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

-- Dump completed on 2025-10-17 17:14:10
