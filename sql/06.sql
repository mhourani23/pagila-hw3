/*
 * This question and the next one are inspired by the Bacon Number:
 * https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon#Bacon_numbers
 *
 * List all actors with Bacall Number 1.
 * That is, list all actors that have appeared in a film with 'RUSSELL BACALL'.
 * Do not list 'RUSSELL BACALL', since he has a Bacall Number of 0.
 */

WITH russel_bacall_films AS (SELECT film.film_id FROM film JOIN film_actor USING(film_id) JOIN actor USING(actor_id) WHERE actor.actor_id = 112)
SELECT DISTINCT (actor.first_name || ' ' || actor.last_name) AS "Actor Name" FROM actor JOIN film_actor USING(actor_id) JOIN film USING(film_id) WHERE film.film_id IN (SELECT * FROM russel_bacall_films) AND actor.actor_id != 112 ORDER BY "Actor Name";
