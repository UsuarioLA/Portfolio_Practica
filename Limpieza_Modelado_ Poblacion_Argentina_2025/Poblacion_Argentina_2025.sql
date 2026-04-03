-- SE CREA LA BASE DE DATOS --

CREATE DATABASE Poblacion_Argentina_2025;

USE Poblacion_Argentina_2025;

-- SE RENOMBA LA TABLA poblacion_identificada_departam$ --

EXEC sp_rename 
    'dbo.poblacion_identificada_departam$',
    'POBLACION';

 -- SE ELIMINAN COLUMNAS INNECESARIAS --

ALTER TABLE POBLACION
DROP COLUMN F10, F11, F12, F13, F14, F15, F16;

-- SE DETERMINAN TIPOS DE DATOS --

ALTER TABLE POBLACION
ALTER COLUMN Provincia_ID INT 

-- SE TRAE CADA PROVINCIA CON SU RESPECTIVO ID --

SELECT DISTINCT Provincia_ID, Provincia_Nombre
FROM POBLACION;

-- SE CORRIGE CODIFICACION DE CARACTERES EN BASE A LA CONSULTA ANTERIOR --

UPDATE POBLACION SET Provincia_Nombre = 'Entre R�os' WHERE Provincia_Nombre = 'Entre Ríos';
UPDATE POBLACION SET Provincia_Nombre = 'Tucum�n' WHERE Provincia_Nombre = 'Tucumán';
UPDATE POBLACION SET Provincia_Nombre = 'C�rdoba' WHERE Provincia_Nombre = 'Córdoba';
UPDATE POBLACION SET Provincia_Nombre = 'R�o Negro' WHERE Provincia_Nombre = 'Río Negro';
UPDATE POBLACION SET Provincia_Nombre = 'Neuqu�n' WHERE Provincia_Nombre = 'Neuquén';

-- SE CREA LA TABLA PROVINCIAS Y SE INSERTAN DATOS DE TABLA POBLACION --

CREATE TABLE PROVINCIAS (Provincia_ID INT PRIMARY KEY NOT NULL, Provincia_Nombre VARCHAR (50));

EXEC sp_rename 'dbo.Provincias', 'PROVINCIAS';

INSERT INTO PROVINCIAS (Provincia_ID,Provincia_Nombre)
SELECT DISTINCT Provincia_ID, Provincia_Nombre
FROM POBLACION;


-- SE CORRIGE TIPO DE DATO EN POBLACION Y SE DEFINE FOREIGN KEY  --

ALTER TABLE POBLACION
ALTER COLUMN Provincia_ID INT;

ALTER TABLE POBLACION
ADD CONSTRAINT FK_PD_Provincia
FOREIGN KEY (Provincia_ID) REFERENCES PROVINCIAS(Provincia_ID);

-- SE FILTRAN LOS DEPARTAMENTOS CON SUS RESPECTIVOS ID Y SE CORRIGE CODIFICACION DE CARACTERES MEDIANTE UNA TABLA DE CORRECION --

SELECT DISTINCT Departamento_ID, Nombre_Departamento
FROM POBLACION;

CREATE TABLE Correciones (Incorrecto VARCHAR(50), Correcto VARCHAR(50));
EXEC sp_rename 'dbo.Correciones', 'Correcciones';

