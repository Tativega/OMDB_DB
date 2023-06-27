-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS omdb;

-- Usar la base de datos creada
USE omdb;

-- Eliminar tablas si ya existen
DROP TABLE IF EXISTS PELICULAS_PERSONAS;
DROP TABLE IF EXISTS PELICULAS_IDIOMAS;
DROP TABLE IF EXISTS PELICULAS_GENEROS;
DROP TABLE IF EXISTS PELICULAS_PREMIOS;
DROP TABLE IF EXISTS CATEGORIAS_PREMIOS;
DROP TABLE IF EXISTS PELICULAS_TRADUCCIONES;
DROP TABLE IF EXISTS PELICULAS_PRODUCTORAS;
DROP TABLE IF EXISTS PELICULAS;
DROP TABLE IF EXISTS PERSONAS;
DROP TABLE IF EXISTS IDIOMAS;
DROP TABLE IF EXISTS GENEROS;
DROP TABLE IF EXISTS PREMIOS;
DROP TABLE IF EXISTS ROLES;
DROP TABLE IF EXISTS PRODUCTORAS;
DROP TABLE IF EXISTS PAISES;


-- Crear las tablas
CREATE TABLE IDIOMAS (
  ID_IDIOMA INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  NOMBRE VARCHAR(60) NOT NULL
);

CREATE TABLE PAISES (
  ID_PAIS INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  NOMBRE VARCHAR(60) NOT NULL
);

CREATE TABLE PELICULAS (
  ID_PELICULA INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  TITULO VARCHAR(160) NOT NULL,
  FECHA_ESTRENO DATE NOT NULL,
  DURACION INT NOT NULL,
  PARENT_ID INT,
  ORDEN_VISUALIZACION INT NOT NULL,
  ID_IDIOMA_ORIGINAL INT NOT NULL,
  FOREIGN KEY (PARENT_ID) REFERENCES PELICULAS (ID_PELICULA),
  FOREIGN KEY (ID_IDIOMA_ORIGINAL) REFERENCES IDIOMAS (ID_IDIOMA)
);

CREATE TABLE PERSONAS (
  ID_PERSONA INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  NOMBRE VARCHAR(60) NOT NULL,
  APELLIDO VARCHAR(60) NOT NULL,
  SEXO VARCHAR(1),
  FECHA_NAC DATE,
  ID_PAIS_NAC INT NOT NULL,
  FOREIGN KEY (ID_PAIS_NAC) REFERENCES PAISES (ID_PAIS)
);

CREATE TABLE ROLES (
  ID_ROL INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  NOMBRE VARCHAR(60) NOT NULL
);

CREATE TABLE PELICULAS_PERSONAS (
  ID_PELICULA INT NOT NULL,
  ID_PERSONA INT NOT NULL,
  ID_ROL INT NOT NULL,
  PRIMARY KEY (ID_PELICULA, ID_PERSONA, ID_ROL),
  FOREIGN KEY (ID_ROL) REFERENCES ROLES (ID_ROL),
  FOREIGN KEY (ID_PELICULA) REFERENCES PELICULAS (ID_PELICULA),
  FOREIGN KEY (ID_PERSONA) REFERENCES PERSONAS (ID_PERSONA)
);

CREATE TABLE GENEROS (
  ID_GENERO INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  NOMBRE VARCHAR(60) NOT NULL
);

CREATE TABLE PELICULAS_GENEROS (
  ID_PELICULA INT NOT NULL,
  ID_GENERO INT NOT NULL,
  PRIMARY KEY (ID_PELICULA, ID_GENERO),
  FOREIGN KEY (ID_PELICULA) REFERENCES PELICULAS (ID_PELICULA),
  FOREIGN KEY (ID_GENERO) REFERENCES GENEROS (ID_GENERO)
);

CREATE TABLE PELICULAS_TRADUCCIONES (
  ID_PELICULA INT NOT NULL,
  ID_IDIOMA INT NOT NULL,
  TITULO_TRADUCIDO VARCHAR(160) NOT NULL,
  PRIMARY KEY (ID_PELICULA, ID_IDIOMA),
  FOREIGN KEY (ID_PELICULA) REFERENCES PELICULAS (ID_PELICULA),
  FOREIGN KEY (ID_IDIOMA) REFERENCES IDIOMAS (ID_IDIOMA)
);

CREATE TABLE PREMIOS (
  ID_PREMIO INT PRIMARY KEY NOT NULL,
  NOMBRE VARCHAR(60) NOT NULL,
  ID_PAIS_ENTREGA INT NOT NULL,
  FOREIGN KEY (ID_PAIS_ENTREGA) REFERENCES PAISES (ID_PAIS)
);

