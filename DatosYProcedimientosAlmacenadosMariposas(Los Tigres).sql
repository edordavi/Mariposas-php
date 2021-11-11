CREATE DATABASE  IF NOT EXISTS `Mariposas` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `Mariposas`;

SET foreign_key_checks=0;

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

SET foreign_key_checks=1;