INSERT INTO Correcciones VALUES
('Bahía Blanca','Bah�a Blanca'),('Benito Juárez','Benito Ju�rez'),('Bolívar','Bol�var'),('Cañuelas','Ca�uelas'),
('Capitán Sarmiento','Capit�n Sarmiento'),('Colón','Col�n'),('Coronel Suárez','Coronel Su�rez'),
('Esteban Echeverría','Esteban Echeverr�a'),('Exaltación de la Cruz','Exaltaci�n de la Cruz'),('General Pueyrredón','General Pueyrred�n'),
('General Rodríguez','General Rodr�guez'),('General San Martín','General San Mart�n'),('Guaminí','Guamin�'),
('Hipólito Yrigoyen','Hip�lito Yrigoyen'),('Ituzaingó','Ituzaing�'),('José C. Paz','Jos� C. Paz'),('Junín','Jun�n'),
('Lanús','Lan�s'),('Lobería','Lover�a'),('Luján','Luj�n'),('Maipú','Maip�'),('Morón','Mor�n'),('Olavarría','Olavarr�a'),
('Pehuajó','Pehuaj�'),('Presidente Perón','Presidente Per�n'),('Puán','Pu�n'),('Roque Pérez','Roque P�rez'),
('Salliqueló','Salliquel�'),('San Andrés de Giles','San Andr�s de Giles'),('San Nicolás','San Nicol�s'),('Tapalqué','Tapalqu�'),
('Vicente López','Vicente L�pez'),('Zárate','Z�rate'),('Andalgalá','Andalgal�'),('Belén','Bel�n'),('Capayán','Capay�n'),
('Fray Mamerto Esquiú','Fray Mamerto Esqui�'),('Paclín','Pacl��n'),('Pomán','Pom�n'),('Santa María','Santa Mar�a'),
('Ischilín','Ischil��n'),('Juárez Celman','Ju�rez Celman'),('Marcos Juárez','Marcos Ju�rez'),('Presidente Roque Sáenz Peña','Presidente Roque S�enz Pe�a'),
('Río Cuarto','R�o Cuarto'),('Río Primero','R�o Primero'),('Río Seco','R��o Seco'),('Río Segundo','Río Segundo'),('Unión','Uni�n'),
('Berón de Astrada','Ber�n de Astrada'),('Concepción','Concepci�n'),('Curuzú Cuatiá','Curuz� Cuati�'),('Itatí','Itat��'),
('Mburucuyá','Mburucuy�'),('Santo Tomé','Santo Tom�s'),('Comandante Fernández','Comandante Fern�ndez'),('Fray Justo Santa María de Oro','Fray Justo Santa Mar�a de Oro'),
('General Güemes','General G�emes'),('Libertador General San Martín','Libertador General San Mart�n'),('Maipú','Maip�'),('1º de Mayo','1� de Mayo'),
('Tapenagá','Tapenag�'),('Futaleufú','Futaleuf�'),('Languiñeo','Langui�eo'),('Mártires','M�rtires'),('Río Senguer','R��o Senguer'),
('Federación','Federaci�n'),('Gualeguaychú','Gualeguaych�'),('Nogoyá','Nogoy�'),('Paraná','Paran�'),('Patiño','Pati�o'),
('Pilagás','Pilag�s'),('Pirané','Piran�'),('Ramón Lista','Ram�n Lista'),('Palpalá','Palpal�'),('Santa Bárbara','Santa B�rbara'),
('Atreucó','Atreuc�'),('Catriló','Catril�'),('Curacó','Curac�'),('Chapaleufú','Chapaleuf�'),('Guatraché','Guatrach�'),('Loventué','Loventu�'),
('Maracó','Marac�'),('Puelén','Puel�n'),('Quemú Quemú','Quem� Quem�'),('Realicó','Realic�'),('Utracán','Utrac�n'),
('General Angel V. Peñaloza','General Angel V. Pe�aloza'),('Rosario Vera Peñaloza','Rosario Vera Pe�aloza'),('Guaymallén','Guaymall�n'),
('Luján de Cuyo','Luj�n de Cuyo'),('Maipú','Maip�'),('Malargüe','Malarg�e'),('Tunuyán','Tunuy�n'),('Apóstoles','Ap�stoles'),
('Cainguás','Caingu�s'),('Guaraní','Guaran��'),('Iguazú',',Iguaz�'),('Oberá','Ober�'),('Aluminé','Alumin�'),('Collón Curá','Coll�n Cur�'),
('Lácar','L�car'),('Loncopué','Loncopu�'),('Ñorquín','�orqu�n'),('Picún Leufú','Pic�n Leuf�'),('Ñorquinco','�orquinco'),
('General José de San Martín','General Jos� de San Mart�n'),('La Viña','La Vi�a'),('General José de San Martín','General Jos� de San Mart�n'),('La Viña','La Vi�a'),
('Metán','Met�n'),('Orán','Or�n'),('Albardón','Albard�n'),('Jáchal','J�chal'),('Santa Lucía','Santa Luc�a'),('Ullúm','Ull�m'),
('Valle Fértil','Valle F�rtil'),('Juan Martín Pueyrredón','Juan Mart��n Pueyrred�n'),('Güer Aike','G�er Aike'),('Río Chico','R�o Chico'),
('Constitución','Constituci�n'),('General López','General L�pez'),('San Cristóbal','San Crist�bal'),('San Jerónimo','San Jer�nimo'),
('Guasayán','Guasay�n'),('Jiménez','Jim�nez'),('Río Hondo','R��o Hondo'),('Silípica','Sil��pica'),('Burruyacú','Burruyac�'),('Famaillá','Famaill�'),
('Tafí del Valle','Taf�� del Valle'),('Tafí Viejo','Taf�� Viejo');

