-- MySQL dump 10.14  Distrib 5.5.60-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: conectpark
-- ------------------------------------------------------
-- Server version	5.5.60-MariaDB

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
-- Table structure for table `controledlist`
--

DROP TABLE IF EXISTS `controledlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `controledlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `limitsforplan`
--

DROP TABLE IF EXISTS `limitsforplan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `limitsforplan` (
  `id` int(11) NOT NULL,
  `description` varchar(200) NOT NULL,
  `credit` decimal(14,2) NOT NULL DEFAULT '0.00',
  `changedate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_erro_envio_park_service`
--

DROP TABLE IF EXISTS `log_erro_envio_park_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_erro_envio_park_service` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transactionId` int(11) NOT NULL,
  `attempts` smallint(6) NOT NULL,
  `errorCode` varchar(3) DEFAULT NULL,
  `errorMessage` varchar(8000) DEFAULT NULL,
  `lastUpdate` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `monthlypaymentlist`
--

DROP TABLE IF EXISTS `monthlypaymentlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monthlypaymentlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicleid` int(11) NOT NULL,
  `plate` varchar(10) NOT NULL,
  `tag` varchar(100) DEFAULT NULL,
  `includedDate` datetime DEFAULT NULL,
  `sendDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12835 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `readings`
--

DROP TABLE IF EXISTS `readings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `readings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rssi` int(11) NOT NULL,
  `issuer` int(11) NOT NULL DEFAULT '0',
  `tag` varchar(45) NOT NULL DEFAULT '0',
  `intime` datetime DEFAULT NULL,
  `outtime` datetime DEFAULT NULL,
  `lane` varchar(100) NOT NULL,
  `tampered` bit(1) DEFAULT b'0',
  `batteryout` bit(1) DEFAULT b'0',
  `validr96` bit(1) DEFAULT b'0',
  `antstrength` int(11) DEFAULT '0',
  `sendDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `traffic`
--

DROP TABLE IF EXISTS `traffic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `traffic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL,
  `time` datetime NOT NULL,
  `lane` varchar(100) NOT NULL,
  `laneDepth` tinyint(4) NOT NULL,
  `imageFolder` varchar(255) DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  `reason` varchar(256) DEFAULT NULL,
  `thirdPartyTicket` varchar(100) DEFAULT NULL,
  `transit` int(11) DEFAULT '0',
  `safemode` bit(1) DEFAULT NULL,
  `manualoperation` bit(1) DEFAULT NULL,
  `lanestate` int(11) DEFAULT '0',
  `lanestatetime` datetime DEFAULT NULL,
  `ocr` bit(1) DEFAULT b'0',
  `validr96` bit(1) DEFAULT b'0',
  `rssi` decimal(10,0) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ix_traffic1` (`vehicle`,`laneDepth`,`id`),
  KEY `fk_traffic_1` (`id`),
  KEY `ix_3rdpartyticket` (`thirdPartyTicket`),
  KEY `idx_traffic_lane_time_status` (`lane`,`time`,`status`),
  KEY `idx_traffic_status_lane` (`status`,`lane`),
  CONSTRAINT `fk_traffic_1` FOREIGN KEY (`vehicle`) REFERENCES `vehicle` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2095602 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `traffic_temp`
--

DROP TABLE IF EXISTS `traffic_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `traffic_temp` (
  `plate` varchar(10) DEFAULT NULL,
  `tag` varchar(100) DEFAULT NULL,
  `id` int(11) DEFAULT NULL,
  `vehicle` int(11) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `lane` varchar(100) DEFAULT NULL,
  `laneDepth` tinyint(4) DEFAULT NULL,
  `imageFolder` varchar(255) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `reason` varchar(256) DEFAULT NULL,
  `thirdPartyTicket` varchar(100) DEFAULT NULL,
  `transit` int(11) DEFAULT NULL,
  `safemode` bit(1) DEFAULT NULL,
  `manualoperation` bit(1) DEFAULT NULL,
  `lanestate` int(11) DEFAULT NULL,
  `lanestatetime` datetime DEFAULT NULL,
  `ocr` bit(1) DEFAULT NULL,
  `validr96` bit(1) DEFAULT NULL,
  `rssi` decimal(10,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transacoes`
--

