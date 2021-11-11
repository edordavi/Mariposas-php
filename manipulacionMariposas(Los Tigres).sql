#########################
#####MANIPULACION 01#####
#########################
DROP PROCEDURE IF EXISTS sp_especies_capturadas_mayorq_fecha;
delimiter //
CREATE PROCEDURE sp_especies_capturadas_mayorq_fecha(fecha VARCHAR(20))
BEGIN

	SELECT esp.especie As Especie,esp.nombre_cientifico As 'Nombre Cientifico',
			esp.genero AS Genero
		FROM Especie As esp
		WHERE esp.especie IN (SELECT DISTINCT ejm.especie FROM Ejemplar AS ejm
							WHERE ejm.fecha_captura > fecha);

END//
delimiter ;


#########################
#####MANIPULACION 02#####
#########################
DROP PROCEDURE IF EXISTS sp_nombres_comunes_cientificos_intervalo;
delimiter //
CREATE PROCEDURE sp_nombres_comunes_cientificos_intervalo(fecha_i VARCHAR(20),
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

END//
delimiter ;


#########################
#####MANIPULACION 03#####
#########################
DROP PROCEDURE IF EXISTS sp_ejemplar_precio_mayormenor;
delimiter //
CREATE PROCEDURE sp_ejemplar_precio_mayormenor()
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

END//
delimiter ;


#########################
#####MANIPULACION 04#####
#########################
DROP PROCEDURE IF EXISTS sp_familias_liberadas;
delimiter //
CREATE PROCEDURE sp_familias_liberadas()
BEGIN

	SELECT gen.familia As Familia
		FROM Genero AS gen
		WHERE gen.genero IN 
				(SELECT DISTINCT esp.genero FROM Especie As esp
					WHERE esp.especie IN 
						(SELECT DISTINCT ejm.especie 
							FROM Ejemplar AS ejm
							WHERE ejm.tipo_ejemplar='O'));

END//
delimiter ;


#########################
#####MANIPULACION 05#####
#########################
DROP PROCEDURE IF EXISTS sp_especies_nocapturadas;
delimiter //
CREATE PROCEDURE sp_especies_nocapturadas()
BEGIN

	SELECT gen.familia As Familia,gen.genero As Genero ,esp.especie As Especie 
		FROM Especie As esp
			INNER JOIN Genero As gen
				ON gen.genero= esp.genero
		WHERE esp.especie NOT IN 
			(SELECT DISTINCT ejm.especie FROM Ejemplar As ejm);
	
END//
delimiter ;


#########################
#####MANIPULACION 06#####
#########################
DROP PROCEDURE IF EXISTS sp_zonas_mas_6capturas;
delimiter //
CREATE PROCEDURE sp_zonas_mas_6capturas()
BEGIN
	SELECT ejm.zona As Zona, zna.pais AS Pais, zna.region As Region ,count(*) AS 'Cantidad Capt.'
		FROM Ejemplar As ejm
			INNER JOIN Zona AS zna
				ON ejm.zona = zna.zona
		GROUP BY ejm.zona,zna.pais,zna.region
		HAVING COUNT(*) > 6
		ORDER BY COUNT(*);
END//
delimiter ;


#########################
#####MANIPULACION 07#####
#########################
CREATE VIEW vst_colecciones AS
	SELECT per.primer_nombre As 'Nombre',per.primer_apellido As Apellido
			,per.dni AS DNI,col.precio_total AS 'Precio Estimado'
		FROM Coleccion As col
			INNER JOIN Persona As per
				ON col.dni = per.dni
		WHERE col.fecha_inicial >= '19960101 00:01:01';


#########################
#####MANIPULACION 08#####
#########################
DROP PROCEDURE IF EXISTS sp_personas_capturaron_sin_coleccion;
delimiter //
CREATE PROCEDURE sp_personas_capturaron_sin_coleccion()
BEGIN
	SELECT per.dni As DNI, per.primer_nombre As Nombre,per.primer_apellido As Apellido
		FROM Persona AS per
		WHERE 
			(per.dni IN (SELECT DISTINCT ejm.dni FROM Ejemplar As ejm
							WHERE ejm.fecha_captura < '1990-11-5 00:00:00'))
			AND
			(per.dni NOT IN (SELECT DISTINCT col.dni FROM Coleccion As col));
END//
delimiter ;

