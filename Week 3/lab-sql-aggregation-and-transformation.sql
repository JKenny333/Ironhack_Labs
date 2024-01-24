USE sakila; 
#Challenge 1
#1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
	#1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
    SELECT MAX(length) AS max_duration FROM film;
	SELECT MIN(length) AS min_duration FROM film;
  
	#1.2. Express the average movie duration in hours and minutes. Don't use decimals.
    SELECT 
    FLOOR(AVG(length) / 60) AS average_hours, 
    ROUND(AVG(length)) % 60 AS average_minutes
	FROM film;
    
#2. You need to gain insights related to rental dates:
	#2.1 Calculate the number of days that the company has been operating.
	#Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
	SELECT DATEDIFF(MAX(rental_date),MIN(rental_date)) as number_of_days_operating
    FROM rental;
    
    #2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
	
    SELECT rental_id, DATE_FORMAT(rental_date, '%M') as rental_month, DATE_FORMAT(rental_date, '%W') as rental_weekday
    FROM rental
	LIMIT 20;
    
    
    #2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
	#Hint: use a conditional expression.
    SELECT
    rental_id,
    CASE
        WHEN DATE_FORMAT(rental_date, '%W') = 'Saturday' OR DATE_FORMAT(rental_date, '%W') = 'Sunday' THEN 'Weekend'
        ELSE 'Workday'
    END AS day_type
	FROM rental;

    
#3. You need to ensure that customers can easily access information about the movie collection.
	# To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL,
    # replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
	#Please note that even if there are currently no null values in the rental duration column,
    # the query should still be written to handle such cases in the future.
	#Hint: Look for the IFNULL() function.
    SELECT title,
	IFNULL(length, 'Not Available') AS length
    FROM film
    ORDER by title;
    
    
#Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for 
# customers. To achieve this, you need to retrieve the concatenated first and last names of customers, 
#along with the first 3 characters of their email address, 
#so that you can address them by their first name and use their email address to send personalized recommendations. 
#The results should be ordered by last name in ascending order to make it easier to use the data

SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;




