-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 12 Sty 2018, 23:33
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
-- Baza danych: `footbalfun`
--

DELIMITER $$
--
-- Procedury
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `czyszczenieMeczy` ()  BEGIN
          	truncate mecze;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `czyszczenieMeczyAbstrakcyjnych` ()  BEGIN
          	truncate mecze_abstrakcyjne;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `danekonta` (IN `log` VARCHAR(20), IN `has` CHAR(50))  BEGIN
	DECLARE x int;
   	SET x = (SELECT uzytkownicy.wlasna_liga FROM uzytkownicy WHERE uzytkownicy.login=log AND uzytkownicy.haslo=has);

	IF x IS NOT null THEN
		SELECT uzytkownicy.login,uzytkownicy.poziom_dostepu,uzytkownicy.wlasna_liga,zespoly.nazwa
    	FROM uzytkownicy 
    	JOIN zespoly ON zespoly.ID=uzytkownicy.ulubiony_zespol
    	WHERE uzytkownicy.login=log AND uzytkownicy.haslo=has;
    ELSE
    	SELECT uzytkownicy.login,uzytkownicy.poziom_dostepu,uzytkownicy.wlasna_liga,uzytkownicy.ulubiony_zespol
    	FROM uzytkownicy 
    	WHERE uzytkownicy.login=log AND uzytkownicy.haslo=has;
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dodajZespolAbstrakcyjny` (IN `klub1` VARCHAR(50), IN `log` VARCHAR(20))  BEGIN
	DECLARE rozgrywki varchar(50);
	DECLARE ID1 int;
	DECLARE powtorka varchar(50);
DECLARE zespol int;
    DECLARE done INT DEFAULT 0;
    DECLARE pozycja INT DEFAULT 1;
    DECLARE cur CURSOR FOR SELECT * FROM test_prepare_vw;
 	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;

SET rozgrywki = CONCAT(log,'_leauge');
SET @query = CONCAT("CREATE VIEW test_prepare_vw as select ID_zespolu FROM ", rozgrywki," ORDER BY punkty DESC, bilans_bramkowy DESC");
select @query; 
PREPARE stmt from @query; 
EXECUTE stmt; 
DEALLOCATE PREPARE stmt; 




        SET powtorka = (SELECT ID FROM zespoly WHERE nazwa=klub1);
SET ID1 = (SELECT ID FROM zespoly where nazwa=klub1);

        IF powtorka IS NOT null THEN
	 

        
    SET @query = CONCAT('INSERT INTO ',rozgrywki,'  (ID_zespolu,rozegrane_mecze,bramki_stracone,bramki_strzelone,bilans_bramkowy,punkty,pozycja_w_tabeli) VALUES (',ID1,',0,0,0,0,0,0);'); 
	select @query; 
	PREPARE stmt from @query; 
	EXECUTE stmt; 
	DEALLOCATE PREPARE stmt;

	END IF;

OPEN cur;
FETCH cur INTO zespol;
    	WHILE done=0 DO
            SET @zespol=(SELECT zespol);
    		SET @pozycja=(SELECT pozycja);
    		SET @pol = CONCAT("UPDATE ", rozgrywki ," SET pozycja_w_tabeli=",@pozycja," WHERE ID_zespolu=",@zespol);
    		PREPARE stmt FROM @pol;
			EXECUTE stmt;
 			DEALLOCATE PREPARE stmt;
        	
        	SET pozycja=pozycja+1;
            FETCH cur INTO zespol;	
    	END WHILE;
    CLOSE cur; 
	DROP VIEW test_prepare_vw;  

    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `informacjeOStadionie` (IN `arena` VARCHAR(50))  BEGIN
DECLARE powtorka varchar(50);
        SET powtorka = (SELECT nazwa FROM stadiony WHERE nazwa=arena);
        IF powtorka IS NOT null THEN 
	SELECT  zespoly.nazwa, stadiony.nazwa AS 'nazwa2', stadiony.adres, stadiony.ilosc_miejsc FROM stadiony JOIN zespoly ON stadiony.ID=zespoly.stadion WHERE stadiony.nazwa=arena;
    
        END IF ;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `informacjeOZespole` (IN `klub` VARCHAR(50))  BEGIN
	DECLARE powtorka varchar(50);
        SET powtorka = (SELECT nazwa FROM zespoly WHERE nazwa=klub);
        IF powtorka IS NOT null THEN 
	SELECT  zespoly.nazwa, zespoly.mijescowosc, zespoly.liga, zespoly.trener, zespoly.barwy, stadiony.nazwa AS 'nazwa2', stadiony.adres, stadiony.ilosc_miejsc FROM stadiony JOIN zespoly ON stadiony.ID=zespoly.stadion WHERE zespoly.nazwa=klub;
    
        END IF ;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ligaZespolu` (IN `klub1` VARCHAR(50))  BEGIN
	 	 
    SELECT liga FROM zespoly where nazwa=klub1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `logowanie` (IN `log` VARCHAR(20), IN `has` CHAR(50))  BEGIN
	DECLARE x varchar(5);
    DECLARE pas char(50);
    SET pas = (SELECT uzytkownicy.haslo FROM uzytkownicy WHERE uzytkownicy.login=log);
    IF pas=has THEN
    	SELECT 'true' AS 'wynik';
    ELSE
    	SELECT 'false' AS 'wynik';
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pokazAbstrakcyjneMecze` (IN `log` VARCHAR(30))  BEGIN
	DECLARE powtorka varchar(50); 
	DECLARE nazwa varchar(20);
	SET nazwa=CONCAT(log,'_leauge');

	SET powtorka = (SELECT wlasna_liga FROM uzytkownicy WHERE login=log);

IF powtorka IS NOT null THEN
SET @pol = CONCAT("SELECT * FROM v_mecze_abstrakcyjne WHERE rozgrywki='",nazwa,"'");
		PREPARE stmt FROM @pol;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
    ELSE
    	SELECT * FROM `v_mecze_abstrakcyjne`;
    END IF ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pokazAbstrakcyjnyWidok` (IN `log` VARCHAR(50))  BEGIN


DECLARE powtorka varchar(50);
DECLARE nazwa varchar(20);
SET nazwa=CONCAT(log,'_leauge');
SET powtorka = (SELECT wlasna_liga FROM uzytkownicy WHERE login=log);

IF powtorka IS NOT null THEN 

SET @pol = CONCAT('SELECT * FROM v_',nazwa);

		PREPARE stmt FROM @pol;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;

END IF; 

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pokazBundesliga` ()  BEGIN
	SELECT * FROM `v_bundesliga`;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pokazEkstraklasa` ()  BEGIN
    SELECT * FROM `v_ekstraklasa`;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pokazLaLiga` ()  BEGIN
	SELECT * FROM `v_la_liga`;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pokazLigue1` ()  BEGIN
	SELECT * FROM `v_ligue_1`;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pokazMecze` (IN `roz` VARCHAR(30))  BEGIN 
	IF roz='Ekstraklasa' OR roz='La Liga' OR roz='Serie A' OR roz='Ligue 1' OR roz='Premier Leauge' OR roz='Bundesliga' THEN
		SELECT * FROM `v_mecze` WHERE `v_mecze`.`rozgrywki`=roz;
    ELSE
    	SELECT * FROM `v_mecze`;
    END IF ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pokazMeczeAbstrakcyjne` ()  BEGIN 
	SELECT * FROM v_mecze_abstrakcyjne;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pokazPremierLeauge` ()  BEGIN
	SELECT * FROM `v_premier_leauge`;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pokazSerieA` ()  BEGIN
	SELECT * FROM `v_serie_a`;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pozycjaBundesliga` ()  BEGIN
    DECLARE zespol int;
    DECLARE done INT DEFAULT 0;
    DECLARE pozycja INT DEFAULT 1;
    DECLARE cur CURSOR FOR SELECT `ID_zespolu` FROM `bundesliga` ORDER BY `bundesliga`.`punkty` DESC,`bundesliga`.`bilans_bramkowy` DESC;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;

    OPEN cur;
    	WHILE done=0 DO
    		FETCH cur INTO zespol;
            SET @zespol=(SELECT zespol);
    		SET @pozycja=(SELECT pozycja);
    		SET @pol = CONCAT('UPDATE `bundesliga` SET `bundesliga`.`pozycja_w_tabeli`=',@pozycja,' WHERE `bundesliga`.`ID_zespolu`=',@zespol);
    		PREPARE stmt FROM @pol;
		EXECUTE stmt;
 		DEALLOCATE PREPARE stmt;
        	IF pozycja<18 THEN
        		SET pozycja=pozycja+1;
            	END IF;
    	END WHILE;
    CLOSE cur;  
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pozycjaEkstraklasa` ()  BEGIN
    DECLARE zespol int;
    DECLARE done INT DEFAULT 0;
    DECLARE pozycja INT DEFAULT 1;
    DECLARE cur CURSOR FOR SELECT `ID_zespolu` FROM `ekstraklasa` ORDER BY `ekstraklasa`.`punkty` DESC,`ekstraklasa`.`bilans_bramkowy` DESC;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;

    OPEN cur;
    	WHILE done=0 DO
    		FETCH cur INTO zespol;
            SET @zespol=(SELECT zespol);
    		SET @pozycja=(SELECT pozycja);
    		SET @pol = CONCAT('UPDATE `ekstraklasa` SET `ekstraklasa`.`pozycja_w_tabeli`=',@pozycja,' WHERE `ekstraklasa`.`ID_zespolu`=',@zespol);
    		PREPARE stmt FROM @pol;
			EXECUTE stmt;
 			DEALLOCATE PREPARE stmt;
            IF pozycja<16 THEN
        		SET pozycja=pozycja+1;
            END IF;
    	END WHILE;
    CLOSE cur;  
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pozycjaLaLiga` ()  BEGIN
    DECLARE zespol int;
    DECLARE done INT DEFAULT 0;
    DECLARE pozycja INT DEFAULT 1;
    DECLARE cur CURSOR FOR SELECT `ID_zespolu` FROM `la_liga` ORDER BY `la_liga`.`punkty` DESC,`la_liga`.`bilans_bramkowy` DESC;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;

    OPEN cur;
    	WHILE done=0 DO
    		FETCH cur INTO zespol;
            SET @zespol=(SELECT zespol);
    		SET @pozycja=(SELECT pozycja);
    		SET @pol = CONCAT('UPDATE `la_liga` SET `la_liga`.`pozycja_w_tabeli`=',@pozycja,' WHERE `la_liga`.`ID_zespolu`=',@zespol);
    		PREPARE stmt FROM @pol;
			EXECUTE stmt;
 			DEALLOCATE PREPARE stmt;
        	IF pozycja<20 THEN
        		SET pozycja=pozycja+1;
            END IF;
    	END WHILE;
    CLOSE cur;  
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pozycjaLigue1` ()  BEGIN
    DECLARE zespol int;
    DECLARE done INT DEFAULT 0;
    DECLARE pozycja INT DEFAULT 1;
    DECLARE cur CURSOR FOR SELECT `ID_zespolu` FROM `ligue_1` ORDER BY `ligue_1`.`punkty` DESC,`ligue_1`.`bilans_bramkowy` DESC;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;

    OPEN cur;
    	WHILE done=0 DO
    		FETCH cur INTO zespol;
            SET @zespol=(SELECT zespol);
    		SET @pozycja=(SELECT pozycja);
    		SET @pol = CONCAT('UPDATE `ligue_1` SET `ligue_1`.`pozycja_w_tabeli`=',@pozycja,' WHERE `ligue_1`.`ID_zespolu`=',@zespol);
    		PREPARE stmt FROM @pol;
		EXECUTE stmt;
 		DEALLOCATE PREPARE stmt;
        	IF pozycja<20 THEN
        		SET pozycja=pozycja+1;
            	END IF;
    	END WHILE;
    CLOSE cur;  
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pozycjaPremierLeauge` ()  BEGIN
    DECLARE zespol int;
    DECLARE done INT DEFAULT 0;
    DECLARE pozycja INT DEFAULT 1;
    DECLARE cur CURSOR FOR SELECT `ID_zespolu` FROM `premier_leauge` ORDER BY `premier_leauge`.`punkty` DESC,`premier_leauge`.`bilans_bramkowy` DESC;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;

    OPEN cur;
    	WHILE done=0 DO
    		FETCH cur INTO zespol;
            SET @zespol=(SELECT zespol);
    		SET @pozycja=(SELECT pozycja);
    		SET @pol = CONCAT('UPDATE `premier_leauge` SET `premier_leauge`.`pozycja_w_tabeli`=',@pozycja,' WHERE `premier_leauge`.`ID_zespolu`=',@zespol);
    		PREPARE stmt FROM @pol;
		EXECUTE stmt;
 		DEALLOCATE PREPARE stmt;
        	IF pozycja<20 THEN
        		SET pozycja=pozycja+1;
            	END IF;
    	END WHILE;
    CLOSE cur;  
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pozycjaSerieA` ()  BEGIN
    DECLARE zespol int;
    DECLARE done INT DEFAULT 0;
    DECLARE pozycja INT DEFAULT 1;
    DECLARE cur CURSOR FOR SELECT `ID_zespolu` FROM `serie_a` ORDER BY `serie_a`.`punkty` DESC,`serie_a`.`bilans_bramkowy` DESC;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;

    OPEN cur;
    	WHILE done=0 DO
    		FETCH cur INTO zespol;
            SET @zespol=(SELECT zespol);
    		SET @pozycja=(SELECT pozycja);
    		SET @pol = CONCAT('UPDATE `serie_a` SET `serie_a`.`pozycja_w_tabeli`=',@pozycja,' WHERE `serie_a`.`ID_zespolu`=',@zespol);
    		PREPARE stmt FROM @pol;
		EXECUTE stmt;
 		DEALLOCATE PREPARE stmt;
        	IF pozycja<20 THEN
        		SET pozycja=pozycja+1;
            	END IF;
    	END WHILE;
    CLOSE cur;  
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rozegrajMecz` (IN `klub1` VARCHAR(50), IN `bramki1` INT, IN `bramki2` INT, IN `klub2` VARCHAR(50))  BEGIN

    DECLARE ID1 int;
    DECLARE ID2 int;
    DECLARE liga1 varchar(30);

    SET ID1 = (SELECT ID FROM zespoly where nazwa=klub1);
    SET ID2 = (SELECT ID FROM zespoly where nazwa=klub2);
	 
    SET liga1 = (SELECT liga FROM zespoly where nazwa=klub1);
    
    INSERT INTO mecze VALUES (null,CURDATE(),ID1,bramki1,bramki2,ID2,liga1);
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rozegrajMeczAbstrakcyjny` (IN `klub1` VARCHAR(50), IN `klub2` VARCHAR(50), IN `log` VARCHAR(20))  BEGIN
	DECLARE rozgrywki varchar(50);
    DECLARE punktyZ1 int;
    DECLARE punktyZ2 int;
    DECLARE bramki1 int;
    DECLARE bramki2 int;
    DECLARE ID1 int;
    DECLARE ID2 int;
    DECLARE liga1 varchar(30);
    DECLARE liga2 varchar(30);
    DECLARE powtorka3 varchar(50);
    DECLARE powtorka4 varchar(50);
     DECLARE zespol int;
    DECLARE done INT DEFAULT 0;
    DECLARE pozycja INT DEFAULT 1;
    DECLARE cur CURSOR FOR SELECT * FROM test_prepare_vw;
 	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;

