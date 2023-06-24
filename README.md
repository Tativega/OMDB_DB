# OMDB_DB


# 1. Los nombres de las películas junto con su director, que tenga más de una parte. Ordenadas por orden en que deben ser vistas. Ejemplo volver al futuro tiene 3 partes.

```sql
SELECT P.TITULO
FROM PELICULAS AS P
WHERE P.PARENT_ID IS NOT NULL OR P.ID IN (
    SELECT PARENT_ID FROM PELICULAS
)
ORDER BY (CASE WHEN P.PARENT_ID IS NULL THEN P.ID ELSE P.PARENT_ID END), ORDEN_VISUALIZACION;
```

# 2. Los nombres de las películas en donde su director también sea el actor principal.
# 3. Los nombres de todas las películas, junto con la cantidad de actores que actúan en cada una, ordenadas por cantidad de actores en forma descendiente. 
# 4. Los nombres de las películas que no tengan ningún actor.
# 5. Los nombres de los actores que actúan en más de una película de la base de datos.
# 6. La duración promedio (en minutos) de las películas estrenadas antes del año 2000.
# 7. El nombre de las películas que hayan ganado un oscar y su idioma original no sea el inglés.
# 8. El nombre alguna película (Que no sea Star Wars) en donde haya participado algún actor de la película Star Wars (11)
# 9. El listado de películas con su tiempo de duración donde su nombre en castellano sea igual a su nombre original en el idioma en que fue creada.
# 10. La cantidad de películas agrupadas por género. Animación, Aventura, Terror, etc. 
