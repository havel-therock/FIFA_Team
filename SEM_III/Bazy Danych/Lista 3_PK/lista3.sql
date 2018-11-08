-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 05 Gru 2017, 16:25
-- Wersja serwera: 10.1.26-MariaDB
-- Wersja PHP: 7.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `lista3`
--

DELIMITER $$
--
-- Procedury
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `tworca_informatykow` (IN `n` INT)  BEGIN
	DECLARE i int ;
    DECLARE ur date ;
    DECLARE pes char(11) ;
    DECLARE im ENUM ('Piotr','Adam','Franciszek','Zenon','Dawid','Kamil','Edward','Elżbieta','Aleksandra','Olga') ;
    DECLARE naz ENUM ('Piotrowski','Lewandowski','Drewno','Listek','Dąb','Bubr','Tapeta','Kot','Ekran','Mysz') ;
    SET i=0 ;
    WHILE i < 13 DO
        	SET i = i + 1 ;
            SET ur=ADDDATE('1900-01-01', INTERVAL (FLOOR(RAND() * datediff('1999-12-31','1900-01-01'))) DAY) ;
            SET pes = CONCAT(RIGHT((ur-0),6),(SELECT FLOOR(RAND() * 90000) + 10000)) ;
            SET im = (SELECT FLOOR(1 + (RAND() * 9))) ;
            SET naz = (SELECT FLOOR(1 + (RAND() * 9))) ;
			INSERT INTO ludzie (PESEL,imie,nazwisko,data_urodzenia,wzrost,waga,rozmiar_buta)
			VALUES (pes,im,naz,ur,(SELECT FLOOR(130 + (RAND() * 80))),(SELECT FLOOR(50 + (RAND() * 75))),(SELECT FLOOR(36 + (RAND() * 11)))) ;
            INSERT INTO pracownicy (PESEL,zawod,pensja)
			VALUES (pes,'informatyk',(SELECT FLOOR(4000 + (RAND() * 7000)))) ;
	END WHILE ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tworca_reporterow` (IN `n` INT)  BEGIN
	DECLARE i int ;
    DECLARE ur date ;
    DECLARE pes char(11) ;
    DECLARE im ENUM ('Piotr','Adam','Ewa','Zenon','Dawid','Kamil','Edward','Elżbieta','Aleksandra','Olga') ;
    DECLARE naz ENUM ('Milczak','Lewandowski','Drewno','Listek','Dąb','Bubr','Tapeta','Kot','Ekran','Mysz') ;
    SET i=0 ;
    WHILE i < 20 DO
        	SET i = i + 1 ;
            SET ur=ADDDATE('1900-01-01', INTERVAL (FLOOR(RAND() * datediff('1999-12-31','1900-01-01'))) DAY) ;
            SET pes = CONCAT(RIGHT((ur-0),6),(SELECT FLOOR(RAND() * 90000) + 10000)) ;
            SET im = (SELECT FLOOR(1 + (RAND() * 9))) ;
            SET naz = (SELECT FLOOR(1 + (RAND() * 9))) ;
			INSERT INTO ludzie (PESEL,imie,nazwisko,data_urodzenia,wzrost,waga,rozmiar_buta)
			VALUES (pes,im,naz,ur,(SELECT FLOOR(130 + (RAND() * 80))),(SELECT FLOOR(50 + (RAND() * 75))),(SELECT FLOOR(36 + (RAND() * 11)))) ;
            INSERT INTO pracownicy (PESEL,zawod,pensja)
			VALUES (pes,'reporter',(SELECT FLOOR(2000 + (RAND() * 2500)))) ;
	END WHILE ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tworca_sprzedawcow` (IN `n` INT)  BEGIN
	DECLARE i int ;
    DECLARE ur date ;
    DECLARE pes char(11) ;
    DECLARE im ENUM ('Piotr','Adam','Ewa','Zenon','Dawid','Kamil','Edward','Elżbieta','Aleksandra','Olga') ;
    DECLARE naz ENUM ('Milczak','Lewandowski','Drewno','Listek','Dąb','Bubr','Tapeta','Kot','Ekran','Mysz') ;
    SET i=0 ;
    WHILE i < 77 DO
        	SET i = i + 1 ;
            SET ur=ADDDATE(ADDDATE(CURDATE(), INTERVAL -65 YEAR), INTERVAL (FLOOR(RAND() * datediff('1999-12-31',ADDDATE(CURDATE(), INTERVAL -65 YEAR)))) DAY) ;
            SET pes = CONCAT(RIGHT((ur-0),6),(SELECT FLOOR(RAND() * 90000) + 10000)) ;
            SET im = (SELECT FLOOR(1 + (RAND() * 10))) ;
            SET naz = (SELECT FLOOR(1 + (RAND() * 10))) ;
			INSERT INTO ludzie (PESEL,imie,nazwisko,data_urodzenia,wzrost,waga,rozmiar_buta)
			VALUES (pes,im,naz,ur,(SELECT FLOOR(130 + (RAND() * 80))),(SELECT FLOOR(50 + (RAND() * 75))),(SELECT FLOOR(36 + (RAND() * 11)))) ;
            INSERT INTO pracownicy (PESEL,zawod,pensja)
			VALUES (pes,'sprzedawca',(SELECT FLOOR(2000 + (RAND() * 2500)))) ;
	END WHILE ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `zad3` (IN `agg` CHAR(100), IN `kol` CHAR(100))  BEGIN
	SET @agg = (SELECT agg) ;
	SET @kol = (SELECT kol) ;
    IF @agg = 'COUNT' THEN
    SET @pol = CONCAT('SELECT ',@kol,', "',@agg,'", ',@agg,'(',@kol,') FROM `ludzie` GROUP BY ',@kol);
    PREPARE stmt FROM @pol;
    
	EXECUTE stmt;
 
	DEALLOCATE PREPARE stmt;
    ELSE
    SET @pol = CONCAT('SELECT "',@kol,'", "',@agg,'", ',@agg,'(',@kol,') FROM `ludzie`');
    PREPARE stmt FROM @pol;
    
	EXECUTE stmt;
 
	DEALLOCATE PREPARE stmt;
    END IF ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `zad4` (IN `budzet` INT(100), IN `zawod` CHAR(100))  BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE pen CHAR(11);
    DECLARE cur CURSOR FOR SELECT `pracownicy`.`pensja` FROM `pracownicy` WHERE `pracownicy`.`zawod`=zawod;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
    
    SET autocommit = 0;
    START TRANSACTION ;
    OPEN cur;
    WHILE done=0 DO
    FETCH cur INTO pen;
    SET budzet=budzet-pen;
    IF budzet<0 THEN
    SET done=2;
    END IF;
    END WHILE;
    CLOSE cur;
    
    IF done=2 THEN
        SELECT 'Za mały budżet'AS 'BŁĄD';
    ELSEIF done=1 THEN
    SELECT CONCAT('********',RIGHT((`pracownicy`.`PESEL`),3)) AS 'pesel', `pracownicy`.`pensja` AS 'wyplacono' FROM `pracownicy` WHERE `pracownicy`.`zawod`=zawod ;
    END IF ;
    COMMIT ;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `log`