UPDATE Correcciones SET Correcto = 'R��o Segundo' WHERE Correcto = 'Río Segundo';
UPDATE Correcciones SET Correcto = 'Iguaz�' WHERE Correcto = ',Iguaz�';

--SE REALIZA UPDATE CON JOIN PARA CORREGIR LOS ERRORES DE CODIFICACION --

UPDATE P
SET Nombre_Departamento = C.Correcto
FROM POBLACION P
JOIN Correcciones C
ON P.Nombre_Departamento = C.Incorrecto;

-- SE CORRIGEN IDs DIFERENTES PARA UN MISMO DEPARTAMENTO --

SELECT DISTINCT Provincia_ID, Provincia_Nombre, Departamento_ID, Nombre_Departamento
FROM POBLACION WHERE Nombre_Departamento = 'Ciudad Autonoma de Buenos Aires';

UPDATE POBLACION SET Departamento_ID = 2000 WHERE Departamento_ID = 2084;

SELECT DISTINCT Provincia_ID, Provincia_Nombre, Departamento_ID, Nombre_Departamento
FROM POBLACION WHERE Departamento_ID = 6539;

UPDATE POBLACION SET Departamento_ID = 6540 WHERE Nombre_Departamento = 'Merlo';

SELECT DISTINCT Provincia_ID, Provincia_Nombre, Departamento_ID, Nombre_Departamento
FROM POBLACION WHERE Departamento_ID = 22168;

UPDATE POBLACION SET Departamento_ID = 22036 WHERE Nombre_Departamento = '12 de Octubre' AND Provincia_ID = 22 AND Departamento_ID <> 22036;
UPDATE POBLACION SET Departamento_ID = 22126 WHERE Nombre_Departamento = '1� de Mayo' AND Provincia_ID = 22 AND Departamento_ID <> 22126;
UPDATE POBLACION SET Departamento_ID = 22039 WHERE Nombre_Departamento = '2 de Abril' AND Provincia_ID = 22 AND Departamento_ID <> 22039;
UPDATE POBLACION SET Departamento_ID = 22105 WHERE Nombre_Departamento = '9 de Julio' AND Provincia_ID = 22 AND Departamento_ID <> 22105;
UPDATE POBLACION SET Departamento_ID = 22007 WHERE Nombre_Departamento = 'Almirante Brown' AND Provincia_ID = 22 AND Departamento_ID <> 22007;
UPDATE POBLACION SET Departamento_ID = 22014 WHERE Nombre_Departamento = 'Bermejo' AND Provincia_ID = 22 AND Departamento_ID <> 22014;
UPDATE POBLACION SET Departamento_ID = 22028 WHERE Nombre_Departamento = 'Chacabuco' AND Provincia_ID = 22 AND Departamento_ID <> 22028;
UPDATE POBLACION SET Departamento_ID = 22021 WHERE Nombre_Departamento = 'Comandante Fern�ndez' AND Provincia_ID = 22 AND Departamento_ID <> 22021;
UPDATE POBLACION SET Departamento_ID = 22043 WHERE Nombre_Departamento = 'Fray Justo Santa Mar�a de Oro' AND Provincia_ID = 22 AND Departamento_ID <> 22043;
UPDATE POBLACION SET Departamento_ID = 22049 WHERE Nombre_Departamento = 'General Belgrano' AND Provincia_ID = 22 AND Departamento_ID <> 22049;
UPDATE POBLACION SET Departamento_ID = 22056 WHERE Nombre_Departamento = 'General Donovan' AND Provincia_ID = 22 AND Departamento_ID <> 22056;
UPDATE POBLACION SET Departamento_ID = 22063 WHERE Nombre_Departamento = 'General G�emes' AND Provincia_ID = 22 AND Departamento_ID <> 22063;
UPDATE POBLACION SET Departamento_ID = 22070 WHERE Nombre_Departamento = 'Independencia' AND Provincia_ID = 22 AND Departamento_ID <> 22070;
UPDATE POBLACION SET Departamento_ID = 22077 WHERE Nombre_Departamento = 'Libertad' AND Provincia_ID = 22 AND Departamento_ID <> 22077;
UPDATE POBLACION SET Departamento_ID = 22084 WHERE Nombre_Departamento = 'Libertador General San Mart�n' AND Provincia_ID = 22 AND Departamento_ID <> 22084;
UPDATE POBLACION SET Departamento_ID = 22091 WHERE Nombre_Departamento = 'Maip�' AND Provincia_ID = 22 AND Departamento_ID <> 22091;
UPDATE POBLACION SET Departamento_ID = 22098 WHERE Nombre_Departamento = 'Mayor Luis J. Fontana' AND Provincia_ID = 22 AND Departamento_ID <> 22098;
UPDATE POBLACION SET Departamento_ID = 22112 WHERE Nombre_Departamento = 'O''Higgins' AND Provincia_ID = 22 AND Departamento_ID <> 22112;
UPDATE POBLACION SET Departamento_ID = 22119 WHERE Nombre_Departamento = 'Presidencia de la Plaza' AND Provincia_ID = 22 AND Departamento_ID <> 22119;
UPDATE POBLACION SET Departamento_ID = 22133 WHERE Nombre_Departamento = 'Quitilipi' AND Provincia_ID = 22 AND Departamento_ID <> 22133;
UPDATE POBLACION SET Departamento_ID = 22140 WHERE Nombre_Departamento = 'San Fernando' AND Provincia_ID = 22 AND Departamento_ID <> 22140;
UPDATE POBLACION SET Departamento_ID = 22147 WHERE Nombre_Departamento = 'San Lorenzo' AND Provincia_ID = 22 AND Departamento_ID <> 22147;
UPDATE POBLACION SET Departamento_ID = 22154 WHERE Nombre_Departamento = 'Sargento Cabral' AND Provincia_ID = 22 AND Departamento_ID <> 22154;
UPDATE POBLACION SET Departamento_ID = 22161 WHERE Nombre_Departamento = 'Tapenag�' AND Provincia_ID = 22 AND Departamento_ID <> 22161;

