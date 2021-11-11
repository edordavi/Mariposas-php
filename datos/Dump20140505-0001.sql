CREATE DATABASE  IF NOT EXISTS `Mariposas` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `Mariposas`;

SET foreign_key_checks=0;
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

INSERT INTO Coleccion (dni, fecha_inicial, precio_total) VALUES ('0801-1981-15489','1997-12-15 10:35:23',550.00),('0801-1985-12835','2014-05-05 03:05:00',150.00),('0806-1962-78954','1998-01-01 00:01:01',300.00);

INSERT INTO Coleccionada (especie, zona, fecha_captura, precio, dni) VALUES ('Adscita schmidti','La Tigra','2014-05-01 01:57:00',200.00,'0806-1962-78954'),('Ancylolomia aff tentaculella','La Tigra','2014-05-01 02:56:00',250.00,'0801-1981-15489'),('Adscita schmidti','UNAH','2014-05-02 02:03:00',150.00,'0801-1985-12835'),('Ancylolomia aff tentaculella','UNAH','2014-05-02 02:55:00',300.00,'0801-1981-15489'),('Agrotis trux','UNAH','2014-05-13 01:59:00',100.00,'0806-1962-78954');

INSERT INTO Ejemplar (zona, fecha_captura, especie, dni, tipo_ejemplar) VALUES ('La Tigra','2014-05-01 01:57:00','Adscita schmidti','0801-1981-15489','C'),('La Tigra','2014-05-01 02:56:00','Ancylolomia aff tentaculella','0806-1962-78954','C'),('UNAH','2014-05-01 01:58:00','Agrotis trux','0801-1981-15489','O'),('UNAH','2014-05-02 02:00:00','Agrotis trux','0801-1981-15489','O'),('UNAH','2014-05-02 02:03:00','Adscita schmidti','0806-1962-78954','C'),('UNAH','2014-05-02 02:55:00','Ancylolomia aff tentaculella','0806-1962-78954','C'),('UNAH','2014-05-13 01:59:00','Agrotis trux','0801-1981-15489','C');

INSERT INTO Especie (especie, nombre_cientifico, genero) VALUES ('Adscita schmidti','Adscita schmidti Naufock','Adscita'),('Agrotis trux','Agrotis trux Linnaeus','Agrotis'),('Ancylolomia aff tentaculella','Ancylolomia aff tentaculella (Hubner)','Ancylolomia');

INSERT INTO Familia (familia) VALUES ('Crambidae'),('Noctuidae'),('Nymphalidae'),('Zygaenidae');

INSERT INTO Genero (genero, familia) VALUES ('Ancylolomia','Crambidae'),('Agrotis','Noctuidae'),('Aglais','Nymphalidae'),('Adscita','Zygaenidae');

INSERT INTO Observada (especie, zona, fecha_captura, tiempo, observaciones) VALUES ('Agrotis trux','UNAH','2014-05-01 01:58:00',4,'Nada'),('Agrotis trux','UNAH','2014-05-02 02:00:00',3,'Nadas');

INSERT INTO Persona (dni, primer_nombre, primer_apellido, segundo_nombre, segundo_apellido) VALUES ('0801-1981-15489','Camilo','Castro','',''),('0801-1985-12835','Karla','Cortes',NULL,NULL),('0802-1978-45677','Carlos','Betancourt',NULL,NULL),('0806-1962-78954','Chuy','Barahona','','');

INSERT INTO Zona (zona, pais, region) VALUES ('Cerro Juana Lainez','Honduras','Tegucigalpa'),('El Picacho','Honduras','Francisco Morazan'),('La Granada','Honduras','Francisco Morazan'),('La Tigra','Honduras','Francisco Morazan'),('UNAH','Honduras','Tegucigalpa');

