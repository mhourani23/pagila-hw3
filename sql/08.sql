/*
 *
 * The film 'BUCKET BROTHERHOOD' is your favorite movie, but you're tired of watching it.
 * You want to find something new to watch that is still similar to 'BUCKET BROTHERHOOD'.
 * To find a similar movie, you decide to search the history of movies that other people have rented.
 * Your idea is that if a lot of people have rented both 'BUCKET BROTHERHOOD' and movie X,
 * then movie X must be similar and something you'd like to watch too.
 * Your goal is to create a SQL query that finds movie X.
 * Specifically, write a SQL query that returns all films that have been rented by at least 3 customers who have also rented 'BUCKET BROTHERHOOD'.
 *
 * HINT:
 * This query is very similar to the query from problem 06,
 * but you will have to use joins to connect the rental table to the film table.
 *
 * HINT:
 * If your query is *almost* getting the same results as mine, but off by 1-2 entries, ensure that:
 * 1. You are not including 'BUCKET BROTHERHOOD' in the output.
 * 2. Some customers have rented movies multiple times.
 *    Ensure that you are not counting a customer that has rented a movie twice as 2 separate customers renting the movie.
 *    I did this by using the SELECT DISTINCT clause.
 */

WITH rent AS (SELECT film_id, customer_id FROM rental JOIN inventory USING(inventory_id) JOIN film USING(film_id)),
bucket_brotherhood_customer AS (SELECT customer_id FROM rental JOIN inventory USING(inventory_id) JOIN film USING(film_id) WHERE film.film_id=103),
bucket_brotherhood_rent AS (SELECT * FROM rent WHERE customer_id IN (SELECT * FROM bucket_brotherhood_customer)),
more AS (SELECT film_id FROM bucket_brotherhood_rent GROUP BY film_id HAVING COUNT(DISTINCT bucket_brotherhood_rent.customer_id) >= 3)
SELECT DISTINCT title FROM film JOIN more USING(film_id) WHERE NOT film_id = 103 ORDER BY title;
