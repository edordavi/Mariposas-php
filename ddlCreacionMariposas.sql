CREATE TABLE Coleccion (
    dni VARCHAR(15) NOT NULL,
    fecha_inicial DATETIME,
    precio_total NUMERIC(14 , 2 ) NOT NULL
);
ALTER TABLE Coleccion ADD CONSTRAINT Coleccion_PK PRIMARY KEY ( dni ) ;

CREATE TABLE Coleccionada (
    nombre_comun VARCHAR(50) NOT NULL,
    zona VARCHAR(25) NOT NULL,
    fecha_captura DATETIME NOT NULL,
    precio NUMERIC(14 , 2 ) NOT NULL,
    coleccion VARCHAR(15) NOT NULL,
    dni VARCHAR(15) NOT NULL
);
ALTER TABLE Coleccionada ADD CONSTRAINT Coleccionada_PK PRIMARY KEY ( nombre_comun, zona, fecha_captura ) ;

CREATE TABLE Ejemplar (
    nombre_comun VARCHAR(50) NOT NULL,
    zona VARCHAR(25) NOT NULL,
    fecha_captura DATETIME NOT NULL,
    especie VARCHAR(50) NOT NULL,
    dni VARCHAR(15) NOT NULL
);
ALTER TABLE Ejemplar ADD CONSTRAINT ejemplar_PK PRIMARY KEY ( nombre_comun, zona, fecha_captura ) ;

CREATE TABLE Especie (
    especie VARCHAR(50) NOT NULL,
    nombre_cientifico VARCHAR(150) NOT NULL,
    genero VARCHAR(50) NOT NULL
);
ALTER TABLE Especie ADD CONSTRAINT Especie_PK PRIMARY KEY ( especie ) ;

CREATE TABLE Familia (
    familia VARCHAR(50) NOT NULL
);
ALTER TABLE Familia ADD CONSTRAINT Familia_PK PRIMARY KEY ( familia ) ;

CREATE TABLE Genero (
    genero VARCHAR(50) NOT NULL,
    familia VARCHAR(50) NOT NULL
);
ALTER TABLE Genero ADD CONSTRAINT Genero_PK PRIMARY KEY ( genero ) ;

CREATE TABLE Observada (
    nombre_comun VARCHAR(50) NOT NULL,
    zona VARCHAR(25) NOT NULL,
    fecha_captura DATETIME NOT NULL,
    tiempo NUMERIC(6),
    observaciones VARCHAR(1000)
);
ALTER TABLE Observada ADD CONSTRAINT Observada_PK PRIMARY KEY ( nombre_comun, zona, fecha_captura ) ;

CREATE TABLE Persona (
    dni VARCHAR(15) NOT NULL,
    primer_nombre VARCHAR(25) NOT NULL,
    primer_apellido VARCHAR(25) NOT NULL,
    segundo_nombre VARCHAR(25),
    segundo_apellido VARCHAR(25)
);
ALTER TABLE Persona ADD CONSTRAINT Persona_PK PRIMARY KEY ( dni ) ;

CREATE TABLE Zona (
    zona VARCHAR(25) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL
);
ALTER TABLE Zona ADD CONSTRAINT Zona_PK PRIMARY KEY ( zona ) ;

ALTER TABLE Coleccion ADD CONSTRAINT Coleccion_Persona_FK FOREIGN KEY ( dni ) REFERENCES Persona ( dni ) ;

ALTER TABLE Coleccionada ADD CONSTRAINT Coleccionada_Coleccion_FK FOREIGN KEY ( dni ) REFERENCES Coleccion ( dni ) ;

-- Error - Foreign Key Coleccionada_Coleccion_FK has no columns

ALTER TABLE Coleccionada ADD CONSTRAINT Coleccionada_Ejemplar_FK FOREIGN KEY ( nombre_comun, zona, fecha_captura ) REFERENCES Ejemplar ( nombre_comun, zona, fecha_captura ) ;

ALTER TABLE Ejemplar ADD CONSTRAINT Ejemplar_Especie_FK FOREIGN KEY ( especie ) REFERENCES Especie ( especie ) ;

ALTER TABLE Ejemplar ADD CONSTRAINT Ejemplar_Persona_FK FOREIGN KEY ( dni ) REFERENCES Persona ( dni ) ;

ALTER TABLE Ejemplar ADD CONSTRAINT Ejemplar_Zona_FK FOREIGN KEY ( zona ) REFERENCES Zona ( zona ) ;

ALTER TABLE Especie ADD CONSTRAINT Especie_Genero_FK FOREIGN KEY ( genero ) REFERENCES Genero ( genero ) ;

ALTER TABLE Genero ADD CONSTRAINT Genero_Familia_FK FOREIGN KEY ( familia ) REFERENCES Familia ( familia ) ;

ALTER TABLE Observada ADD CONSTRAINT Observada_Ejemplar_FK FOREIGN KEY ( nombre_comun, zona, fecha_captura ) REFERENCES Ejemplar ( nombre_comun, zona, fecha_captura ) ;

