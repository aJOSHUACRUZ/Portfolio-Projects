USE sakila;

-- Exercise answers for O'Reilly Learning SQL Third Edition
-- All answers have been answered fairly except Exercises 11 -16 

-- Exercise 3-1
-- Retrieve the actor ID, first name, and last name for all actors. Sort by last name and then by first name
USE sakila;
SELECT actor_id, first_name, last_name
FROM actor
ORDER BY last_name, first_name;
/* My understanding of Exercise 3-1 
We will select the actor_id, first_name and last_name columns from the actor tables and 
sort them by last_name in ascending order and first name in ascending order */

-- Exercies 3-2
-- Retrieve the actor ID, first name, and last name for all actors whose last name equals 'WILLIAMS' or 'DAVIS'
SELECT actor_id, first_name, last_name
FROm actor
WHERE last_name IN ('WILLIAMS', 'DAVIS');

-- Exercise 3-3
-- Write a query against the rental table that returns the IDs of the customers who rented a film on July 5,2005
SELECT DISTINCT customer_id
FROM rental
WHERE date(rental_date) = '2005-07-05';

-- Exercise 3-4
SELECT c.email, r.return_date
FROM customer AS c 
INNER JOIN rental AS r
ON c.customer_id = r.customer_id
WHERE date(r.rental_date) = '2005-06-14'
ORDER BY return_date DESC;

-- Exercise 4-1
SELECT payment_id
FROM payment
WHERE customer_id <> 5 AND (amount > 8 OR DATE(payment_date) = '2005-08-23');

-- Exercise 4-2

SELECT payment_id
FROM payment
WHERE customer_id = 5 AND NOT (amount > 6 OR date(payment_date) = '2005-06-19');

-- Exercise 4-3
-- Contruct a query that retrieves all rows from the payment table where the amount is either 1.98, 7.98, or 9.98
SELECT amount
FROM payment
WHERE amount IN (1.98, 7.98, 9.98);

-- Exercise 4-4
-- Construct a query that finds all customers whose last name contains an A in the second position and a W anywhere after the A.
SELECT first_name, last_name
FROM customer
WHERE last_name LIKE '_A%W%';

-- Exercise 5-1
SELECT c.first_name, c.last_name, a.ddress, ct.city
FROM customer AS c
INNER JOIN address AS a
ON c.address_id = a.address_id
INNER JOIN city AS ct
ON a.city_id = ct.city_id
WHERE a.district = 'California';

-- Exercise 5-2
-- Write a query that retunrs the title of every film in which an actor with the first name JOHN appeared
SELECT f.title
FROM film AS f
INNER JOIN film_actor AS fa
ON f.film_id = fa.film_id
INNER JOIN actor AS a
ON fa.actor_id = a.actor_id
WHERE a.first_name = 'JOHN';

-- Exercise 5-3
-- Construct a query that returns all addresses that are in the same city. YOu will need to join the address table to itself, and each row should include two different addresses.alter
SELECT a1.address AS address_1, a2.address AS address_2, a1.city_id
FROM address AS a1
INNER JOIN address a2
ON a1.city_id = a2.city_id
WHERE a1.address_id <> a2.address_id;

-- Exercise 6-2
-- Write a coumpound query that finds the first and last names of all actors and customers whose last name start with L.
SELECT first_name, last_name
FROm actor
WHERE last_name LIKE 'L%'
UNION
SELECT first_name, last_name
FROm customer
WHERE last_name LIKE 'L%';

-- Exercise 6-3
-- Sort the reults from Exercise 6-2 by the last_name column
SELECT first_name, last_name
FROm actor
WHERE last_name LIKE 'L%'
UNION
SELECT first_name, last_name
FROm customer
WHERE last_name LIKE 'L%'
ORDER BY last_name;

-- Exercise 7-1
-- Write a query that returns the 17th through 25th characters of the string 'Please find the substring in this string'
SELECT SUBSTRING('Please find the substring in this string', 17, 9);

-- Exercise 7-2
-- Write a query that retunrs the absolute value and sign (-1, 0, or 1) of the number -2576823. Also return the number rounded to the nearest hundredth
SELECT ABS(-25.76823), SIGN(-25.76823), ROUND(-25.76823, 2);

