# OMDB_DB


# 1. Los nombres de las películas junto con su director, que tenga más de una parte. Ordenadas por orden en que deben ser vistas. Ejemplo volver al futuro tiene 3 partes.

```sql
SELECT *
FROM PELICULAS AS P
WHERE P.PARENT_ID IS NOT NULL OR P.ID_PELICULA IN (
    SELECT PARENT_ID FROM PELICULAS WHERE PARENT_ID IS NOT NULL
)
ORDER BY (CASE WHEN P.PARENT_ID IS NULL THEN P.ID_PELICULA ELSE P.PARENT_ID END), ORDEN_VISUALIZACION;
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
# 4. Los nombres de las películas que no tengan ningún actor.

```sql
SELECT PEL.TITULO FROM PELICULAS AS PEL
INNER JOIN PELICULAS_GENEROS PG ON PEL.ID_PELICULA = PG.ID_PELICULA
INNER JOIN GENEROS G ON PG.ID_GENERO = G.ID_GENERO
WHERE G.ID_GENERO = 6;

```

# 5. Los nombres de los actores que actúan en más de una película de la base de datos.

```sql
SELECT CONCAT(PER.NOMBRE, ' ', PER.APELLIDO) AS ACTORES FROM PERSONAS PER
INNER JOIN PELICULAS_PERSONAS PP ON PER.ID_PERSONA = PP.ID_PERSONA
WHERE PP.ID_ROL = 1 OR PP.ID_ROL = 3
GROUP BY PER.NOMBRE, PER.APELLIDO
HAVING COUNT (DISTINCT PP.ID_PELICULA) > 1;
```
# 6. La duración promedio (en minutos) de las películas estrenadas antes del año 2000.
# 7. El nombre de las películas que hayan ganado un oscar y su idioma original no sea el inglés.
# 8. El nombre alguna película (Que no sea Star Wars) en donde haya participado algún actor de la película Star Wars (11)
# 9. El listado de películas con su tiempo de duración donde su nombre en castellano sea igual a su nombre original en el idioma en que fue creada.
# 10. La cantidad de películas agrupadas por género. Animación, Aventura, Terror, etc. 