INSERT INTO ZonaEjemplar (especie, zona, nombre_comun) VALUES ('Adscita schmidti','La Tigra','Adita'),('Adscita schmidti','UNAH','Adita'),('Agrotis trux','UNAH','Trux'),('Ancylolomia aff tentaculella','Cerro Juana Lainez','Tentaculella'),('Ancylolomia aff tentaculella','La Tigra','Ancy'),('Ancylolomia aff tentaculella','UNAH','Ancy');
/*!50003 DROP PROCEDURE IF EXISTS sp_actualiza_coleccion */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_actualiza_coleccion(dni1 VARCHAR(15),dni2 VARCHAR(15),
		fin DATETIME)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
	END;

	START TRANSACTION;
		
		SET @precio = (SELECT SUM(cld.precio) FROM Coleccionada AS cld WHERE dni = dni1);
		
		UPDATE Coleccion
			SET dni=dni2,fecha_inicial=fin,precio_total = @precio
			WHERE dni=dni1;
	COMMIT;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_actualiza_ejemplar */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_actualiza_ejemplar(zna1 VARCHAR(25),fcp1 DATETIME,esp1 VARCHAR(50),
	zna2 VARCHAR(25),fcp2 DATETIME,esp2 VARCHAR(50),
	cap VARCHAR(15),tip VARCHAR(1),nco VARCHAR(50),tip1 DECIMAL(14,2),tip2 VARCHAR(1000))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		set foreign_key_checks=1;
		ROLLBACK;
	END;

	START TRANSACTION;
		set foreign_key_checks=0;
		UPDATE Ejemplar
			SET zona=zna2,fecha_captura=fcp2,especie=esp2,dni=cap,tipo_ejemplar=tip
			WHERE zona=zna1 AND fecha_captura=fcp1 AND especie=esp1;
		UPDATE ZonaEjemplar
			SET zona=zna2,nombre_comun=nco
			WHERE zona=zna1 AND especie=esp1;
		
		IF EXISTS (SELECT * FROM Coleccionada WHERE zona = zna1 
								AND fecha_captura=fcp1 AND especie = esp1) THEN
			UPDATE Coleccionada
				SET zona=zna2,fecha_captura=fcp2,especie=esp2,dni=tip2,precio=tip1
				WHERE zona=zna1 AND fecha_captura=fcp1 AND especie=esp1;
			SET @precio = (SELECT SUM(cld.precio) FROM Coleccionada AS cld WHERE dni = tip2);
			UPDATE Coleccion SET precio_total=@precio
				WHERE dni=tip2;
		ELSE
			UPDATE Observada
				SET zona=zna2,fecha_captura=fcp2,especie=esp2,observaciones=tip2,tiempo=tip1
				WHERE zona=zna1 AND fecha_captura=fcp1 AND especie=esp1;
		END IF;
		set foreign_key_checks=1;
	COMMIT;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_actualiza_especie */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_actualiza_especie(esp1 VARCHAR(50),esp2 VARCHAR(50),
		gen VARCHAR(50),nci VARCHAR(150))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
	END;

	START TRANSACTION;
		UPDATE Especie
			SET especie=esp2,genero=gen,nombre_cientifico=nci
			WHERE especie=esp1;
	COMMIT;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_actualiza_familia */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_actualiza_familia(fam1 VARCHAR(50),fam2 VARCHAR(50))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
	END;
		
	START TRANSACTION;
		UPDATE Familia
			SET familia=fam2
			WHERE familia=fam1;
	COMMIT;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_actualiza_genero */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_actualiza_genero(gen1 VARCHAR(50),gen2 VARCHAR(50),
		fam VARCHAR(50))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
	END;

	START TRANSACTION;
		UPDATE Genero
			SET genero=gen2,familia=fam
			WHERE genero=gen1;
	COMMIT;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_actualiza_persona */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_actualiza_persona(dni1 VARCHAR(15),
	dni2 VARCHAR(15),pnombre VARCHAR(25),snombre VARCHAR(25),papellido VARCHAR(25),sapellido VARCHAR(25))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
	END;

	START TRANSACTION;
		UPDATE Persona 
			SET dni = dni2,primer_nombre=pnombre,primer_apellido=papellido,
				segundo_nombre=snombre,segundo_apellido=sapellido
			WHERE Persona.dni=dni1;
	COMMIT;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_actualiza_zona */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_actualiza_zona(zna1 VARCHAR(25),zna2 VARCHAR(25),
		pais VARCHAR(50),rgn VARCHAR(50))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
	END;

	SET @pais=pais;

	START TRANSACTION;
		UPDATE Zona
			SET zona=zna2,pais=@pais,region=rgn
			WHERE zona=zna1;
	COMMIT;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_ejemplar_precio_mayormenor */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_ejemplar_precio_mayormenor()