SET powtorka3 = (SELECT ID FROM zespoly WHERE nazwa=klub1);
        IF powtorka3 IS NOT null THEN 
SET powtorka4 = (SELECT ID FROM zespoly WHERE nazwa=klub2);
        IF powtorka4 IS NOT null THEN 

	SET rozgrywki = CONCAT(log,'_leauge');
    SET ID1 = (SELECT ID FROM zespoly where nazwa=klub1);
    SET ID2 = (SELECT ID FROM zespoly where nazwa=klub2);

SET @query = CONCAT("CREATE VIEW test_prepare_vw as select ID_zespolu FROM ", rozgrywki," ORDER BY punkty DESC, bilans_bramkowy DESC");
select @query; 
PREPARE stmt from @query; 
EXECUTE stmt; 
DEALLOCATE PREPARE stmt; 
	 
    SET liga1 = (SELECT liga FROM zespoly where nazwa=klub1);
    SET liga2 = (SELECT liga FROM zespoly where nazwa=klub2);



        IF liga1='Ekstraklasa' THEN
        	SET bramki1 = FLOOR(rand()*(((21-(SELECT pozycja_w_tabeli FROM ekstraklasa WHERE ID_zespolu=ID1 ))/5)+2));
          
        ELSEIF liga1='Ligue 1' THEN
        	SET bramki1 = FLOOR(rand()*(((21-(SELECT pozycja_w_tabeli FROM ligue_1  WHERE ID_zespolu=ID1 ))/5)+2));
           
        ELSEIF liga1='Bundesliga' THEN
        	SET bramki1 = FLOOR(rand()*(((21-(SELECT pozycja_w_tabeli FROM bundesliga WHERE ID_zespolu=ID1 ))/5)+2));
            
        ELSEIF liga1='La Liga' THEN
        	SET bramki1 = FLOOR(rand()*(((21-(SELECT pozycja_w_tabeli FROM la_liga  WHERE ID_zespolu=ID1 ))/5)+2));
            
        ELSEIF liga1='Serie A' THEN
        	SET bramki1 = FLOOR(rand()*(((21-(SELECT pozycja_w_tabeli FROM serie_a WHERE ID_zespolu=ID1 ))/5)+2));
           
        ELSEIF liga1='Premier Leauge' THEN
        	SET bramki1 = FLOOR(rand()*(((21-(SELECT pozycja_w_tabeli FROM premier_leauge WHERE ID_zespolu=ID1 ))/5)+2));
            
        END IF;

IF liga2='Ekstraklasa' THEN
        	SET bramki2 = FLOOR(rand()*(((21-(SELECT pozycja_w_tabeli FROM ekstraklasa WHERE ID_zespolu=ID2 ))/5)+2));
           
        ELSEIF liga2='Ligue 1' THEN
        	SET bramki2 = FLOOR(rand()*(((21-(SELECT pozycja_w_tabeli FROM ligue_1  WHERE ID_zespolu=ID2 ))/5)+2));
            
        ELSEIF liga2='Bundesliga' THEN
        	SET bramki2 = FLOOR(rand()*(((21-(SELECT pozycja_w_tabeli FROM bundesliga WHERE ID_zespolu=ID2 ))/5)+2));
            
        ELSEIF liga2='La Liga' THEN
        	SET bramki2 = FLOOR(rand()*(((21-(SELECT pozycja_w_tabeli FROM la_liga  WHERE ID_zespolu=ID2 ))/5)+2));
        
        ELSEIF liga2='Serie A' THEN
        	SET bramki2 = FLOOR(rand()*(((21-(SELECT pozycja_w_tabeli FROM serie_a WHERE ID_zespolu=ID2 ))/5)+2));
        ELSEIF liga2='Premier Leauge' THEN
        	SET bramki2 = FLOOR(rand()*(((21-(SELECT pozycja_w_tabeli FROM premier_leauge WHERE ID_zespolu=ID2 ))/5)+2));
           
        END IF;

	IF bramki1 > bramki2 THEN
    	SET punktyZ1 = 3;
        SET punktyZ2 = 0;
    ELSEIF bramki1 < bramki2 THEN
    	SET punktyZ1 = 0;
        SET punktyZ2 = 3;
    ELSEIF bramki1 = bramki2 THEN
    	SET punktyZ1 = 1;
        SET punktyZ2 = 1;
    END IF;
    
      INSERT INTO mecze_abstrakcyjne VALUES (null,CURDATE(),ID1,bramki1,bramki2,ID2,rozgrywki);

SET @str = CONCAT("UPDATE ", rozgrywki ," SET rozegrane_mecze=rozegrane_mecze+1, bramki_strzelone=bramki_strzelone+ ", bramki1 ,", bramki_stracone=bramki_stracone- ", bramki2 ,", bilans_bramkowy=bilans_bramkowy + ", bramki1 ," - ", bramki2 ,", punkty=punkty + ", punktyZ1 ," WHERE ID_zespolu= ", ID1);
PREPARE stmt FROM @str;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @str = CONCAT("UPDATE ", rozgrywki ," SET rozegrane_mecze=rozegrane_mecze+1, bramki_strzelone=bramki_strzelone+ ", bramki2 ,", bramki_stracone=bramki_stracone- ", bramki1 ,", bilans_bramkowy=bilans_bramkowy + ", bramki2 ," - ", bramki1 ,", punkty=punkty + ", punktyZ2 ," WHERE ID_zespolu= ", ID2);
PREPARE stmt FROM @str;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

OPEN cur;
FETCH cur INTO zespol;
    	WHILE done=0 DO
            SET @zespol=(SELECT zespol);
    		SET @pozycja=(SELECT pozycja);
    		SET @pol = CONCAT("UPDATE ", rozgrywki ," SET pozycja_w_tabeli=",@pozycja," WHERE ID_zespolu=",@zespol);
    		PREPARE stmt FROM @pol;
			EXECUTE stmt;
 			DEALLOCATE PREPARE stmt;
        	
        	SET pozycja=pozycja+1;
            FETCH cur INTO zespol;	
    	END WHILE;
    CLOSE cur; 
	DROP VIEW test_prepare_vw;  


end IF;
end IF;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sortujTabele` (IN `roz` VARCHAR(30), IN `kol` VARCHAR(30))  BEGIN
	DECLARE tabela varchar(30);
	SET @kol = (SELECT kol);

	IF roz='Ekstraklasa' THEN
    	SET @tabela = 'v_ekstraklasa';
        SET @pol = CONCAT('SELECT * FROM ',@tabela,' ORDER BY ',@kol,' DESC');
		PREPARE stmt FROM @pol;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
    ELSEIF roz='La Liga' THEN
    	SET @tabela = 'v_la_liga';
        SET @pol = CONCAT('SELECT * FROM ',@tabela,' ORDER BY ',@kol,' DESC');
		PREPARE stmt FROM @pol;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
    ELSEIF roz='Bundesliga' THEN
    	SET @tabela = 'v_bundesliga';
        SET @pol = CONCAT('SELECT * FROM ',@tabela,' ORDER BY ',@kol,' DESC');
		PREPARE stmt FROM @pol;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
    ELSEIF roz='Premier Leauge' THEN
    	SET @tabela = 'v_premier_leauge';
        SET @pol = CONCAT('SELECT * FROM ',@tabela,' ORDER BY ',@kol,' DESC');
		PREPARE stmt FROM @pol;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
    ELSEIF roz='Ligue 1' THEN
    	SET @tabela = 'v_ligue_1';
        SET @pol = CONCAT('SELECT * FROM ',@tabela,' ORDER BY ',@kol,' DESC');
		PREPARE stmt FROM @pol;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
    ELSEIF roz='Serie A' THEN
    	SET @tabela = 'v_serie_a';
        SET @pol = CONCAT('SELECT * FROM ',@tabela,' ORDER BY ',@kol,' DESC');
		PREPARE stmt FROM @pol;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sortujTabeleAbstrakcyjna` (IN `log` VARCHAR(30), IN `kol` VARCHAR(30))  BEGIN
	DECLARE nazwa varchar(50);
    DECLARE tabela varchar(30);
SET nazwa = (SELECT wlasna_liga FROM uzytkownicy WHERE login=log);

IF nazwa IS NOT null THEN 
	
	SET @kol = (SELECT kol);
    	SET @tabela = CONCAT('v_',log,'_leauge');
        SET @pol = CONCAT('SELECT * FROM ',@tabela,' ORDER BY ',@kol,' DESC');
		PREPARE stmt FROM @pol;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tworzenieAbstrakcyjnejLigi` (IN `log` CHAR(20))  BEGIN

DECLARE powtorka varchar(50);
DECLARE nazwa varchar(20);
SET nazwa=CONCAT(log,'_leauge');
SET powtorka = (SELECT wlasna_liga FROM uzytkownicy WHERE login=log);

IF powtorka IS null THEN 

UPDATE uzytkownicy SET wlasna_liga = nazwa WHERE login=log;


        SET @pol = CONCAT('CREATE TABLE ',nazwa,' (\r\n`ID_zespolu` int(11) NOT NULL,\r\n  `rozegrane_mecze` int(11) NOT NULL,\r\n  `bramki_stracone` int(11) NOT NULL,\r\n  `bramki_strzelone` int(11) NOT NULL,\r\n  `bilans_bramkowy` int(11) NOT NULL,\r\n  `punkty` int(11) NOT NULL,\r\n  `pozycja_w_tabeli` int(11) NOT NULL,\r\n   FOREIGN KEY (`ID_zespolu`) REFERENCES `zespoly` (`ID`)\r\n);');
		PREPARE stmt FROM @pol;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;

SET @pol = CONCAT('CREATE VIEW v_',nazwa,' AS SELECT ', nazwa,'.pozycja_w_tabeli,`zespoly`.`nazwa`, ',nazwa,'.`rozegrane_mecze`, ',nazwa,'.`bramki_stracone`, ',nazwa,'.`bramki_strzelone`, ',nazwa,'.`bilans_bramkowy`,',nazwa,'.`punkty`\r\nFROM ',nazwa,' JOIN `zespoly` ON `zespoly`.`ID`=',nazwa,'.`ID_zespolu`\r\nORDER BY ',nazwa,'.`pozycja_w_tabeli`;');

		PREPARE stmt FROM @pol;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt; 


END IF; 

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tworzenieLudzi` ()  BEGIN



DECLARE imiona ENUM('Jan','Carlo','Pep','Diego', 'Gerardo', 'Adam', 'Jorge', 'Arsene', 'Antonio', 'Jose', 'Jurgen', 'Laurent', 'Unai', 'Manuel', 'Yupp', 'Marcelo', 'Enderson','Rafael', 'Orest', 'Roberto');

DECLARE nazwiska ENUM('Di Matteo','Urban','Ancelotti', 'Guardiola', 'Martio', 'Simeone', 'Guardiola', 'Nawalka', 'Jesus', 'Wenger', 'Conte', 'Mourinho', 'Klopp', 'Blanc','Emery', 'Pellergini', 'Lenczyk', 'Benitez','Moreira','Henckes');

DECLARE czlonKlub ENUM('FC','Chelsea','Real','Atletico', 'City', 'Crystal', 'Celtia', 'Anderlacht', 'Ajax', 'Celtic', 'United', 'Juventus', 'Benfica', 'Bayer', 'Bayern','Borrusia', 'Szachtar', 'Inter', 'AC', 'Slask');

DECLARE miejscowosc ENUM('London','Warszawa','Wroclaw','Barcelona', 'Madryt', 'Monachium', 'Amsterdam', 'Mediolan', 'Rzym', 'Lizbona', 'Dortmund', 'Manchester', 'Liverpool', 'Glasgow', 'Donieck', 'Zagrzeb', 'Paryz', 'Sevilla', 'Monaco', 'Brimingham');

DECLARE czlonStadionu ENUM('Salt Lake','Santiago Bernabeu','Camp Nou','Maracana', 'Rose', 'Alianz', 'Croke', 'Wembley', 'Old', ' San', 'Pepsi', 'Stamford', 'Reliant', 'Celtic', 'Abuja', 'Odi', 'Emirates', 'Anfield', 'Ellis', 'Imtech');

