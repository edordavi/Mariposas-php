USE `Mariposas`;
SET foreign_key_checks = 0;
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

INSERT INTO Coleccion (dni, fecha_inicial, precio_total) VALUES ('0801-1981-15487','1997-12-15 10:35:23',50.00),('0806-1962-78954','1998-01-01 00:01:01',50.00);

INSERT INTO Coleccionada (especie, zona, fecha_captura, precio, dni) VALUES ('Ancylolomia aff tentaculella','Cerro Juana Lainez','1997-12-15 10:35:23',30.00,'0801-1981-15487'),('Adscita schmidti','La Tigra','2013-12-12 10:35:23',20.00,'0801-1981-15487'),('Agrotis trux','UNAH','1998-01-01 00:01:01',50.00,'0806-1962-78954');

INSERT INTO Ejemplar (zona, fecha_captura, especie, dni, tipo_ejemplar) VALUES ('Cerro Juana Lainez','1997-12-15 10:35:23','Ancylolomia aff tentaculella','0801-1981-15487','C'),('La Tigra','2013-09-14 10:35:23','Adscita schmidti','0801-1981-15487',''),('La Tigra','2013-09-14 10:40:23','Adscita schmidti','0801-1981-15487',''),('La Tigra','2013-10-15 10:30:23','Adscita schmidti','0801-1981-15487',''),('La Tigra','2013-10-15 10:35:23','Adscita schmidti','0801-1981-15487',''),('La Tigra','2013-11-15 10:35:23','Adscita schmidti','0801-1981-15487',''),('La Tigra','2013-12-12 10:35:23','Adscita schmidti','0801-1981-15487','C'),('La Tigra','2013-12-14 10:35:23','Adscita schmidti','0801-1981-15487',''),('La Tigra','2013-12-15 10:35:23','Adscita schmidti','0801-1981-15487','O'),('UNAH','1990-01-01 00:01:01','Agrotis trux','0802-1978-45677',''),('UNAH','1992-01-01 00:01:01','Agrotis trux','0802-1978-45677',''),('UNAH','1995-01-01 00:01:01','Agrotis trux','0802-1978-45677',''),('UNAH','1996-01-01 00:01:01','Agrotis trux','0802-1978-45677','O'),('UNAH','1998-01-01 00:01:01','Agrotis trux','0802-1978-45677','C'),('UNAH','1999-01-01 00:01:01','Agrotis trux','0802-1978-45677',''),('UNAH','2005-01-01 00:01:01','Agrotis trux','0802-1978-45677',''),('UNAH','2007-01-01 00:01:01','Agrotis trux','0802-1978-45677',''),('UNAH','2009-01-01 00:01:01','Agrotis trux','0802-1978-45677',''),('UNAH','2010-01-01 00:01:01','Agrotis trux','0802-1978-45677',''),('UNAH','2012-01-01 00:01:01','Agrotis trux','0802-1978-45677',''),('UNAH','2014-01-01 00:01:01','Agrotis trux','0802-1978-45677','O');

INSERT INTO Especie (especie, nombre_cientifico, genero) VALUES ('Adscita schmidti','Adscita schmidti Naufock','Adscita'),('Aglais urticae','Aglais urticae Linnaeus','Aglais'),('Agrotis trux','Agrotis trux Linnaeus','Agrotis'),('Ancylolomia aff tentaculella','Ancylolomia aff tentaculella (Hübner)','Ancylolomia');

INSERT INTO Familia (familia) VALUES ('Crambidae'),('Noctuidae'),('Nymphalidae'),('Zygaenidae');

INSERT INTO Genero (genero, familia) VALUES ('Ancylolomia','Crambidae'),('Agrotis','Noctuidae'),('Aglais','Nymphalidae'),('Adscita','Zygaenidae');


INSERT INTO Persona (dni, primer_nombre, primer_apellido, segundo_nombre, segundo_apellido) VALUES ('0801-1981-15487','Camilo','Castro',NULL,NULL),('0801-1985-12835','Karla','Cortes',NULL,NULL),('0802-1978-45677','Carlos','Betancourt',NULL,NULL),('0806-1962-78954','Jesus','Barahona',NULL,NULL);

INSERT INTO Zona (zona, pais, region) VALUES ('Cerro Juana Lainez','Francisco Morazan','Honduras'),('El Picacho','Francisco Morazan','Honduras'),('La Tigra','Honduras','Francisco Morazan'),('UNAH','Francisco Morazan','Honduras');

INSERT INTO ZonaEjemplar (especie, zona, nombre_comun) VALUES ('Adscita schmidti','La Tigra','La Schmidt'),('Agrotis trux','UNAH','Trux'),('Ancylolomia aff tentaculella','Cerro Juana Lainez','Tentaculella');
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
SET foreign_key_checks = 1;

CREATE VIEW vst_colecciones AS
	SELECT per.primer_nombre As 'Nombre',per.primer_apellido As Apellido
			,per.dni AS DNI,col.precio_total AS 'Precio Estimado'
		FROM Coleccion As col
			INNER JOIN Persona As per
				ON col.dni = per.dni
		WHERE col.fecha_inicial >= '19960101 00:01:01';