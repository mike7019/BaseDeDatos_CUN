-- MySQL dump 10.13  Distrib 8.0.42, for Linux (x86_64)
--
-- Host: localhost    Database: biblioteca
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `detalle_prestamo`
--

DROP TABLE IF EXISTS `detalle_prestamo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_prestamo` (
  `id_prestamo` int NOT NULL,
  `id_libro` int NOT NULL,
  `cantidad` int DEFAULT NULL,
  PRIMARY KEY (`id_prestamo`,`id_libro`),
  KEY `id_libro` (`id_libro`),
  CONSTRAINT `detalle_prestamo_ibfk_1` FOREIGN KEY (`id_prestamo`) REFERENCES `prestamo` (`id_prestamo`) ON DELETE CASCADE,
  CONSTRAINT `detalle_prestamo_ibfk_2` FOREIGN KEY (`id_libro`) REFERENCES `libro` (`id_libro`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_prestamo`
--

LOCK TABLES `detalle_prestamo` WRITE;
/*!40000 ALTER TABLE `detalle_prestamo` DISABLE KEYS */;
INSERT INTO `detalle_prestamo` VALUES (1,1,1),(1,3,1),(2,2,1),(3,3,1),(3,5,1),(4,4,1);
/*!40000 ALTER TABLE `detalle_prestamo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `libro`
--

DROP TABLE IF EXISTS `libro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `libro` (
  `id_libro` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `autor` varchar(255) DEFAULT NULL,
  `editorial` varchar(255) DEFAULT NULL,
  `anio_publicacion` year DEFAULT NULL,
  `categoria` varchar(100) DEFAULT NULL,
  `stock` int NOT NULL,
  PRIMARY KEY (`id_libro`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `libro`
--

LOCK TABLES `libro` WRITE;
/*!40000 ALTER TABLE `libro` DISABLE KEYS */;
INSERT INTO `libro` VALUES (1,'Cien años de soledad','Gabriel García Márquez','Sudamericana',1967,'Novela',5),(2,'La Odisea','Homero','Clásicos Griegos',1998,'Épica',3),(3,'El Principito','Antoine de Saint-Exupéry','Salamandra',1943,'Fábula',10),(4,'1984','George Orwell','Secker & Warburg',1949,'Distopía',4),(5,'Clean Code','Robert C. Martin','Prentice Hall',2008,'Programación',2);
/*!40000 ALTER TABLE `libro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `multa`
--

DROP TABLE IF EXISTS `multa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `multa` (
  `id_multa` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT NULL,
  `monto` decimal(8,2) DEFAULT NULL,
  `motivo` varchar(255) DEFAULT NULL,
  `estado` enum('pendiente','pagada') DEFAULT NULL,
  PRIMARY KEY (`id_multa`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `multa_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `multa`
--

LOCK TABLES `multa` WRITE;
/*!40000 ALTER TABLE `multa` DISABLE KEYS */;
INSERT INTO `multa` VALUES (1,2,15000.00,'Devolución tardía','pendiente'),(2,1,5000.00,'Libro dañado','pagada');
/*!40000 ALTER TABLE `multa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prestamo`
--

DROP TABLE IF EXISTS `prestamo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prestamo` (
  `id_prestamo` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT NULL,
  `fecha_prestamo` date DEFAULT NULL,
  `fecha_devolucion` date DEFAULT NULL,
  `estado` enum('activo','devuelto','atrasado') DEFAULT NULL,
  PRIMARY KEY (`id_prestamo`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `prestamo_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prestamo`
--

LOCK TABLES `prestamo` WRITE;
/*!40000 ALTER TABLE `prestamo` DISABLE KEYS */;
INSERT INTO `prestamo` VALUES (1,1,'2025-04-28','2025-05-05','devuelto'),(2,2,'2025-04-18','2025-05-03','atrasado'),(3,3,'2025-05-06','2025-05-13','activo'),(4,1,'2025-04-08','2025-04-23','devuelto');
/*!40000 ALTER TABLE `prestamo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `tipo_usuario` enum('estudiante','profesor') DEFAULT NULL,
  `carrera_departamento` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Ana','Martínez','ana.martinez@example.com','3214567890','estudiante','Ingeniería de Sistemas'),(2,'Luis','Gómez','luis.gomez@example.com','3106543210','profesor','Matemáticas'),(3,'Sofía','Ríos','sofia.rios@example.com','3001234567','estudiante','Psicología'),(4,'Carlos','Pérez','carlos.perez@example.com','3157654321','profesor','Física');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vista_historial_prestamos`
--

DROP TABLE IF EXISTS `vista_historial_prestamos`;
/*!50001 DROP VIEW IF EXISTS `vista_historial_prestamos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_historial_prestamos` AS SELECT 
 1 AS `id_usuario`,
 1 AS `nombre_usuario`,
 1 AS `id_prestamo`,
 1 AS `fecha_prestamo`,
 1 AS `fecha_devolucion`,
 1 AS `estado`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_libros_disponibles`
--

DROP TABLE IF EXISTS `vista_libros_disponibles`;
/*!50001 DROP VIEW IF EXISTS `vista_libros_disponibles`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_libros_disponibles` AS SELECT 
 1 AS `id_libro`,
 1 AS `titulo`,
 1 AS `autor`,
 1 AS `editorial`,
 1 AS `anio_publicacion`,
 1 AS `categoria`,
 1 AS `stock`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_libros_mas_prestados`
--

DROP TABLE IF EXISTS `vista_libros_mas_prestados`;
/*!50001 DROP VIEW IF EXISTS `vista_libros_mas_prestados`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_libros_mas_prestados` AS SELECT 
 1 AS `id_libro`,
 1 AS `titulo`,
 1 AS `total_prestamos`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_multas_activas`
--

DROP TABLE IF EXISTS `vista_multas_activas`;
/*!50001 DROP VIEW IF EXISTS `vista_multas_activas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_multas_activas` AS SELECT 
 1 AS `id_multa`,
 1 AS `id_usuario`,
 1 AS `nombre_usuario`,
 1 AS `monto`,
 1 AS `motivo`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_usuarios_con_prestamos_vencidos`
--

DROP TABLE IF EXISTS `vista_usuarios_con_prestamos_vencidos`;
/*!50001 DROP VIEW IF EXISTS `vista_usuarios_con_prestamos_vencidos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_usuarios_con_prestamos_vencidos` AS SELECT 
 1 AS `id_usuario`,
 1 AS `nombre_usuario`,
 1 AS `id_prestamo`,
 1 AS `fecha_prestamo`,
 1 AS `fecha_devolucion`,
 1 AS `estado`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vista_historial_prestamos`
--

/*!50001 DROP VIEW IF EXISTS `vista_historial_prestamos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`user`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_historial_prestamos` AS select `u`.`id_usuario` AS `id_usuario`,concat(`u`.`nombre`,' ',`u`.`apellido`) AS `nombre_usuario`,`p`.`id_prestamo` AS `id_prestamo`,`p`.`fecha_prestamo` AS `fecha_prestamo`,`p`.`fecha_devolucion` AS `fecha_devolucion`,`p`.`estado` AS `estado` from (`usuario` `u` join `prestamo` `p` on((`u`.`id_usuario` = `p`.`id_usuario`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_libros_disponibles`
--

/*!50001 DROP VIEW IF EXISTS `vista_libros_disponibles`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`user`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_libros_disponibles` AS select `libro`.`id_libro` AS `id_libro`,`libro`.`titulo` AS `titulo`,`libro`.`autor` AS `autor`,`libro`.`editorial` AS `editorial`,`libro`.`anio_publicacion` AS `anio_publicacion`,`libro`.`categoria` AS `categoria`,`libro`.`stock` AS `stock` from `libro` where (`libro`.`stock` > 0) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_libros_mas_prestados`
--

/*!50001 DROP VIEW IF EXISTS `vista_libros_mas_prestados`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`user`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_libros_mas_prestados` AS select `l`.`id_libro` AS `id_libro`,`l`.`titulo` AS `titulo`,count(`dp`.`id_libro`) AS `total_prestamos` from (`detalle_prestamo` `dp` join `libro` `l` on((`dp`.`id_libro` = `l`.`id_libro`))) group by `l`.`id_libro`,`l`.`titulo` order by `total_prestamos` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_multas_activas`
--

/*!50001 DROP VIEW IF EXISTS `vista_multas_activas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`user`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_multas_activas` AS select `m`.`id_multa` AS `id_multa`,`u`.`id_usuario` AS `id_usuario`,concat(`u`.`nombre`,' ',`u`.`apellido`) AS `nombre_usuario`,`m`.`monto` AS `monto`,`m`.`motivo` AS `motivo` from (`multa` `m` join `usuario` `u` on((`m`.`id_usuario` = `u`.`id_usuario`))) where (`m`.`estado` = 'pendiente') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_usuarios_con_prestamos_vencidos`
--

/*!50001 DROP VIEW IF EXISTS `vista_usuarios_con_prestamos_vencidos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`user`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_usuarios_con_prestamos_vencidos` AS select `u`.`id_usuario` AS `id_usuario`,concat(`u`.`nombre`,' ',`u`.`apellido`) AS `nombre_usuario`,`p`.`id_prestamo` AS `id_prestamo`,`p`.`fecha_prestamo` AS `fecha_prestamo`,`p`.`fecha_devolucion` AS `fecha_devolucion`,`p`.`estado` AS `estado` from (`usuario` `u` join `prestamo` `p` on((`u`.`id_usuario` = `p`.`id_usuario`))) where (`p`.`estado` = 'atrasado') */;
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

-- Dump completed on 2025-05-08  4:40:45
