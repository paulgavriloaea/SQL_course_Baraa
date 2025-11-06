-- Concatenate using CONCAT: first name and country into one column
USE MyDatabase;

SELECT
	first_name,
    country
FROM customers;

SELECT
	CONCAT(first_name,': ',country) AS name_country
FROM customers;

-- Upper and Lower
-- Convert the first name to lower case

SELECT
	LOWER(first_name)
FROM customers;

-- Convert the first name to upper case
SELECT
	UPPER(first_name)
FROM customers;


-- Trim function: removes trailing and leading spaces


-- Find customers whose first name contains leading and trailing spaces

SELECT 
	first_name
FROM customers
WHERE SUBSTRING(first_name,1,1) IN (' ') 
OR RIGHT(first_name,1) IN (' ');

-- Or a very cool method to do the same as above:

SELECT
	first_name
FROM customers
WHERE first_name !=TRIM(first_name);

-- remove trailing/leading spaces from first_name column
SELECT
	TRIM(first_name)
FROM customers;


-- REPLACE : replaces characters..
SELECT
	'123-123-832' original_mobile,
    REPLACE('123-123-832','-','/') new_mobile;

-- LENGTH function - calculates the length of a string
-- in other sql variants, its LEN isntead of LENGTH
SELECT LENGTH(first_name)
FROM customers;

-- LEFT & RIGHT
-- extract x numbers from left or right of string

-- retrieve the first two characters and last two chars of each firstname
SELECT 
	LEFT(TRIM(first_name),2),
    RIGHT(first_name,2)
FROM customers;

-- SUBSTRING extracts a certain substring from a string with a given length and from a cefrtain position
-- RETRIEVE a list of customers' first name after removing the first character
SELECT 
	SUBSTRING(first_name,2,LENGTH(first_name))
FROM customers;

-- NUMERIC functions
-- ROUND to round numbers

SELECT 
	3.1456,
    ROUND(3.1456,2),
    ROUND(3.1456,3),
    ROUND(3.1456,0);
-- ABS to get absolute..
SELECT 
	ABS(-10);
    
-- DATE and TIME functions
-- A timestamp or datetime has date and time info.
-- we also have date and time alone

USE salesdb;

SELECT 
	orderid,
    orderdate,
    shipdate,
    creationtime
FROM orders;

SELECT 
	orderid,
    creationtime,
    '2025-08-20' HardCoded
FROM orders;

SELECT 
	orderid,
    creationtime,
    '2025-08-20' HardCoded,
    CURRENT_DATE() Today,
    CURRENT_TIME() Today_Time,
    CURRENT_TIMESTAMP() Today_timestamp
FROM orders;

-- DAY(), MONTH() and YEAR() are returning day,mnth or year from a date
SELECT 
	orderid,
	DAY(creationtime),
    MONTH(creationtime),
    YEAR(creationtime)
FROM orders;

-- DATEPART(part,date) does not work in MySQL. 
-- but you can use EXTRACT(part FROM date) returns a specific part of a date as a number
-- for instance a week or a quarter.
SELECT 
	orderid,
	EXTRACT(QUARTER FROM creationtime)
FROM orders;

SELECT 
	orderid,
	creationtime
FROM orders;

-- DATENAME does not exist in mysql

-- you can also extract date names:
SELECT DATE_FORMAT('2025-11-05', '%W') AS weekday_name,   -- full weekday name
       DATE_FORMAT('2025-11-05', '%M') AS month_name,     -- full month name
       DATE_FORMAT('2025-11-05', '%b') AS short_month,    -- abbreviated month name
       DATE_FORMAT('2025-11-05', '%a') AS short_weekday;  -- abbreviated weekday name
-- or using>

SELECT 
	MONTHNAME(creationtime),
    DAYNAME(creationtime),
    WEEKDAY(creationtime),
    DAYOFWEEK(creationtime)
FROM orders;

-- DATETRUNC doesnt exist for MySQL

