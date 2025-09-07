CREATE DATABASE  IF NOT EXISTS `monthly-budget-app` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `monthly-budget-app`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: monthly-budget-app
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
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('income','expense') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_categories_user_id` (`user_id`),
  KEY `idx_categories_user_type` (`user_id`,`type`),
  CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,1,'Sueldo','income','2025-08-12 21:01:26'),(2,1,'Trabajo extra','income','2025-08-12 21:01:26'),(3,1,'Alquiler','expense','2025-08-12 21:01:26'),(4,1,'Comida','expense','2025-08-12 21:01:26'),(5,2,'Sueldo','income','2025-08-12 21:01:26'),(6,2,'Servicios','expense','2025-08-12 21:01:26');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `monthly_budgets`
--

DROP TABLE IF EXISTS `monthly_budgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `monthly_budgets` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `category_id` int unsigned NOT NULL,
  `budget_month` date NOT NULL,
  `budget_amount` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_budget` (`user_id`,`category_id`,`budget_month`),
  KEY `idx_budgets_user_month` (`user_id`,`budget_month`),
  KEY `idx_budgets_category_month` (`category_id`,`budget_month`),
  CONSTRAINT `monthly_budgets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `monthly_budgets_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `monthly_budgets`
--

LOCK TABLES `monthly_budgets` WRITE;
/*!40000 ALTER TABLE `monthly_budgets` DISABLE KEYS */;
INSERT INTO `monthly_budgets` VALUES (1,1,3,'2025-08-01',500.00,'2025-08-12 21:01:26'),(2,1,4,'2025-08-01',200.00,'2025-08-12 21:01:26'),(3,2,6,'2025-08-01',150.00,'2025-08-12 21:01:26');
/*!40000 ALTER TABLE `monthly_budgets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `category_id` int unsigned NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_transactions_user_date` (`user_id`,`transaction_date`),
  KEY `idx_transactions_category_date` (`category_id`,`transaction_date`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,1,1,1500.00,'Pago mensual empresa','2025-08-01','2025-08-12 21:01:26'),(2,1,2,200.00,'Proyecto freelance','2025-08-05','2025-08-12 21:01:26'),(3,1,3,500.00,'Renta departamento','2025-08-02','2025-08-12 21:01:26'),(4,1,4,150.00,'Supermercado','2025-08-03','2025-08-12 21:01:26'),(5,2,5,1800.00,'Sueldo oficina','2025-08-01','2025-08-12 21:01:26'),(6,2,6,100.00,'Cuenta de luz','2025-08-04','2025-08-12 21:01:26');
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions_log`
--

DROP TABLE IF EXISTS `transactions_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transaction_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `action_type` enum('INSERT','UPDATE','DELETE') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `old_amount` decimal(10,2) DEFAULT NULL,
  `new_amount` decimal(10,2) DEFAULT NULL,
  `action_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions_log`
--

LOCK TABLES `transactions_log` WRITE;
/*!40000 ALTER TABLE `transactions_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactions_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_users_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Juan Pérez','juan@example.com','hash_password_1','2025-08-12 21:01:26'),(2,'María López','maria@example.com','hash_password_2','2025-08-12 21:01:26');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `view_budget_vs_spent`
--

