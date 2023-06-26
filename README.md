# OMDB_DB


# 1. Los nombres de las películas junto con su director, que tenga más de una parte. Ordenadas por orden en que deben ser vistas. Ejemplo volver al futuro tiene 3 partes.

```sql
SELECT PEL.TITULO, PER.NOMBRE, PER.APELLIDO
FROM PELICULAS AS PEL
INNER JOIN PELICULAS_PERSONAS AS PP ON PEL.ID_PELICULA = PP.ID_PELICULA
INNER JOIN PERSONAS AS PER ON PER.ID_PERSONA = PP.ID_PERSONA
WHERE (PEL.PARENT_ID IS NOT NULL OR PEL.ID_PELICULA IN (SELECT PARENT_ID FROM PELICULAS)) 
AND PP.ID_ROL = 2
ORDER BY PEL.TITULO, PEL.ORDEN_VISUALIZACION;
```

# 2. Los nombres de las películas en donde su director también sea el actor principal.

```sql
SELECT PEL.TITULO
FROM PELICULAS AS PEL
INNER JOIN PELICULAS_PERSONAS PP1 ON PEL.ID_PELICULA = PP1.ID_PELICULA
INNER JOIN PELICULAS_PERSONAS PP2 ON PEL.ID_PELICULA = PP2.ID_PELICULA
INNER JOIN PERSONAS PER1 ON PP1.ID_PERSONA = PER1.ID_PERSONA
INNER JOIN PERSONAS PER2 ON PP2.ID_PERSONA = PER2.ID_PERSONA
WHERE PP1.ID_ROL = 2 AND PP2.ID_ROL = 1
AND PER1.ID_PERSONA = PER2.ID_PERSONA;
```

# 3. Los nombres de todas las películas, junto con la cantidad de actores que actúan en cada una, ordenadas por cantidad de actores en forma descendiente. 

```sql
SELECT PEL.TITULO, COUNT(PP.ID_PERSONA) AS CANTIDAD_ACTORES
FROM PELICULAS PEL
INNER JOIN PELICULAS_PERSONAS PP ON PEL.ID_PELICULA = PP.ID_PELICULA
WHERE PP.ID_ROL = 1 OR PP.ID_ROL = 3 OR PP.ID_ROL = 10
GROUP BY PEL.ID_PELICULA, PEL.TITULO
ORDER BY CANTIDAD_ACTORES DESC;
```

# 4. Los nombres de las películas que no tengan ningún actor.

```sql
SELECT PEL.TITULO FROM PELICULAS AS PEL
WHERE NOT EXISTS (
SELECT 1
FROM PELICULAS_PERSONAS AS PP
WHERE PEL.ID_PELICULA = PP.ID_PELICULA
AND ID_ROL IN (1, 3)
);

```

# 5. Los nombres de los actores que actúan en más de una película de la base de datos.

```sql
SELECT CONCAT(PER.NOMBRE, ' ', PER.APELLIDO) AS ACTORES FROM PERSONAS PER
INNER JOIN PELICULAS_PERSONAS PP ON PER.ID_PERSONA = PP.ID_PERSONA
WHERE PP.ID_ROL = 1 OR PP.ID_ROL = 3
GROUP BY PER.NOMBRE, PER.APELLIDO
HAVING COUNT(DISTINCT PP.ID_PELICULA) > 1;
```
# 6. La duración promedio (en minutos) de las películas estrenadas antes del año 2000.

```sql
SELECT AVG(DURACION) FROM PELICULAS
WHERE YEAR(FECHA_ESTRENO) < 2000;
```

# 7. El nombre de las películas que hayan ganado un oscar y su idioma original no sea el inglés.

```sql
SELECT PEL.TITULO FROM PELICULAS PEL
INNER JOIN PELICULAS_PREMIOS PP ON PEL.ID_PELICULA = PP.ID_PELICULA
WHERE PP.ID_PREMIO = 1 AND PEL.ID_IDIOMA_ORIGINAL <> '1';
```

# 8. El nombre alguna película (Que no sea Star Wars) en donde haya participado algún actor de la película Star Wars (11)

```sql
SELECT DISTINCT PEL.TITULO FROM PELICULAS PEL
INNER JOIN PELICULAS_PERSONAS PP ON PEL.ID_PELICULA = PP.ID_PELICULA
INNER JOIN PERSONAS PER ON PP.ID_PERSONA = PER.ID_PERSONA
WHERE PP.ID_PERSONA IN
    (SELECT DISTINCT PER2.ID_PERSONA 
    FROM PELICULAS_PERSONAS PP2
    INNER JOIN PERSONAS PER2 ON PP2.ID_PERSONA = PER2.ID_PERSONA
    INNER JOIN PELICULAS PEL2 ON PP2.ID_PELICULA = PEL2.ID_PELICULA
    WHERE PEL2.TITULO LIKE '%STAR WARS%' AND PP2.ID_ROL IN (1, 3))
AND PEL.TITULO NOT LIKE '%STAR WARS%';
```

# 9. El listado de películas con su tiempo de duración donde su nombre en castellano sea igual a su nombre original en el idioma en que fue creada.

```sql
SELECT PEL.TITULO "Titulo original", PEL.DURACION, PT.TITULO_TRADUCIDO "Titulo traducido", I.NOMBRE "Idioma traduccion"
FROM PELICULAS AS PEL
INNER JOIN PELICULAS_TRADUCCIONES AS PT ON PEL.ID_PELICULA = PT.ID_PELICULA
INNER JOIN IDIOMAS AS I ON PT.ID_IDIOMA = I.ID_IDIOMA
WHERE PEL.TITULO = PT.TITULO_TRADUCIDO AND PT.ID_IDIOMA = 2
ORDER BY PEL.ID_PELICULA;
```

# 10. La cantidad de películas agrupadas por género. Animación, Aventura, Terror, etc. 

```sql
 SELECT G.NOMBRE AS GENERO, COUNT(PG.ID_PELICULA) AS CANTIDAD_PELICULAS
 FROM GENEROS G
 INNER JOIN PELICULAS_GENEROS AS PG ON G.ID_GENERO = PG.ID_GENERO
 GROUP BY G.ID_GENERO;
```