-- Exercise 7-3
-- Write a query to retun just the month portion of the current date
SELECT EXTRACT(MONTH FROM CURRENT_DATE());

-- Excercise 8-1
-- Contruct a query that counds the number of rows in the payment table
SELECT COUNT(*)
FROM payment;
-- Exercise 8-2
-- Modify your query from Exercise 8-1 to count the number of payments made by each customer. Show the customer ID and the total amount paid for earch customer
SELECT customer_id, count(8) AS number_of_payments, sum(amount) AS total_amount_paid
FROm payment
GROUP BY customer_id;

-- Exercise 8-3
-- Modify your query from Exercise 8-2 to include only those customers who have made at least 40 payments
SELECT customer_id, count(8) AS number_of_payments, sum(amount) AS total_amount_paid
FROm payment
GROUP BY customer_id
HAVING count(*) >= 40;

-- Exercise 9-1
-- Contruct a query againts the flm table that uses a filter condition with a noncorrelated subquery againts the category table to find all action films (category.name = 'Action')
SELECT title
FROM film
WHERE film_id IN (
	SELECT fc.film_id
    FROm film_category AS fc
    INNER JOIN category AS c
    ON fc.category_id = c.category_id
    WHERE c.name = 'Action');
    
-- Exercise 9-2
-- Rework the query from Exercise 9-1 using a correlated subquiery againts the category and film_category tables to achieve the same results
SELECT f.title
FROm film AS f
WHERE EXISTS (
	SELECT 1
    FROM film_category AS fc
    INNER JOIN category AS c
    ON fc.category_id = c.category_id
    WHERE c.name = 'action' AND fc.film_id = f.film_id);
    
-- Exercise 9-3
SELECT a.actor_id_id, grps.level
FROM
(SELECT actor_id, COUNT(*) AS num_roles
FROM film_actor
GROUP BY actor_id) AS a
INNER JOIN
(SELECT 'Hollywood Star' level, 30 min_roles, 99999 max_roles
UNION ALL
SELECT 'Prolific Actor' level, 20 min_roles, 29 max_roles
UNION ALL
SELECT 'Newcomer' level, 1 min_roles, 19 max_roles) AS grps
on a.num_roles BETWEEN grps.min_roles AND grps.max_roles;

-- Exercises 10-1
SELECT c.name, sum(p.amount)
FROm customer AS c
LEFT OUTER JOIN payment AS p
ON c.customer_id = p.customer_id
GROUP BY c.name;


-- Exercise 10-2
-- Reformulate query from 10-2 to use the the other outer join type (use a right outer join) 
SELECT c.name, sum(p.amount)
FROm customer AS c
RIGHT OUTER JOIN payment AS p
ON c.customer_id = p.customer_id
GROUP BY c.name;

-- Exercise 10-3
-- Devise a query that will generate the set (1-100). Use a cross join with at least two from cluase subqueries

SELECT ones.x + tens.x +1
FROM
(SELECT 0 x UNION ALL
SELECT 1 x UNION ALL
SELECT 2 x UNION ALL
SELECT 3 x UNION ALL
SELECT 4 x UNION ALL
SELECT 5 x UNION ALL
SELECT 6 x UNION ALL
SELECT 7 x UNION ALL
SELECT 8 x UNION ALL
SELECT 9 x
) AS ones
CROSS JOIN
(SELECT 0 x UNION ALL
SELECT 10 x UNION ALL
SELECT 20 x UNION ALL
SELECT 30 x UNION ALL
SELECT 40 x UNION ALL
SELECT 50 x UNION ALL
SELECT 60 x UNION ALL
SELECT 70 x UNION ALL
SELECT 80 x UNION ALL
SELECT 90 x 
) AS tens;

-- Exercise 11-1
SELECT name, 
	CASE 
    WHEN name IN ('English', 'Italian', 'French', 'German') THEN 'latin1'
    WHEN name IN ('Japanese', 'Mandarin') THEN 'utf8'
    ELSE 'Unknown' END AS character_set
FROM language;

-- Exercise 11-2
SELECT
	SUM(CASE WHEN rating = 'G' THEN 1 ELSE 0 END) AS g,
    SUM(CASE WHEN rating = 'PG' THEN 1 ELSE 0 END) AS pg,
	SUM(CASE WHEN rating = 'pg-13' THEN 1 ELSE 0 END) AS pg_13,
    SUM(CASE WHEN rating = 'R' THEN 1 ELSE 0 END) AS r,
    SUM(CASE WHEN rating = 'NC-17-1' THEN 1 ELSE 0 END) AS nc_17
