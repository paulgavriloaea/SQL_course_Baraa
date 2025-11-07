-- case statement evaluates a list of conditions and returns a value 
-- when the first condition is met

-- CASE ... WHEN ...THEN...WHEN ... THEN.. ELSE..END
-- the default is NULL for else


-- categorizing data
-- generate a report showing the total sales for each category:
-- high if the sales higher 50 , medium if sales bet 20 and 50 and low if sales eq or lower to 20
-- sort the result from lowest to highest
USE salesdb;

SELECT
	sorted_sales,
	SUM(sales) AS total_sales_per_category
FROM(
SELECT 
	sales,
	CASE 
		WHEN sales>50 THEN 'High'
        WHEN sales<50 AND sales >20 THEN 'Medium'
        ELSE 'Low'
	END AS sorted_sales
FROM orders) AS t
GROUP BY sorted_sales
ORDER BY total_sales_per_category ASC;

-- with case statements , the daata type of the result must be matching, makes sense
-- since everything is put together in the same column

-- mapping value: transform values from one from to another

-- Retrieve employeee details with gender dispalyed as full text


SELECT 
	TYPE(gendergender)
FROM employees;

SELECT
	*,
    CASE
		WHEN TRIM(gender)='M' THEN 'Male'
        WHEN TRIM(gender)='F' THEN 'Female'
        ELSE ''
	END AS new_gender
FROM employees;


-- return customer details with abbrev. country code

SELECT
	*,
    CASE
		WHEN LENGTH(country)>3 THEN UPPER(LEFT(country,3))
        ELSE country
    END AS abbrev_country
FROM customers;


-- handling nulls
-- Find the average scores of customers and treat Nulls as 0

SELECT 
	AVG(new_score)
FROM(
SELECT 
	score,
    CASE
		WHEN score IS NULL THEN 0
        ELSE score
	END as new_score
FROM customers) t;

-- conditional aggregation

-- count how many times each customer has made an order 
-- with sales GT 30


SELECT 
	customerid,
    SUM(CASE
		WHEN sales>30 THEN 1
		ELSE 0
	END) AS HighOrders,
    COUNT(*) TotalOrders
FROM orders
GROUP BY customerid;