CREATE TABLE CATEGORIAS_PREMIOS (
  ID_CATEGORIA INT PRIMARY KEY NOT NULL,
  NOMBRE VARCHAR(160) NOT NULL
);

CREATE TABLE PELICULAS_PREMIOS (
   ID_PELICULA INT NOT NULL,
   ID_PREMIO INT NOT NULL,
   NRO_EDICION INT,
   ID_CATEGORIA INT NOT NULL,
   PRIMARY KEY (ID_PELICULA, ID_PREMIO, ID_CATEGORIA),
   FOREIGN KEY (ID_CATEGORIA) REFERENCES CATEGORIAS_PREMIOS (ID_CATEGORIA)
);

CREATE TABLE PRODUCTORAS (
  ID_PRODUCTORA INT PRIMARY KEY NOT NULL,
  NOMBRE VARCHAR(160) NOT NULL
);

CREATE TABLE PELICULAS_PRODUCTORAS (
  ID_PELICULA INT NOT NULL,
  ID_PRODUCTORA INT NOT NULL,
  PRIMARY KEY (ID_PELICULA, ID_PRODUCTORA),
  FOREIGN KEY (ID_PELICULA) REFERENCES PELICULAS (ID_PELICULA),
  FOREIGN KEY (ID_PRODUCTORA) REFERENCES PRODUCTORAS (ID_PRODUCTORA)
);

INSERT INTO PAISES (ID_PAIS, NOMBRE) VALUES
(1, 'ESTADOS UNIDOS'),
(2, 'INGLATERRA'),
(3, 'ARGENTINA'),
(4, 'FRANCIA'),
(5, 'ESPAÑA'),
(6, 'ALEMANIA'),
(7, 'JAPÓN'),
(8, 'ITALIA'),
(9, 'ESCOCIA'),
(10, 'CANADA'),
(11, 'IRLANDA DEL NORTE'),
(12, 'ISRAEL'),
(13, 'GALES'),
(14, 'AUSTRALIA'),
(15, 'NORUEGA'),
(16, 'SUECIA'),
(17, 'GHANA'),
(18, 'NUEVA ZELANDA');

INSERT INTO GENEROS (ID_GENERO, NOMBRE) VALUES
(1, 'Romance'),
(2, 'Drama'),
(3, 'Acción'),
(4, 'Aventura'),
(5, 'Fantasía'),
(6, 'Animación'),
(7, 'Familia'),
(8, 'Comedia'),
(9, 'Ciencia Ficción'),
(10, 'Biografía'),
(11, 'Historia'),
(12, 'Comedia Romántica'),
(13, 'Musical'),
(14, 'Crimen'),
(15, 'Suspenso');

INSERT INTO IDIOMAS (ID_IDIOMA, NOMBRE)
VALUES 
(1, 'INGLES'),
(2, 'CASTELLANO'),
(3, 'JAPONES'),
(4, 'ALEMAN'),
(5, 'FRANCES'),
(6, 'ITALIANO'),
(7, 'PORTUGUES'),
(8, 'RUSO'),
(9, 'CHINO'),
(10, 'ARABE');

INSERT INTO PREMIOS (ID_PREMIO, NOMBRE, ID_PAIS_ENTREGA)
VALUES
(1, 'OSCAR', 1),
(2, 'GLOBO DE ORO', 1),
(3, 'BAFTA', 2),
(4, 'GOYAS', 5),
(5, 'CESAR', 4),
(6, 'MARTIN FIERRO', 3);

INSERT INTO PRODUCTORAS (ID_PRODUCTORA, NOMBRE)
VALUES
(1, 'PIXAR ANIMATION STUDIOS'),
(2, 'PARAMOUNT PICTURES'),
(3, '20TH CENTURY STUDIOS'),
(4, 'STUDIO GHIBLI'),
(5, 'UNIVERSAL PICTURES'),
(6, 'AMBLIN ENTERTAINMENT'),
(7, 'LUCASFILM'),
(8, 'MARQUIS FILM'),
(9, 'LADD COMPANY'),
(10, 'ICON PRODUCTIONS'),
(11, 'WALT DISNEY PICTURES'),
(12, 'BUENA VISTA PICTURES'),
(13, 'JERRY BUCKHEIMER FILMS'),
(14, 'INTERSCOPE COMMUNICATIONS'),
(15, 'TEITLER FILM'),
(16, 'COLUMBIA PICTURES'),
(17, 'TORNASOL FILMS'),
(18, '100 BARES'),
(19, 'HISTORIAS CINEMATOGRAFICAS CINEMANIA'),
(20, 'PROGRESS COMMUNICATIONS'),
(21, 'TOUCHSTONE PICTURES'),
(22, 'SILVER SCREEN PARTNERS III');