BEGIN

	SELECT	ejm.especie AS 'Especie',ejm.dni AS 'Capturada por',
			col.dni AS 'ID coleccionista', col.precio AS 'Precio'
		FROM Ejemplar As ejm
			INNER JOIN Coleccionada As col
				ON col.especie = ejm.especie 
					AND col.fecha_captura = ejm.fecha_captura
					AND col.zona = ejm.zona
		WHERE 
				(col.precio = (SELECT MAX(col.precio) FROM Coleccionada AS col))
				OR 
				(col.precio = (SELECT MIN(col.precio) FROM Coleccionada AS col));

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_elimina_coleccion */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_elimina_coleccion(dn VARCHAR(15))
BEGIN
	
	DELETE FROM Coleccion
		WHERE dni=@dn;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_elimina_ejemplar */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_elimina_ejemplar(zna VARCHAR(25),fcp DATETIME,esp VARCHAR(50))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
	END;

	START TRANSACTION;
		SET @col = (SELECT dni FROM Coleccionada WHERE zona=zna AND fecha_captura=fcp AND especie = esp);

		DELETE FROM Coleccionada
			WHERE zona=zna AND fecha_captura=fcp AND especie = esp;
		DELETE FROM Observada
			WHERE zona=zna AND fecha_captura=fcp AND especie = esp;
		DELETE FROM Ejemplar
			WHERE zona=zna AND fecha_captura=fcp AND especie = esp;

		SET @precio = (SELECT SUM(cld.precio) FROM Coleccionada AS cld WHERE dni = @col);

		UPDATE Coleccion
			SET precio_total = @precio
			WHERE dni = @col;
	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_elimina_especie */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_elimina_especie(esp VARCHAR(50))
BEGIN
	DELETE FROM Especie
		WHERE especie=esp;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_elimina_familia */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_elimina_familia(fam VARCHAR(50))
BEGIN

	DELETE FROM Familia
		WHERE familia=fam;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_elimina_genero */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_elimina_genero(gen VARCHAR(50))
BEGIN
	DELETE FROM Genero
		WHERE genero=gen;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_elimina_persona */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_elimina_persona(dni VARCHAR(15))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		SELECT 100;
	END;

	SET @dni1 = dni;

	START TRANSACTION;
		DELETE FROM Persona
			WHERE Persona.dni=@dni1;
	COMMIT;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_elimina_zona */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_elimina_zona(zna VARCHAR(25))
BEGIN
	DELETE FROM Zona
		WHERE zona=zna;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_especies_capturadas_mayorq_fecha */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_especies_capturadas_mayorq_fecha(fecha VARCHAR(20))
BEGIN

	SELECT esp.especie As Especie,esp.nombre_cientifico As 'Nombre Cientifico',
			esp.genero AS Genero
		FROM Especie As esp
		WHERE esp.especie IN (SELECT DISTINCT ejm.especie FROM Ejemplar AS ejm
							WHERE ejm.fecha_captura > fecha);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_especies_nocapturadas */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_especies_nocapturadas()
