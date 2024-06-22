-- Lab | Stored procedures
-- In this lab, we will continue working on the Sakila database of movie rentals.

-- Instructions
-- Write queries, stored procedures to answer the following questions:

-- 1. En el laboratorio anterior escribimos una consulta para encontrar nombre, apellido y correos electrónicos de todos los clientes que alquilaron películas de Acción. Convierta la consulta en un procedimiento almacenado simple. 
-- Utilice la siguiente consulta:
USE sakila;
  
  DELIMITER //
CREATE PROCEDURE GetActionMovieCustomers()
BEGIN
    SELECT first_name, last_name, email
    FROM customer
    JOIN rental ON customer.customer_id = rental.customer_id
    JOIN inventory ON rental.inventory_id = inventory.inventory_id
    JOIN film ON film.film_id = inventory.film_id
    JOIN film_category ON film_category.film_id = film.film_id
    JOIN category ON category.category_id = film_category.category_id
    WHERE category.name = "Action"
    GROUP BY first_name, last_name, email;
END //
DELIMITER ;
-- OTRO METODO (no sabemos porque no funciona):
  CREATE PROCEDURE action_clients(first_name, last_name, email)
  BEGIN
	  select first_name, last_name, email
	  from customer
	  join rental on customer.customer_id = rental.customer_id
	  join inventory on rental.inventory_id = inventory.inventory_id
	  join film on film.film_id = inventory.film_id
	  join film_category on film_category.film_id = film.film_id
	  join category on category.category_id = film_category.category_id
	  where category.name = "Action"
	  group by first_name, last_name, email
  END;


  
  -- 2. Ahora sigue trabajando en el procedimiento almacenado anterior para hacerlo más dinámico. 
  -- Actualice el procedimiento almacenado de tal manera que pueda tomar un argumento de cadena para el nombre de la categoría y devuelva los resultados de todos los clientes que alquilaron películas de esa categoría/género. 
  -- Por ejemplo, podría ser acción, animación, niños, clásicos, etc.
  
 DELIMITER //
 CREATE PROCEDURE GetCustomersByCategory(IN category_name VARCHAR(50))
BEGIN
    SELECT first_name, last_name, email
    FROM customer
    JOIN rental ON customer.customer_id = rental.customer_id
    JOIN inventory ON rental.inventory_id = inventory.inventory_id
    JOIN film ON film.film_id = inventory.film_id
    JOIN film_category ON film_category.film_id = film.film_id
    JOIN category ON category.category_id = film_category.category_id
    WHERE category.name = category_name
    GROUP BY first_name, last_name, email;
END //
DELIMITER ;
  
CALL GetCustomersByCategory('Action');
CALL GetCustomersByCategory('Animation');
  
 -- 3. Escriba una consulta para comprobar el número de películas estrenadas en cada categoría de películas. Convierte la consulta en un procedimiento almacenado para filtrar sólo aquellas categorías que tienen películas estrenadas por encima de un cierto número. 
 -- Pase ese número como argumento en el procedimiento almacenado.

DELIMITER //
DELIMITER //

CREATE PROCEDURE category_count_limit1(IN amount_limit VARCHAR(50))
BEGIN
    SELECT category.name AS category_name, COUNT(film.film_id) AS movie_count
    FROM category
    JOIN film_category ON category.category_id = film_category.category_id
    JOIN film ON film.film_id = film_category.film_id
    GROUP BY category.name
    HAVING COUNT(film.film_id) >= amount_limit;
END //

DELIMITER ;

CALL category_count_limit1(60);


    SELECT category.name AS category_name, COUNT(film.film_id) AS movie_count
    FROM category
    JOIN film_category ON category.category_id = film_category.category_id
    JOIN film ON film.film_id = film_category.film_id
    GROUP BY category.name
    HAVING COUNT(film.film_id) = 60;
 