FROm film;

-- Exercise 12-1
-- Generate a unit of work to transfer $50 from account 123 to account 789
START TRANSACTION;
INSERT INTO transaction
(txn_id, txn_date, account_id, txn_type_cd, amount)
VALUES
(1003, now(), 123, 'D', 50);

INSERT INTO transaction
(txn_id, txn_date, account_id, txn_type_cd, amount)
VALUES
(1004, now(), 789, 'C', 50);

UPDATE account
SET avail_balance = available_balance - 50,
last_activity = now()
WHERE account_id = 123;

UPDATE account
SET avail_balance = available_balance + 50,
last_activity_data = now()
WHERE account_id = 789;

-- Exercise 13-1
-- Generate an alter table statement for the rental table so that an error will be raised if a row having a value found in the rental.customer_id is deleted from the customer table
ALTER TABLE rental
ADD CONSTRAINT fk_rental_customer_id FOREIGN KEY(customer_id)
REFERENCES customer(customer_id) ON DELETE RESTRICT;

-- Exercise 13-2
-- Generate a multicolumn index on the payment table that could be used by both of the following queries
SELECT customer_id, payment_date, amount
FROM payment
WHERE payment_date > cast('2019-01-2031 23:59:59' as DATETIME);

SELECT customer_id, payment_date, amount
FROM payment
WHERE payment_date > cast('2019-01-2031 23:59:59' as DATETIME)
AND amount < 5;

CREATE INDEX idx_payment01
ON payment(payment_date, amount);

-- Exercise 14-1
-- Create a view definition that can be used by the following query to generate the given results:
SELECT title, category_name, first_name, last_name
FROM film_ctgry_actor
WHERE last_name = 'FAWCETT';

CREATE VIEW film_ctgry_actor
AS
SELECT f.title, c.name AS category_name, a.first_name, a.last_name
FROM film AS f
INNER JOIN film_category AS fc
on f.film_id = fc.film_id
INNER JOIN category AS c
ON fc.category_id = c.category_id
INNER JOIN film_actor AS fa
ON fa.film_id = f.film_id
INNER JOIN actor AS a
ON fa_actor_id = a.actor_id;

-- Exercise 14-2
-- Generate a view definition that queries the country table and uses a scalar subquery to calculate a value for a clumn named tot_payments
CREATE VIEW country_payments AS
SELECT c.country,
(SELECT SUM(p.amount)
FROM city AS ct
INNER JOIN address AS a
ON ct.city_id = a.city_id
INNER JOIN customer AS cst
ON a.address_id = cst.address_id
INNER JOIN payment AS p
on cst.customer_id = p.customer_id
WHERE ct.country_id = c.country_id
) AS tot_payments
FROM country AS c;

-- Exercise 15-1
-- Write a query that lists all of the index in the Sakila schema. Include the table names
SELECT DISTINCT(table_name), index_name
FROm information_schema.statistics
WHERE table_schema = 'sakila';

-- Exercise 15-2
-- Write a query that generates output that can be used to create all of the indexes on the sakila.customer table.
-- Unable to answer yet need more practice 



-- Exercise 16-1 
-- Write a query that retrieves every row from Sales_Fact, and add a column to generate a ranking based on the tot_sales colun values. The highest values should receive a ranking of 1, and the lowest a ranking of 24
SELECT year_no, month_no, tot_sales, 
	rank() over(order by tot_sales DESC) AS sales_rank
FROM sales_fact;

-- Exercise 16-2
-- Modify the query year_no, month_no, tot_sales,
	SELECT year_no, month_no, tot_sales,
		RANK() over (partition by year_no ORDER BY tot_sales DESC) AS sales_rank
	FROm sales_fact;
    
-- Exercise 16-2
-- Write a query that retrieves all 2020 data, and include column that will contain the tot_sales value from the previous month
SELECT year_no, month_no, tot_sales,
	lag(tot_sales) OVER(ORDER BY month_no) AS prev_month_sales
    WHERE year_no = 2020;



