INSERT INTO ROLES (ID_ROL, NOMBRE) VALUES
(1, 'PROTAGONISTA'),
(2, 'DIRECTOR'),
(3, 'ACTOR SECUNDARIO'),
(4, 'PRODUCTOR'),
(5, 'AUTOR'),
(6, 'EDITOR'),
(7, 'COMPOSITOR'),
(8, 'DIRECTOR DE FOTOGRAFIA'),
(9, 'GUIONISTA'),
(10, 'VOZ');

INSERT INTO CATEGORIAS_PREMIOS (ID_CATEGORIA, NOMBRE) VALUES
(1, 'MEJOR PELICULA'),
(2, 'MEJOR ACTOR'),
(3, 'MEJOR ACTRIZ'),
(4, 'MEJOR CANCION ORIGINAL'),
(5, 'MEJOR DIRECTOR'),
(6, 'MEJOR PELICULA DE HABLA NO INGLESA'),
(7, 'MEJOR GUION ORIGINAL'),
(8, 'MEJOR SONIDO'),
(9, 'MEJORES EFECTOS VISUALES'),
(10, 'MEJOR MONTAJE'),
(11, 'MEJOR DIRECCION DE ARTE'),
(12, 'MEJOR MONTAJE DE SONIDO'),
(13, 'MEJORES EFECTOS DE SONIDO'),
(14, 'MEJOR GUION ADAPTADO'),
(15, 'MEJOR EDICION'),
(16, 'MEJOR LARGOMETRAJE ANIMADO'),
(17, 'MEJOR PELICULA DE ANIMACION'),
(18, 'MEJOR CINEMATOGRAFIA'),
(19, 'MEJOR DISEÑO DE VESTUARIO'),
(20, 'MEJOR MAQUILLAJE'),
(21, 'MEJOR MEZCLA DE SONIDO');


INSERT INTO PELICULAS (ID_PELICULA, TITULO, FECHA_ESTRENO, DURACION, PARENT_ID, ORDEN_VISUALIZACION, ID_IDIOMA_ORIGINAL) 
VALUES
(1, 'Titanic', '1997-12-18', 194, NULL, 10, 1),
(2, 'Star Wars Episode I: The Phantom Menace', '1999-05-19', 133, NULL, 10, 1),
(3, 'Star Wars Episode II: Attack of the Clones', '2002-05-16', 142, 2, 20, 1),
(4, 'Star Wars Episode III: Revenge of the Sith', '2005-05-19', 140, 2, 30, 1),
(5, 'Star Wars Episode IV: A New Hope', '1977-05-25', 121, 2, 40, 1),
(6, 'Star Wars Episode V: The Empire Strikes Back', '1980-05-21', 124, 2, 50, 1),
(7, 'Star Wars Episode VI: Return of the Jedi', '1983-05-25', 135, 2, 60, 1),
(8, 'Star Wars Episode VII: The Force Awakens', '2015-12-14', 136, 2, 70, 1),
(9, 'Star Wars Episode VIII: The Last Jedi', '2017-12-09', 152, 2, 80, 1),
(10, 'Star Wars Episode IX: The Rise of Skywalker', '2019-12-16', 155, 2, 90, 1),
(11, 'Spirited Away', '2001-07-20', 125, NULL, 10, 3),
(12, 'Inside Out', '2015-05-18', 102, NULL, 10, 1),
(13, 'Braveheart', '1995-05-24', 177, NULL, 10, 1),
(14, 'Back to the Future', '1985-07-03', 111, NULL, 10, 1),
(15, 'Back to the Future II', '1989-11-22', 108, 14, 20, 1),
(16, 'Back to the Future III', '1990-05-25', 118, 14, 30, 1),
(17, 'Forrest Gump', '1994-06-23', 142, NULL, 10, 1),
(18, 'Who Framed Roger Rabbit', '1988-06-21', 103, NULL, 10, 1),
(19, 'Indiana Jones and the Temple of Doom', '1984-05-23', 118, NULL, 10, 1),
(20, 'Indiana Jones and the Raiders of the Lost Ark', '1981-06-12', 115, 19, 20, 1),
(21, 'Indiana Jones and the Last Crusade', '1989-05-24', 127, 19, 30, 1),
(22, 'Indiana Jones and the Kingdom of the Crystall Skull', '2008-05-18', 140, 19, 40, 1),
(23, 'Indiana Jones and the Dial of Destiny', '2023-05-18', 142, 19, 50, 1),
(24, 'Jumanji', '1995-12-15', 101, NULL, 10, 1),
(25, 'Pirates of the Caribbean: The Curse of the Black Pearl', '2003-07-09', 143, NULL, 10, 1),
(26, 'Pirates of the Caribbean: Dead Man''s Chest', '2006-07-07', 151, 25, 20, 1),
(27, 'Pirates of the Caribbean: At World''s End', '2007-05-19', 180, 25, 30, 1),
(28, 'Pirates of the Caribbean: On Stranger Tides', '2011-05-20', 136, 25, 40, 1),
(29, 'Pirates of the Caribbean: Dead Men Tells No Tales', '2017-05-11', 129, 25, 50, 1),
(30, 'Toy Story', '1995-11-22', 81, NULL, 10, 1),
(31, 'Toy Story 2', '1999-11-13', 92, 30, 20, 1),
(32, 'Toy Story 3', '2010-06-18', 86, 30, 30, 1),
(33, 'Toy Story 4', '2019-06-14', 100, 30, 40, 1),
(34, 'Cars', '2006-03-14', 116, NULL, 10, 1),
(35, 'Cars 2', '2011-06-18', 107, 34, 20, 1),
(36, 'Cars 3', '2017-06-10', 109, 34, 30, 1),
(37, 'Coco', '2017-10-20', 109, NULL, 10, 1),
(38, 'El secreto de sus ojos', '2009-08-13', 127, NULL, 10, 2);

