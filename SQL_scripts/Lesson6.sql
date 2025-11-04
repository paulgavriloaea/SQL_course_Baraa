-- SET operators

-- With set operators, you can use order by only at the end of the query..makes sense.
-- The number of columns in each query must be the same
-- also data types in the columns match column
-- The order of columns also must be the same
-- The first query controls the naming of the output columns, if you want to use aliases, you have to use it only in the first query


-- UNION : it returns all distinct rows from both queries, removes all the duplcates from the combined result

-- task: combine the data from employees and customers into one table
USE salesdb;

SELECT
	firstname,
	lastname
FROM customers

UNION

SELECT
	firstname,
    lastname
FROM employees;

-- UNION ALL , returns everything from both selects with the distinction that 
-- it does not remove any duplicates
-- UNION ALL is faster than UNION, doest check for duplicates


-- task: combine the data from employees and customers 
-- including duplicates

SELECT
	firstname,
	lastname
FROM customers

UNION ALL

SELECT
	firstname,
    lastname
FROM employees;

-- EXCEPT : returns all results from the first query that are not found in
-- the second query.
-- it removes duplicates
SELECT
	firstname,
	lastname
FROM employees
	EXCEPT
SELECT
	firstname,
    lastname
FROM customers;

-- INTERSECT: returns only the matching rows between the queries
SELECT
	firstname,
	lastname
FROM employees

INTERSECT

SELECT
	firstname,
    lastname
FROM customers;

-- turns out EXCEPT and INTERSECT are not supported in MySQL

