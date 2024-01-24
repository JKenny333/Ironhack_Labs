#Challenge
#Write SQL queries to perform the following tasks using the Sakila database:
USE sakila;
# 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
    SELECT COUNT(film_id) as number_of_copies
	FROM inventory
	WHERE film_id = (SELECT film_id
						FROM film
						WHERE title = "Hunchback Impossible");
                        
# 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length)
						FROM film);

# 3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (SELECT actor_id
					FROM film_actor
					WHERE film_id = (SELECT film_id
										FROM film
										WHERE title = "Alone Trip"));


#Bonus:
# 4. Sales have been lagging among young families, and you want to target family movies for a promotion. 
	#Identify all movies categorized as family films.
SELECT name FROM category;
#sub query
SELECT title
FROM film
WHERE film_id IN (SELECT film_id
					FROM film_category
                    WHERE category_id IN (SELECT category_id
											FROM category
											WHERE name = "Family"));
#with join                                          
SELECT film.title, category.name
FROM film 
INNER JOIN film_category
USING(film_id)
INNER JOIN category
USING(category_id)
WHERE category.name = "Family";


    
# 5. Retrieve the name and email of customers from Canada using both subqueries and joins. 
	# To use joins, you will need to identify the relevant tables and their primary and foreign keys.
#with subqueries
SELECT first_name, last_name, email
FROM customer
WHERE address_id IN(SELECT address_id
						FROM address
                        WHERE city_id IN(SELECT city_id
											FROM city
                                            WHERE country_id IN(SELECT country_id
																	FROM country
																	WHERE country = "Canada")));




#with joins
SELECT cu.first_name, cu.last_name, cu.email, co.country
FROM customer as cu
INNER JOIN address
USING(address_id)
INNER JOIN city
USING(city_id)
INNER JOIN country as co
USING(country_id)
WHERE co.country = "Canada";  
    
# 6. Determine which films were starred by the most prolific actor in the Sakila database.
	# A prolific actor is defined as the actor who has acted in the most number of films.
    # First, you will need to find the most prolific actor and then use that actor_id to find the 
    # different films that he or she starred in.
    
SELECT title
FROM film
WHERE actor_id = (SELECT actor_id
					FROM film_actor
                    WHERE IN 
                    
SELECT 
FROM film_actor 
INNER JOIN film
USING(address_id)
INNER JOIN city
USING(city_id)
INNER JOIN country as co
USING(country_id)
WHERE co.country = "Canada";                     
    
# 7. Find the films rented by the most profitable customer in the Sakila database. 
	# You can use the customer and payment tables to find the most profitable customer, 
    # i.e., the customer who has made the largest sum of payments.
    
    
# 8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average
	# of the total_amount spent by each client. You can use subqueries to accomplish this.