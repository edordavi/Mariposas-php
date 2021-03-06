CREATE TABLE Coleccion
  (
    dni           VARCHAR (15) NOT NULL ,
    fecha_inicial DATETIME ,
    precio_total  NUMERIC (14,2) NOT NULL
  ) ;
ALTER TABLE Coleccion ADD CONSTRAINT Coleccion_PK PRIMARY KEY ( dni ) ;

CREATE TABLE Coleccionada
  (
    especie       VARCHAR (50) NOT NULL ,
    zona          VARCHAR (25) NOT NULL ,
    fecha_captura DATETIME NOT NULL ,
    precio        NUMERIC (14,2) NOT NULL ,
    dni           VARCHAR (15) NOT NULL
  ) ;
ALTER TABLE Coleccionada ADD CONSTRAINT Coleccionada_PK PRIMARY KEY ( zona, fecha_captura, especie ) ;

CREATE TABLE Ejemplar
  (
    zona          VARCHAR (25) NOT NULL ,
    fecha_captura DATETIME NOT NULL ,
    especie       VARCHAR (50) NOT NULL ,
    dni           VARCHAR (15) NOT NULL ,
    tipo_ejemplar VARCHAR (1) NOT NULL
  ) ;
ALTER TABLE Ejemplar ADD CONSTRAINT ejemplar_PK PRIMARY KEY ( zona, fecha_captura, especie ) ;

CREATE TABLE Especie
  (
    especie           VARCHAR (50) NOT NULL ,
    nombre_cientifico VARCHAR (150) NOT NULL ,
    genero            VARCHAR (50) NOT NULL
  ) ;
ALTER TABLE Especie ADD CONSTRAINT Especie_PK PRIMARY KEY ( especie ) ;

CREATE TABLE Familia
  ( familia VARCHAR (50) NOT NULL
  ) ;
ALTER TABLE Familia ADD CONSTRAINT Familia_PK PRIMARY KEY ( familia ) ;

CREATE TABLE Genero
  (
    genero  VARCHAR (50) NOT NULL ,
    familia VARCHAR (50) NOT NULL
  ) ;
ALTER TABLE Genero ADD CONSTRAINT Genero_PK PRIMARY KEY ( genero ) ;

CREATE TABLE Observada
  (
    especie       VARCHAR (50) NOT NULL ,
    zona          VARCHAR (25) NOT NULL ,
    fecha_captura DATETIME NOT NULL ,
    tiempo        NUMERIC (6) ,
    observaciones VARCHAR (1000)
  ) ;
ALTER TABLE Observada ADD CONSTRAINT Observada_PK PRIMARY KEY ( zona, fecha_captura, especie ) ;

CREATE TABLE Persona
  (
    dni              VARCHAR (15) NOT NULL ,
    primer_nombre    VARCHAR (25) NOT NULL ,
    primer_apellido  VARCHAR (25) NOT NULL ,
    segundo_nombre   VARCHAR (25) ,
    segundo_apellido VARCHAR (25)
  ) ;
ALTER TABLE Persona ADD CONSTRAINT Persona_PK PRIMARY KEY ( dni ) ;

CREATE TABLE Zona
  (
    zona   VARCHAR (25) NOT NULL ,
    pais   VARCHAR (50) NOT NULL ,
    region VARCHAR (50) NOT NULL
  ) ;
ALTER TABLE Zona ADD CONSTRAINT Zona_PK PRIMARY KEY ( zona ) ;

CREATE TABLE ZonaEjemplar
  (
    especie      VARCHAR (50) NOT NULL ,
    zona         VARCHAR (25) NOT NULL ,
    nombre_comun VARCHAR (50)
  ) ;
ALTER TABLE ZonaEjemplar ADD CONSTRAINT ZonaNombreComun_PK PRIMARY KEY ( especie, zona ) ;

ALTER TABLE Coleccion ADD CONSTRAINT Coleccion_Persona_FK FOREIGN KEY ( dni ) REFERENCES Persona ( dni ) ON
DELETE RESTRICT ON UPDATE CASCADE ;

ALTER TABLE Coleccionada ADD CONSTRAINT Coleccionada_Coleccion_FK FOREIGN KEY ( dni ) REFERENCES Coleccion ( dni ) ON
DELETE RESTRICT ON UPDATE CASCADE ;

ALTER TABLE Coleccionada ADD CONSTRAINT Coleccionada_Ejemplar_FK FOREIGN KEY ( zona, fecha_captura, especie ) REFERENCES Ejemplar ( zona, fecha_captura, especie ) ON
DELETE RESTRICT ON UPDATE CASCADE ;

ALTER TABLE Ejemplar ADD CONSTRAINT Ejemplar_Especie_FK FOREIGN KEY ( especie ) REFERENCES Especie ( especie ) ON
DELETE RESTRICT ON UPDATE CASCADE ;

ALTER TABLE Ejemplar ADD CONSTRAINT Ejemplar_Persona_FK FOREIGN KEY ( dni ) REFERENCES Persona ( dni ) ON
DELETE RESTRICT ON UPDATE CASCADE ;

ALTER TABLE Ejemplar ADD CONSTRAINT Ejemplar_ZonaNombreComun_FK FOREIGN KEY ( especie, zona ) REFERENCES ZonaEjemplar ( especie, zona ) ON
DELETE RESTRICT ON UPDATE CASCADE ;

ALTER TABLE Especie ADD CONSTRAINT Especie_Genero_FK FOREIGN KEY ( genero ) REFERENCES Genero ( genero ) ON
DELETE RESTRICT ON UPDATE CASCADE ;

ALTER TABLE Genero ADD CONSTRAINT Genero_Familia_FK FOREIGN KEY ( familia ) REFERENCES Familia ( familia ) ON
DELETE RESTRICT ON UPDATE CASCADE ;

ALTER TABLE Observada ADD CONSTRAINT Observada_Ejemplar_FK FOREIGN KEY ( zona, fecha_captura, especie ) REFERENCES Ejemplar ( zona, fecha_captura, especie ) ON
DELETE RESTRICT ON UPDATE CASCADE ;

ALTER TABLE ZonaEjemplar ADD CONSTRAINT ZonaNombreComun_Zona_FK FOREIGN KEY ( zona ) REFERENCES Zona ( zona ) ON
DELETE RESTRICT ON UPDATE CASCADE ;

CREATE VIEW vst_colecciones AS
	SELECT per.primer_nombre As 'Nombre',per.primer_apellido As Apellido
			,per.dni AS DNI,col.precio_total AS 'Precio Estimado'
		FROM Coleccion As col
			INNER JOIN Persona As per
				ON col.dni = per.dni
		WHERE col.fecha_inicial >= '19960101 00:01:01';