BEGIN

	SELECT gen.familia As Familia,gen.genero As Genero ,esp.especie As Especie 
		FROM Especie As esp
			INNER JOIN Genero As gen
				ON gen.genero= esp.genero
		WHERE esp.especie NOT IN 
			(SELECT DISTINCT ejm.especie FROM Ejemplar As ejm);
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_familias_liberadas */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_familias_liberadas()
BEGIN

	SELECT gen.familia As Familia
		FROM Genero AS gen
		WHERE gen.genero IN 
				(SELECT DISTINCT esp.genero FROM Especie As esp
					WHERE esp.especie IN 
						(SELECT DISTINCT ejm.especie 
							FROM Ejemplar AS ejm
							WHERE ejm.tipo_ejemplar='O'));

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_get_colecciones */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_get_colecciones(dni VARCHAR(15))
BEGIN
	
	SELECT c.dni AS COLECCIONISTA, c.fecha_inicial AS "FECHA INICIO",c.precio_total As "PRECIO TOTAL"
		FROM Coleccion As c
		WHERE c.dni LIKE CONCAT("%",dni,"%");
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_get_ejemplares */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_get_ejemplares(zna VARCHAR(25),fcp DATETIME,esp VARCHAR(50),tip VARCHAR(1))
BEGIN
	IF upper(tip) = 'C' THEN
		IF (fcp IS NULL) OR (fcp='') OR (fcp=' ') OR (fcp='0000-00-00 00:00:00') THEN
			SELECT ej.zona As ZONA,ej.fecha_captura As 'FECHA CAPTURA' ,
				ej.especie As ESPECIE, ej.dni As CAPTURO,
				zej.nombre_comun As "NOMBRE COMUN",
				ej.tipo_ejemplar As TIPO,tip.precio As PRECIO,
				tip.dni AS COLECCIONISTA
			FROM Ejemplar AS ej
				INNER JOIN ZonaEjemplar As zej
					ON zej.zona=ej.zona AND zej.especie=ej.especie
				INNER JOIN Coleccionada As tip
					ON tip.zona=ej.zona AND tip.especie=ej.especie 
						AND tip.fecha_captura=ej.fecha_captura
			WHERE 	ej.zona LIKE CONCAT("%",zna,"%")
				AND
					ej.especie LIKE CONCAT("%",esp,"%")
			ORDER BY ej.fecha_captura;
		ELSE
			SELECT ej.zona As ZONA,ej.fecha_captura As 'FECHA CAPTURA' ,
				ej.especie As ESPECIE, ej.dni As CAPTURO,
				zej.nombre_comun As "NOMBRE COMUN",
				ej.tipo_ejemplar As TIPO,tip.precio As PRECIO,
				tip.dni AS COLECCIONISTA
			FROM Ejemplar AS ej
				INNER JOIN ZonaEjemplar As zej
					ON zej.zona=ej.zona AND zej.especie=ej.especie
				INNER JOIN Coleccionada As tip
					ON tip.zona=ej.zona AND tip.especie=ej.especie 
						AND tip.fecha_captura=ej.fecha_captura
			WHERE 	ej.zona LIKE CONCAT("%",zna,"%")
				AND
					ej.especie LIKE CONCAT("%",esp,"%")
				AND
					ej.fecha_captura = fcp
			ORDER BY ej.fecha_captura;
		END IF;
	ELSEIF upper(tip) = 'O' THEN
		IF (fcp IS NULL) OR (fcp='') OR (fcp=' ') OR (fcp='0000-00-00 00:00:00') THEN
			SELECT ej.zona As ZONA,ej.fecha_captura As 'FECHA CAPTURA' ,
				ej.especie As ESPECIE, ej.dni As CAPTURO,
				zej.nombre_comun As "NOMBRE COMUN",
				ej.tipo_ejemplar As TIPO,tip.tiempo As TIEMPO,
				tip.observaciones AS OBSERVACIONES
			FROM Ejemplar AS ej
				INNER JOIN ZonaEjemplar As zej
					ON zej.zona=ej.zona AND zej.especie=ej.especie
				INNER JOIN Observada As tip
					ON tip.zona=ej.zona AND tip.especie=ej.especie 
						AND tip.fecha_captura=ej.fecha_captura
			WHERE 	ej.zona LIKE CONCAT("%",zna,"%")
				AND
					ej.especie LIKE CONCAT("%",esp,"%")
			ORDER BY ej.fecha_captura;
		ELSE
			SELECT ej.zona As ZONA,ej.fecha_captura As 'FECHA CAPTURA' ,
				ej.especie As ESPECIE, ej.dni As CAPTURO,
				zej.nombre_comun As "NOMBRE COMUN",
				ej.tipo_ejemplar As TIPO,tip.tiempo As TIEMPO,
				tip.observaciones AS OBSERVACIONES
			FROM Ejemplar AS ej
				INNER JOIN ZonaEjemplar As zej
					ON zej.zona=ej.zona AND zej.especie=ej.especie
				INNER JOIN Observada As tip
					ON tip.zona=ej.zona AND tip.especie=ej.especie 
						AND tip.fecha_captura=ej.fecha_captura
			WHERE 	ej.zona LIKE CONCAT("%",zna,"%")
				AND
					ej.especie LIKE CONCAT("%",esp,"%")
				AND
					ej.fecha_captura = fcp
			ORDER BY ej.fecha_captura;
		END IF;
	ELSE
		IF (fcp IS NULL) OR (fcp='') OR (fcp=' ') OR (fcp='0000-00-00 00:00:00') THEN
			SELECT ej.zona As ZONA,ej.fecha_captura As 'FECHA CAPTURA' ,
				ej.especie As ESPECIE, ej.dni As CAPTURO,
				zej.nombre_comun As "NOMBRE COMUN",
				ej.tipo_ejemplar As TIPO
			FROM Ejemplar AS ej
				INNER JOIN ZonaEjemplar As zej
					ON zej.zona=ej.zona AND zej.especie=ej.especie
			WHERE 	ej.zona LIKE CONCAT("%",zna,"%")
				OR
					ej.especie LIKE CONCAT("%",esp,"%")
			ORDER BY ej.fecha_captura;
		ELSE
			SELECT ej.zona As ZONA,ej.fecha_captura As 'FECHA CAPTURA' ,
				ej.especie As ESPECIE, ej.dni As CAPTURO,
				zej.nombre_comun As "NOMBRE COMUN",
				ej.tipo_ejemplar As TIPO
			FROM Ejemplar AS ej
				INNER JOIN ZonaEjemplar As zej
					ON zej.zona=ej.zona AND zej.especie=ej.especie
			WHERE 	ej.zona LIKE CONCAT("%",zna,"%")
				AND
					ej.especie LIKE CONCAT("%",esp,"%")
				AND
					ej.fecha_captura = fcp
			ORDER BY ej.fecha_captura;
		END IF;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_get_especies */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_get_especies(esp VARCHAR(50))
