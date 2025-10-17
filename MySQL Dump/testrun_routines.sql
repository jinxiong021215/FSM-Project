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

-- Dump completed on 2025-10-17 17:12:01