INSERT INTO PERSONAS (ID_PERSONA, NOMBRE, APELLIDO, SEXO, FECHA_NAC, ID_PAIS_NAC) VALUES
(1, 'KATE', 'WINSLET', 'F', '1975-10-05', 2),
(2, 'LEONARDO', 'DICAPRIO', 'M', '1974-11-11', 1),
(3, 'JAMES', 'CAMERON', 'M', '1954-08-16', 10),
(4, 'FRANCES', 'FISHER', 'F', '1952-05-11', 2),
(5, 'BILLY', 'ZANE', 'M', '1966-02-24', 1),
(6, 'MICHAEL', 'FOX', 'M', '1961-06-09', 10),
(7, 'CHRISTOPHER', 'LLOYD', 'M', '1938-10-22', 1),
(8, 'LEA', 'THOMPSON', 'F', '1961-05-31', 1),
(9, 'CRISPIN', 'GLOVER', 'M', '1964-04-20', 1),
(10, 'ROBERT', 'ZEMECKIS', 'M', '1952-05-14', 1),
(11, 'LIAM', 'NEESON', 'M', '1952-06-07', 11),
(12, 'EWAN', 'MCGREGOR', 'M', '1971-03-31', 9),
(13, 'NATALIE', 'PORTMAN', 'F', '1981-06-09', 12),
(14, 'JAKE', 'LLOYD', 'M', '1989-03-05', 1),
(15, 'GEORGE', 'LUCAS', 'M', '1944-05-14', 1),
(16, 'HAYDEN', 'CHRISTENSEN', 'M', '1981-04-19', 10),
(17, 'CHRISTOPHER', 'LEE', 'M', '1922-05-27', 2),
(18, 'MARK', 'HAMILL', 'M', '1951-09-25', 1),
(19, 'CARRIE', 'FISHER', 'F', '1956-10-21', 1),
(20, 'HARRISON', 'FORD', 'M', '1942-07-13', 1),
(21, 'ALEC', 'GUINNESS', 'M', '1914-04-02', 2),
(22, 'DAVID', 'PROWSE', 'M', '1935-07-01', 2),
(23, 'IRVIN', 'KERSHNER', 'M', '1923-04-29', 1),
(24, 'RICHARD', 'MARQUAND', 'M', '1937-09-22', 13),
(25, 'BILLY', 'WILLIAMS', 'M', '1937-04-06', 1),
(26, 'JEFFREY JACOB', 'ADAMS', 'M', '1966-06-27', 1),
(27, 'ADAM', 'DRIVER', 'M', '1983-11-19', 1),
(28, 'DAISY', 'RIDLEY', 'F', '1992-04-10', 2),
(29, 'RIAN', 'JOHNSON', 'M', '1973-12-17', 1),
(30, 'MEL', 'GIBSON', 'M', '1956-01-03', 1),
(31, 'CATHERINE', 'MCCORMACK', 'F', '1972-04-03', 2),
(32, 'SOPHIE', 'MARCEAU', 'F', '1966-11-17', 4),
(33, 'TOM', 'HANKS', 'M', '1956-07-09', 1),
(34, 'ROBIN', 'WRIGHT', 'F', '1966-04-08', 1),
(35, 'BOB', 'HOSKINS', 'M', '1942-10-26', 2),
(36, 'JOANNA', 'CASSIDY', 'F', '1945-08-02', 1),
(37, 'CHARLES', 'FLEISCHER', 'M', '1950-08-27', 1),
(38, 'STEVEN', 'SPIELBERG', 'M', '1946-12-18', 1),
(39, 'SEAN', 'CONNERY', 'M', '1930-08-25', 9),
(40, 'SHIA', 'LABEOUF', 'M', '1986-06-11', 1),
(41, 'CATHERINE', 'BLANCHETT', 'F', '1969-05-14', 14),
(42, 'KATE', 'CAPSHAW', 'F', '1953-11-03', 1),
(43, 'KAREN', 'ALLEN', 'F', '1951-10-05', 1),
(44, 'JOE', 'JOHNSTON', 'M', '1950-05-13', 1),
(45, 'ROBIN', 'WILLIAMS', 'M', '1951-07-21', 1),
(46, 'KIRSTEN', 'DUNST', 'F', '1982-04-30', 1),
(47, 'JOHNNY', 'DEPP', 'M', '1963-06-09', 1),
(48, 'KEIRA', 'KNIGTHLEY', 'F', '1985-03-26', 2),
(49, 'ORLANDO', 'BLOOM', 'M', '1977-01-13', 2),
(50, 'GORE', 'VERBINSKI', 'M', '1964-03-16', 1),
(51, 'GEOFFREY', 'RUSH', 'M', '1951-07-06', 14),
(52, 'BILL', 'NIGHY', 'M', '1949-12-12', 2),
(53, 'PENELOPE', 'CRUZ', 'F', '1974-04-28', 5),
(54, 'JOACHIM', 'RONNING', 'M', '1972-05-30', 15),
(55, 'ESPEN', 'SANDBERG', 'M', '1971-06-17', 15),
(56, 'JOHN', 'LASSETER', 'M', '1957-01-12', 1),
(57, 'LEE', 'UNKRICH', 'M', '1967-08-08', 1),
(58, 'JOSH', 'COOLEY', 'M', '1979-05-23', 1),
(59, 'TIM', 'ALLEN', 'M', '1953-06-13', 1),
(60, 'BRIAN', 'FEE', 'M', '1975-01-29', 1),
(61, 'ADRIAN', 'MOLINA', 'M', '1985-08-23', 1),
(62, 'JUAN JOSE', 'CAMPANELLA', 'M', '1959-07-19', 3),
(63, 'RICARDO', 'DARIN', 'M', '1957-01-16', 3),
(64, 'SOLEDAD', 'VILLAMIL', 'F', '1969-06-19', 3),
(65, 'PABLO', 'RAGO', 'M', '1972-09-24', 3),
(66, 'JAVIER', 'GODINO', 'M', '1978-03-11', 5),
(67, 'GUILLERMO', 'FRANCELLA', 'M', '1955-02-14', 3),
(68, 'PETE', 'DOCTER', 'M', '1968-10-09', 1),
(69, 'HAYAO', 'MIYAZAKI', 'M', '1941-01-05', 7),
(70, 'THOMAS', 'WILSON', 'M', '1959-04-15', 1),
(71, 'MARY', 'STEENBURGEN', 'F', '1953-02-08', 1),
(72, 'AMY', 'POEHLER', 'F', '1971-09-16', 1),
(73, 'PHYLLIS', 'SMITH', 'F', '1951-07-10', 1),
(74, 'RICHARD', 'KIND', 'M', '1956-11-22', 1),
(75, 'BILL', 'HADER', 'M', '1978-06-07', 1),
(76, 'RUMI', 'HIRAGI', 'F', '1987-08-01', 7),
(77, 'MIYU', 'IRINO', 'M', '1988-02-19', 7),
(78, 'JAMES', 'MANGOLD', 'M', '1963-12-16', 1),
(79, 'ROB', 'MARSHALL', 'M', '1960-10-17', 1),
(80, 'OWEN', 'WILSON', 'M', '1968-11-18', 1),
(81, 'ANTHONY', 'GONZALEZ', 'M', '2004-09-23', 1),
(82, 'KATHY', 'BATES', 'F', '1948-06-28', 1),
(83, 'GLORIA', 'STUART', 'F', '1910-07-04', 1),
(84, 'BILL', 'PAXTON', 'M', '1955-05-17', 1),
(85, 'BERNARD', 'HILL', 'M', '1944-12-17', 2),
(86, 'IAN', 'MCDIARMID', 'M', '1944-08-11', 2),
(87, 'PERNILLA', 'AUGUST', 'F', '1958-02-13', 16),
(88, 'FRANK', 'OZ', 'M', '1944-05-25', 2),
(89, 'OLIVER', 'FORD DAVIES', 'M', '1939-08-12', 2),
(90, 'HUGH', 'QUARSHIE', 'M', '1954-12-22', 17),
(91, 'SAMUEL', 'JACKSON', 'M', '1948-12-21', 1),
(92, 'TEMUERA', 'MORRINSON', 'M', '1960-12-26', 18),
(93, 'ANTHONY', 'DANIELS', 'M', '1946-02-21', 2),
(94, 'KENNY', 'BAKER', 'M', '1934-08-24', 2),
(95, 'PETER', 'MAYHEW', 'M', '1944-05-19', 2),
(96, 'PETER', 'CUSHING', 'M', '1913-05-26', 2),
(97, 'JOHN', 'BOYEGA', 'M', '1992-03-17', 2),
(98, 'MARI', 'NATSUKI', 'F', '1952-05-02', 7), 
(99, 'TAKASHI', 'NAITÔ', 'M', '1955-05-27', 7),
(100, 'YASUKO', 'SAWAGUCHI', 'F', '1965-06-11', 7),
(101, 'GARY', 'SINISE', 'M', '1955-03-17', 1),
(102, 'SALLY', 'FIELD', 'F', '1946-11-06', 1),
(103, 'MYKELTI', 'WILLIAMSON', 'M', '1957-03-04', 1),
(104, 'REBECCA', 'WILLIAMS', 'F', '1988-07-28', 1),
(105, 'CHARLES', 'FLEISCHER', 'M', NULL, NULL),
(106, 'JONATHAN', 'HYDE', 'M', '1948-05-21', 14),
(107, 'BRADLEY', 'PIERCE', 'M', '1982-10-23', 1),
(108, 'BONNIE', 'HUNT', 'F', '1961-09-22', 1),
(109, 'DONALD', 'RICKELS', 'M', '1926-05-08', 1),
(110, 'JOHN', 'MORRIS', 'M', '1984-10-02', 1),
(111, 'JIM', 'VARNEY', 'M', '1949-06-15', 1),
(112, 'WALLACE', 'SHAWN', 'M', '1943-11-12', 1),
(113, 'JOHN', 'RATZENBERGER', 'M', '1947-04-06', 1),
(114, 'ANNIE', 'POTTS', 'F', '1952-10-28', 1),
(115, 'JOAN', 'CUSACK', 'F', '1962-11-11', 1),
(116, 'KELSEY', 'GRAMMER', 'M', '1955-02-21', 1),
(117, 'PAUL', 'NEWMAN', 'M', '2008-09-26', 1),
  
  