BEGIN
	
	SELECT e.especie AS ESPECIE,e.genero AS GENERO,e.nombre_cientifico AS "NOMBRE CIENTIFICO"
		FROM Especie As e
		WHERE e.especie LIKE CONCAT("%",esp,"%");
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_get_familias */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_get_familias(fam VARCHAR(50))
BEGIN

	SELECT fami.familia As FAMILIA
		FROM Familia As fami
		WHERE fami.familia LIKE CONCAT("%",fam,"%");
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_get_generos */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_get_generos(gen VARCHAR(50))
BEGIN
	
	SELECT g.genero AS GENERO,g.familia As FAMILIA
		FROM Genero As g
		WHERE g.genero LIKE CONCAT("%",gen,"%");
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_get_personas */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_get_personas(dni VARCHAR(15),nombre VARCHAR(25))
BEGIN

	SELECT per.dni As DNI, per.primer_nombre As "PRIMER NOMBRE",
			per.segundo_nombre As "SEGUNDO NOMBRE",
			per.primer_apellido As "PRIMER APELLIDO",
			per.segundo_apellido As "SEGUNDO APELLIDO"
		FROM Persona As per
		WHERE per.dni LIKE CONCAT("%",dni,"%")
			AND (per.primer_nombre LIKE CONCAT("%",nombre,"%")
			OR per.primer_apellido LIKE CONCAT("%",nombre,"%")
			OR per.segundo_nombre LIKE CONCAT("%",nombre,"%")
			OR per.segundo_apellido LIKE CONCAT("%",nombre,"%"))
		ORDER BY per.dni ASC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_get_zonas */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_get_zonas(zna VARCHAR(25))
BEGIN
	
	SELECT zon.zona As ZONA, zon.pais As PAIS, zon.region As REGION
		FROM Zona As zon
		WHERE zon.zona LIKE CONCAT("%",zna,"%");
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_nombres_comunes_cientificos_intervalo */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_nombres_comunes_cientificos_intervalo(fecha_i VARCHAR(20),
														fecha_f VARCHAR(20))
BEGIN

	SELECT 	zEj.zona AS Zona,
			zEj.nombre_comun AS 'Nombre Común',
			esp.nombre_cientifico As 'Nombre Cientifico'
		FROM Especie As esp
			INNER JOIN ZonaEjemplar As zEj
				ON zEj.especie = esp.especie
		WHERE esp.especie IN (SELECT DISTINCT ejm.especie FROM Ejemplar AS ejm
							WHERE ejm.fecha_captura BETWEEN fecha_i AND fecha_f)
		ORDER BY zEj.zona;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_nueva_coleccion */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_nueva_coleccion(dni VARCHAR(15),
		fin DATETIME)
BEGIN
	INSERT INTO Coleccion(dni,fecha_inicial,precio_total)
		VALUES (dni,fin,0);
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_nueva_especie */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_nueva_especie(esp VARCHAR(50),
		gen VARCHAR(50),nci VARCHAR(150))
BEGIN
	INSERT INTO Especie(especie,genero,nombre_cientifico)
		VALUES(esp,gen,nci);
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_nueva_familia */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_nueva_familia(fam VARCHAR(50))
BEGIN

	INSERT INTO Familia
		VALUES(fam);
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_nueva_persona */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_nueva_persona(dni VARCHAR(15),pnombre VARCHAR(25),
		snombre VARCHAR(25),papellido VARCHAR(25),sapellido VARCHAR(25))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
	END;
	
	START TRANSACTION;
		INSERT INTO Persona(dni,primer_nombre,segundo_nombre,primer_apellido,segundo_apellido)
			VALUES(dni,pnombre,IF(STRCMP(snombre,""),snombre,NULL),
				papellido,IF(STRCMP(sapellido,""),sapellido,NULL));
	COMMIT;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_nueva_zona */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_nueva_zona(zna VARCHAR(25),
		pais VARCHAR(50),rgn VARCHAR(50))