DECLARE czlonStadionu2 ENUM('Arena','Stadium','Trafford','Bridge', 'Azteca', 'Azadi', 'Karno', 'de France', 'des Martys', ' Jaili', 'Siro', 'Field', 'Dageu', 'da Luz', 'de Lima', 'Azis', 'Magen', 'Estadio', 'La Costa', 'Amisto');

DECLARE barwy ENUM('Biale','Czerwone','Zolte','Bialo-czerwone', 'Niebieskie', 'Zielone', 'Rozowe', 'Granatowo-czarne', 'Niebiesko-zolte', 'Seledynowe', 'Ciemno-niebieskie', 'Srebrne', 'Zlote', 'Zolto-zielone', 'Fioletowe');

DECLARE adres ENUM('zamkowa 7','Football street 1','Galatery 4','Mundo 4', 'Dolling street 9', 'Pariseal 5', 'Lazienkowska 4', 'Le Lasa 2', 'Umis 89', 'Ksasae 1', 'Abaci 1', 'Ceselina 9', 'Agawning 9', 'Sely 1', 'Abbanad 3');



DECLARE trener char(30);
DECLARE i int;
DECLARE id int;
DECLARE klub char(30);
DECLARE stadion char(30);
DECLARE random int;
SET id=0;

SET i=0;
WHILE i<20 DO

SET i=i+1;
set id=id+1;

SET imiona=FLOOR(1+rand()*20);
SET nazwiska=FLOOR(1+rand()*20);
SET czlonKlub=FLOOR(1+rand()*20);
SET miejscowosc=FLOOR(1+rand()*20);
SET czlonStadionu=FLOOR(1+rand()*20);
SET czlonStadionu2=FLOOR(1+rand()*20);
SET barwy=FLOOR(1+rand()*15);

SET trener=CONCAT(imiona,' ',nazwiska);
SET klub=CONCAT(czlonKlub,' ',miejscowosc);
SET stadion=CONCAT(czlonstadionu,' ',czlonstadionu2);
SET adres=FLOOR(1+rand()*15);
SET random = FLOOR(5000+rand()*80000);

INSERT INTO stadiony (ID,nazwa,adres,ilosc_miejsc)
VALUES (id,stadion,adres,random);

INSERT INTO zespoly (ID, nazwa,mijescowosc,stadion,liga,trener,barwy)
VALUES (id,klub,miejscowosc,id,'Ligue 1',trener,barwy);

END WHILE;

SET i=0;
WHILE i<16 DO

SET i=i+1;
set id=id+1;

SET imiona=FLOOR(1+rand()*20);
SET nazwiska=FLOOR(1+rand()*20);
SET czlonKlub=FLOOR(1+rand()*20);
SET miejscowosc=FLOOR(1+rand()*20);
SET czlonStadionu=FLOOR(1+rand()*20);
SET czlonStadionu2=FLOOR(1+rand()*20);
SET barwy=FLOOR(1+rand()*15);

SET trener=CONCAT(imiona,' ',nazwiska);
SET klub=CONCAT(czlonKlub,' ',miejscowosc);
SET stadion=CONCAT(czlonstadionu,' ',czlonstadionu2);
SET adres=FLOOR(1+rand()*15);
SET random = FLOOR(5000+rand()*80000);


INSERT INTO stadiony (ID,nazwa,adres,ilosc_miejsc)
VALUES (id,stadion,adres,random);



INSERT INTO zespoly (ID, nazwa,mijescowosc,stadion,liga,trener,barwy)
VALUES (id,klub,miejscowosc,id,'Ekstraklasa',trener,barwy);

END WHILE;

SET i=0;
WHILE i<18 DO

SET i=i+1;
set id=id+1;

SET imiona=FLOOR(1+rand()*20);
SET nazwiska=FLOOR(1+rand()*20);
SET czlonKlub=FLOOR(1+rand()*20);
SET miejscowosc=FLOOR(1+rand()*20);
SET czlonStadionu=FLOOR(1+rand()*20);
SET czlonStadionu2=FLOOR(1+rand()*20);
SET barwy=FLOOR(1+rand()*15);

SET trener=CONCAT(imiona,' ',nazwiska);
SET klub=CONCAT(czlonKlub,' ',miejscowosc);
SET stadion=CONCAT(czlonstadionu,' ',czlonstadionu2);
SET adres=FLOOR(1+rand()*15);

INSERT INTO stadiony (ID,nazwa,adres,ilosc_miejsc)
VALUES (id,stadion,adres,FLOOR(5000+rand()*80000));



INSERT INTO zespoly (ID, nazwa,mijescowosc,stadion,liga,trener,barwy)
VALUES (id,klub,miejscowosc,id,'Bundesliga',trener,barwy);

END WHILE;

SET i=0;
WHILE i<20 DO

SET i=i+1;
set id=id+1;

SET imiona=FLOOR(1+rand()*20);
SET nazwiska=FLOOR(1+rand()*20);
SET czlonKlub=FLOOR(1+rand()*20);
SET miejscowosc=FLOOR(1+rand()*20);
SET czlonStadionu=FLOOR(1+rand()*20);
SET czlonStadionu2=FLOOR(1+rand()*20);
SET barwy=FLOOR(1+rand()*15);

SET trener=CONCAT(imiona,' ',nazwiska);
SET klub=CONCAT(czlonKlub,' ',miejscowosc);
SET stadion=CONCAT(czlonstadionu,' ',czlonstadionu2);
SET adres=FLOOR(1+rand()*15);


INSERT INTO stadiony (ID,nazwa,adres,ilosc_miejsc)
VALUES (id,stadion,adres,FLOOR(5000+rand()*80000));



INSERT INTO zespoly (ID, nazwa,mijescowosc,stadion,liga,trener,barwy)
VALUES (id,klub,miejscowosc,id,'La Liga',trener,barwy);

END WHILE;

SET i=0;
WHILE i<20 DO

SET i=i+1;
set id=id+1;

SET imiona=FLOOR(1+rand()*20);
SET nazwiska=FLOOR(1+rand()*20);
SET czlonKlub=FLOOR(1+rand()*20);
SET miejscowosc=FLOOR(1+rand()*20);
SET czlonStadionu=FLOOR(1+rand()*20);
SET czlonStadionu2=FLOOR(1+rand()*20);
SET barwy=FLOOR(1+rand()*15);

SET trener=CONCAT(imiona,' ',nazwiska);
SET klub=CONCAT(czlonKlub,' ',miejscowosc);
SET stadion=CONCAT(czlonstadionu,' ',czlonstadionu2);
SET adres=FLOOR(1+rand()*15);


INSERT INTO stadiony (ID,nazwa,adres,ilosc_miejsc)
VALUES (id,stadion,adres,FLOOR(5000+rand()*80000));



INSERT INTO zespoly (ID, nazwa,mijescowosc,stadion,liga,trener,barwy)
VALUES (id,klub,miejscowosc,id,'Serie A',trener,barwy);

END WHILE;

SET i=0;
WHILE i<20 DO

SET i=i+1;
set id=id+1;

SET imiona=FLOOR(1+rand()*20);
SET nazwiska=FLOOR(1+rand()*20);
SET czlonKlub=FLOOR(1+rand()*20);
SET miejscowosc=FLOOR(1+rand()*20);
SET czlonStadionu=FLOOR(1+rand()*20);
SET czlonStadionu2=FLOOR(1+rand()*20);
SET barwy=FLOOR(1+rand()*15);

SET trener=CONCAT(imiona,' ',nazwiska);
SET klub=CONCAT(czlonKlub,' ',miejscowosc);
SET stadion=CONCAT(czlonstadionu,' ',czlonstadionu2);
SET adres=FLOOR(1+rand()*15);


INSERT INTO stadiony (ID,nazwa,adres,ilosc_miejsc)
VALUES (id,stadion,adres,FLOOR(5000+rand()*80000));



INSERT INTO zespoly (ID, nazwa,mijescowosc,stadion,liga,trener,barwy)
VALUES (id,klub,miejscowosc,id,'Premier Leauge',trener,barwy);

END WHILE;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tworzenieUzytkownikow` (IN `log` VARCHAR(20), IN `pas` VARCHAR(50))  BEGIN
DECLARE x varchar(5);
    DECLARE pass char(50);
    SET pass = (SELECT login FROM uzytkownicy WHERE uzytkownicy.login=log);
    IF pass IS null THEN
    	SELECT 'true' AS 'wynik';
    ELSE
    	SELECT 'false' AS 'wynik';
    END IF;

          	INSERT INTO uzytkownicy (login,haslo,poziom_dostepu,wlasna_liga,ulubiony_zespol) VALUES (log,pas,"normalny",null,null);    

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ustawUlubionaDruzyne` (IN `klub` VARCHAR(50), IN `log` VARCHAR(20))  BEGIN
DECLARE powtorka varchar(50);
        SET powtorka = (SELECT ID FROM zespoly WHERE nazwa=klub);
        IF powtorka IS NOT null THEN 

          UPDATE uzytkownicy SET ulubiony_zespol = powtorka WHERE login=log;

        END IF ;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `usunZespolAbstrakcyjny` (IN `klub1` VARCHAR(50), IN `log` VARCHAR(20))  BEGIN
	DECLARE rozgrywki varchar(50);
	DECLARE ID1 int;
	DECLARE powtorka varchar(50);

        SET powtorka = (SELECT ID FROM zespoly WHERE nazwa=klub1);
SET ID1 = (SELECT ID FROM zespoly where nazwa=klub1);

        IF powtorka IS NOT null THEN
	 
	SET rozgrywki = CONCAT(log,'_leauge');
        
    SET @query = CONCAT('DELETE FROM ',rozgrywki, ' WHERE ID_zespolu=',ID1);
	select @query; 
	PREPARE stmt from @query; 
	EXECUTE stmt; 
	DEALLOCATE PREPARE stmt;


	END IF;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `usuwanieAbstrakcyjnejLigi` (IN `log` CHAR(20))  BEGIN

DECLARE nazwa varchar(50);
SET nazwa = (SELECT wlasna_liga FROM uzytkownicy WHERE login=log);

IF nazwa IS NOT null THEN 

UPDATE uzytkownicy SET wlasna_liga = null WHERE login=log;

SET @pol = CONCAT('DROP TABLE ',nazwa);
		PREPARE stmt FROM @pol;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;

SET @pol = CONCAT('DROP VIEW v_',nazwa);
		PREPARE stmt FROM @pol;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;


END IF; 

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `usuwanieUzytkownikow` (IN `log` VARCHAR(20))  BEGIN
DECLARE powtorka varchar(50);
        SET powtorka = (SELECT login FROM uzytkownicy WHERE login=log);
IF powtorka IS NOT null THEN 
delete from uzytkownicy where login LIKE log;   
END IF; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `wypelnianieLig` ()  BEGIN
  DECLARE done INT DEFAULT 0;
  DECLARE l varchar(30);
  DECLARE i int;
  DECLARE p int;
  DECLARE cur CURSOR FOR SELECT `ID`,`liga` FROM `zespoly`;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;

  OPEN cur;
  	WHILE done=0 DO
    	FETCH cur INTO i,l;
        IF l='Ekstraklasa' THEN
        	SET p=1;
        	INSERT INTO ekstraklasa VALUES (i,0,0,0,0,0,p);
            SET p=p+1;
        ELSEIF l='Ligue 1' THEN
        	SET p=1;
        	INSERT INTO ligue_1 VALUES (i,0,0,0,0,0,p);
            SET p=p+1;
        ELSEIF l='Bundesliga' THEN
        	SET p=1;
        	INSERT INTO bundesliga VALUES (i,0,0,0,0,0,p);
            SET p=p+1;
        ELSEIF l='La Liga' THEN
        	SET p=1;
        	INSERT INTO la_liga VALUES (i,0,0,0,0,0,p);
            SET p=p+1;
        ELSEIF l='Serie A' THEN
        	SET p=1;
        	INSERT INTO serie_a VALUES (i,0,0,0,0,0,p);
            SET p=p+1;
        ELSEIF l='Premier Leauge' THEN
        	SET p=1;
        	INSERT INTO premier_leauge VALUES (i,0,0,0,0,0,p);
            SET p=p+1;
        END IF;
    END WHILE;
  CLOSE cur;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `bundesliga`
--

