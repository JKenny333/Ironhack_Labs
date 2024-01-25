
# Challenge  Creating a Customer Summary Report

#Step 1: Create a View
-- First, create a view that summarizes rental information for each customer. 
-- The view should include the customer's ID, name, email address, and total number of rentals (rental_count).
USE sakila;

DROP VIEW IF EXISTS rental_summary;

CREATE VIEW rental_summary AS
SELECT customer_id, first_name, last_name, email, SUM(rental_id) AS rental_count
FROM customer
INNER JOIN rental
USING(customer_id)
GROUP BY customer_id;

SELECT * FROM rental_summary;

#Step 2: Create a Temporary Table
-- Next, create a Temporary Table that calculates the total amount paid by each customer (total_paid). 
-- The Temporary Table should use the rental summary view created in Step 1 to join with the payment table 
-- and calculate the total amount paid by each customer.

DROP TABLE IF EXISTS customer_payment_summary;

CREATE TEMPORARY TABLE customer_payment_summary AS
SELECT rs.customer_id, ct.total_paid
FROM 
	(SELECT customer_id, SUM(amount) as total_paid
	 FROM payment
	 GROUP BY customer_id)
	 AS ct
INNER JOIN rental_summary AS rs
USING(customer_id);

SELECT * FROM customer_payment_summary;

#Step 3: Create a CTE and the Customer Summary Report
-- Create a CTE that joins the rental summary View with the customer payment summary Temporary Table
-- created in Step 2. The CTE should include the customer's name, email address, rental count, 
-- and total amount paid.

WITH customer_summary_report AS (
    SELECT
		first_name,
        last_name, 
        email, 
        rental_count, 
        total_paid
    FROM rental_summary
    INNER JOIN customer_payment_summary
    USING(customer_id)
)
SELECT * FROM customer_summary_report;

-- Next, using the CTE, create the query to generate the final customer summary report, 
-- which should include: customer name, email, rental_count, total_paid and average_payment_per_rental,
--  this last column is a derived column from total_paid and rental_count.

WITH customer_summary_report AS (
    SELECT
		first_name,
        last_name, 
        email, 
        rental_count, 
        total_paid
    FROM rental_summary
    INNER JOIN customer_payment_summary
    USING(customer_id)
)
SELECT
    first_name,
    last_name,
    email,
    rental_count,
    total_paid,
	(total_paid / rental_count) AS average_payment_per_rental
FROM customer_summary_report;