-- EOMONTH() also doesnt exist - changes the day of a date to the last day of the month. 


-- How many orders were placed each year?

USE salesdb;

SELECT
    YEAR(orderdate),
    COUNT(YEAR(orderdate)) -- or COUNT(*) which means count all rows in each group
FROM orders
GROUP BY YEAR(orderdate);

-- Show all orders that were placed during the month of february

SELECT 
	orderid,
    MONTH(orderdate),
    MONTHNAME(orderdate),
	DATE_FORMAT(orderdate, '%M') AS mname
FROM orders
WHERE DATE_FORMAT(orderdate, '%M')='February';

-- dates are represented in sql using the interantional standard ISO 8601
-- YYYY-MM-DD

-- in USA we have MM-DD-YYYY

-- in Europe DD-MM-YYYY

-- FORMAT(value, format [,culture-the style of a specific region]) formats a date or time value
-- for dates you have to use DATE_FORMAT

SELECT 
	orderid,
    creationtime,
    DATE_FORMAT(creationtime, '%d') day,
    DATE_FORMAT(creationtime, '%a') shortnameofday,
	DATE_FORMAT(creationtime, '%W') longnameofday,
    DATE_FORMAT(creationtime, '%m') monthh,
	DATE_FORMAT(creationtime, '%b') shortmonthh,
    DATE_FORMAT(creationtime, '%M') longmonth
FROM orders;

-- Show creation time using the following format : Day Wed Jan Q1 2025 12:34:56 PM
SELECT 
	creationtime,
    CONCAT(DATE_FORMAT(creationtime, '%d %a %b'),
    ' Q',QUARTER(creationtime),' ', YEAR(creationtime),
    ' ', DATE_FORMAT(creationtime,'%r')) AS formatted_time
FROM orders;

-- CONVERT(data_type, value [,style]) in sql server, but in mysql is (value,data_type)
-- also mysql doesnt have int, signed or unsigned only for int
SELECT CONVERT('123',UNSIGNED),
CONVERT('2025-11-06 12:34:56', DATETIME),
creationtime,
CONVERT(creationtime,DATE)
FROM orders;

-- CAST value as datatype

SELECT CAST('123' AS UNSIGNED), -- use unsigned instead of int
CAST(123 AS CHAR), -- use char instead of varchar
CAST('2025-08-20' AS DATE),
CAST('2025-08-20' AS DATETIME);

-- DATEADD(part, interval, date) part=y,m,d  doesnt exist in MySQL
-- you can use DATE_ADD(date, INTERVAL n unit)
SELECT DATE_ADD('1996-02-08', INTERVAL -2 year),
DATE_ADD('1996-02-08', INTERVAL 2 month),
DATE_ADD('1996-02-08', INTERVAL 2 day),
DATE_SUB('1996-02-08', INTERVAL 2 day)
;

-- in MYSQL datediff always returns the answer in days
-- for years, montsh you have other functions TIMESTAMPDIFF
-- Calculate the age of employees
SELECT 
	birthdate,
    current_date(),
    timestampdiff(YEAR,birthdate,current_date()) AS age
FROM employees;

-- Find the average shipping duration in days for each month

SELECT
	MONTHNAME(orderdate),
    AVG(CAST(datediff(shipdate,orderdate) AS unsigned)) AS "shipping duration"
FROM orders
GROUP BY MONTHNAME(orderdate);

-- Find the number of days between each order and the previous order
SELECT 
	orderdate as currentdate,
    LAG(orderdate) OVER (ORDER BY orderdate) previous_date,   -- window function, to learn later,
	datediff(orderdate,LAG(orderdate) OVER (ORDER BY orderdate)) AS difference
FROM orders
ORDER BY orderdate ASC;

-- isdate does not exist in MySQL
-- could use something like this isntead : SELECT STR_TO_DATE('2025-11-06', '%Y-%m-%d') IS NOT NULL AS is_date;

