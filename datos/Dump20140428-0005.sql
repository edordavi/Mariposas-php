CREATE DATABASE  IF NOT EXISTS `mariposas` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `mariposas`;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;



INSERT INTO Ejemplar (nombre_comun, zona, fecha_captura, especie, dni) VALUES ('La Schmidt','La Tigra','2013-12-12 10:35:23','Adscita schmidti','0801-1981-15487'),('La Schmidt','La Tigra','2013-12-15 10:35:23','Adscita schmidti','0801-1981-15487'),('Tentaculella','Cerro Juana Lainez','1997-12-15 10:35:23','Ancylolomia aff tentaculella','0801-1981-15487'),('Trux','UNAH','1996-01-01 00:01:01','Agrotis trux','0802-1978-45677'),('Trux','UNAH','1998-01-01 00:01:01','Agrotis trux','0802-1978-45677'),('Trux','UNAH','2014-01-01 00:01:01','Agrotis trux','0802-1978-45677');

INSERT INTO Especie (especie, nombre_cientifico, genero) VALUES ('Adscita schmidti','Adscita schmidti Naufock','Adscita'),('Aglais urticae','Aglais urticae Linnaeus','Aglais'),('Agrotis trux','Agrotis trux Linnaeus','Agrotis'),('Ancylolomia aff tentaculella','Ancylolomia aff tentaculella (Hübner)','Ancylolomia');

INSERT INTO Familia (familia) VALUES ('Crambidae'),('Noctuidae'),('Nymphalidae'),('Zygaenidae');

INSERT INTO Genero (genero, familia) VALUES ('Ancylolomia','Crambidae'),('Agrotis','Noctuidae'),('Aglais','Nymphalidae'),('Adscita','Zygaenidae');


INSERT INTO Persona (dni, primer_nombre, primer_apellido, segundo_nombre, segundo_apellido) VALUES ('0801-1981-15487','Camilo','Castro',NULL,NULL),('0801-1985-12835','Karla','Cortes',NULL,NULL),('0802-1978-45677','Carlos','Betancourt',NULL,NULL),('0806-1962-78954','Jesus','Barahona',NULL,NULL);

INSERT INTO Zona (zona, pais, region) VALUES ('Cerro Juana Lainez','Francisco Morazan','Honduras'),('El Picacho','Francisco Morazan','Honduras'),('La Tigra','Honduras','Francisco Morazan'),('UNAH','Francisco Morazan','Honduras');
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
		WHERE esp.especie IN (SELECT ejm.especie FROM Ejemplar AS ejm
							WHERE ejm.fecha_captura > fecha);

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

	SELECT ejm.nombre_comun AS 'Nombre Común',
			esp.nombre_cientifico As 'Nombre Cientifico'
		FROM Especie As esp
			INNER JOIN Ejemplar As ejm
				ON ejm.especie = esp.especie
		WHERE esp.especie IN (SELECT DISTINCT ejm.especie FROM Ejemplar AS ejm
							WHERE ejm.fecha_captura BETWEEN fecha_i AND fecha_f)
		ORDER BY ejm.zona;

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