SELECT Provincia_ID, Nombre_Departamento, COUNT(DISTINCT Departamento_ID)
FROM POBLACION
GROUP BY Provincia_ID, Nombre_Departamento
HAVING COUNT(DISTINCT Departamento_ID) > 1;

SELECT Nombre_Departamento,
COUNT(DISTINCT Departamento_ID) AS IDs_distintos
FROM POBLACION
GROUP BY Nombre_Departamento
HAVING COUNT(DISTINCT Departamento_ID) > 1;

-- SE CREA LA TABLA DEPARTAMENTOS, SE INSERTAN DATOS Y SE DEFINEN LLAVES --

CREATE TABLE DEPARTAMENTOS( Departamento_ID INT PRIMARY KEY NOT NULL, Provincia_ID INT NOT NULL, Nombre_Departamento NVARCHAR(50)
CONSTRAINT FK_Departamentos_Provinicias
FOREIGN KEY (Provincia_ID)
REFERENCES PROVINCIAS (Provincia_ID));

INSERT INTO DEPARTAMENTOS (Departamento_ID, Provincia_ID, Nombre_Departamento)
SELECT DISTINCT Departamento_ID, Provincia_ID, Nombre_Departamento
FROM POBLACION;

ALTER TABLE POBLACION 
ALTER COLUMN Departamento_ID INT NOT NULL;

ALTER TABLE POBLACION
ADD CONSTRAINT FK_Departamentos_Poblacion
FOREIGN KEY (Departamento_ID)
REFERENCES DEPARTAMENTOS (Departamento_ID);

-- CONSULTA 1: POBLACION TOTAL POR PROVINCIA --

SELECT PR.Provincia_Nombre, SUM(P.Cantidad) AS Poblacion_Total
FROM POBLACION P
JOIN DEPARTAMENTOS D
ON D.Departamento_ID = P.Departamento_ID
JOIN PROVINCIAS PR
ON D.Provincia_ID = PR.Provincia_ID
GROUP BY PR.Provincia_Nombre
ORDER BY Poblacion_Total DESC;

-- CONSULTA 2: DISTRIBUCION DE POBLACION POR SEXO --

SELECT Sexo, SUM(Cantidad) AS Poblacion
FROM POBLACION
GROUP BY Sexo
ORDER BY Poblacion DESC;