--

CREATE TABLE `log` (
  `id_zmiany` int(11) NOT NULL,
  `PESEL` char(11) COLLATE utf8_polish_ci NOT NULL,
  `data_zmiany` date NOT NULL,
  `stara_wartosc` int(11) NOT NULL,
  `nowa_wartosc` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `log`
--

INSERT INTO `log` (`id_zmiany`, `PESEL`, `data_zmiany`, `stara_wartosc`, `nowa_wartosc`) VALUES
(1, '07052993682', '2017-12-05', 3250, 3244),
(2, '07052993682', '2017-12-05', 3244, 3275);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `ludzie`
--

CREATE TABLE `ludzie` (
  `PESEL` char(11) COLLATE utf8_polish_ci NOT NULL,
  `imie` varchar(30) COLLATE utf8_polish_ci NOT NULL,
  `nazwisko` varchar(30) COLLATE utf8_polish_ci NOT NULL,
  `data_urodzenia` date NOT NULL,
  `wzrost` float UNSIGNED NOT NULL,
  `waga` float UNSIGNED NOT NULL,
  `rozmiar_buta` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `ludzie`
--

INSERT INTO `ludzie` (`PESEL`, `imie`, `nazwisko`, `data_urodzenia`, `wzrost`, `waga`, `rozmiar_buta`) VALUES
('07052993682', 'Zenon', 'Listek', '1907-05-29', 165, 64, 42),
('13110628435', 'Kamil', 'Listek', '1913-11-06', 155, 73, 42),
('20111343170', 'Adam', 'Ekran', '1920-11-13', 149, 70, 42),
('23020721095', 'Aleksandra', 'Drewno', '1923-02-07', 167, 93, 41),
('28020166767', 'Franciszek', 'Bubr', '1928-02-01', 160, 120, 41),
('31042394723', 'Edward', 'Milczak', '1931-04-23', 191, 109, 43),
('33031281034', 'Aleksandra', 'Listek', '1933-03-12', 135, 65, 44),
('35090952069', 'Ewa', 'Ekran', '1935-09-09', 198, 84, 44),
('39070778957', 'Kamil', 'Ekran', '1939-07-07', 186, 107, 43),
('48022210876', 'Kamil', 'Ekran', '1948-02-22', 141, 107, 40),
('48090787541', 'Elżbieta', 'Bubr', '1948-09-07', 187, 96, 46),
('49051581861', 'Dawid', 'Lewandowski', '1949-05-15', 151, 114, 41),
('50032660843', 'Ewa', 'Ekran', '1950-03-26', 171, 117, 46),
('50050112345', 'Franciszek', 'Zamorski', '1950-05-01', 165, 70, 42),
('53020238068', 'Aleksandra', 'Ekran', '1953-02-02', 177, 68, 41),
('54051648417', 'Piotr', 'Mysz', '1954-05-16', 171, 111, 41),
('54082740865', 'Edward', 'Mysz', '1954-08-27', 142, 108, 41),
('57110750342', 'Dawid', 'Lewandowski', '1957-11-07', 162, 84, 36),
('58052935335', 'Kamil', 'Listek', '1958-05-29', 145, 100, 44),
('58062940520', 'Zenon', 'Tapeta', '1958-06-29', 162, 122, 43),
('59080646827', 'Ewa', 'Milczak', '1959-08-06', 173, 88, 46),
('59102481071', 'Kamil', 'Lewandowski', '1959-10-24', 158, 70, 38),
('60032442569', 'Zenon', 'Tapeta', '1960-03-24', 140, 108, 41),
('60040145642', 'Kamil', 'Listek', '1960-04-01', 158, 96, 36),
('60062520056', 'Piotr', 'Milczak', '1960-06-25', 131, 119, 42),
('60083024528', 'Zenon', 'Milczak', '1960-08-30', 168, 62, 40),
('61032734700', 'Aleksandra', 'Listek', '1961-03-27', 163, 118, 39),
('61103137527', 'Olga', 'Ekran', '1961-10-31', 175, 61, 36),
('61110862659', 'Zenon', 'Milczak', '1961-11-08', 134, 67, 46),
('62020856988', 'Piotr', 'Bubr', '1962-02-08', 187, 119, 41),
('62031262215', 'Piotr', 'Listek', '1962-03-12', 135, 52, 46),
('62081416043', 'Elżbieta', 'Listek', '1962-08-14', 192, 107, 41),
('63070821712', 'Olga', 'Dąb', '1963-07-08', 170, 56, 45),
('65061042368', 'Elżbieta', 'Piotrowski', '1965-06-10', 207, 93, 36),
('65091874333', 'Elżbieta', 'Tapeta', '1965-09-18', 207, 117, 42),
('66011220957', 'Elżbieta', 'Bubr', '1966-01-12', 144, 81, 41),
('66040511951', 'Adam', 'Dąb', '1966-04-05', 156, 51, 37),
('67052495742', 'Aleksandra', 'Listek', '1967-05-24', 147, 53, 42),
('67101110136', 'Piotr', 'Drewno', '1967-10-11', 155, 101, 41),
('68052716459', 'Zenon', 'Tapeta', '1968-05-27', 139, 97, 45),
('69032645639', 'Olga', 'Bubr', '1969-03-26', 190, 66, 45),
('69042245645', 'Olga', 'Dąb', '1969-04-22', 182, 109, 46),
('69042364930', 'Aleksandra', 'Milczak', '1969-04-23', 148, 56, 44),
('69093048277', 'Piotr', 'Ekran', '1969-09-30', 159, 62, 43),
('69100136938', 'Dawid', 'Drewno', '1969-10-01', 197, 89, 37),
('69110657159', 'Kamil', 'Lewandowski', '1969-11-06', 133, 112, 36),
('70022216526', 'Ewa', 'Lewandowski', '1970-02-22', 189, 79, 44),
('71040444180', 'Elżbieta', 'Bubr', '1971-04-04', 159, 74, 41),
('71040992794', 'Dawid', 'Listek', '1971-04-09', 183, 63, 45),
('71102637403', 'Zenon', 'Ekran', '1971-10-26', 172, 113, 43),
('71111781280', 'Elżbieta', 'Listek', '1971-11-17', 183, 63, 45),
('71122716552', 'Adam', 'Bubr', '1971-12-27', 145, 76, 38),
('72051777245', 'Dawid', 'Drewno', '1972-05-17', 186, 111, 46),
('73030189065', 'Adam', 'Ekran', '1973-03-01', 136, 106, 42),
('75102917163', 'Olga', 'Dąb', '1975-10-29', 165, 116, 36),
('76072715404', 'Elżbieta', 'Kot', '1976-07-27', 173, 78, 38),
('76091033340', 'Elżbieta', 'Lewandowski', '1976-09-10', 154, 61, 45),
('76092570663', 'Aleksandra', 'Drewno', '1976-09-25', 181, 89, 43),
('77052331850', 'Edward', 'Bubr', '1977-05-23', 190, 61, 41),
('77061595489', 'Zenon', 'Drewno', '1977-06-15', 139, 106, 40),
('77121190812', 'Adam', 'Milczak', '1977-12-11', 198, 57, 46),
('78012845631', 'Gianluigi', 'Buffon', '1978-01-28', 191, 92, 45),
('78050719145', 'Aleksandra', 'Lewandowski', '1978-05-07', 130, 97, 37),
('79011197216', 'Adam', 'Milczak', '1979-01-11', 166, 71, 36),
('79011719396', 'Aleksandra', 'Mysz', '1979-01-17', 153, 91, 45),
('79022030934', 'Dawid', 'Kot', '1979-02-20', 157, 81, 36),
('79062684462', 'Dawid', 'Kot', '1979-06-26', 158, 93, 45),
('80040264095', 'Ewa', 'Bubr', '1980-04-02', 192, 77, 41),
('80120679580', 'Piotr', 'Milczak', '1980-12-06', 144, 97, 43),
('81052719552', 'Elżbieta', 'Drewno', '1981-05-27', 142, 124, 41),
('81072088175', 'Kamil', 'Mysz', '1981-07-20', 160, 120, 42),
('81081412757', 'Zenon', 'Bubr', '1981-08-14', 184, 109, 46),
('81091722119', 'Adam', 'Tapeta', '1981-09-17', 198, 64, 40),
('83041624625', 'Aleksandra', 'Ekran', '1983-04-16', 199, 96, 41),
('83052380632', 'Olga', 'Bubr', '1983-05-23', 197, 89, 36),
('84031730350', 'Adam', 'Milczak', '1984-03-17', 179, 55, 41),
('84102696809', 'Elżbieta', 'Milczak', '1984-10-26', 202, 78, 38),
('85032957291', 'Kamil', 'Drewno', '1985-03-29', 178, 68, 40),
('85041288713', 'Elżbieta', 'Dąb', '1985-04-12', 194, 99, 45),
('85070283068', 'Dawid', 'Piotrowski', '1985-07-02', 185, 77, 44),
('87042830463', 'Olga', 'Milczak', '1987-04-28', 159, 104, 42),
('87060634981', 'Adam', 'Lewandowski', '1987-06-06', 209, 95, 36),
('87081244736', 'Ewa', 'Listek', '1987-08-12', 197, 61, 38),
('88121724560', 'Adam', 'Lewandowski', '1988-12-17', 182, 96, 37),
('89010226659', 'Edward', 'Bubr', '1989-01-02', 209, 68, 38),
('89010472925', 'Elżbieta', 'Milczak', '1989-01-04', 183, 70, 39),
('89022132185', 'Vadis', 'Odjidja-Ofoe', '1989-02-21', 185, 79, 46),
('89041780446', 'Kamil', 'Tapeta', '1989-04-17', 159, 121, 43),
('89070214765', 'Alex', 'Morgan', '1989-07-02', 170, 63, 38),
('89070453442', 'Piotr', 'Mysz', '1989-07-04', 175, 120, 46),
('89081323113', 'Zenon', 'Bubr', '1989-08-13', 161, 82, 46),
('89083189445', 'Edward', 'Ekran', '1989-08-31', 184, 85, 39),
('90121671171', 'Olga', 'Ekran', '1990-12-16', 149, 103, 45),
('91031712512', 'Edward', 'Dąb', '1991-03-17', 207, 97, 38),
('91032046752', 'Edward', 'Kot', '1991-03-20', 138, 64, 42),
('91061271144', 'Olga', 'Tapeta', '1991-06-12', 172, 97, 42),
('91072565857', 'Edward', 'Listek', '1991-07-25', 192, 117, 37),
('91080443834', 'Dawid', 'Mysz', '1991-08-04', 169, 98, 44),
('92072981116', 'Dawid', 'Kot', '1992-07-29', 167, 59, 37),
('92080575819', 'Elżbieta', 'Lewandowski', '1992-08-05', 158, 65, 46),
('92102325826', 'Zenon', 'Lewandowski', '1992-10-23', 192, 82, 44),
('92120518482', 'Olga', 'Listek', '1992-12-05', 198, 74, 36),
('94021221590', 'Piotr', 'Kot', '1994-02-12', 168, 70, 46),
('94022878952', 'Arkadiusz', 'Milik', '1994-02-28', 186, 78, 44),
('95012150394', 'Zenon', 'Bubr', '1995-01-21', 201, 98, 42),
('95032723252', 'Piotr', 'Kot', '1995-03-27', 183, 54, 39),
('95060840682', 'Olga', 'Mysz', '1995-06-08', 192, 54, 46),
('95082122138', 'Olga', 'Listek', '1995-08-21', 204, 92, 36),
('95090654420', 'Elżbieta', 'Drewno', '1995-09-06', 205, 124, 37),
('95092520857', 'Aleksandra', 'Milczak', '1995-09-25', 165, 61, 40),
('96012165478', 'Marco', 'Asensio', '1996-01-21', 182, 74, 44),
('96060618189', 'Edward', 'Lewandowski', '1996-06-06', 181, 110, 37),
('96071745395', 'Adam', 'Kot', '1996-07-17', 146, 107, 38),
('97100172497', 'Edward', 'Mysz', '1997-10-01', 139, 96, 44),
('98072822240', 'Elżbieta', 'Dąb', '1998-07-28', 203, 68, 41),
('98092441538', 'Aleksandra', 'Lewandowski', '1998-09-24', 135, 124, 44),
('99092181793', 'Piotr', 'Tapeta', '1999-09-21', 143, 118, 37);

--
-- Wyzwalacze `ludzie`
--
DELIMITER $$
CREATE TRIGGER `pelnoletni_ludzie` BEFORE INSERT ON `ludzie` FOR EACH ROW BEGIN 
    IF ADDDATE(CURDATE(), INTERVAL -18 YEAR) < NEW.`data_urodzenia` THEN 
    SET NEW.`data_urodzenia`=null; 
    END IF; 
    IF LEFT((NEW.`PESEL`),6) <> RIGHT((NEW.`data_urodzenia`-0),6) THEN 
    SET NEW.`PESEL`=null; 
    END IF; 
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pracownicy`
--

CREATE TABLE `pracownicy` (
  `PESEL` char(11) COLLATE utf8_polish_ci NOT NULL,
  `zawod` varchar(50) COLLATE utf8_polish_ci NOT NULL,
  `pensja` float UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `pracownicy`
--

INSERT INTO `pracownicy` (`PESEL`, `zawod`, `pensja`) VALUES
('07052993682', 'reporter', 3275),
('13110628435', 'informatyk', 4679),
('20111343170', 'informatyk', 6129),
('23020721095', 'reporter', 3930),
('28020166767', 'informatyk', 9902),
('31042394723', 'reporter', 4225),
('33031281034', 'reporter', 3072),
('35090952069', 'reporter', 3200),
('39070778957', 'reporter', 2285),
('48022210876', 'informatyk', 8853),
('49051581861', 'reporter', 4328),
('50032660843', 'reporter', 2026),
('50050112345', 'malarz', 4500),
('53020238068', 'reporter', 3662),
('54051648417', 'sprzedawca', 2377),
('54082740865', 'sprzedawca', 2014),
('57110750342', 'reporter', 4499),
('58052935335', 'reporter', 4455),
('58062940520', 'sprzedawca', 2712),
('59080646827', 'reporter', 2324),
('59102481071', 'sprzedawca', 3209),
('60032442569', 'sprzedawca', 2318),
('60040145642', 'sprzedawca', 2885),
('60062520056', 'sprzedawca', 2536),
('60083024528', 'sprzedawca', 2828),
('61032734700', 'sprzedawca', 4143),
('61103137527', 'sprzedawca', 4297),
('61110862659', 'sprzedawca', 2335),
('62020856988', 'sprzedawca', 3722),
('62031262215', 'informatyk', 9335),
('62081416043', 'sprzedawca', 2129),
('63070821712', 'sprzedawca', 2486),
('65061042368', 'informatyk', 5804),
('65091874333', 'sprzedawca', 2873),
('66011220957', 'sprzedawca', 3054),
('66040511951', 'informatyk', 8486),
('67052495742', 'sprzedawca', 3733),
('67101110136', 'sprzedawca', 2829),
('68052716459', 'sprzedawca', 2499),
('69032645639', 'sprzedawca', 3133),
('69042245645', 'sprzedawca', 3382),
('69042364930', 'reporter', 3086),
('69093048277', 'informatyk', 4927),
('69100136938', 'sprzedawca', 2145),
('69110657159', 'sprzedawca', 3618),
('70022216526', 'sprzedawca', 3306),
('71040444180', 'sprzedawca', 3340),
('71040992794', 'sprzedawca', 4367),
('71102637403', 'reporter', 4186),
('71111781280', 'sprzedawca', 4206),
('71122716552', 'sprzedawca', 2143),
('72051777245', 'sprzedawca', 2867),
('73030189065', 'sprzedawca', 3188),
('75102917163', 'sprzedawca', 3918),
('76072715404', 'sprzedawca', 2334),
('76091033340', 'sprzedawca', 3947),
('76092570663', 'sprzedawca', 3955),
('77052331850', 'sprzedawca', 2080),
('77061595489', 'informatyk', 9747),
('77121190812', 'reporter', 2792),
('78012845631', 'piłkarz', 334000),
('78050719145', 'sprzedawca', 3963),
('79011197216', 'sprzedawca', 3178),
('79011719396', 'sprzedawca', 3810),
('79022030934', 'sprzedawca', 2286),
('79062684462', 'sprzedawca', 3177),
('80040264095', 'sprzedawca', 2609),
('80120679580', 'sprzedawca', 2765),
('81052719552', 'sprzedawca', 3188),
('81072088175', 'sprzedawca', 2168),
('81081412757', 'sprzedawca', 2669),
('81091722119', 'reporter', 2725),
('83041624625', 'sprzedawca', 3589),
('83052380632', 'sprzedawca', 4217),
('84031730350', 'sprzedawca', 2626),
('84102696809', 'sprzedawca', 4043),
('85032957291', 'sprzedawca', 2605),
('85041288713', 'reporter', 3007),
('85070283068', 'informatyk', 8429),
('87042830463', 'sprzedawca', 3409),
('87060634981', 'sprzedawca', 3391),
('87081244736', 'reporter', 4199),
('88121724560', 'informatyk', 10068),
('89010226659', 'sprzedawca', 3059),
('89010472925', 'reporter', 4379),
('89022132185', 'piłkarz', 84000),
('89041780446', 'sprzedawca', 2884),
('89070214765', 'piłkarz', 38000),
('89070453442', 'sprzedawca', 2402),
('89081323113', 'sprzedawca', 3690),
('89083189445', 'informatyk', 6478),
('90121671171', 'sprzedawca', 2205),
('91031712512', 'sprzedawca', 2480),
('91032046752', 'sprzedawca', 3427),
('91061271144', 'sprzedawca', 4468),
('91072565857', 'sprzedawca', 2199),
('91080443834', 'sprzedawca', 3989),
('92072981116', 'sprzedawca', 3367),
('92080575819', 'informatyk', 5574),
('92102325826', 'sprzedawca', 3894),
('92120518482', 'sprzedawca', 2793),
('94021221590', 'sprzedawca', 4073),
('94022878952', 'piłkarz', 208000),
('95012150394', 'reporter', 4142),
('95032723252', 'sprzedawca', 2865),
('95060840682', 'sprzedawca', 3127),
('95082122138', 'sprzedawca', 3136),
('95090654420', 'sprzedawca', 3932),
('95092520857', 'sprzedawca', 4019),
('96012165478', 'piłkarz', 375000),
('96060618189', 'sprzedawca', 2210),
('96071745395', 'sprzedawca', 4126),
('97100172497', 'sprzedawca', 4095),
('98072822240', 'sprzedawca', 3892),
('98092441538', 'sprzedawca', 4108),
('99092181793', 'sprzedawca', 3851);

--
-- Wyzwalacze `pracownicy`
--
DELIMITER $$
CREATE TRIGGER `history_in_log` AFTER UPDATE ON `pracownicy` FOR EACH ROW BEGIN 
    	DECLARE czas date ;
        SET czas=CURDATE() ;
    	INSERT INTO log (id_zmiany,PESEL,data_zmiany,stara_wartosc,nowa_wartosc)
			VALUES (NULL,OLD.PESEL,czas,OLD.pensja,NEW.pensja) ;
    END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `pracownik_czlowiek` BEFORE INSERT ON `pracownicy` FOR EACH ROW BEGIN 
    DECLARE done INT DEFAULT 0;
    DECLARE pes CHAR(11);
    DECLARE cur CURSOR FOR SELECT PESEL FROM ludzie;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
    OPEN cur;
    WHILE done=0 DO
    FETCH cur INTO pes;
    IF pes=NEW.`PESEL` THEN
    SET done=2;
    END IF;
    END WHILE;
    CLOSE cur;
    IF done=1 THEN
    SET NEW.`PESEL`=null;
    END IF;
    END
$$
DELIMITER ;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indexes for table `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`id_zmiany`);

--
-- Indexes for table `ludzie`
--
ALTER TABLE `ludzie`
  ADD PRIMARY KEY (`PESEL`);

--
-- Indexes for table `pracownicy`
--
ALTER TABLE `pracownicy`
  ADD PRIMARY KEY (`PESEL`),
  ADD KEY `pensja_idx` (`pensja`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `log`
--
ALTER TABLE `log`
  MODIFY `id_zmiany` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
