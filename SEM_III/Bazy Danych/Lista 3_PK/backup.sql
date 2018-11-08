-- MySQL dump 10.16  Distrib 10.1.26-MariaDB, for Win32 (AMD64)
--
-- Host: localhost    Database: lista3
-- ------------------------------------------------------
-- Server version	10.1.26-MariaDB

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
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `id_zmiany` int(11) NOT NULL AUTO_INCREMENT,
  `PESEL` char(11) COLLATE utf8_polish_ci NOT NULL,
  `data_zmiany` date NOT NULL,
  `stara_wartosc` int(11) NOT NULL,
  `nowa_wartosc` int(11) NOT NULL,
  PRIMARY KEY (`id_zmiany`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES (1,'03062799827','2017-12-05',3203,3400),(2,'99010175396','2017-12-05',321000,328000);
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ludzie`
--

DROP TABLE IF EXISTS `ludzie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ludzie` (
  `PESEL` char(11) COLLATE utf8_polish_ci NOT NULL,
  `imie` varchar(30) COLLATE utf8_polish_ci NOT NULL,
  `nazwisko` varchar(30) COLLATE utf8_polish_ci NOT NULL,
  `data_urodzenia` date NOT NULL,
  `wzrost` float unsigned NOT NULL,
  `waga` float unsigned NOT NULL,
  `rozmiar_buta` int(10) unsigned NOT NULL,
  PRIMARY KEY (`PESEL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ludzie`
--

LOCK TABLES `ludzie` WRITE;
/*!40000 ALTER TABLE `ludzie` DISABLE KEYS */;
INSERT INTO `ludzie` VALUES ('03062799827','Elżbieta','Listek','1903-06-27',171,71,45),('09070721539','Zenon','Listek','1909-07-07',202,74,46),('11030986748','Aleksandra','Milczak','1911-03-09',180,117,42),('19062547539','Dawid','Drewno','1919-06-25',191,55,36),('23072912982','Dawid','Lewandowski','1923-07-29',177,78,37),('24102547619','Zenon','Dąb','1924-10-25',156,67,37),('25110927307','Adam','Listek','1925-11-09',146,122,38),('31101057570','Edward','Kot','1931-10-10',149,96,40),('33112627034','Aleksandra','Piotrowski','1933-11-26',178,109,37),('34111612382','Piotr','Listek','1934-11-16',169,82,43),('36033150867','Adam','Dąb','1936-03-31',147,81,40),('37071858248','Dawid','Lewandowski','1937-07-18',141,69,45),('39060865991','Aleksandra','Tapeta','1939-06-08',136,54,36),('40102729165','Elżbieta','Bubr','1940-10-27',153,106,45),('42021992760','Zenon','Ekran','1942-02-19',173,50,40),('42102478165','Dawid','Drewno','1942-10-24',185,106,43),('54020684350','Piotr','Ekran','1954-02-06',196,108,40),('54040972944','Dawid','Mysz','1954-04-09',174,119,46),('55111755692','Zenon','Drewno','1955-11-17',137,108,42),('56091584008','Aleksandra','Ekran','1956-09-15',195,83,44),('56122500017','Antoni','Ernest','1956-12-25',184,94,45),('57070569800','Piotr','Lewandowski','1957-07-05',185,50,46),('58120129521','Elżbieta','Ekran','1958-12-01',146,83,42),('59031953298','Piotr','Bubr','1959-03-19',201,103,46),('60020529419','Franciszek','Tapeta','1960-02-05',196,123,40),('60041578663','Zenon','Dąb','1960-04-15',142,85,45),('60050788597','Kamil','Lewandowski','1960-05-07',140,63,41),('60062398399','Piotr','Dąb','1960-06-23',161,77,42),('60092119996','Piotr','Mysz','1960-09-21',179,66,38),('60110356311','Piotr','Kot','1960-11-03',193,90,39),('61010525169','Zenon','Lewandowski','1961-01-05',183,123,45),('61031394206','Adam','Mysz','1961-03-13',153,94,37),('61071114231','Edward','Drewno','1961-07-11',162,62,42),('62040421524','Edward','Dąb','1962-04-04',135,120,41),('62070712033','Ewa','Lewandowski','1962-07-07',200,55,43),('62090261179','Ewa','Dąb','1962-09-02',159,94,45),('63032526772','Ewa','Ekran','1963-03-25',150,114,41),('63090489626','Elżbieta','Milczak','1963-09-04',208,108,46),('63111730404','Dawid','Dąb','1963-11-17',144,81,42),('64020491185','Elżbieta','Drewno','1964-02-04',133,74,41),('64020532244','Kamil','Ekran','1964-02-05',195,84,45),('64050930326','Dawid','Listek','1964-05-09',164,63,42),('64062390362','Elżbieta','Mysz','1964-06-23',180,70,41),('65032256344','Elżbieta','Dąb','1965-03-22',184,63,45),('66040976435','Aleksandra','Mysz','1966-04-09',163,58,39),('66122929180','Piotr','Bubr','1966-12-29',132,67,36),('68081341290','Elżbieta','Tapeta','1968-08-13',132,64,45),('68090463951','Olga','Lewandowski','1968-09-04',199,111,41),('68111880223','Elżbieta','Kot','1968-11-18',182,110,36),('68111966858','Piotr','Bubr','1968-11-19',174,54,43),('69062451100','Ewa','Kot','1969-06-24',143,91,38),('69101010680','Olga','Kot','1969-10-10',137,55,37),('70042762121','Elżbieta','Lewandowski','1970-04-27',180,92,45),('70072386218','Adam','Milczak','1970-07-23',188,96,46),('71050195738','Kamil','Milczak','1971-05-01',185,66,46),('72021989993','Ewa','Dąb','1972-02-19',170,66,42),('72111482938','Elżbieta','Dąb','1972-11-14',131,102,40),('73052539597','Zenon','Kot','1973-05-25',173,92,38),('74021737560','Adam','Mysz','1974-02-17',158,114,38),('74051913567','Aleksandra','Milczak','1974-05-19',184,74,42),('74082523115','Dawid','Milczak','1974-08-25',175,113,41),('75112437638','Piotr','Dąb','1975-11-24',207,89,44),('75122670084','Aleksandra','Listek','1975-12-26',137,83,46),('76022597194','Zenon','Mysz','1976-02-25',167,97,44),('76051925169','Zenon','Drewno','1976-05-19',140,119,38),('76090374055','Piotr','Milczak','1976-09-03',155,73,42),('78021151253','Aleksandra','Listek','1978-02-11',209,113,38),('79011628753','Zenon','Drewno','1979-01-16',144,57,46),('79032537995','Aleksandra','Dąb','1979-03-25',183,123,45),('79090983403','Zenon','Dąb','1979-09-09',206,90,45),('79121212120','Marcin','Mistrz','1979-12-12',188,90,46),('80091163156','Dawid','Ekran','1980-09-11',197,93,39),('81032163711','Adam','Lewandowski','1981-03-21',131,108,45),('81032922697','Olga','Milczak','1981-03-29',186,69,38),('81072637564','Elżbieta','Tapeta','1981-07-26',205,114,41),('82041978861','Olga','Dąb','1982-04-19',170,57,46),('82070616928','Dawid','Drewno','1982-07-06',196,76,39),('82091971472','Kamil','Bubr','1982-09-19',139,123,42),('83022559558','Aleksandra','Dąb','1983-02-25',204,65,38),('83122195239','Adam','Drewno','1983-12-21',174,53,42),('85041483628','Dawid','Lewandowski','1985-04-14',164,89,40),('85071693413','Kamil','Mysz','1985-07-16',155,94,36),('85091535957','Zenon','Ekran','1985-09-15',165,86,37),('86010791759','Aleksandra','Milczak','1986-01-07',172,79,40),('86013177038','Adam','Dąb','1986-01-31',205,72,43),('86022843495','Elżbieta','Bubr','1986-02-28',190,50,44),('86032360469','Edward','Kot','1986-03-23',176,106,46),('86070123681','Edward','Tapeta','1986-07-01',159,117,40),('86090783713','Olga','Drewno','1986-09-07',168,94,42),('86101996193','Adam','Piotrowski','1986-10-19',185,73,41),('87012872038','Ewa','Drewno','1987-01-28',178,62,36),('87033099885','Aleksandra','Milczak','1987-03-30',190,102,38),('87052381497','Elżbieta','Dąb','1987-05-23',141,68,44),('87070465985','Olga','Tapeta','1987-07-04',178,53,40),('87091412587','Olga','Bubr','1987-09-14',207,64,36),('87100570865','Adam','Kot','1987-10-05',162,102,38),('88012334804','Adam','Ekran','1988-01-23',203,124,38),('88021395360','Dawid','Tapeta','1988-02-13',190,112,46),('88082445682','Franciszek','Smuda','1988-08-24',168,64,40),('89012265020','Elżbieta','Mysz','1989-01-22',163,69,36),('89050611122','Adam','Wzorzec','1989-05-06',177,70,42),('89051820424','Ewa','Mysz','1989-05-18',201,100,43),('89091842771','Dawid','Drewno','1989-09-18',130,64,46),('89102480867','Kamil','Bubr','1989-10-24',136,102,39),('89111085330','Aleksandra','Tapeta','1989-11-10',188,103,39),('90061353249','Piotr','Tapeta','1990-06-13',133,76,43),('92010145094','Dawid','Lewandowski','1992-01-01',150,117,43),('93031566689','Paul','Pogba','1993-03-15',191,84,46),('93052185897','Edward','Tapeta','1993-05-21',160,120,41),('93080883019','Franciszek','Kot','1993-08-08',153,54,40),('94091848500','Dawid','Milczak','1994-09-18',133,121,42),('95080339695','Olga','Tapeta','1995-08-03',172,99,43),('96011637269','Kamil','Drewno','1996-01-16',161,64,44),('96042517414','Dawid','Listek','1996-04-25',150,64,37),('96052254248','Edward','Mysz','1996-05-22',191,119,39),('96081210409','Ewa','Lewandowski','1996-08-12',144,75,38),('97112017166','Kamil','Dąb','1997-11-20',171,75,37),('99010175396','Zdzisław','Manekin','1999-01-01',166,62,39);
/*!40000 ALTER TABLE `ludzie` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER pelnoletni_ludzie BEFORE INSERT ON ludzie
    FOR EACH ROW 
    BEGIN 
    IF ADDDATE(CURDATE(), INTERVAL -18 YEAR) < NEW.`data_urodzenia` THEN 
    SET NEW.`data_urodzenia`=null; 
    END IF; 
    IF LEFT((NEW.`PESEL`),6) <> RIGHT((NEW.`data_urodzenia`-0),6) THEN 
    SET NEW.`PESEL`=null; 
    END IF; 
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pracownicy`
--

DROP TABLE IF EXISTS `pracownicy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pracownicy` (
  `PESEL` char(11) COLLATE utf8_polish_ci NOT NULL,
  `zawod` varchar(50) COLLATE utf8_polish_ci NOT NULL,
  `pensja` float unsigned NOT NULL,
  PRIMARY KEY (`PESEL`),
  KEY `pensja_idx` (`pensja`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pracownicy`
--

LOCK TABLES `pracownicy` WRITE;
/*!40000 ALTER TABLE `pracownicy` DISABLE KEYS */;
INSERT INTO `pracownicy` VALUES ('03062799827','reporter',3400),('09070721539','reporter',3701),('11030986748','reporter',3131),('19062547539','reporter',2319),('23072912982','informatyk',6669),('24102547619','reporter',2289),('25110927307','informatyk',4587),('31101057570','reporter',2284),('34111612382','informatyk',4339),('36033150867','reporter',4487),('37071858248','reporter',3205),('39060865991','informatyk',5711),('40102729165','informatyk',5841),('42021992760','reporter',2146),('42102478165','reporter',2466),('54020684350','sprzedawca',3463),('54040972944','sprzedawca',4216),('55111755692','sprzedawca',4055),('56091584008','sprzedawca',2964),('56122500017','malarz',4000),('57070569800','sprzedawca',4016),('58120129521','sprzedawca',3721),('59031953298','sprzedawca',3090),('60020529419','informatyk',10477),('60041578663','sprzedawca',4351),('60050788597','informatyk',4318),('60062398399','reporter',2156),('60092119996','sprzedawca',3213),('60110356311','sprzedawca',2269),('61010525169','sprzedawca',3032),('61031394206','sprzedawca',4087),('61071114231','sprzedawca',3056),('62040421524','reporter',3297),('62070712033','reporter',2588),('62090261179','sprzedawca',3738),('63032526772','sprzedawca',4196),('63090489626','sprzedawca',3099),('63111730404','sprzedawca',3492),('64020491185','sprzedawca',3646),('64020532244','sprzedawca',4114),('64050930326','sprzedawca',3413),('64062390362','sprzedawca',3202),('65032256344','sprzedawca',3615),('66040976435','sprzedawca',2704),('66122929180','informatyk',8901),('68081341290','sprzedawca',4205),('68090463951','sprzedawca',2022),('68111880223','reporter',3993),('68111966858','reporter',2161),('69062451100','sprzedawca',3621),('69101010680','sprzedawca',2780),('70042762121','sprzedawca',4138),('70072386218','sprzedawca',3834),('71050195738','sprzedawca',2651),('72021989993','sprzedawca',2988),('72111482938','sprzedawca',2104),('73052539597','sprzedawca',2658),('74021737560','sprzedawca',3431),('74051913567','sprzedawca',3944),('74082523115','reporter',2085),('75112437638','sprzedawca',2214),('75122670084','sprzedawca',2842),('76022597194','sprzedawca',4045),('76051925169','sprzedawca',3173),('76090374055','sprzedawca',2482),('79011628753','sprzedawca',3504),('79032537995','sprzedawca',3129),('79090983403','sprzedawca',3294),('79121212120','piłkarz',90000),('80091163156','reporter',4343),('81032163711','sprzedawca',4067),('81032922697','sprzedawca',2613),('81072637564','sprzedawca',4119),('82041978861','sprzedawca',3589),('82070616928','sprzedawca',3070),('82091971472','sprzedawca',4221),('83022559558','sprzedawca',3178),('83122195239','informatyk',8265),('85041483628','reporter',2685),('85071693413','sprzedawca',2942),('85091535957','sprzedawca',2633),('86010791759','reporter',3716),('86013177038','reporter',3386),('86022843495','sprzedawca',3682),('86032360469','sprzedawca',3668),('86070123681','sprzedawca',3022),('86090783713','sprzedawca',4449),('86101996193','informatyk',8006),('87012872038','sprzedawca',3727),('87033099885','sprzedawca',2021),('87052381497','sprzedawca',2415),('87070465985','sprzedawca',2019),('87091412587','sprzedawca',3792),('87100570865','sprzedawca',2651),('88012334804','sprzedawca',2161),('88021395360','sprzedawca',2110),('88082445682','piłkarz',48000),('89012265020','sprzedawca',3472),('89050611122','piłkarz',200000),('89051820424','sprzedawca',2875),('89091842771','sprzedawca',4490),('89102480867','sprzedawca',2722),('89111085330','sprzedawca',3619),('90061353249','sprzedawca',2575),('92010145094','sprzedawca',4342),('93031566689','piłkarz',400000),('93052185897','sprzedawca',4068),('93080883019','informatyk',9831),('94091848500','sprzedawca',2566),('95080339695','sprzedawca',3105),('96011637269','informatyk',7225),('96042517414','informatyk',6027),('96052254248','sprzedawca',4388),('96081210409','sprzedawca',4388),('97112017166','sprzedawca',3917),('99010175396','piłkarz',328000);
/*!40000 ALTER TABLE `pracownicy` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER history_in_log AFTER UPDATE ON pracownicy
    FOR EACH ROW 
    BEGIN 
    	DECLARE czas date ;
        SET czas=CURDATE() ;
    	INSERT INTO log (id_zmiany,PESEL,data_zmiany,stara_wartosc,nowa_wartosc)
			VALUES (NULL,OLD.PESEL,czas,OLD.pensja,NEW.pensja) ;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-05 19:46:45