INSERT INTO PELICULAS_GENEROS (ID_PELICULA, ID_GENERO) VALUES
(1, 1), (1, 2),
(2, 4), (2, 9), (2, 5),
(3, 4), (3, 9), (3, 5),
(4, 4), (4, 9), (4, 5),
(5, 4), (5, 9), (5, 5),
(6, 4), (6, 9), (6, 5),
(7, 4), (7, 9), (7, 5),
(8, 4), (8, 9), (8, 5),
(9, 4), (9, 9), (9, 5),
(10, 4), (10, 9), (10, 5),
(11, 6),
(12, 6), (12, 8),
(13, 3), (13, 2),
(14, 4), (14, 9), (14, 8),
(15, 4), (15, 9), (15, 8),
(16, 4), (16, 9), (16, 8),
(17, 2),
(18, 6), (18, 8),
(19, 3), (19, 4),
(20, 3), (20, 4),
(21, 3), (21, 4),
(22, 3), (22, 4),
(23, 3), (23, 4),
(24, 5), (24, 8),
(25, 4), (25, 8),
(26, 4), (26, 8),
(27, 4), (27, 8),
(28, 4), (28, 8),
(29, 4), (29, 8),
(30, 6), (30, 4), (30, 8),
(31, 6), (31, 4), (31, 8),
(32, 6), (32, 4), (32, 8),
(33, 6), (33, 4), (33, 8),
(34, 6), (34, 4), (34, 8),
(35, 6), (35, 4), (35, 8),
(36, 6), (36, 4), (36, 8),
(37, 6), (37, 13),
(38, 2), (38, 14), (38, 15);