DROP TABLE IF EXISTS `view_budget_vs_spent`;
/*!50001 DROP VIEW IF EXISTS `view_budget_vs_spent`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_budget_vs_spent` AS SELECT 
 1 AS `budget_id`,
 1 AS `user_id`,
 1 AS `user_name`,
 1 AS `category_id`,
 1 AS `category_name`,
 1 AS `budget_month`,
 1 AS `budget_amount`,
 1 AS `total_spent`,
 1 AS `remaining`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_expenses_by_category`
--

DROP TABLE IF EXISTS `view_expenses_by_category`;
/*!50001 DROP VIEW IF EXISTS `view_expenses_by_category`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_expenses_by_category` AS SELECT 
 1 AS `user_id`,
 1 AS `user_name`,
 1 AS `category_id`,
 1 AS `category_name`,
 1 AS `year`,
 1 AS `month`,
 1 AS `total_spent`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_latest_transactions`
--

DROP TABLE IF EXISTS `view_latest_transactions`;
/*!50001 DROP VIEW IF EXISTS `view_latest_transactions`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_latest_transactions` AS SELECT 
 1 AS `transaction_id`,
 1 AS `user_name`,
 1 AS `category_name`,
 1 AS `type`,
 1 AS `amount`,
 1 AS `description`,
 1 AS `transaction_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_monthly_balance`
--

DROP TABLE IF EXISTS `view_monthly_balance`;
/*!50001 DROP VIEW IF EXISTS `view_monthly_balance`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_monthly_balance` AS SELECT 
 1 AS `user_id`,
 1 AS `user_name`,
 1 AS `year`,
 1 AS `month`,
 1 AS `total_income`,
 1 AS `total_expense`,
 1 AS `balance`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'monthly-budget-app'
--

--
-- Dumping routines for database 'monthly-budget-app'
--
/*!50003 DROP FUNCTION IF EXISTS `get_budget_for_category` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_budget_for_category`(p_user_id INT, p_category_id INT, p_month DATE) RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN
    DECLARE v_budget DECIMAL(10,2);

    SELECT IFNULL(budget_amount,0)
    INTO v_budget
    FROM monthly_budgets
    WHERE user_id = p_user_id
      AND category_id = p_category_id
      AND DATE_FORMAT(budget_month, '%Y-%m') = DATE_FORMAT(p_month, '%Y-%m');

    RETURN v_budget;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_monthly_balance` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_monthly_balance`(p_user_id INT, p_month DATE) RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN
    DECLARE v_income DECIMAL(10,2);
    DECLARE v_expense DECIMAL(10,2);

    SELECT IFNULL(SUM(t.amount),0)
    INTO v_income
    FROM transactions t
    JOIN categories c ON t.category_id = c.id
    WHERE t.user_id = p_user_id
      AND c.type = 'income'
      AND DATE_FORMAT(t.transaction_date, '%Y-%m') = DATE_FORMAT(p_month, '%Y-%m');

    SELECT IFNULL(SUM(t.amount),0)
    INTO v_expense
    FROM transactions t
    JOIN categories c ON t.category_id = c.id
    WHERE t.user_id = p_user_id
      AND c.type = 'expense'
      AND DATE_FORMAT(t.transaction_date, '%Y-%m') = DATE_FORMAT(p_month, '%Y-%m');

    RETURN v_income - v_expense;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `view_budget_vs_spent`
--

/*!50001 DROP VIEW IF EXISTS `view_budget_vs_spent`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_budget_vs_spent` AS select `mb`.`id` AS `budget_id`,`u`.`id` AS `user_id`,`u`.`name` AS `user_name`,`c`.`id` AS `category_id`,`c`.`name` AS `category_name`,`mb`.`budget_month` AS `budget_month`,`mb`.`budget_amount` AS `budget_amount`,coalesce(sum(`t`.`amount`),0) AS `total_spent`,(`mb`.`budget_amount` - coalesce(sum(`t`.`amount`),0)) AS `remaining` from (((`monthly_budgets` `mb` join `categories` `c` on((`mb`.`category_id` = `c`.`id`))) join `users` `u` on((`mb`.`user_id` = `u`.`id`))) left join `transactions` `t` on(((`t`.`user_id` = `mb`.`user_id`) and (`t`.`category_id` = `mb`.`category_id`) and (date_format(`t`.`transaction_date`,'%Y-%m') = date_format(`mb`.`budget_month`,'%Y-%m'))))) group by `mb`.`id`,`u`.`id`,`u`.`name`,`c`.`id`,`c`.`name`,`mb`.`budget_month`,`mb`.`budget_amount` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_expenses_by_category`
--

/*!50001 DROP VIEW IF EXISTS `view_expenses_by_category`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_expenses_by_category` AS select `u`.`id` AS `user_id`,`u`.`name` AS `user_name`,`c`.`id` AS `category_id`,`c`.`name` AS `category_name`,year(`t`.`transaction_date`) AS `year`,month(`t`.`transaction_date`) AS `month`,sum(`t`.`amount`) AS `total_spent` from ((`transactions` `t` join `categories` `c` on((`t`.`category_id` = `c`.`id`))) join `users` `u` on((`t`.`user_id` = `u`.`id`))) where (`c`.`type` = 'expense') group by `u`.`id`,`u`.`name`,`c`.`id`,`c`.`name`,year(`t`.`transaction_date`),month(`t`.`transaction_date`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_latest_transactions`
--

/*!50001 DROP VIEW IF EXISTS `view_latest_transactions`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_latest_transactions` AS select `t`.`id` AS `transaction_id`,`u`.`name` AS `user_name`,`c`.`name` AS `category_name`,`c`.`type` AS `type`,`t`.`amount` AS `amount`,`t`.`description` AS `description`,`t`.`transaction_date` AS `transaction_date` from ((`transactions` `t` join `categories` `c` on((`t`.`category_id` = `c`.`id`))) join `users` `u` on((`t`.`user_id` = `u`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_monthly_balance`
--

/*!50001 DROP VIEW IF EXISTS `view_monthly_balance`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_monthly_balance` AS select `u`.`id` AS `user_id`,`u`.`name` AS `user_name`,year(`t`.`transaction_date`) AS `year`,month(`t`.`transaction_date`) AS `month`,sum((case when (`c`.`type` = 'income') then `t`.`amount` else 0 end)) AS `total_income`,sum((case when (`c`.`type` = 'expense') then `t`.`amount` else 0 end)) AS `total_expense`,(sum((case when (`c`.`type` = 'income') then `t`.`amount` else 0 end)) - sum((case when (`c`.`type` = 'expense') then `t`.`amount` else 0 end))) AS `balance` from ((`transactions` `t` join `categories` `c` on((`t`.`category_id` = `c`.`id`))) join `users` `u` on((`t`.`user_id` = `u`.`id`))) group by `u`.`id`,`u`.`name`,year(`t`.`transaction_date`),month(`t`.`transaction_date`) */;
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

-- Dump completed on 2025-09-07 22:32:05
