-- Comparison operators

USE MyDatabase;

SELECT *
FROM customers;


-- Retrieve all customers from Germany
SELECT * 
FROM customers
WHERE country='Germany';

-- Retrieve all customers who are not from Germany
SELECT *
FROM customers
WHERE country !='Germany'; -- you can also use <> which is equivalent to !=


-- Retrieve all customers with a score GT 500
SELECT *
FROM customers
WHERE score>500;

-- Retrieve all customers with a score of 500 or more
SELECT *
FROM customers
WHERE score>=500;

-- Retrieve all customers with a score of 500 or less
SELECT *
FROM customers
WHERE score<=500;

-- Retrieve all customers who are from the USA AND
-- have a score GT 500

SELECT *
FROM customers
WHERE country = 'USA' AND score>500;

-- Retrieve all customers who are either from the USA
-- OR have a score GT 500

SELECT * 
FROM customers
WHERE country = 'USA' OR score>500;

-- Retrieve all customers with a score NOT less than 500
SELECT *
FROM customers
WHERE NOT score<500;

-- Retrieve all customers whose score falls in the range between
-- 100 and 500

SELECT *
FROM customers
WHERE score BETWEEN 100 AND 500; -- with between , the boundaries are inclusive [a:b], not (a,b)

-- Retrieve all customers from either Germany or USA

SELECT *
FROM customers
WHERE country IN ('Germany','USA');

-- Like % for any and _ for 1 char
-- Find all customers whose first name starts with M

SELECT *
FROM customers
WHERE first_name LIKE 'M%';

-- Find all customers whose first name ends with n

SELECT *
FROM customers
WHERE first_name LIKE '%n';

-- Find all customers whose first name contains an r

SELECT *
FROM customers
WHERE first_name LIKE '%r%';

-- Find all customers whose first name contains an r in the third position

SELECT *
FROM customers
WHERE first_name LIKE '__r%';