DROP TABLE IF EXISTS `transacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transacoes` (
  `entrada` datetime DEFAULT NULL,
  `saida` datetime DEFAULT NULL,
  `valor` decimal(14,2) DEFAULT NULL,
  `placa` varchar(50) DEFAULT NULL,
  `laneEntrada` varchar(100) DEFAULT NULL,
  `laneSaida` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transacoes_consolidador_wps`
--

DROP TABLE IF EXISTS `transacoes_consolidador_wps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transacoes_consolidador_wps` (
  `entrada` datetime DEFAULT NULL,
  `saida` datetime DEFAULT NULL,
  `valor` decimal(14,2) DEFAULT NULL,
  `placa` varchar(50) DEFAULT NULL,
  `laneEntrada` varchar(100) DEFAULT NULL,
  `laneSaida` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle` int(11) NOT NULL,
  `time` datetime NOT NULL,
  `inTraffic` int(11) NOT NULL,
  `outTraffic` int(11) NOT NULL,
  `totalAmount` decimal(14,2) DEFAULT NULL,
  `discount` decimal(14,2) DEFAULT NULL,
  `discountReason` varchar(100) DEFAULT NULL,
  `stayTimeMinutes` int(11) DEFAULT NULL,
  `thirdPartyTicket` varchar(100) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `postTime` datetime DEFAULT NULL,
  `conectSysCode` varchar(45) DEFAULT NULL,
  `conectSysReturnCode` int(11) DEFAULT NULL,
  `conectSysReturnDesc` varchar(100) DEFAULT NULL,
  `lastFailedPostDate` datetime DEFAULT NULL,
  `lastFailedPostError` varchar(100) DEFAULT NULL,
  `lastFailedPostErrorType` int(11) DEFAULT NULL,
  `operation` varchar(10) DEFAULT 'M',
  PRIMARY KEY (`id`),
  KEY `fk_transaction_1` (`vehicle`),
  KEY `fk_transaction_2` (`inTraffic`),
  KEY `fk_transaction_3` (`outTraffic`),
  CONSTRAINT `fk_transaction_1` FOREIGN KEY (`vehicle`) REFERENCES `vehicle` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_transaction_2` FOREIGN KEY (`inTraffic`) REFERENCES `traffic` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_transaction_3` FOREIGN KEY (`outTraffic`) REFERENCES `traffic` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10300 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transactionerrorhistory`
--

DROP TABLE IF EXISTS `transactionerrorhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactionerrorhistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `error` varchar(100) NOT NULL,
  `errorType` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_transactionerrorhistory_1` (`id`),
  KEY `ix_transactiondate` (`transaction`,`date`),
  KEY `ix_date` (`date`),
  CONSTRAINT `fk_transactionerrorhistory_1` FOREIGN KEY (`transaction`) REFERENCES `transaction` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transit`
--

DROP TABLE IF EXISTS `transit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle` int(11) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL,
  `intime` datetime DEFAULT NULL,
  `outtime` datetime DEFAULT NULL,
  `lane` varchar(100) DEFAULT NULL,
  `laneDepth` int(11) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `error` varchar(500) DEFAULT NULL,
  `thirdpartyticket` varchar(100) DEFAULT NULL,
  `verify` tinyint(1) DEFAULT NULL,
  `verifyreason` int(11) DEFAULT '0',
  `safemode` bit(1) DEFAULT b'0',
  `manualoperation` bit(1) DEFAULT b'0',
  `batteryout` bit(1) NOT NULL,
  `tampered` bit(1) NOT NULL,
  `vehiclesnapshot` blob,
  `processcount` int(11) DEFAULT '0',
  `armactivated` datetime DEFAULT NULL,
  `gateclosed` datetime DEFAULT NULL,
  `ocr` bit(1) DEFAULT b'0',
  `validr96` bit(1) DEFAULT b'0',
  `rssii` decimal(10,0) DEFAULT '0',
  `rssie` decimal(10,0) DEFAULT '0',
  `antstrength` int(11) DEFAULT '0',
  `senddate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Traffic_Vehicle_idx` (`vehicle`),
  CONSTRAINT `FK_Traffic_Vehicle` FOREIGN KEY (`vehicle`) REFERENCES `vehicle` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=407480 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updatelog`
--

DROP TABLE IF EXISTS `updatelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updatelog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `itemcount` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_date` (`date`)
) ENGINE=InnoDB AUTO_INCREMENT=173352 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updatetagativahistory`
--

DROP TABLE IF EXISTS `updatetagativahistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updatetagativahistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data` datetime NOT NULL,
  `qtde` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updatetagshistory`
--

DROP TABLE IF EXISTS `updatetagshistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updatetagshistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dataatualizacao` datetime NOT NULL,
  `qtde` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(10) NOT NULL,
  `tag` varchar(100) DEFAULT NULL,
  `serialnumber` varchar(100) DEFAULT NULL,
  `status` smallint(6) NOT NULL,
  `updated` datetime DEFAULT NULL,
  `currentThirdPartyTicket` varchar(100) DEFAULT NULL,
  `openTrafficId` int(11) DEFAULT NULL,
  `MonthlyPayment` tinyint(1) DEFAULT '0',
  `currentHashData` varchar(512) DEFAULT NULL,
  `changeRate` int(11) DEFAULT NULL,
  `mastervehicle` int(11) DEFAULT NULL,
  `balance` decimal(14,2) NOT NULL,
  `issuer` varchar(200) NOT NULL,
  `paymentPlan` int(11) NOT NULL,
  `creditLimit` decimal(14,2) NOT NULL,
  `lastCharge` int(11) NOT NULL,
  `validationSensitiveData` char(40) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_vehicle_1` (`openTrafficId`),
  KEY `tag_unique` (`tag`,`status`,`id`),
  KEY `idx_plate` (`plate`),
  KEY `idx_vehicle_currentThirdPartyTicket` (`currentThirdPartyTicket`),
  KEY `idxx_vehicle_mastervehicle` (`mastervehicle`),
  KEY `idxx_vehicle_id_mastervehicle` (`id`,`mastervehicle`),
  CONSTRAINT `fk_vehicle_1` FOREIGN KEY (`openTrafficId`) REFERENCES `traffic` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1256415 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vehicle_temp`
--

DROP TABLE IF EXISTS `vehicle_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_temp` (
  `plate` varchar(10) DEFAULT NULL,
  `tag` varchar(100) DEFAULT NULL,
  `currentThirdPartyTicket` varchar(100) DEFAULT NULL,
  `openTrafficId` int(11) DEFAULT NULL,
  `MonthlyPayment` tinyint(1) DEFAULT NULL,
  `currentHashData` varchar(512) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-01-15 23:08:12