BEGIN
	INSERT INTO Zona(zona,pais,region)
		VALUES(zna,pais,rgn);
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_nuevo_ejemplarColeccionado */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_nuevo_ejemplarColeccionado(zna VARCHAR(25),fcp DATETIME,esp VARCHAR(50),
	cap VARCHAR(15),tip VARCHAR(1),nco VARCHAR(50),prc DECIMAL(14,2),col VARCHAR(15))
BEGIN
##:zna,:fcp,:esp,:cap,:tip,:prc,:col,:nco
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SET foreign_key_checks=1;
		ROLLBACK;
	END;

	START TRANSACTION;
	SET foreign_key_checks=0;
	INSERT INTO Ejemplar(zona,especie,fecha_captura,dni,tipo_ejemplar)
		VALUES(zna,esp,fcp,cap,tip);
	
	IF NOT EXISTS (SELECT * FROM ZonaEjemplar As zej 
						WHERE zej.especie=esp AND zej.zona=zna) THEN
		INSERT INTO ZonaEjemplar (zona,especie,nombre_comun)
			VALUES(zna,esp,nco);
	ELSE
		UPDATE ZonaEjemplar
			SET nombre_comun=nco
			WHERE zona=zna AND especie=esp;
	END IF;
	
	INSERT INTO Coleccionada(zona,especie,fecha_captura,precio,dni)
		VALUES(zna,esp,fcp,prc,col);
	
	SET @precio = (SELECT SUM(cld.precio) FROM Coleccionada AS cld WHERE dni = col);

	UPDATE Coleccion
		SET precio_total = @precio
		WHERE dni = col;
	SET foreign_key_checks=1;
	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_nuevo_ejemplarObservado */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_nuevo_ejemplarObservado(zna VARCHAR(25),fcp DATETIME,esp VARCHAR(50),
	cap VARCHAR(15),tip VARCHAR(1),nco VARCHAR(50),tmp DECIMAL(6),obs VARCHAR(1000))
BEGIN
##:zna,:fcp,:esp,:cap,:tip,:tmp,:obs,:nco
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SET foreign_key_checks=1;
		ROLLBACK;
	END;

	START TRANSACTION;
	SET foreign_key_checks=0;
	INSERT INTO Ejemplar(zona,especie,fecha_captura,dni,tipo_ejemplar)
		VALUES(zna,esp,fcp,cap,tip);
	
	IF NOT EXISTS (SELECT * FROM ZonaEjemplar As zej 
						WHERE zej.especie=esp AND zej.zona=zna) THEN
		INSERT INTO ZonaEjemplar (zona,especie,nombre_comun)
			VALUES(zna,esp,nco);
	ELSE
		UPDATE ZonaEjemplar
			SET nombre_comun=nco
			WHERE zona=zna AND especie=esp;
	END IF;
	
	INSERT INTO Observada(zona,especie,fecha_captura,tiempo,observaciones)
		VALUES(zna,esp,fcp,tmp,obs);
	SET foreign_key_checks=1;
	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_nuevo_genero */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_nuevo_genero(gen VARCHAR(50),
		fam VARCHAR(50))
BEGIN
	INSERT INTO Genero(genero,familia)
		VALUES(gen,fam);
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_personas_capturaron_sin_coleccion */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_personas_capturaron_sin_coleccion()
BEGIN
	SELECT per.dni As DNI, per.primer_nombre As Nombre,per.primer_apellido As Apellido
		FROM Persona AS per
		WHERE 
			(per.dni IN (SELECT DISTINCT ejm.dni FROM Ejemplar As ejm
							WHERE ejm.fecha_captura < '1990-11-5 00:00:00'))
			AND
			(per.dni NOT IN (SELECT DISTINCT col.dni FROM Coleccion As col));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sp_zonas_mas_6capturas */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=eavila@localhost PROCEDURE sp_zonas_mas_6capturas()
BEGIN
	SELECT ejm.zona As Zona, zna.pais AS Pais, zna.region As Region ,count(*) AS 'Cantidad Capt.'
		FROM Ejemplar As ejm
			INNER JOIN Zona AS zna
				ON ejm.zona = zna.zona
		GROUP BY ejm.zona,zna.pais,zna.region
		HAVING COUNT(*) > 6
		ORDER BY COUNT(*);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

SET foreign_key_checks=1;
