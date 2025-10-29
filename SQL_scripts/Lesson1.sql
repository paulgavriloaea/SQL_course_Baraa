-- This is a comment

/* This is another comment

*/

-- Use 'MyDatabase' DB
USE MyDatabase;

-- How do I retrieve all the data?
SELECT * 
FROM customers;

SELECT *
FROM orders;

-- SELECT specific columns
SELECT 
	first_name,
	country,
	score
FROM customers;

-- Filter data with WHERE
-- Select all customers with a score>500
SELECT * 
FROM customers
WHERE score>500;

-- Select all customers with the score not 0
SELECT *
FROM customers
WHERE score!=0;

-- Select all customers from Germany
SELECT *
FROM customers
WHERE country='Germany';


-- Sort data with ORDER BY
-- Retrieve all results and sort them 
-- by country (asc) and score (desc)
SELECT *
FROM customers
ORDER BY 
	country ASC,
    score DESC;
    
-- Group by 
-- Combine rows with the same value by aggr. function
SELECT
	country,
	SUM(score) AS total -- aggregate function
FROM customers  
GROUP BY country; -- enforces an aggregate by country using the aggr. function

-- Find the total score and total number of customers 
-- for each country 

SELECT
	country,
	SUM(score) AS total_score,
    COUNT(country) AS total_customers
FROM customers
GROUP BY country;

-- HAVING , helps me filter after I use GROUP BY, WHERE would not work in this situation
SELECT
	country,
	SUM(score) AS total_score,
    COUNT(country) AS total_customers
FROM customers
WHERE score>400 # Filter data before aggregation
GROUP BY country
HAVING total_score>=850; #Filter data after aggregation


-- Find the average score for each country considering only customers with a score
-- 	not equal to 0 and return only those countries with an average score GT 430
SELECT
	country,
	AVG(score) AS mean
FROM customers
WHERE score != 0
GROUP BY country
HAVING mean>430;

-- SELECT DISTINCT (obvious from the name)

-- Return unique list of all countries

SELECT DISTINCT -- use DISTINCT only when necessary, slows code down otherwise
	country
FROM customers;


-- SELECT TOP to limit number of items shown . 
-- l.e: turns out SELECT TOP works on sql server , here i shoudl use LIMIT 3 as below. can also include OFFSET x.
SELECT *
FROM customers
LIMIT 3;

-- Retrieve the top 3 customers with the highest scores
SELECT *
FROM customers
ORDER BY score DESC
LIMIT 3;

-- Retrieve the 2 customers with the lowest scores
SELECT * 
FROM customers
ORDER BY score ASC
LIMIT 2;

-- Get the two most recent orders
SELECT * 
FROM orders
ORDER BY order_date DESC
LIMIT 2;

-- Static values 
SELECT 
	first_name,
	123 AS static_value,
	'New Customer' AS customer_type
FROM customers;




