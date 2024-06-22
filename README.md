![logo_ironhack_blue 7](https://user-images.githubusercontent.com/23629340/40541063-a07a0a8a-601a-11e8-91b5-2f13e4e6b441.png)

# Laboratorio | Procedimientos almacenados

En esta práctica de laboratorio, continuaremos trabajando en la base de datos de alquiler de películas [Sakila](https://dev.mysql.com/doc/sakila/en/).

### Instrucciones

Escriba consultas, procedimientos almacenados para responder las siguientes preguntas:

- En la práctica de laboratorio anterior escribimos una consulta para encontrar el nombre, apellido y correos electrónicos de todos los clientes que alquilaron películas de "Acción". Convierta la consulta en un procedimiento almacenado simple. Utilice la siguiente consulta:

  ```sql
    seleccione nombre, apellido, correo electrónico
    del cliente
    unirse al alquiler en customer.customer_id = rent.customer_id
    unirse al inventario en alquiler.inventory_id = inventario.inventory_id
    unirse a la película en film.film_id = inventario.film_id
    únete a film_category en film_category.film_id = film.film_id
    únete a la categoría en categoría.category_id = film_category.category_id
    donde categoría.nombre = "Acción"
    agrupar por nombre, apellido, correo electrónico;
  ```

- Ahora sigue trabajando en el procedimiento almacenado anterior para hacerlo más dinámico. Actualice el procedimiento almacenado de tal manera que pueda tomar un argumento de cadena para el nombre de la categoría y devolver los resultados para todos los clientes que alquilaron películas de esa categoría/género. Por ejemplo, podría ser "acción", "animación", "niños", "clásicos", etc.

- Escriba una consulta para verificar la cantidad de películas estrenadas en cada categoría de películas. Convierta la consulta en un procedimiento almacenado para filtrar solo aquellas categorías que tienen películas lanzadas más de un número determinado. Pase ese número como argumento en el procedimiento almacenado.