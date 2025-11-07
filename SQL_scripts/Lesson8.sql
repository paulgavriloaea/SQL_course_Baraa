-- ISNULL() COALESCE from null to value

-- NULLIF value to null

-- IS NULL and IS NOT NULL


-- ISNULL(value, replacement_value) doesnt really work like this in MySQL, you
-- have IFNULL in MySQL that behaves identical.  ISNULL in Mysql can take only one
-- argument

USE salesdb;

SELECT 
	shipaddress,
    billaddress,
    IFNULL(shipaddress,billaddress),
    ISNULL(shipaddress)
FROM orders;


-- Coalesce(value1, value 2, value3) retursn the first non-null value , if value 1 is null, it returns value 2. if value 1 is not null it returns value 1
-- if all are null you can input a default element Coalesce(value1, value 2, default)
SELECT 
	shipaddress,
    COALESCE(shipaddress,billaddress, 'This is my default')
FROM orders;



-- Handle the null before doing data aggregations for instance replacing the null to 0.

 
-- Find the average scores of the customers

SELECT
	AVG(score) -- does not take into account the null value N items = 4
FROM customers;

SELECT
	AVG(COALESCE(score,0)) -- takes into account the null value but conversts it to 0 , N=5
FROM customers;

-- you can also do the following to include the avg score everywhere
SELECT
	firstname,
	AVG(COALESCE(score,0)) OVER () AvgScores -- takes into account the null value but conversts it to 0 , N=5
FROM customers;

-- Handle the null before doing math operations
-- display the full name of the customers in a single field 
-- by merging their first and last names and add 10 bonus points to each customer's score
SELECT
	IFNULL(CONCAT(firstname,' ',lastname),'No Name'),
    firstname + ' ' + lastname,
    IFNULL(score,0),
	IFNULL(score+10,0)
FROM customers;

-- Handle the NULL before doing JOINS
-- handle the null before sorting data

-- Sort the customers from lowest to highest scores,
-- with NULLs appearing last.

SELECT 
	firstname,
    score,
    CASE WHEN score IS NULL THEN 1 ELSE 0 END Flag
FROM customers
ORDER BY Flag ASC, score ASC;


-- NULL IF , comapres two expression, returns NULL if they are equal. 
-- returns first value if they are not equal

SELECT 
	billaddress,
    shipaddress,
	NULLIF(billaddress,shipaddress)
FROM orders;


-- preventing the error of dividing by zero
-- find the sales price for each order by dividing the sales by the quantity


SELECT 
	sales,
	sales/NULLIF(quantity,0) -- if the two values are equal, return a null instead.
FROM orders;

-- return true if the value is null IS NULL 
-- return true if the value is not null IS NOT NULL
 
-- Identify the customers who have no scores

SELECT 
	firstname,lastname
FROM customers
WHERE score IS NULL;

-- Identify the customers who have scores
SELECT 
	firstname,lastname
FROM customers
WHERE score IS NOT NULL;

-- Find the unmatched rows between two tables
-- list all details for customers who have not placed any orders

SELECT 
	*
FROM customers AS c
LEFT JOIN orders AS o ON c.customerid = o.customerid
WHERE o.customerid IS NULL;