CREATE TABLE `bundesliga` (
  `ID_zespolu` int(11) NOT NULL,
  `rozegrane_mecze` int(11) NOT NULL,
  `bramki_stracone` int(11) NOT NULL,
  `bramki_strzelone` int(11) NOT NULL,
  `bilans_bramkowy` int(11) NOT NULL,
  `punkty` int(11) NOT NULL,
  `pozycja_w_tabeli` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `bundesliga`
--

INSERT INTO `bundesliga` (`ID_zespolu`, `rozegrane_mecze`, `bramki_stracone`, `bramki_strzelone`, `bilans_bramkowy`, `punkty`, `pozycja_w_tabeli`) VALUES
(37, 0, 0, 0, 0, 0, 1),
(38, 0, 0, 0, 0, 0, 17),
(39, 0, 0, 0, 0, 0, 16),
(40, 0, 0, 0, 0, 0, 15),
(41, 0, 0, 0, 0, 0, 14),
(42, 0, 0, 0, 0, 0, 13),
(43, 0, 0, 0, 0, 0, 12),
(44, 0, 0, 0, 0, 0, 11),
(45, 0, 0, 0, 0, 0, 10),
(46, 0, 0, 0, 0, 0, 9),
(47, 0, 0, 0, 0, 0, 8),
(48, 0, 0, 0, 0, 0, 7),
(49, 0, 0, 0, 0, 0, 6),
(50, 0, 0, 0, 0, 0, 5),
(51, 0, 0, 0, 0, 0, 4),
(52, 0, 0, 0, 0, 0, 3),
(53, 0, 0, 0, 0, 0, 2),
(54, 0, 0, 0, 0, 0, 18);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `ekstraklasa`
--

CREATE TABLE `ekstraklasa` (
  `ID_zespolu` int(11) NOT NULL,
  `rozegrane_mecze` int(11) NOT NULL,
  `bramki_stracone` int(11) NOT NULL,
  `bramki_strzelone` int(11) NOT NULL,
  `bilans_bramkowy` int(11) NOT NULL,
  `punkty` int(11) NOT NULL,
  `pozycja_w_tabeli` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `ekstraklasa`
--

INSERT INTO `ekstraklasa` (`ID_zespolu`, `rozegrane_mecze`, `bramki_stracone`, `bramki_strzelone`, `bilans_bramkowy`, `punkty`, `pozycja_w_tabeli`) VALUES
(21, 0, 0, 0, 0, 0, 9),
(22, 0, 0, 0, 0, 0, 13),
(23, 1, 3, 4, 1, 3, 2),
(24, 1, 4, 3, -1, 0, 15),
(25, 1, 4, 2, -2, 0, 16),
(26, 0, 0, 0, 0, 0, 12),
(27, 0, 0, 0, 0, 0, 11),
(28, 0, 0, 0, 0, 0, 10),
(29, 1, 0, 0, 0, 1, 3),
(30, 0, 0, 0, 0, 0, 8),
(31, 0, 0, 0, 0, 0, 7),
(32, 0, 0, 0, 0, 0, 6),
(33, 2, 2, 4, 2, 4, 1),
(34, 0, 0, 0, 0, 0, 5),
(35, 0, 0, 0, 0, 0, 4),
(36, 0, 0, 0, 0, 0, 14);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `la_liga`
--

CREATE TABLE `la_liga` (
  `ID_zespolu` int(11) NOT NULL,
  `rozegrane_mecze` int(11) NOT NULL,
  `bramki_stracone` int(11) NOT NULL,
  `bramki_strzelone` int(11) NOT NULL,
  `bilans_bramkowy` int(11) NOT NULL,
  `punkty` int(11) NOT NULL,
  `pozycja_w_tabeli` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `la_liga`
--

INSERT INTO `la_liga` (`ID_zespolu`, `rozegrane_mecze`, `bramki_stracone`, `bramki_strzelone`, `bilans_bramkowy`, `punkty`, `pozycja_w_tabeli`) VALUES
(55, 0, 0, 0, 0, 0, 1),
(56, 0, 0, 0, 0, 0, 12),
(57, 0, 0, 0, 0, 0, 13),
(58, 0, 0, 0, 0, 0, 14),
(59, 0, 0, 0, 0, 0, 15),
(60, 0, 0, 0, 0, 0, 16),
(61, 0, 0, 0, 0, 0, 17),
(62, 0, 0, 0, 0, 0, 18),
(63, 0, 0, 0, 0, 0, 19),
(64, 0, 0, 0, 0, 0, 11),
(65, 0, 0, 0, 0, 0, 10),
(66, 0, 0, 0, 0, 0, 2),
(67, 0, 0, 0, 0, 0, 3),
(68, 0, 0, 0, 0, 0, 4),
(69, 0, 0, 0, 0, 0, 5),
(70, 0, 0, 0, 0, 0, 6),
(71, 0, 0, 0, 0, 0, 7),
(72, 0, 0, 0, 0, 0, 8),
(73, 0, 0, 0, 0, 0, 9),
(74, 0, 0, 0, 0, 0, 20);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `ligue_1`
--

CREATE TABLE `ligue_1` (
  `ID_zespolu` int(11) NOT NULL,
  `rozegrane_mecze` int(11) NOT NULL,
  `bramki_stracone` int(11) NOT NULL,
  `bramki_strzelone` int(11) NOT NULL,
  `bilans_bramkowy` int(11) NOT NULL,
  `punkty` int(11) NOT NULL,
  `pozycja_w_tabeli` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `ligue_1`
--

INSERT INTO `ligue_1` (`ID_zespolu`, `rozegrane_mecze`, `bramki_stracone`, `bramki_strzelone`, `bilans_bramkowy`, `punkty`, `pozycja_w_tabeli`) VALUES
(1, 1, 2, 4, 2, 3, 1),
(2, 1, 4, 2, -2, 0, 20),
(3, 0, 0, 0, 0, 0, 12),
(4, 0, 0, 0, 0, 0, 13),
(5, 0, 0, 0, 0, 0, 14),
(6, 0, 0, 0, 0, 0, 15),
(7, 0, 0, 0, 0, 0, 16),
(8, 0, 0, 0, 0, 0, 17),
(9, 0, 0, 0, 0, 0, 18),
(10, 0, 0, 0, 0, 0, 11),
(11, 0, 0, 0, 0, 0, 10),
(12, 0, 0, 0, 0, 0, 2),
(13, 0, 0, 0, 0, 0, 3),
(14, 0, 0, 0, 0, 0, 4),
(15, 0, 0, 0, 0, 0, 5),
(16, 0, 0, 0, 0, 0, 6),
(17, 0, 0, 0, 0, 0, 7),
(18, 0, 0, 0, 0, 0, 8),
(19, 0, 0, 0, 0, 0, 9),
(20, 0, 0, 0, 0, 0, 19);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mecze`
--

CREATE TABLE `mecze` (
  `id_meczy` int(11) NOT NULL,
  `data` date DEFAULT NULL,
  `zespol1` int(11) NOT NULL,
  `bramki_z1` int(11) NOT NULL,
  `bramki_z2` int(11) NOT NULL,
  `zespol2` int(11) NOT NULL,
  `rozgrywki` varchar(30) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `mecze`
--

INSERT INTO `mecze` (`id_meczy`, `data`, `zespol1`, `bramki_z1`, `bramki_z2`, `zespol2`, `rozgrywki`) VALUES
(1, '2018-01-08', 24, 3, 4, 23, 'Ekstraklasa'),
(2, '2018-01-08', 1, 4, 2, 2, 'Ligue 1'),
(3, '2018-01-12', 33, 4, 2, 25, 'Ekstraklasa'),
(4, '2018-01-12', 33, 0, 0, 29, 'Ekstraklasa');

--
-- Wyzwalacze `mecze`
--
DELIMITER $$
CREATE TRIGGER `poMeczuDoTabeli` BEFORE INSERT ON `mecze` FOR EACH ROW BEGIN
    
    DECLARE punktyZ1 int;
    DECLARE punktyZ2 int;
    IF NEW.`bramki_z1` > NEW.`bramki_z2` THEN
    	SET punktyZ1 = 3;
        SET punktyZ2 = 0;
    ELSEIF NEW.`bramki_z1` < NEW.`bramki_z2` THEN
    	SET punktyZ1 = 0;
        SET punktyZ2 = 3;
    ELSEIF NEW.`bramki_z1` = NEW.`bramki_z2` THEN
    	SET punktyZ1 = 1;
        SET punktyZ2 = 1;
    END IF;
    
    IF NEW.`rozgrywki`='Ekstraklasa' THEN
    	UPDATE `ekstraklasa`
        SET `ekstraklasa`.`rozegrane_mecze` = `rozegrane_mecze`+1,
        `ekstraklasa`.`bramki_stracone` = `bramki_stracone`+NEW.`bramki_z2`,
        `ekstraklasa`.`bramki_strzelone` = `bramki_strzelone`+NEW.`bramki_z1`,
        `ekstraklasa`.`bilans_bramkowy` = `bilans_bramkowy`+(NEW.`bramki_z1`-NEW.`bramki_z2`),
        `ekstraklasa`.`punkty` = `punkty`+punktyZ1
        WHERE `ekstraklasa`.`ID_zespolu`=NEW.`zespol1`;
        UPDATE `ekstraklasa`
        SET `ekstraklasa`.`rozegrane_mecze` = `rozegrane_mecze`+1,
        `ekstraklasa`.`bramki_stracone` = `bramki_stracone`+NEW.`bramki_z1`,
        `ekstraklasa`.`bramki_strzelone` = `bramki_strzelone`+NEW.`bramki_z2`,
        `ekstraklasa`.`bilans_bramkowy` = `bilans_bramkowy`+(NEW.`bramki_z2`-NEW.`bramki_z1`),
        `ekstraklasa`.`punkty` = `punkty`+punktyZ2
        WHERE `ekstraklasa`.`ID_zespolu`=NEW.`zespol2`;
    ELSEIF NEW.`rozgrywki`='Ligue 1' THEN
    	UPDATE `ligue_1`
        SET `ligue_1`.`rozegrane_mecze` = `rozegrane_mecze`+1,
        `ligue_1`.`bramki_stracone` = `bramki_stracone`+NEW.`bramki_z2`,
        `ligue_1`.`bramki_strzelone` = `bramki_strzelone`+NEW.`bramki_z1`,
        `ligue_1`.`bilans_bramkowy` = `bilans_bramkowy`+(NEW.`bramki_z1`-NEW.`bramki_z2`),
        `ligue_1`.`punkty` = `punkty`+punktyZ1
        WHERE `ligue_1`.`ID_zespolu`=NEW.`zespol1`;
        UPDATE `ligue_1`
        SET `ligue_1`.`rozegrane_mecze` = `rozegrane_mecze`+1,
        `ligue_1`.`bramki_stracone` = `bramki_stracone`+NEW.`bramki_z1`,
        `ligue_1`.`bramki_strzelone` = `bramki_strzelone`+NEW.`bramki_z2`,
        `ligue_1`.`bilans_bramkowy` = `bilans_bramkowy`+(NEW.`bramki_z2`-NEW.`bramki_z1`),
        `ligue_1`.`punkty` = `punkty`+punktyZ2
        WHERE `ligue_1`.`ID_zespolu`=NEW.`zespol2`;
    ELSEIF NEW.`rozgrywki`='Bundesliga' THEN
    	UPDATE `bundesliga`
        SET `bundesliga`.`rozegrane_mecze` = `rozegrane_mecze`+1,
        `bundesliga`.`bramki_stracone` = `bramki_stracone`+NEW.`bramki_z2`,
        `bundesliga`.`bramki_strzelone` = `bramki_strzelone`+NEW.`bramki_z1`,
        `bundesliga`.`bilans_bramkowy` = `bilans_bramkowy`+(NEW.`bramki_z1`-NEW.`bramki_z2`),
        `bundesliga`.`punkty` = `punkty`+punktyZ1
        WHERE `bundesliga`.`ID_zespolu`=NEW.`zespol1`;
        UPDATE `bundesliga`
        SET `bundesliga`.`rozegrane_mecze` = `rozegrane_mecze`+1,
        `bundesliga`.`bramki_stracone` = `bramki_stracone`+NEW.`bramki_z1`,
        `bundesliga`.`bramki_strzelone` = `bramki_strzelone`+NEW.`bramki_z2`,
        `bundesliga`.`bilans_bramkowy` = `bilans_bramkowy`+(NEW.`bramki_z2`-NEW.`bramki_z1`),
        `bundesliga`.`punkty` = `punkty`+punktyZ2
        WHERE `bundesliga`.`ID_zespolu`=NEW.`zespol2`;
    ELSEIF NEW.`rozgrywki`='La Liga' THEN
    	UPDATE `la_liga`
        SET `la_liga`.`rozegrane_mecze` = `rozegrane_mecze`+1,
        `la_liga`.`bramki_stracone` = `bramki_stracone`+NEW.`bramki_z2`,
        `la_liga`.`bramki_strzelone` = `bramki_strzelone`+NEW.`bramki_z1`,
        `la_liga`.`bilans_bramkowy` = `bilans_bramkowy`+(NEW.`bramki_z1`-NEW.`bramki_z2`),
        `la_liga`.`punkty` = `punkty`+punktyZ1
        WHERE `la_liga`.`ID_zespolu`=NEW.`zespol1`;
        UPDATE `la_liga`
        SET `la_liga`.`rozegrane_mecze` = `rozegrane_mecze`+1,
        `la_liga`.`bramki_stracone` = `bramki_stracone`+NEW.`bramki_z1`,
        `la_liga`.`bramki_strzelone` = `bramki_strzelone`+NEW.`bramki_z2`,
        `la_liga`.`bilans_bramkowy` = `bilans_bramkowy`+(NEW.`bramki_z2`-NEW.`bramki_z1`),
        `la_liga`.`punkty` = `punkty`+punktyZ2
        WHERE `la_liga`.`ID_zespolu`=NEW.`zespol2`;
    ELSEIF NEW.`rozgrywki`='Serie A' THEN
    	UPDATE `serie_a`
        SET `serie_a`.`rozegrane_mecze` = `rozegrane_mecze`+1,
        `serie_a`.`bramki_stracone` = `bramki_stracone`+NEW.`bramki_z2`,
        `serie_a`.`bramki_strzelone` = `bramki_strzelone`+NEW.`bramki_z1`,
        `serie_a`.`bilans_bramkowy` = `bilans_bramkowy`+(NEW.`bramki_z1`-NEW.`bramki_z2`),
        `serie_a`.`punkty` = `punkty`+punktyZ1
        WHERE `serie_a`.`ID_zespolu`=NEW.`zespol1`;
        UPDATE `serie_a`
        SET `serie_a`.`rozegrane_mecze` = `rozegrane_mecze`+1,
        `serie_a`.`bramki_stracone` = `bramki_stracone`+NEW.`bramki_z1`,
        `serie_a`.`bramki_strzelone` = `bramki_strzelone`+NEW.`bramki_z2`,
        `serie_a`.`bilans_bramkowy` = `bilans_bramkowy`+(NEW.`bramki_z2`-NEW.`bramki_z1`),
        `serie_a`.`punkty` = `punkty`+punktyZ2
        WHERE `serie_a`.`ID_zespolu`=NEW.`zespol2`;
    ELSEIF NEW.`rozgrywki`='Premier Leauge' THEN
    	UPDATE `premier_leauge`
        SET `premier_leauge`.`rozegrane_mecze` = `rozegrane_mecze`+1,
        `premier_leauge`.`bramki_stracone` = `bramki_stracone`+NEW.`bramki_z2`,
        `premier_leauge`.`bramki_strzelone` = `bramki_strzelone`+NEW.`bramki_z1`,
        `premier_leauge`.`bilans_bramkowy` = `bilans_bramkowy`+(NEW.`bramki_z1`-NEW.`bramki_z2`),
        `premier_leauge`.`punkty` = `punkty`+punktyZ1
        WHERE `premier_leauge`.`ID_zespolu`=NEW.`zespol1`;
        UPDATE `premier_leauge`
        SET `premier_leauge`.`rozegrane_mecze` = `rozegrane_mecze`+1,
        `premier_leauge`.`bramki_stracone` = `bramki_stracone`+NEW.`bramki_z1`,
        `premier_leauge`.`bramki_strzelone` = `bramki_strzelone`+NEW.`bramki_z2`,
        `premier_leauge`.`bilans_bramkowy` = `bilans_bramkowy`+(NEW.`bramki_z2`-NEW.`bramki_z1`),
        `premier_leauge`.`punkty` = `punkty`+punktyZ2
        WHERE `premier_leauge`.`ID_zespolu`=NEW.`zespol2`;
    END IF;
    
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mecze_abstrakcyjne`
--

CREATE TABLE `mecze_abstrakcyjne` (
  `id_meczy` int(11) NOT NULL,
  `data` date DEFAULT NULL,
  `zespol1` int(11) NOT NULL,
  `bramki_z1` int(11) NOT NULL,
  `bramki_z2` int(11) NOT NULL,
  `zespol2` int(11) NOT NULL,
  `rozgrywki` varchar(30) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `mecze_abstrakcyjne`
--

INSERT INTO `mecze_abstrakcyjne` (`id_meczy`, `data`, `zespol1`, `bramki_z1`, `bramki_z2`, `zespol2`, `rozgrywki`) VALUES
(1, '2018-01-01', 2, 4, 2, 6, 'test_leauge'),
(2, '2018-01-12', 6, 2, 3, 14, 'test_leauge'),
(3, '2018-01-12', 75, 3, 1, 103, 'test2_leauge');

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `podv_mecze`
-- (See below for the actual view)
--
CREATE TABLE `podv_mecze` (
`data` date
,`nazwa` varchar(50)
,`bramki_z1` int(11)
,`bramki_z2` int(11)
,`zespol2` int(11)
,`rozgrywki` varchar(30)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `podv_mecze_abstrakcyjne`
-- (See below for the actual view)
--
CREATE TABLE `podv_mecze_abstrakcyjne` (
`data` date
,`nazwa` varchar(50)
,`bramki_z1` int(11)
,`bramki_z2` int(11)
,`zespol2` int(11)
,`rozgrywki` varchar(30)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `premier_leauge`
--

CREATE TABLE `premier_leauge` (
  `ID_zespolu` int(11) NOT NULL,
  `rozegrane_mecze` int(11) NOT NULL,
  `bramki_stracone` int(11) NOT NULL,
  `bramki_strzelone` int(11) NOT NULL,
  `bilans_bramkowy` int(11) NOT NULL,
  `punkty` int(11) NOT NULL,
  `pozycja_w_tabeli` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `premier_leauge`
--

INSERT INTO `premier_leauge` (`ID_zespolu`, `rozegrane_mecze`, `bramki_stracone`, `bramki_strzelone`, `bilans_bramkowy`, `punkty`, `pozycja_w_tabeli`) VALUES
(95, 0, 0, 0, 0, 0, 1),
(96, 0, 0, 0, 0, 0, 12),
(97, 0, 0, 0, 0, 0, 13),
(98, 0, 0, 0, 0, 0, 14),
(99, 0, 0, 0, 0, 0, 15),
(100, 0, 0, 0, 0, 0, 16),
(101, 0, 0, 0, 0, 0, 17),
(102, 0, 0, 0, 0, 0, 18),
(103, 0, 0, 0, 0, 0, 19),
(104, 0, 0, 0, 0, 0, 11),
(105, 0, 0, 0, 0, 0, 10),
(106, 0, 0, 0, 0, 0, 2),
(107, 0, 0, 0, 0, 0, 3),
(108, 0, 0, 0, 0, 0, 4),
(109, 0, 0, 0, 0, 0, 5),
(110, 0, 0, 0, 0, 0, 6),
(111, 0, 0, 0, 0, 0, 7),
(112, 0, 0, 0, 0, 0, 8),
(113, 0, 0, 0, 0, 0, 9),
(114, 0, 0, 0, 0, 0, 20);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `serie_a`
--

CREATE TABLE `serie_a` (
  `ID_zespolu` int(11) NOT NULL,
  `rozegrane_mecze` int(11) NOT NULL,
  `bramki_stracone` int(11) NOT NULL,
  `bramki_strzelone` int(11) NOT NULL,
  `bilans_bramkowy` int(11) NOT NULL,
  `punkty` int(11) NOT NULL,
  `pozycja_w_tabeli` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `serie_a`
--

INSERT INTO `serie_a` (`ID_zespolu`, `rozegrane_mecze`, `bramki_stracone`, `bramki_strzelone`, `bilans_bramkowy`, `punkty`, `pozycja_w_tabeli`) VALUES
(75, 0, 0, 0, 0, 0, 1),
(76, 0, 0, 0, 0, 0, 12),
(77, 0, 0, 0, 0, 0, 13),
(78, 0, 0, 0, 0, 0, 14),
(79, 0, 0, 0, 0, 0, 15),
(80, 0, 0, 0, 0, 0, 16),
(81, 0, 0, 0, 0, 0, 17),
(82, 0, 0, 0, 0, 0, 18),
(83, 0, 0, 0, 0, 0, 19),
(84, 0, 0, 0, 0, 0, 11),
(85, 0, 0, 0, 0, 0, 10),
(86, 0, 0, 0, 0, 0, 2),
(87, 0, 0, 0, 0, 0, 3),
(88, 0, 0, 0, 0, 0, 4),
(89, 0, 0, 0, 0, 0, 5),
(90, 0, 0, 0, 0, 0, 6),
(91, 0, 0, 0, 0, 0, 7),
(92, 0, 0, 0, 0, 0, 8),
(93, 0, 0, 0, 0, 0, 9),
(94, 0, 0, 0, 0, 0, 20);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `stadiony`
--

CREATE TABLE `stadiony` (
  `ID` int(11) NOT NULL,
  `nazwa` varchar(50) COLLATE utf8_polish_ci NOT NULL,
  `adres` varchar(50) COLLATE utf8_polish_ci NOT NULL,
  `ilosc_miejsc` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `stadiony`
--

INSERT INTO `stadiony` (`ID`, `nazwa`, `adres`, `ilosc_miejsc`) VALUES
(1, 'Celtic Magen', 'Umis 89', 78327),
(2, 'Emirates Arena', 'Le Lasa 2', 80830),
(3, 'Ellis Trafford', 'Sely 1', 11477),
(4, 'Alianz Azteca', 'Lazienkowska 4', 51619),
(5, 'Croke Azadi', 'Abaci 1', 76913),
(6, 'Ellis Stadium', 'zamkowa 7', 9177),
(7, 'Anfield de France', 'Football street 1', 69330),
(8, 'Camp Nou Azteca', 'Sely 1', 31380),
(9, 'Stamford da Luz', 'Dolling street 9', 36474),
(10, 'Camp Nou da Luz', 'Le Lasa 2', 25149),
(11, 'Stamford Field', 'Mundo 4', 56030),
(12, 'Celtic La Costa', 'Ksasae 1', 71632),
(13, 'Rose da Luz', 'Football street 1', 76520),
(14, 'Croke Azis', 'Abaci 1', 44564),
(15, 'Anfield Karno', 'Umis 89', 52730),
(16, 'Imtech Field', 'Abbanad 3', 77643),
(17, 'Maracana Field', 'Football street 1', 39617),
(18, 'Abuja Magen', 'Sely 1', 6523),
(19, 'Stamford Arena', 'Ceselina 9', 61158),
(20, 'Imtech Magen', 'Umis 89', 17787),
(21, ' San Amisto', 'Agawning 9', 53614),
(22, 'Anfield Field', 'Umis 89', 5517),
(23, 'Emirates Karno', 'Le Lasa 2', 12988),
(24, 'Santiago Bernabeu Azteca', 'Ceselina 9', 13657),
(25, ' San Siro', 'Football street 1', 56215),
(26, 'Old Stadium', 'zamkowa 7', 11090),
(27, 'Reliant da Luz', 'Le Lasa 2', 5291),
(28, 'Imtech Azadi', 'Pariseal 5', 55558),
(29, 'Wembley Dageu', 'Galatery 4', 72459),
(30, ' San Bridge', 'Lazienkowska 4', 6664),
(31, 'Odi Azteca', 'Football street 1', 18385),
(32, 'Celtic Trafford', 'Le Lasa 2', 59490),
(33, 'Abuja Field', 'Le Lasa 2', 57069),
(34, 'Croke Stadium', 'Sely 1', 13501),
(35, 'Maracana Arena', 'Football street 1', 40813),
(36, 'Croke de Lima', 'Le Lasa 2', 23998),
(37, 'Reliant Azteca', 'Pariseal 5', 28283),
(38, 'Abuja Estadio', 'Abaci 1', 49966),
(39, 'Emirates de Lima', 'Le Lasa 2', 12406),
(40, 'Old Karno', 'Galatery 4', 28243),
(41, 'Maracana Azteca', 'zamkowa 7', 5657),
(42, 'Anfield Karnosky', 'zamkowa 7', 26249),
(43, 'Anfield Siro', 'Dolling street 9', 39853),
(44, 'Salt Lake da Luz', 'Abaci 1', 49255),
(45, 'Salt Lake Trafford', 'Sely 1', 16579),
(46, 'Imtech da Luz', 'Abaci 1', 69627),
(47, 'Pepsi Azadi', 'Abbanad 3', 56939),
(48, 'Celtic de France', 'Abbanad 3', 39963),
(49, 'Imtech de Lima', 'Sely 1', 13306),
(50, 'Santiago Bernabeu des Martys', 'Mundo 4', 44724),
(51, 'Alianz de Lima', 'Football street 1', 76254),
(52, 'Stamford Siro', 'Pariseal 5', 80418),
(53, 'Reliant de France', 'Umis 89', 17576),
(54, 'Pepsi de Lima', 'Pariseal 5', 54139),
(55, 'Emirates Anfield', 'Ceselina 9', 34352),
(56, 'Camp Nou Magen', 'Ksasae 1', 70235),
(57, 'Celtic Azis', 'Football street 1', 62985),
(58, 'Stamford Arena', 'Pariseal 5', 6232),
(59, ' San Estadio', 'Agawning 9', 50463),
(60, ' San Sun', 'Dolling street 9', 35263),
(61, 'Croke La Costa', 'Dolling street 9', 62766),
(62, 'Rose Arena', 'Abbanad 3', 47795),
(63, 'Anfield de Polonia', 'Galatery 4', 7224),
(64, 'Salt Lake Siro', 'Sely 1', 25198),
(65, 'Ellis Trafford Arena', 'Ceselina 9', 42853),
(66, 'Croke Amisto', 'Ceselina 9', 8428),
(67, 'Wembley Field', 'zamkowa 7', 75308),
(68, 'Stamford Dageuon', 'Ceselina 9', 75610),
(69, 'Stamford Stadium', 'Galatery 4', 71096),
(70, 'Rose Dageu', 'Umis 89', 76515),
(71, ' San de France', 'zamkowa 7', 79269),
(72, 'Croke Siro', 'Abaci 1', 56829),
(73, 'Celtic Bridge', 'Ksasae 1', 61981),
(74, 'Santiago Bernabeu Bridge', 'Agawning 9', 11272),
(75, 'Maracana Siro', 'Umis 89', 69505),
(76, 'Stamford de France', 'Sely 1', 81293),
(77, 'Emirates Siro', 'Umis 89', 8290),
(78, 'Imtech  Jaili', 'Pariseal 5', 72463),
(79, 'Imtech des Martys', 'Le Lasa 2', 32780),
(80, 'Reliant Stadium', 'Ksasae 1', 49107),
(81, 'Wembley  Jaili', 'Mundo 4', 9370),
(82, ' San  Jaili', 'Abaci 1', 81061),
(83, 'Emirates Dageu', 'Dolling street 9', 45963),
(84, 'Salt Lake des Martys', 'Abaci 1', 46914),
(85, 'Odi Field', 'Sely 1', 6395),
(86, 'Salt Lake Estadio', 'Lazienkowska 4', 76135),
(87, 'Abuja  Jaili', 'Dolling street 9', 22903),
(88, 'Emirates de France', 'Lazienkowska 4', 61170),
(89, 'Rose Trafford', 'Pariseal 5', 13532),
(90, ' San Dageu', 'Agawning 9', 8028),
(91, 'Abuja Azadi', 'zamkowa 7', 66946),
(92, 'Emirates Field', 'Abbanad 3', 83284),
(93, 'Anfield Pepsi', 'Football street 1', 56114),
(94, ' San Karno', 'Mundo 4', 16445),
(95, 'Wembley  Jailis', 'Abbanad 3', 73271),
(96, 'Emirates Siron', 'zamkowa 7', 76609),
(97, 'Wembley des Martys', 'Le Lasa 2', 62915),
(98, 'Odi Karno', 'Dolling street 9', 82958),
(99, 'Odi Trafford', 'Dolling street 9', 43062),
(100, 'Stamford Arena Pepsi', 'Pariseal 5', 82943),
(101, 'Camp Nou Field', 'Dolling street 9', 19981),
(102, 'Old des Martys', 'Umis 89', 6247),
(103, 'Stamford Dageu', 'Umis 89', 40535),
(104, ' San Azis', 'Abbanad 3', 48658),
(105, 'Old Bridge', 'Lazienkowska 4', 47206),
(106, 'Maracana Azis', 'Mundo 4', 29124),
(107, 'Ellis Azis', 'Dolling street 9', 20112),
(108, 'Pepsi des Martys', 'Mundo 4', 47910),
(109, 'Imtech Siro', 'Dolling street 9', 28847),
(110, 'Ellis Amisto', 'Agawning 9', 67138),
(111, 'Pepsi Karno', 'Le Lasa 2', 71380),
(112, 'Anfield Dageu', 'zamkowa 7', 83656),
(113, 'Reliant Stadiumen', 'Dolling street 9', 16724),
(114, 'Salt Lake Siro San', 'Le Lasa 2', 51688);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `test2_leauge`
--

CREATE TABLE `test2_leauge` (
  `ID_zespolu` int(11) NOT NULL,
  `rozegrane_mecze` int(11) NOT NULL,
  `bramki_stracone` int(11) NOT NULL,
  `bramki_strzelone` int(11) NOT NULL,
  `bilans_bramkowy` int(11) NOT NULL,
  `punkty` int(11) NOT NULL,
  `pozycja_w_tabeli` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `test2_leauge`
--

INSERT INTO `test2_leauge` (`ID_zespolu`, `rozegrane_mecze`, `bramki_stracone`, `bramki_strzelone`, `bilans_bramkowy`, `punkty`, `pozycja_w_tabeli`) VALUES
(103, 1, -3, 1, -2, 0, 2),
(75, 1, -1, 3, 2, 3, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `test_leauge`
--

CREATE TABLE `test_leauge` (
  `ID_zespolu` int(11) NOT NULL,
  `rozegrane_mecze` int(11) NOT NULL,
  `bramki_stracone` int(11) NOT NULL,
  `bramki_strzelone` int(11) NOT NULL,
  `bilans_bramkowy` int(11) NOT NULL,
  `punkty` int(11) NOT NULL,
  `pozycja_w_tabeli` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `test_leauge`
--

INSERT INTO `test_leauge` (`ID_zespolu`, `rozegrane_mecze`, `bramki_stracone`, `bramki_strzelone`, `bilans_bramkowy`, `punkty`, `pozycja_w_tabeli`) VALUES
(2, 8, -9, 6, -3, 8, 3),
(6, 20, -42, 19, -23, 12, 2),
(11, 5, -9, 6, -3, 4, 4),
(14, 10, -10, 28, 18, 25, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uzytkownicy`
--

CREATE TABLE `uzytkownicy` (
  `login` varchar(20) COLLATE utf8_polish_ci NOT NULL,
  `haslo` char(50) COLLATE utf8_polish_ci NOT NULL,
  `poziom_dostepu` int(11) NOT NULL DEFAULT '1',
  `wlasna_liga` varchar(30) COLLATE utf8_polish_ci DEFAULT NULL,
  `ulubiony_zespol` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `uzytkownicy`
--

INSERT INTO `uzytkownicy` (`login`, `haslo`, `poziom_dostepu`, `wlasna_liga`, `ulubiony_zespol`) VALUES
('', 'c6d64e4aa786d4649304e860029534a8', 0, NULL, NULL),
('admin', '9ce82f90f072665240042ad2f5b53ff3', 2, NULL, NULL),
('test', 'testpass', 1, 'test_leauge', 103),
('test2', 'test2pass', 1, 'test2_leauge', NULL),
('test3', '5c1bc694affa714f0e0ea5cac384e775', 0, NULL, NULL);

--
-- Wyzwalacze `uzytkownicy`
--
DELIMITER $$
CREATE TRIGGER `sprawdzaniePoprawnosciLoginu` BEFORE INSERT ON `uzytkownicy` FOR EACH ROW BEGIN
    	DECLARE powtorka varchar(50);
        SET powtorka = (SELECT uzytkownicy.login FROM uzytkownicy WHERE uzytkownicy.login=NEW.login);
        IF powtorka IS NOT null THEN 
        	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: Taki login juz istnieje';
        END IF ;
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `v_bundesliga`
-- (See below for the actual view)
--
CREATE TABLE `v_bundesliga` (
`pozycja_w_tabeli` int(11)
,`nazwa` varchar(50)
,`rozegrane_mecze` int(11)
,`bramki_stracone` int(11)
,`bramki_strzelone` int(11)
,`bilans_bramkowy` int(11)
,`punkty` int(11)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `v_ekstraklasa`
-- (See below for the actual view)
--
CREATE TABLE `v_ekstraklasa` (
`pozycja_w_tabeli` int(11)
,`nazwa` varchar(50)
,`rozegrane_mecze` int(11)
,`bramki_stracone` int(11)
,`bramki_strzelone` int(11)
,`bilans_bramkowy` int(11)
,`punkty` int(11)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `v_la_liga`
-- (See below for the actual view)
--
CREATE TABLE `v_la_liga` (
`pozycja_w_tabeli` int(11)
,`nazwa` varchar(50)
,`rozegrane_mecze` int(11)
,`bramki_stracone` int(11)
,`bramki_strzelone` int(11)
,`bilans_bramkowy` int(11)
,`punkty` int(11)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `v_ligue_1`
-- (See below for the actual view)
--
CREATE TABLE `v_ligue_1` (
`pozycja_w_tabeli` int(11)
,`nazwa` varchar(50)
,`rozegrane_mecze` int(11)
,`bramki_stracone` int(11)
,`bramki_strzelone` int(11)
,`bilans_bramkowy` int(11)
,`punkty` int(11)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `v_mecze`
-- (See below for the actual view)
--
CREATE TABLE `v_mecze` (
`data` date
,`nazwa` varchar(50)
,`bramki_z1` int(11)
,`bramki_z2` int(11)
,`nazwa 2` varchar(50)
,`rozgrywki` varchar(30)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `v_mecze_abstrakcyjne`
-- (See below for the actual view)
--
CREATE TABLE `v_mecze_abstrakcyjne` (
`data` date
,`nazwa` varchar(50)
,`bramki_z1` int(11)
,`bramki_z2` int(11)
,`nazwa 2` varchar(50)
,`rozgrywki` varchar(30)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `v_premier_leauge`
-- (See below for the actual view)
--
CREATE TABLE `v_premier_leauge` (
`pozycja_w_tabeli` int(11)
,`nazwa` varchar(50)
,`rozegrane_mecze` int(11)
,`bramki_stracone` int(11)
,`bramki_strzelone` int(11)
,`bilans_bramkowy` int(11)
,`punkty` int(11)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `v_serie_a`
-- (See below for the actual view)
--
CREATE TABLE `v_serie_a` (
`pozycja_w_tabeli` int(11)
,`nazwa` varchar(50)
,`rozegrane_mecze` int(11)
,`bramki_stracone` int(11)
,`bramki_strzelone` int(11)
,`bilans_bramkowy` int(11)
,`punkty` int(11)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `v_test2_leauge`
-- (See below for the actual view)
--
CREATE TABLE `v_test2_leauge` (
`pozycja_w_tabeli` int(11)
,`nazwa` varchar(50)
,`rozegrane_mecze` int(11)
,`bramki_stracone` int(11)
,`bramki_strzelone` int(11)
,`bilans_bramkowy` int(11)
,`punkty` int(11)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `v_test_leauge`
-- (See below for the actual view)
--
CREATE TABLE `v_test_leauge` (
`pozycja_w_tabeli` int(11)
,`nazwa` varchar(50)
,`rozegrane_mecze` int(11)
,`bramki_stracone` int(11)
,`bramki_strzelone` int(11)
,`bilans_bramkowy` int(11)
,`punkty` int(11)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `zespoly`
--

CREATE TABLE `zespoly` (
  `ID` int(11) NOT NULL,
  `nazwa` varchar(50) COLLATE utf8_polish_ci NOT NULL,
  `mijescowosc` varchar(50) COLLATE utf8_polish_ci NOT NULL,
  `stadion` int(11) NOT NULL,
  `liga` varchar(50) COLLATE utf8_polish_ci NOT NULL,
  `trener` varchar(50) COLLATE utf8_polish_ci NOT NULL,
  `barwy` varchar(50) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `zespoly`
--

INSERT INTO `zespoly` (`ID`, `nazwa`, `mijescowosc`, `stadion`, `liga`, `trener`, `barwy`) VALUES
(1, 'Benfica Dortmund', 'Dortmund', 1, 'Ligue 1', 'Diego Martio', 'Fioletowe'),
(2, 'Juventus Donieck', 'Donieck', 2, 'Ligue 1', 'Enderson Jesus', 'Granatowo-czarne'),
(3, 'Szachtar Lizbona', 'Lizbona', 3, 'Ligue 1', 'Adam Conte', 'Zlote'),
(4, 'Olympique Donieck', 'Donieck', 4, 'Ligue 1', 'Unai Benitez', 'Bialo-czerwone'),
(5, 'Szachtar Donieck', 'Donieck', 5, 'Ligue 1', 'Laurent Ancelotti', 'Granatowo-czarne'),
(6, 'City Katowice', 'Dortmund', 6, 'Ligue 1', 'Antonio Conte', 'Seledynowe'),
(7, 'Podbeskidzie Mediolan', 'Mediolan', 7, 'Ligue 1', 'Adam Ancelotti', 'Bialo-czerwone'),
(8, 'United Paryz', 'Paryz', 8, 'Ligue 1', 'Manuel Di Matteo', 'Ciemno-niebieskie'),
(9, 'United London', 'London', 9, 'Ligue 1', 'Roberto Benitez', 'Seledynowe'),
(10, 'Juventus Brimingham', 'Brimingham', 10, 'Ligue 1', 'Diego Klopp', 'Czerwone'),
(11, 'Lazio Rzym', 'Rzym', 11, 'Ligue 1', 'Manuel Emery', 'Zolte'),
(12, 'Celtia Dortmund', 'Dortmund', 12, 'Ligue 1', 'Antonio Guardiola', 'Granatowo-czarne'),
(13, 'FC Rzym', 'Rzym', 13, 'Ligue 1', 'Gerardo Conte', 'Zlote'),
(14, 'Slask Madryt', 'Madryt', 14, 'Ligue 1', 'Gerardo Conte', 'Biale'),
(15, 'Anderlacht Brimingham', 'Brimingham', 15, 'Ligue 1', 'Arsene Simeone', 'Czerwone'),
(16, 'Ajax Rzym', 'Rzym', 16, 'Ligue 1', 'Diego Martio', 'Zolto-zielone'),
(17, 'Real Wroclaw', 'Wroclaw', 17, 'Ligue 1', 'Yupp Benitez', 'Zielone'),
(18, 'Bayer Brimingham', 'Brimingham', 18, 'Ligue 1', 'Enderson Lenczyk', 'Zolto-zielone'),
(19, 'Celtia Amsterdam', 'Amsterdam', 19, 'Ligue 1', 'Jorge Jesus', 'Zielone'),
(20, 'Inter Mediolan', 'Mediolan', 20, 'Ligue 1', 'Gerardo Henckes', 'Bialo-czerwone'),
(21, 'Celtic Zagrzeb', 'Zagrzeb', 21, 'Ekstraklasa', 'Pep Guardiola', 'Niebiesko-zolte'),
(22, 'Slask Manchester', 'Manchester', 22, 'Ekstraklasa', 'Jose Wenger', 'Bialo-czerwone'),
(23, 'Celtia Brimingham', 'Brimingham', 23, 'Ekstraklasa', 'Arsene Benitez', 'Czerwone'),
(24, 'Atletico Donieck', 'Donieck', 24, 'Ekstraklasa', 'Carlo Urban', 'Zolto-zielone'),
(25, 'Ajax Monaco', 'Monaco', 25, 'Ekstraklasa', 'Adam Di Matteo', 'Niebiesko-zolte'),
(26, 'Bayer Donieck', 'Donieck', 26, 'Ekstraklasa', 'Roberto Moreira', 'Biale'),
(27, 'Real Paryz', 'Paryz', 27, 'Ekstraklasa', 'Gerardo Henckes', 'Granatowo-czarne'),
(28, 'Chelsea Paryz', 'Paryz', 28, 'Ekstraklasa', 'Jurgen Conte', 'Rozowe'),
(29, 'United Rzym', 'Rzym', 29, 'Ekstraklasa', 'Jan Ancelotti', 'Biale'),
(30, 'Bayern Donieck', 'Donieck', 30, 'Ekstraklasa', 'Manuel Henckes', 'Zielone'),
(31, 'Ajax Madryt', 'Madryt', 31, 'Ekstraklasa', 'Enderson Henckes', 'Srebrne'),
(32, 'Borrusia Rzym', 'Rzym', 32, 'Ekstraklasa', 'Unai Conte', 'Niebiesko-zolte'),
(33, 'FC Mediolan', 'Mediolan', 33, 'Ekstraklasa', 'Roberto Benitez', 'Seledynowe'),
(34, 'Anderlacht Dortmund', 'Dortmund', 34, 'Ekstraklasa', 'Manuel Wenger', 'Rozowe'),
(35, 'United Brimingham', 'Brimingham', 35, 'Ekstraklasa', 'Orest Simeone', 'Seledynowe'),
(36, 'Bayern Monachium', 'Monachium', 36, 'Ekstraklasa', 'Jan Pellergini', 'Srebrne'),
(37, 'AC Monachium', 'Monachium', 37, 'Bundesliga', 'Yupp Lenczyk', 'Bialo-czerwone'),
(38, 'Benfica Monaco', 'Monaco', 38, 'Bundesliga', 'Jorge Emery', 'Niebieskie'),
(39, 'FC Barcelona', 'Barcelona', 39, 'Bundesliga', 'Marcelo Simeone', 'Zolte'),
(40, 'Celtic Brimingham', 'Brimingham', 40, 'Bundesliga', 'Orest Wenger', 'Bialo-czerwone'),
(41, 'Borrusia Dortmund', 'Dortmund', 41, 'Bundesliga', 'Rafael Wenger', 'Srebrne'),
(42, 'Real Glasgow', 'Glasgow', 42, 'Bundesliga', 'Rafael Nawalka', 'Fioletowe'),
(43, 'Borrusia Liverpool', 'Liverpool', 43, 'Bundesliga', 'Diego Urban', 'Fioletowe'),
(44, 'Bayern Paryz', 'Paryz', 44, 'Bundesliga', 'Arsene Mourinho', 'Zielone'),
(45, 'Celtic Donieck', 'Donieck', 45, 'Bundesliga', 'Laurent Martio', 'Rozowe'),
(46, 'Ajax Warszawa', 'Warszawa', 46, 'Bundesliga', 'Jan Emery', 'Niebiesko-zolte'),
(47, 'AC Rzym', 'Rzym', 47, 'Bundesliga', 'Roberto Nawalka', 'Srebrne'),
(48, 'Inter Liverpool', 'Liverpool', 48, 'Bundesliga', 'Adam Mourinho', 'Zlote'),
(49, 'Crystal Mediolan', 'Mediolan', 49, 'Bundesliga', 'Adam Di Matteo', 'Zlote'),
(50, 'Atletico Amsterdam', 'Amsterdam', 50, 'Bundesliga', 'Marcelo Wenger', 'Zolto-zielone'),
(51, 'Anderlacht Sevilla', 'Sevilla', 51, 'Bundesliga', 'Marcelo Guardiola', 'Zlote'),
(52, 'Celtia Wroclaw', 'Wroclaw', 52, 'Bundesliga', 'Diego Guardiola', 'Biale'),
(53, 'Bayern Brimingham', 'Brimingham', 53, 'Bundesliga', 'Jurgen Benitez', 'Fioletowe'),
(54, 'Wisła Amsterdam', 'Amsterdam', 54, 'Bundesliga', 'Roberto Wenger', 'Czerwone'),
(55, 'Slask Mediolan', 'Mediolan', 55, 'La Liga', 'Rafael Conte', 'Srebrne'),
(56, 'FC Madryt', 'Madryt', 56, 'La Liga', 'Unai Henckes', 'Zlote'),
(57, 'Bayern Manchester', 'Manchester', 57, 'La Liga', 'Carlo Henckes', 'Zolto-zielone'),
(58, 'Ajax Brimingham', 'Brimingham', 58, 'La Liga', 'Arsene Emery', 'Niebieskie'),
(59, 'Real Barcelona', 'Barcelona', 59, 'La Liga', 'Roberto Lenczyk', 'Zolto-zielone'),
(60, 'Crystal Sevilla', 'Sevilla', 60, 'La Liga', 'Jorge Lenczyk', 'Fioletowe'),
(61, 'HSV Monachium', 'Monachium', 61, 'La Liga', 'Carlo Martio', 'Seledynowe'),
(62, 'United Mediolan', 'Mediolan', 62, 'La Liga', 'Manuel Urban', 'Zielone'),
(63, 'Celtic Glasgow', 'Glasgow', 63, 'La Liga', 'Enderson Klopp', 'Bialo-czerwone'),
(64, 'AC Barcelona', 'Barcelona', 64, 'La Liga', 'Manuel Guardiola', 'Ciemno-niebieskie'),
(65, 'Celtic Sevilla', 'Sevilla', 65, 'La Liga', 'Unai Wenger', 'Zlote'),
(66, 'Atletico Manchester', 'Manchester', 66, 'La Liga', 'Roberto Jesus', 'Fioletowe'),
(67, 'Benfica Lizbona', 'Lizbona', 67, 'La Liga', 'Rafael Simeone', 'Srebrne'),
(68, 'FC Wroclaw', 'Wroclaw', 68, 'La Liga', 'Adam Lenczyk', 'Niebieskie'),
(69, 'Szachtar Liverpool', 'Liverpool', 69, 'La Liga', 'Carlo Lenczyk', 'Ciemno-niebieskie'),
(70, 'Szachtar Dortmund', 'Dortmund', 70, 'La Liga', 'Unai Conte', 'Niebieskie'),
(71, 'Crystal Glasgow', 'Glasgow', 71, 'La Liga', 'Enderson Mourinho', 'Rozowe'),
(72, 'Ajax Donieck', 'Donieck', 72, 'La Liga', 'Jurgen Pellergini', 'Ciemno-niebieskie'),
(73, 'Celtia Donieck', 'Donieck', 73, 'La Liga', 'Jan Simeone', 'Zlote'),
(74, 'Celtic Wroclaw', 'Wroclaw', 74, 'La Liga', 'Unai Urban', 'Ciemno-niebieskie'),
(75, 'Slask Paryz', 'Paryz', 75, 'Serie A', 'Orest Guardiola', 'Biale'),
(76, 'Legia Dortmund', 'Dortmund', 76, 'Serie A', 'Adam Di Matteo', 'Bialo-czerwone'),
(77, 'City Dortmund', 'Dortmund', 77, 'Serie A', 'Roberto Ancelotti', 'Bialo-czerwone'),
(78, 'Hajduk Zagrzeb', 'Zagrzeb', 78, 'Serie A', 'Laurent Emery', 'Zielone'),
(79, 'Celtia Zagrzeb', 'Zagrzeb', 79, 'Serie A', 'Carlo Moreira', 'Zielone'),
(80, 'Borrusia Brimingham', 'Brimingham', 80, 'Serie A', 'Adam Guardiola', 'Niebiesko-zolte'),
(81, 'Borrusia Wroclaw', 'Wroclaw', 81, 'Serie A', 'Marcelo Martio', 'Zielone'),
(82, 'Chelsea Amsterdam', 'Amsterdam', 82, 'Serie A', 'Unai Henckes', 'Zlote'),
(83, 'Bayern Barcelona', 'Barcelona', 83, 'Serie A', 'Yupp Pellergini', 'Seledynowe'),
(84, 'AC Manchester', 'Manchester', 84, 'Serie A', 'Yupp Di Matteo', 'Fioletowe'),
(85, 'FC Zagrzeb', 'Zagrzeb', 85, 'Serie A', 'Jurgen Ancelotti', 'Granatowo-czarne'),
(86, 'Inter Donieck', 'Donieck', 86, 'Serie A', 'Jorge Mourinho', 'Rozowe'),
(87, 'Szachtar Warszawa', 'Warszawa', 87, 'Serie A', 'Pep Urban', 'Zolte'),
(88, 'Sporting Madryt', 'Madryt', 88, 'Serie A', 'Pep Henckes', 'Granatowo-czarne'),
(89, 'Bayern Glasgow', 'Glasgow', 89, 'Serie A', 'Pep Klopp', 'Fioletowe'),
(90, 'FC Monaco', 'Monaco', 90, 'Serie A', 'Jorge Jesus', 'Srebrne'),
(91, 'Inter Lizbona', 'Lizbona', 91, 'Serie A', 'Unai Moreira', 'Zolte'),
(92, 'Juventus Dortmund', 'Dortmund', 92, 'Serie A', 'Manuel Ancelotti', 'Zielone'),
(93, 'City Amsterdam', 'Amsterdam', 93, 'Serie A', 'Orest Mourinho', 'Zolto-zielone'),
(94, 'Atletico Mediolan', 'Mediolan', 94, 'Serie A', 'Orest Pellergini', 'Biale'),
(95, 'City Paryz', 'Paryz', 95, 'Premier Leauge', 'Roberto Jesus', 'Niebieskie'),
(96, 'City Sevilla', 'Sevilla', 96, 'Premier Leauge', 'Jose Emery', 'Czerwone'),
(97, 'Crystal Paryz', 'Paryz', 97, 'Premier Leauge', 'Jorge Lenczyk', 'Fioletowe'),
(98, 'Ajax Paryz', 'Paryz', 98, 'Premier Leauge', 'Carlo Ancelotti', 'Rozowe'),
(99, 'AC Monaco', 'Monaco', 99, 'Premier Leauge', 'Carlo Nawalka', 'Zielone'),
(100, 'United Liverpool', 'Liverpool', 100, 'Premier Leauge', 'Jose Henckes', 'Niebieskie'),
(101, 'AC Mediolan', 'Mediolan', 101, 'Premier Leauge', 'Marcelo Urban', 'Zielone'),
(102, 'Inter Madryt', 'Madryt', 102, 'Premier Leauge', 'Pep Di Matteo', 'Fioletowe'),
(103, 'Polonia Warszawa', 'Warszawa', 103, 'Premier Leauge', 'Adam Jesus', 'Granatowo-czarne'),
(104, 'FC Dortmund', 'Dortmund', 104, 'Premier Leauge', 'Antonio Benitez', 'Rozowe'),
(105, 'FC Monachium', 'Monachium', 105, 'Premier Leauge', 'Marcelo Simeone', 'Niebiesko-zolte'),
(106, 'Borrusia Glasgow', 'Glasgow', 106, 'Premier Leauge', 'Adam Emery', 'Niebieskie'),
(107, 'Juventus Monaco', 'Monaco', 107, 'Premier Leauge', 'Marcelo Henckes', 'Czerwone'),
(108, 'Crystal Warszawa', 'Warszawa', 108, 'Premier Leauge', 'Jan Wenger', 'Granatowo-czarne'),
(109, 'Benfica Zagrzeb', 'Zagrzeb', 109, 'Premier Leauge', 'Carlo Pellergini', 'Srebrne'),
(110, 'Anderlacht Madryt', 'Madryt', 110, 'Premier Leauge', 'Jose Mourinho', 'Zolte'),
(111, 'Anderlacht Wroclaw', 'Wroclaw', 111, 'Premier Leauge', 'Jorge Simeone', 'Zolto-zielone'),
(112, 'Atletico Monachium', 'Monachium', 112, 'Premier Leauge', 'Manuel Lenczyk', 'Zielone'),
(113, 'Amber Brimingham', 'Brimingham', 113, 'Premier Leauge', 'Rafael Jesus', 'Granatowo-czarne'),
(114, 'Slask Barcelona', 'Barcelona', 114, 'Premier Leauge', 'Yupp Martio', 'Seledynowe');

--
-- Wyzwalacze `zespoly`
--
DELIMITER $$
CREATE TRIGGER `zapobieganiePowtorekDruzyn` BEFORE INSERT ON `zespoly` FOR EACH ROW BEGIN
    	DECLARE powtorka varchar(50);
        SET powtorka = (SELECT zespoly.nazwa FROM zespoly WHERE zespoly.nazwa=NEW.nazwa);
        IF powtorka IS NOT null THEN 
        	SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'ERROR: Druzyna istnieje';
        END IF ;
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura widoku `podv_mecze`
--
DROP TABLE IF EXISTS `podv_mecze`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `podv_mecze`  AS  select `mecze`.`data` AS `data`,`zespoly`.`nazwa` AS `nazwa`,`mecze`.`bramki_z1` AS `bramki_z1`,`mecze`.`bramki_z2` AS `bramki_z2`,`mecze`.`zespol2` AS `zespol2`,`mecze`.`rozgrywki` AS `rozgrywki` from (`mecze` join `zespoly` on((`zespoly`.`ID` = `mecze`.`zespol1`))) ;

-- --------------------------------------------------------

--
-- Struktura widoku `podv_mecze_abstrakcyjne`
--
DROP TABLE IF EXISTS `podv_mecze_abstrakcyjne`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `podv_mecze_abstrakcyjne`  AS  select `mecze_abstrakcyjne`.`data` AS `data`,`zespoly`.`nazwa` AS `nazwa`,`mecze_abstrakcyjne`.`bramki_z1` AS `bramki_z1`,`mecze_abstrakcyjne`.`bramki_z2` AS `bramki_z2`,`mecze_abstrakcyjne`.`zespol2` AS `zespol2`,`mecze_abstrakcyjne`.`rozgrywki` AS `rozgrywki` from (`mecze_abstrakcyjne` join `zespoly` on((`zespoly`.`ID` = `mecze_abstrakcyjne`.`zespol1`))) ;

-- --------------------------------------------------------

--
-- Struktura widoku `v_bundesliga`
--
DROP TABLE IF EXISTS `v_bundesliga`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_bundesliga`  AS  select `bundesliga`.`pozycja_w_tabeli` AS `pozycja_w_tabeli`,`zespoly`.`nazwa` AS `nazwa`,`bundesliga`.`rozegrane_mecze` AS `rozegrane_mecze`,`bundesliga`.`bramki_stracone` AS `bramki_stracone`,`bundesliga`.`bramki_strzelone` AS `bramki_strzelone`,`bundesliga`.`bilans_bramkowy` AS `bilans_bramkowy`,`bundesliga`.`punkty` AS `punkty` from (`bundesliga` join `zespoly` on((`zespoly`.`ID` = `bundesliga`.`ID_zespolu`))) order by `bundesliga`.`pozycja_w_tabeli` ;

-- --------------------------------------------------------

--
-- Struktura widoku `v_ekstraklasa`
--
DROP TABLE IF EXISTS `v_ekstraklasa`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_ekstraklasa`  AS  select `ekstraklasa`.`pozycja_w_tabeli` AS `pozycja_w_tabeli`,`zespoly`.`nazwa` AS `nazwa`,`ekstraklasa`.`rozegrane_mecze` AS `rozegrane_mecze`,`ekstraklasa`.`bramki_stracone` AS `bramki_stracone`,`ekstraklasa`.`bramki_strzelone` AS `bramki_strzelone`,`ekstraklasa`.`bilans_bramkowy` AS `bilans_bramkowy`,`ekstraklasa`.`punkty` AS `punkty` from (`ekstraklasa` join `zespoly` on((`zespoly`.`ID` = `ekstraklasa`.`ID_zespolu`))) order by `ekstraklasa`.`pozycja_w_tabeli` ;

-- --------------------------------------------------------

--
-- Struktura widoku `v_la_liga`
--
DROP TABLE IF EXISTS `v_la_liga`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_la_liga`  AS  select `la_liga`.`pozycja_w_tabeli` AS `pozycja_w_tabeli`,`zespoly`.`nazwa` AS `nazwa`,`la_liga`.`rozegrane_mecze` AS `rozegrane_mecze`,`la_liga`.`bramki_stracone` AS `bramki_stracone`,`la_liga`.`bramki_strzelone` AS `bramki_strzelone`,`la_liga`.`bilans_bramkowy` AS `bilans_bramkowy`,`la_liga`.`punkty` AS `punkty` from (`la_liga` join `zespoly` on((`zespoly`.`ID` = `la_liga`.`ID_zespolu`))) order by `la_liga`.`pozycja_w_tabeli` ;

-- --------------------------------------------------------

--
-- Struktura widoku `v_ligue_1`
--
DROP TABLE IF EXISTS `v_ligue_1`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_ligue_1`  AS  select `ligue_1`.`pozycja_w_tabeli` AS `pozycja_w_tabeli`,`zespoly`.`nazwa` AS `nazwa`,`ligue_1`.`rozegrane_mecze` AS `rozegrane_mecze`,`ligue_1`.`bramki_stracone` AS `bramki_stracone`,`ligue_1`.`bramki_strzelone` AS `bramki_strzelone`,`ligue_1`.`bilans_bramkowy` AS `bilans_bramkowy`,`ligue_1`.`punkty` AS `punkty` from (`ligue_1` join `zespoly` on((`zespoly`.`ID` = `ligue_1`.`ID_zespolu`))) order by `ligue_1`.`pozycja_w_tabeli` ;

-- --------------------------------------------------------

--
-- Struktura widoku `v_mecze`
--
DROP TABLE IF EXISTS `v_mecze`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_mecze`  AS  select `z`.`data` AS `data`,`z`.`nazwa` AS `nazwa`,`z`.`bramki_z1` AS `bramki_z1`,`z`.`bramki_z2` AS `bramki_z2`,`zespoly`.`nazwa` AS `nazwa 2`,`z`.`rozgrywki` AS `rozgrywki` from (`zespoly` join `podv_mecze` `z` on((`z`.`zespol2` = `zespoly`.`ID`))) ;

-- --------------------------------------------------------

--
-- Struktura widoku `v_mecze_abstrakcyjne`
--
DROP TABLE IF EXISTS `v_mecze_abstrakcyjne`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_mecze_abstrakcyjne`  AS  select `z`.`data` AS `data`,`z`.`nazwa` AS `nazwa`,`z`.`bramki_z1` AS `bramki_z1`,`z`.`bramki_z2` AS `bramki_z2`,`zespoly`.`nazwa` AS `nazwa 2`,`z`.`rozgrywki` AS `rozgrywki` from (`zespoly` join `podv_mecze_abstrakcyjne` `z` on((`z`.`zespol2` = `zespoly`.`ID`))) ;

-- --------------------------------------------------------

--
-- Struktura widoku `v_premier_leauge`
--
DROP TABLE IF EXISTS `v_premier_leauge`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_premier_leauge`  AS  select `premier_leauge`.`pozycja_w_tabeli` AS `pozycja_w_tabeli`,`zespoly`.`nazwa` AS `nazwa`,`premier_leauge`.`rozegrane_mecze` AS `rozegrane_mecze`,`premier_leauge`.`bramki_stracone` AS `bramki_stracone`,`premier_leauge`.`bramki_strzelone` AS `bramki_strzelone`,`premier_leauge`.`bilans_bramkowy` AS `bilans_bramkowy`,`premier_leauge`.`punkty` AS `punkty` from (`premier_leauge` join `zespoly` on((`zespoly`.`ID` = `premier_leauge`.`ID_zespolu`))) order by `premier_leauge`.`pozycja_w_tabeli` ;

-- --------------------------------------------------------

--
-- Struktura widoku `v_serie_a`
--
DROP TABLE IF EXISTS `v_serie_a`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_serie_a`  AS  select `serie_a`.`pozycja_w_tabeli` AS `pozycja_w_tabeli`,`zespoly`.`nazwa` AS `nazwa`,`serie_a`.`rozegrane_mecze` AS `rozegrane_mecze`,`serie_a`.`bramki_stracone` AS `bramki_stracone`,`serie_a`.`bramki_strzelone` AS `bramki_strzelone`,`serie_a`.`bilans_bramkowy` AS `bilans_bramkowy`,`serie_a`.`punkty` AS `punkty` from (`serie_a` join `zespoly` on((`zespoly`.`ID` = `serie_a`.`ID_zespolu`))) order by `serie_a`.`pozycja_w_tabeli` ;

-- --------------------------------------------------------

--
-- Struktura widoku `v_test2_leauge`
--
DROP TABLE IF EXISTS `v_test2_leauge`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_test2_leauge`  AS  select `test2_leauge`.`pozycja_w_tabeli` AS `pozycja_w_tabeli`,`zespoly`.`nazwa` AS `nazwa`,`test2_leauge`.`rozegrane_mecze` AS `rozegrane_mecze`,`test2_leauge`.`bramki_stracone` AS `bramki_stracone`,`test2_leauge`.`bramki_strzelone` AS `bramki_strzelone`,`test2_leauge`.`bilans_bramkowy` AS `bilans_bramkowy`,`test2_leauge`.`punkty` AS `punkty` from (`test2_leauge` join `zespoly` on((`zespoly`.`ID` = `test2_leauge`.`ID_zespolu`))) order by `test2_leauge`.`pozycja_w_tabeli` ;

-- --------------------------------------------------------

--
-- Struktura widoku `v_test_leauge`
--
DROP TABLE IF EXISTS `v_test_leauge`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_test_leauge`  AS  select `test_leauge`.`pozycja_w_tabeli` AS `pozycja_w_tabeli`,`zespoly`.`nazwa` AS `nazwa`,`test_leauge`.`rozegrane_mecze` AS `rozegrane_mecze`,`test_leauge`.`bramki_stracone` AS `bramki_stracone`,`test_leauge`.`bramki_strzelone` AS `bramki_strzelone`,`test_leauge`.`bilans_bramkowy` AS `bilans_bramkowy`,`test_leauge`.`punkty` AS `punkty` from (`test_leauge` join `zespoly` on((`zespoly`.`ID` = `test_leauge`.`ID_zespolu`))) order by `test_leauge`.`pozycja_w_tabeli` ;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indexes for table `bundesliga`
--
ALTER TABLE `bundesliga`
  ADD PRIMARY KEY (`ID_zespolu`);

--
-- Indexes for table `ekstraklasa`
--
ALTER TABLE `ekstraklasa`
  ADD PRIMARY KEY (`ID_zespolu`);

--
-- Indexes for table `la_liga`
--
ALTER TABLE `la_liga`
  ADD PRIMARY KEY (`ID_zespolu`);

--
-- Indexes for table `ligue_1`
--
ALTER TABLE `ligue_1`
  ADD PRIMARY KEY (`ID_zespolu`);

--
-- Indexes for table `mecze`
--
ALTER TABLE `mecze`
  ADD PRIMARY KEY (`id_meczy`),
  ADD KEY `zespol1` (`zespol1`),
  ADD KEY `zespol2` (`zespol2`);

--
-- Indexes for table `mecze_abstrakcyjne`
--
ALTER TABLE `mecze_abstrakcyjne`
  ADD PRIMARY KEY (`id_meczy`),
  ADD KEY `zespol1` (`zespol1`),
  ADD KEY `zespol2` (`zespol2`);

--
-- Indexes for table `premier_leauge`
--
ALTER TABLE `premier_leauge`
  ADD PRIMARY KEY (`ID_zespolu`);

--
-- Indexes for table `serie_a`
--
ALTER TABLE `serie_a`
  ADD PRIMARY KEY (`ID_zespolu`);

--
-- Indexes for table `stadiony`
--
ALTER TABLE `stadiony`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `test2_leauge`
--
ALTER TABLE `test2_leauge`
  ADD KEY `ID_zespolu` (`ID_zespolu`);

--
-- Indexes for table `test_leauge`
--
ALTER TABLE `test_leauge`
  ADD KEY `ID_zespolu` (`ID_zespolu`);

--
-- Indexes for table `uzytkownicy`
--
ALTER TABLE `uzytkownicy`
  ADD PRIMARY KEY (`login`),
  ADD KEY `ulubiony_zespol` (`ulubiony_zespol`);

--
-- Indexes for table `zespoly`
--
ALTER TABLE `zespoly`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `stadion` (`stadion`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `bundesliga`
--
ALTER TABLE `bundesliga`
  MODIFY `ID_zespolu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT dla tabeli `ekstraklasa`
--
ALTER TABLE `ekstraklasa`
  MODIFY `ID_zespolu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT dla tabeli `la_liga`
--
ALTER TABLE `la_liga`
  MODIFY `ID_zespolu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT dla tabeli `ligue_1`
--
ALTER TABLE `ligue_1`
  MODIFY `ID_zespolu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT dla tabeli `mecze`
--
ALTER TABLE `mecze`
  MODIFY `id_meczy` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT dla tabeli `mecze_abstrakcyjne`
--
ALTER TABLE `mecze_abstrakcyjne`
  MODIFY `id_meczy` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT dla tabeli `premier_leauge`
--
ALTER TABLE `premier_leauge`
  MODIFY `ID_zespolu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;

--
-- AUTO_INCREMENT dla tabeli `serie_a`
--
ALTER TABLE `serie_a`
  MODIFY `ID_zespolu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=95;

--
-- AUTO_INCREMENT dla tabeli `stadiony`
--
ALTER TABLE `stadiony`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;

--
-- AUTO_INCREMENT dla tabeli `zespoly`
--
ALTER TABLE `zespoly`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `bundesliga`
--
ALTER TABLE `bundesliga`
  ADD CONSTRAINT `bundesliga_ibfk_1` FOREIGN KEY (`ID_zespolu`) REFERENCES `zespoly` (`ID`);

--
-- Ograniczenia dla tabeli `ekstraklasa`
--
ALTER TABLE `ekstraklasa`
  ADD CONSTRAINT `ekstraklasa_ibfk_1` FOREIGN KEY (`ID_zespolu`) REFERENCES `zespoly` (`ID`);

--
-- Ograniczenia dla tabeli `la_liga`
--
ALTER TABLE `la_liga`
  ADD CONSTRAINT `la_liga_ibfk_1` FOREIGN KEY (`ID_zespolu`) REFERENCES `zespoly` (`ID`);

--
-- Ograniczenia dla tabeli `ligue_1`
--
ALTER TABLE `ligue_1`
  ADD CONSTRAINT `ligue_1_ibfk_1` FOREIGN KEY (`ID_zespolu`) REFERENCES `zespoly` (`ID`);

--
-- Ograniczenia dla tabeli `mecze`
--
ALTER TABLE `mecze`
  ADD CONSTRAINT `mecze_ibfk_1` FOREIGN KEY (`zespol1`) REFERENCES `zespoly` (`ID`),
  ADD CONSTRAINT `zespol2` FOREIGN KEY (`zespol2`) REFERENCES `zespoly` (`ID`);

--
-- Ograniczenia dla tabeli `mecze_abstrakcyjne`
--
ALTER TABLE `mecze_abstrakcyjne`
  ADD CONSTRAINT `mecze_abstrakcyjne_ibfk_1` FOREIGN KEY (`zespol1`) REFERENCES `zespoly` (`ID`),
  ADD CONSTRAINT `mecze_abstrakcyjne_ibfk_2` FOREIGN KEY (`zespol2`) REFERENCES `zespoly` (`ID`);

--
-- Ograniczenia dla tabeli `premier_leauge`
--
ALTER TABLE `premier_leauge`
  ADD CONSTRAINT `premier_leauge_ibfk_1` FOREIGN KEY (`ID_zespolu`) REFERENCES `zespoly` (`ID`);

--
-- Ograniczenia dla tabeli `serie_a`
--
ALTER TABLE `serie_a`
  ADD CONSTRAINT `serie_a_ibfk_1` FOREIGN KEY (`ID_zespolu`) REFERENCES `zespoly` (`ID`);

--
-- Ograniczenia dla tabeli `test2_leauge`
--
ALTER TABLE `test2_leauge`
  ADD CONSTRAINT `test2_leauge_ibfk_1` FOREIGN KEY (`ID_zespolu`) REFERENCES `zespoly` (`ID`);

--
-- Ograniczenia dla tabeli `test_leauge`
--
ALTER TABLE `test_leauge`
  ADD CONSTRAINT `test_leauge_ibfk_1` FOREIGN KEY (`ID_zespolu`) REFERENCES `zespoly` (`ID`);

--
-- Ograniczenia dla tabeli `uzytkownicy`
--
ALTER TABLE `uzytkownicy`
  ADD CONSTRAINT `uzytkownicy_ibfk_1` FOREIGN KEY (`ulubiony_zespol`) REFERENCES `zespoly` (`ID`);

--
-- Ograniczenia dla tabeli `zespoly`
--
ALTER TABLE `zespoly`
  ADD CONSTRAINT `stadion` FOREIGN KEY (`stadion`) REFERENCES `stadiony` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