-- CONSULTA 3: POBLACION POR GRUPO ETARIO --

SELECT Edad_Quinquenal, SUM(Cantidad) AS Poblacion
FROM POBLACION
GROUP BY Edad_Quinquenal
ORDER BY Poblacion DESC;

-- CONSULTA 4: DEPARTAMENTOS MAS POBLADOS --

SELECT D.Nombre_Departamento,PR.Provincia_Nombre, SUM(P.Cantidad) AS Poblacion_Total
FROM POBLACION P
JOIN DEPARTAMENTOS D
ON P.Departamento_ID = D.Departamento_ID
JOIN PROVINCIAS PR
ON D.Provincia_ID = PR.Provincia_ID
GROUP BY PR.Provincia_Nombre, D.Nombre_Departamento
ORDER BY Poblacion_Total DESC;

-- CONSULTA 5: DISTRIBUCION DE POBLACION POR SEXO Y GRUPO ETARIO --

SELECT Edad_Quinquenal, Sexo, SUM(Cantidad) AS Poblacion_Total
FROM POBLACION
GROUP BY Sexo, Edad_Quinquenal
ORDER BY Poblacion_Total DESC;

-- CONSULTA 6: POBLACION MAYOR DE 100 A�OS POR PRIOVINCIA --

SELECT PR.Provincia_Nombre, SUM(P.Cantidad) AS Poblacion_100A�os
FROM POBLACION P
JOIN PROVINCIAS PR
ON P.Provincia_ID = PR.Provincia_ID
WHERE P.Edad_Quinquenal = '100 y +'
GROUP BY PR.Provincia_Nombre
ORDER BY Poblacion_100A�os DESC;

-- CONSULTA 7: POBLACION NO NACIONALIZADA POR PROVINCIA --

SELECT PR.Provincia_Nombre, SUM(P.Cantidad) AS Poblacion_Total
FROM POBLACION P
JOIN PROVINCIAS PR
ON P.Provincia_ID = PR.Provincia_ID
WHERE P.Nacionalidad = 'EXTRANJERA' AND P.Pais_Nacimiento = 'OTRO PAIS'
GROUP BY PR.Provincia_Nombre
ORDER BY Poblacion_Total DESC;

-- CONSULTA 8: POBLACION NACIONALIZADA POR PROVINCIA --

SELECT PR.Provincia_Nombre, SUM(P.Cantidad) AS Poblacion_Total
FROM POBLACION P
JOIN PROVINCIAS PR
ON P.Provincia_ID = PR.Provincia_ID
WHERE P.Nacionalidad = 'ARGENTINA' AND P.Pais_Nacimiento = 'OTRO PAIS'
GROUP BY PR.Provincia_Nombre
ORDER BY Poblacion_Total DESC;

-- SE CREAN VISTAS PARA UTILIZAR EN POWER BI --

CREATE VIEW vw_poblacion_provincia AS
SELECT PR.Provincia_Nombre,
SUM(P.Cantidad) AS Poblacion_Total
FROM POBLACION P
JOIN DEPARTAMENTOS D
ON P.Departamento_ID = D.Departamento_ID
JOIN PROVINCIAS PR
ON D.Provincia_ID = PR.Provincia_ID
GROUP BY PR.Provincia_Nombre;

CREATE VIEW vw_poblacion_sexo AS
SELECT Sexo,
SUM(Cantidad) AS Poblacion
FROM POBLACION
GROUP BY Sexo;

CREATE VIEW vw_poblacion_edad AS
SELECT Edad_Quinquenal,
SUM(Cantidad) AS Poblacion
FROM POBLACION
GROUP BY Edad_Quinquenal;

CREATE VIEW vw_departamentos_poblacion AS
SELECT 
D.Nombre_Departamento,
PR.Provincia_Nombre,
SUM(P.Cantidad) AS Poblacion_Total
FROM POBLACION P
JOIN DEPARTAMENTOS D
ON P.Departamento_ID = D.Departamento_ID
JOIN PROVINCIAS PR
ON D.Provincia_ID = PR.Provincia_ID
GROUP BY PR.Provincia_Nombre, D.Nombre_Departamento;

