/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

WITH russel_bacall_films AS (SELECT film_id FROM actor JOIN film_actor USING(actor_id) WHERE actor_id = 112),
first_russel AS (SELECT actor_id FROM film_actor WHERE actor_id != 112 AND film_id IN (SELECT * FROM russel_bacall_films)),
first_russel_films AS (SELECT * FROM actor JOIN first_russel USING(actor_id) WHERE actor_id IN (SELECT * FROM first_russel)),
second_russel AS (SELECT actor_id FROM film_actor WHERE actor_id NOT IN (SELECT * FROM first_russel) AND film_id IN (SELECT film_id FROM first_russel_films) AND actor_id != 112)
SELECT DISTINCT CONCAT(actor.first_name, ' ', actor.last_name) AS "Actor Name" FROM second_russel JOIN actor USING(actor_id) ORDER BY "Actor Name";