INSERT INTO PELICULAS_PREMIOS (ID_PELICULA, ID_PREMIO, NRO_EDICION, ID_CATEGORIA) VALUES
(1, 1, 70, 1), (1, 1, 70, 5), (1, 1, 70, 2), (1, 1, 70, 3), (1, 1, 70, 7), (1, 1, 70, 11),
(1, 1, 70, 18), (1, 1, 70, 19), (1, 1, 70, 15), (1, 1, 70, 20), (1, 1, 70, 21), (1, 1, 70, 9),
(11, 1, 75, 17),
(12, 1, 88, 16),
(17, 1, 67, 1), (17, 1, 67, 2), (17, 1, 67, 5), (17, 1, 67, 9), (17, 1, 67, 14), (17, 1, 67, 15),
(18, 1, 61, 10), (18, 1, 61, 9), (18, 1, 61, 12), (18, 1, 61, 13),
(20, 1, 55, 8), (20, 1, 55, 9), (20, 1, 55, 10), (20, 1, 55, 11),
(30, 1, 68, 4),
(38, 1, 82, 6);

INSERT INTO PELICULAS_PERSONAS (ID_PELICULA, ID_PERSONA, ID_ROL) VALUES
(1, 1, 3), (1, 2, 1), (1, 3, 2), (1, 4, 3), (1, 5, 3), (1, 82, 3), (1, 83, 3), (1, 84, 3), (1, 85, 3),
(14, 6, 1), (14, 7, 1), (14, 10, 2), (14, 8, 3), (14, 9, 3),
(15, 6, 1), (15, 7, 1), (15, 10, 2), (15, 8, 3), (15, 70, 3),
(16, 6, 1), (16, 7, 1), (16, 10, 2), (16, 70, 3), (16, 71, 3),
(17, 33, 1), (17, 10, 2), (17, 34, 3), (17, 101, 3), (17, 102, 3), (17, 103, 3), (17, 104, 3),
(2, 11, 1), (2, 12, 1), (2, 13, 1), (2, 14, 1), (2, 15, 2), (2, 86, 3), (2, 87, 3), (2, 88, 10), (2,89, 3), (2, 90, 3),
(3, 12, 1), (3, 13, 1), (3, 16, 1), (3, 17, 3), (3, 15, 2), (3, 91, 3), (3, 86, 3), (3, 87, 3), (3, 88, 10), (3, 92, 3),
(4, 16, 1), (4, 12, 1), (4, 13, 1), (4, 15, 2), (4, 86, 1), (4, 91, 3), (4, 88, 10), (4, 17, 3), (4, 92, 3), (4, 89, 3),
(5, 18, 1), (5, 19, 1), (5, 20, 1), (5, 21, 3), (5, 15, 2), (5, 96, 3), (5, 95, 3), (5, 94, 3), (5, 93, 3), (5, 22, 3),
(6, 18, 1), (6, 20, 1), (6, 19, 1), (6, 22, 3), (6, 23, 2), (6, 93, 3), (6, 25, 3), (6, 95, 3), (6, 94, 3), (6, 88, 10), (6, 86, 3), (6, 92, 3),
(7, 18, 1), (7, 20, 1), (7, 19, 1), (7, 25, 3), (7, 24, 2), (7, 95, 3), (7, 93, 3), (7, 88, 10), (7, 86, 3), (7, 21, 3), (7, 22, 3), (7, 94, 3),
(8, 20, 1), (8, 27, 1), (8, 28, 1), (8, 26, 2), (8, 97, 1), (8, 18, 3), (8, 19, 3), (8, 93, 3), (8, 95, 3), 
(9, 18, 1), (9, 19, 1), (9, 27, 1), (9, 28, 1), (9, 29, 2), (9, 97, 1), (9, 93, 3), (9, 88, 10), 
(10, 27, 1), (10, 28, 1), (10, 26, 2), (10, 97, 1), (10, 19, 3), (10, 18, 3), (10, 93, 3), (10, 25, 3), (10, 86, 3), (10, 88, 10), (10, 20, 3), 
(11, 69, 2), (11, 76, 10), (11, 77, 10), (11, 98, 10), (11, 99, 10), (11, 100, 10),
(12, 68, 2), (12, 72, 10), (12, 73, 10), (12, 74, 10), (12, 75, 10),
(13, 30, 1), (13, 30, 2), (13, 31, 3), (13, 32, 3),
(18, 35, 1), (18, 10, 2), (18, 36, 3), (18, 105, 10), (18, 7, 3),
(19, 38, 2), (19, 20, 1), (19, 42, 3), 
(20, 38, 2), (20, 20, 1), (20, 43, 3),
(21, 38, 2), (21, 20, 1), (21, 39, 3),
(22, 38, 2), (22, 20, 1), (22, 41, 3), (22, 40, 3), (22, 43, 3),
(23, 78, 2), (23, 20, 1), 
(24, 44, 2), (24, 45, 1), (24, 46, 3), (24, 106, 3), (24, 107, 3), (24, 108, 3),
(25, 47, 1), (25, 48, 1), (25, 49, 1), (25, 50, 2), (25, 51, 3),
(26, 47, 1), (26, 48, 1), (26, 49, 1), (26, 50, 2), (26, 52, 3),
(27, 47, 1), (27, 48, 1), (27, 49, 1), (27, 50, 2), (27, 51, 3),
(28, 47, 1), (28, 53, 3), (28, 51, 3), (28, 79, 2),
(29, 54, 2), (29, 55, 2), (29, 47, 1), (29, 51, 3),
(30, 56, 2), (30, 33, 10), (30, 59, 10), (30, 109, 10), (30, 110, 10), (30, 111, 10), (30, 112, 10), (30, 113, 10), (30, 114, 10), 
(31, 56, 2), (31, 33, 10), (31, 59, 10), (31, 109, 10), (31, 110, 10), (31, 111, 10), (31, 112, 10), (31, 113, 10), (31, 114, 10), (31, 115, 10), (31, 116, 10),
(32, 57, 2), (32, 33, 10), (32, 59, 10), (32, 109, 10), (32, 110, 10), (32, 111, 10), (32, 112, 10), (32, 113, 10), (32, 114, 10), (32, 115, 10),
(33, 58, 2), (33, 33, 10), (33, 59, 10), (33, 109, 10), (33, 110, 10), (33, 111, 10), (33, 112, 10), (33, 113, 10), (33, 114, 10), (33, 115, 10),
(34, 56, 2), (34, 80, 10), (34, 117, 10), 
(35, 56, 2), (35, 80, 10), 
(36, 60, 2), (36, 80, 10),  
(37, 57, 2), (37, 81, 10),
(38, 62, 2), (38, 63, 1), (38, 64, 1), (38, 67, 1), (38, 65, 3), (38, 66, 3);