CREATE VIEW vw_poblacion_extranjera AS
SELECT PR.Provincia_Nombre,
SUM(P.Cantidad) AS Poblacion_Extranjera
FROM POBLACION P
JOIN PROVINCIAS PR
ON P.Provincia_ID = PR.Provincia_ID
WHERE P.Nacionalidad = 'EXTRANJERA'
AND P.Pais_Nacimiento = 'OTRO PAIS'
GROUP BY PR.Provincia_Nombre;

CREATE VIEW vw_poblacion_nacionalizada AS
SELECT PR.Provincia_Nombre,
SUM(P.Cantidad) AS Poblacion_Nacionalizada
FROM POBLACION P
JOIN PROVINCIAS PR
ON P.Provincia_ID = PR.Provincia_ID
WHERE P.Nacionalidad = 'ARGENTINA'
AND P.Pais_Nacimiento = 'OTRO PAIS'
GROUP BY PR.Provincia_Nombre;

-- SE CREA COLUMNAS CON COORDENADAS DEL CENTROIDE APROXIMADO CADA PROVINCIA Y SE INSERTAN DATOS EN TABLA PROVINCIA --

ALTER TABLE PROVINCIAS ADD Latitud DECIMAL(9,6), Longitud DECIMAL(9,6);

UPDATE PROVINCIAS SET Latitud = -34.6145, Longitud = -58.4459 WHERE Provincia_ID = 2;
UPDATE PROVINCIAS SET Latitud = -36.6769, Longitud = -60.5588 WHERE Provincia_ID = 6;
UPDATE PROVINCIAS SET Latitud = -27.3358, Longitud = -66.9477 WHERE Provincia_ID = 10;
UPDATE PROVINCIAS SET Latitud = -32.1429, Longitud = -63.8018 WHERE Provincia_ID = 14;
UPDATE PROVINCIAS SET Latitud = -28.7743, Longitud = -57.8012 WHERE Provincia_ID = 18;
UPDATE PROVINCIAS SET Latitud = -26.3864, Longitud = -60.7653 WHERE Provincia_ID = 22;
UPDATE PROVINCIAS SET Latitud = -43.2934, Longitud = -65.1115 WHERE Provincia_ID = 26;
UPDATE PROVINCIAS SET Latitud = -31.7333, Longitud = -59.0000 WHERE Provincia_ID = 30;
UPDATE PROVINCIAS SET Latitud = -24.8949, Longitud = -59.9327 WHERE Provincia_ID = 34;
UPDATE PROVINCIAS SET Latitud = -23.3167, Longitud = -65.3000 WHERE Provincia_ID = 38;
UPDATE PROVINCIAS SET Latitud = -37.1316, Longitud = -65.4466 WHERE Provincia_ID = 42;
UPDATE PROVINCIAS SET Latitud = -29.4128, Longitud = -66.8549 WHERE Provincia_ID = 46;
UPDATE PROVINCIAS SET Latitud = -34.7879, Longitud = -68.4381 WHERE Provincia_ID = 50;
UPDATE PROVINCIAS SET Latitud = -27.3621, Longitud = -55.9000 WHERE Provincia_ID = 54;
UPDATE PROVINCIAS SET Latitud = -38.6418, Longitud = -70.1180 WHERE Provincia_ID = 58;
UPDATE PROVINCIAS SET Latitud = -40.8261, Longitud = -63.0000 WHERE Provincia_ID = 62;
UPDATE PROVINCIAS SET Latitud = -24.7990, Longitud = -65.4150 WHERE Provincia_ID = 66;
UPDATE PROVINCIAS SET Latitud = -30.8654, Longitud = -68.8895 WHERE Provincia_ID = 70;
UPDATE PROVINCIAS SET Latitud = -33.7577, Longitud = -66.0281 WHERE Provincia_ID = 74;
UPDATE PROVINCIAS SET Latitud = -48.8156, Longitud = -69.9558 WHERE Provincia_ID = 78;
UPDATE PROVINCIAS SET Latitud = -31.5855, Longitud = -60.7238 WHERE Provincia_ID = 82;
UPDATE PROVINCIAS SET Latitud = -27.7834, Longitud = -64.2642 WHERE Provincia_ID = 86;
UPDATE PROVINCIAS SET Latitud = -54.4296, Longitud = -67.1955 WHERE Provincia_ID = 94;
UPDATE PROVINCIAS SET Latitud = -26.9478, Longitud = -65.3648 WHERE Provincia_ID = 90;

SELECT*FROM PROVINCIAS;