INSERT INTO PELICULAS_TRADUCCIONES (ID_PELICULA, ID_IDIOMA, TITULO_TRADUCIDO) VALUES
(1, 4, 'Titanic'), (1, 2, 'Titanic'), (1, 5, 'Titanic'), (1, 6, 'Titanic'),
(2, 2, 'Star Wars Episodio I: La amenaza fantasma'), 
(3, 2, 'Star Wars Episodio II: El ataque de los clones'), 
(4, 2, 'Star Wars Episodio III: La venganza de los Sith'), 
(5, 2, 'Star Wars Episodio IV: Una nueva esperanza'), 
(6, 2, 'Star Wars Episodio V: El imperio contraataca'), 
(7, 2, 'Star Wars Episodio VI: El retorno del Jedi'), 
(8, 2, 'Star Wars Episodio VII: El despertar de la Fuerza'), 
(9, 2, 'Star Wars Episodio VIII: Los últimos Jedi'), 
(10, 2, 'Star Wars Episodio IX: El ascenso de Skywalker'), 
(11, 2, 'El viaje de Chihiro'), 
(12, 2, 'Intensa-Mente'), 
(13, 2, 'Corazón valiente'), 
(14, 2, 'Volver al futuro'), 
(15, 2, 'Volver al futuro II'), 
(16, 2, 'Volver al futuro III'), 
(17, 2, 'Forrest Gump'), 
(18, 2, '¿Quién engañó a Roger Rabbit?'), 
(19, 2, 'Indiana Jones y el templo de la perdición'), 
(20, 2, 'Indiana Jones y los cazadores del arca perdida'), 
(21, 2, 'Indiana Jones y la última cruzada'), 
(22, 2, 'Indiana Jones y el reino de la calavera de cristal'), 
(23, 2, 'Indiana Jones y el dial del destino'), 
(24, 2, 'Jumanji'), 
(25, 2, 'Piratas del Caribe: La maldición del Perla Negra'), 
(26, 2, 'Piratas del Caribe: El cofre de la muerte'), 
(27, 2, 'Piratas del Caribe: En el fin del mundo'), 
(28, 2, 'Piratas del Caribe: Navegando aguas misteriosas'), 
(29, 2, 'Piratas del Caribe: La venganza de Salazar'), 
(30, 2, 'Toy Story'), 
(31, 2, 'Toy Story 2'), 
(32, 2, 'Toy Story 3'), 
(33, 2, 'Toy Story 4'), 
(34, 2, 'Cars: Rápidos como el Rayo'), 
(35, 2, 'Cars 2'), 
(36, 2, 'Cars 3'), 
(37, 2, 'Coco'), 
(38, 1, 'The secret in their eyes');

INSERT INTO PELICULAS_PRODUCTORAS (ID_PELICULA, ID_PRODUCTORA) VALUES
(1, 2), (1, 3),
(2, 3), (2, 7),
(3, 2),
(4, 7),
(5, 7),
(6, 3),
(7, 3),
(8, 7),
(9, 7),
(10, 7),
(11, 4),
(12, 1),
(13, 3), (13, 2), (13, 8), (13, 9), (13, 10),
(14, 5), (14, 6),
(15, 5), (15, 6),
(16, 5), (16, 6),
(17, 2), (17, 16),
(18, 6), (18, 21), (18, 22),
(19, 2), (19, 7), 
(20, 2), (20, 7),
(21, 2), (21, 7),
(22, 2),
(23, 7),
(24, 14), (24, 15),
(25, 11), (25, 12), (25, 13),
(26, 11), (26, 12),
(27, 11), (27, 12),
(28, 11), (28, 13),
(29, 11), (29, 13),
(30, 1), (30, 11),
(31, 1), (31, 11),
(32, 1), (32, 11),
(33, 1), (33, 11),
(34, 1), (34, 11),
(35, 1), (35, 11),
(36, 1), (36, 11),
(37, 1), (37, 11),
(38, 17), (38, 18);
