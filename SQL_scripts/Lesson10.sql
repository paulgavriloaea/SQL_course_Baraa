-- COUNT(*), SUM(), AVG(), MAX(), MIN () -- i have already used them in the past lessons.

USE MyDataBase;

SELECT 
	customer_id,
    COUNT(*),
    SUM(sales),
    AVG(sales),
    MAX(sales),
    MIN(sales)
FROM orders
GROUP BY customer_id;

-- analyse the scores in the customers table

SELECT 
	country,
    COUNT(*),
    SUM(score),
    AVG(score),
    MAX(score),
    MIN(score)
FROM customers
GROUP BY country;

-- Window functions // or analytical functions
-- perform calculations on a specific subset of data, without losing the level of
-- details of rows

-- Find the total sales across all orders
USE salesdb;

SELECT 
    SUM(sales)
FROM orders;

-- Find the total sales for each product
SELECT 
	productid,
    SUM(sales)
FROM orders
GROUP BY productid;

-- Find the total sales for each product
-- provide details such as order id and order date

SELECT
	orderid,
    orderdate, 
	productid,
    SUM(sales) OVER(PARTITION BY productid) -- over() tells me we are talking about window functions
FROM orders;

-- over (partition , order or frame)
-- over () takes into account all the data
-- over (partition by) makes individual windows for data


-- find the total sales across all orders 
-- and provide additional info : order id and order date

USE salesdb;


SELECT
	orderid AS "Order ID",
	productid AS "Product ID",
    orderdate AS "Order Date",
	SUM(sales) OVER() AS "Total Sales"
FROM orders;

-- find the total sales across each product
-- and provide additional info : order id and order date

SELECT
	orderid AS "Order ID",
	productid AS "Product ID",
    orderdate AS "Order Date",
	SUM(sales) OVER(PARTITION BY productid) AS "Total Sales per product"
FROM orders;


 -- find the total sales across each product and across all orders
-- and provide additional info : order id and order date

SELECT
	orderid AS "Order ID",
	productid AS "Product ID",
    orderdate AS "Order Date",
	SUM(sales) OVER(PARTITION BY productid) AS "Total Sales per product",
    SUM(sales) OVER() AS "Total Sales"
FROM orders;

-- find the total sales for each combination of product 
-- and order status

SELECT
	orderid AS "Order ID",
    sales,
	productid AS "Product ID",
    orderdate AS "Order Date",
    orderstatus AS "Order status",
	SUM(sales) OVER(PARTITION BY productid) AS "Total Sales per product",
    SUM(sales) OVER() AS "Total Sales",
	SUM(sales) OVER(PARTITION BY productid, orderstatus) AS "Total Sales, productid,status"
FROM orders;


-- rank each order based on their sales
-- from the highest to the lowst-
-- provide additional info such as order id and order date

SELECT 
	orderid,
    orderdate,
    sales,
    RANK() OVER(ORDER BY sales DESC) -- RANK(does not take any arguments)
FROM orders;

-- window frames or frame clause

-- rows/range between current row/n preceding/ unbounded preceding and unbounded following/curernt row/n following
-- frame clause must be used always with order by
-- always start with lower boundary
SELECT 
	orderid,
    orderdate,
    orderstatus,
    sales,
    SUM(sales) OVER (PARTITION BY orderstatus ORDER BY orderdate ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) Totalsales -- RANK(does not take any arguments)
FROM orders;
-- the default frame (if you also use ORDER BY) is unbounded preceding and current row

SELECT 
	orderid,
    orderdate,
    orderstatus,
    sales,
    SUM(sales) OVER (PARTITION BY orderstatus),
    SUM(sales) OVER (PARTITION BY orderstatus ORDER BY sales), -- this uses unbounded preceding and current row
    SUM(sales) OVER (PARTITION BY orderstatus ORDER BY sales ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM orders;

-- you cannot use window functions in the group by or where, just select or order by
-- you cannot use window functions inside window functions.

-- find the total sales for each order status,
-- only for two products 101 and 102

-- where is executed before window function here
SELECT 
	orderid,
    orderdate,
    orderstatus,
    productid,
    sales,
    SUM(sales) OVER(PARTITION BY orderstatus)
FROM orders
WHERE productid IN ("101","102");

-- window functions can be used with the group by only if you use the same columns

-- rank the customers based on their sales
SELECT 
	customerid,
    customersales,
	RANK() OVER(ORDER BY customersales)
FROM(
	SELECT 
		customerid,
		SUM(sales) AS customersales
	FROM orders
	GROUP BY customerid
) t;


SELECT 
	customerid,
	SUM(sales) AS customersales,
    RANK() OVER(ORDER BY SUM(sales)) -- doesnt work if you put customersales
FROM orders
GROUP BY customerid;
-- here SUM(sales) is part both of the group by as well as the window function


-- window aggregate functions

-- find the total number of rows for each product

SELECT 
	productid,
    COUNT(productid) OVER(PARTITION BY productid), -- counts the rows without nulls
	COUNT(*) OVER(PARTITION BY productid), -- counts also the nulls
    COUNT(1) OVER(PARTITION BY productid) -- identical to COUNT(*)
FROM orders;


-- find the total number of orders
-- provide details : order id and order date

SELECT
	orderid,
    orderdate,
	COUNT(orderid) OVER() AS TotalOrders
FROM orders;

-- find the total number of orders for each customer
-- provide details : order id and order date

SELECT
	orderid,
    orderdate,
    customerid,
	COUNT(orderid) OVER(PARTITION BY customerid) AS TotalOrders
FROM orders;

-- Find the total number of customers 
-- and provide all details about customers


SELECT 
	*,
    COUNT(customerid) OVER() totalcustomers
FROM customers;

-- find the total number of scores for
-- the customers

SELECT 
	*,
    COUNT(customerid) OVER() totalcustomers,
    COUNT(score) OVER() totalnoofscores
FROM customers;


-- check whether the table 'Orders'
-- contains any duplicate rows

SELECT 
	orderid,
    COUNT(*) OVER(PARTITION BY orderid) checkPK
FROM orders;
-- doing the same in orders_archive, the PK is not good
SELECT 
	orderid,
    COUNT(*) OVER(PARTITION BY orderid) checkPK
FROM orders_archive;

SELECT 
*
FROM
(SELECT 
	orderid,
    COUNT(*) OVER(PARTITION BY orderid) checkPK
FROM orders_archive) t
WHERE checkPK>1;

-- find the total sales across all orders
-- and the total sales for each product.
-- additionally , provide details such as order id and order date. 

SELECT 
	orderid,
    orderdate,
    sales,
    productid,
	SUM(sales) OVER() totalsales,
    SUM(sales) OVER(PARTITION BY productid) totalsalesperproduct
FROM orders;


-- find the percentage contribution 
-- of the product's slaes to the total sales

SELECT
	orderid,
    orderdate,
    sales,
	SUM(sales) OVER() totalsales,
    SUM(sales) OVER(PARTITION BY productid) totalsalesperproduct,
    (SUM(sales) OVER(PARTITION BY productid))/(SUM(sales) OVER())*100
FROM orders;


-- find the average sales acorss all orders
-- and the average sales for each product
-- additionally, provide details such as order id and order date

SELECT
	orderid,
    orderdate,
    productid,
	AVG(ROUND(COALESCE(sales,0),2)) OVER() avgsales,
    AVG(sales) OVER(PARTITION BY productid) avgsalesperproduct
FROM orders;

-- find the average scores of customers 
-- and provide details such as customerid and lastname

SELECT
	customerid,
    lastname,
    AVG(COALESCE(score,0)) OVER() avgcustomersscore
FROM customers;

-- find all orders where sales are higher 
-- than the avg sales across all orders

SELECT 
	*
FROM (
SELECT
	orderid,
    sales,
    AVG(sales) OVER() avgsales
FROM orders) t
WHERE sales>avgsales;


-- find the highest and lowest sales across all orders
-- find the highest and lowest sales for each product
-- additionally, provide details such as the order id and order date

SELECT
	orderid,
    orderdate,
    productid,
	MIN(sales) OVER(),
    MAX(sales) OVER(),
    MIN(sales) OVER(PARTITION BY productid),
    MAX(sales) OVER(PARTITION BY productid)
FROM orders;

-- show the employees with the highest salaries

SELECT 
*
FROM(
SELECT 
	*,
    MAX(salary) OVER() AS highest_salary
FROM employees) t
WHERE salary = highest_salary;


-- find the deviation of each sales from both 
-- the minimum and maximum sales amounts
SELECT
	orderid, 
	sales,
	MIN(sales) OVER() as min_sale,
    MAX(sales) OVER() as max_sale,
    sales-MIN(sales) OVER(),
    sales-MAX(sales) OVER()
FROM orders;

-- Calculate the moving(running total) average of sales
-- for each product over time

USE salesdb;

SELECT 
	orderid,
    productid,
    orderdate,
    AVG(sales) OVER(PARTITION BY productid ORDER BY orderdate), -- this uses unbounded preceding and current row by default
    AVG(sales) OVER(PARTITION BY productid ORDER BY orderdate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM orders;

-- Calculate the moving(running total) average of sales
-- for each product over time, including only the next order

SELECT 
	orderid,
    productid,
    orderdate,
    sales,
    AVG(sales) OVER(PARTITION BY productid ORDER BY orderdate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING)
FROM orders;

-- ranking in window functions
-- percentage or integer based ranking
-- you alwasy have to order with rank
-- not allowed to use frames


-- row_number() assigns an unique number to each row
-- it doesnt handle ties

-- rank() handles the ties. equal values will be on the same rank
-- dense_rank() handles the ties but does not skip ids for instance A(1) A(1) B(2), instead of A(1) A(1) B(3)
-- rank the orders based on their sales 
-- from the highest to the lowest

SELECT 
	orderid,
    productid,
    sales,
    ROW_NUMBER() OVER(ORDER BY sales DESC),
    RANK() OVER(ORDER BY sales DESC),
    DENSE_RANK() OVER(ORDER BY sales DESC)
FROM orders;

-- find the top highest sales for each product

SELECT 
	*
FROM(
SELECT 
	orderid,
    productid,
    sales,
    ROW_NUMBER() OVER(PARTITION BY productid ORDER BY sales DESC) AS ranking
FROM orders) t
WHERE ranking=1;


-- find the lowest 2 customers based on their total sales
SELECT 
	customerid,
    total_sales,
    ranking
FROM (
SELECT  
	customerid,
    SUM(sales) total_sales,
    ROW_NUMBER() OVER(ORDER BY SUM(sales)) ranking
FROM orders
GROUP BY customerid) t
WHERE ranking IN (1,2);


-- assign unique ids to the rows of the 'Orders Archive' table

SELECT
*,
ROW_NUMBER() OVER(ORDER BY orderid, orderdate) unique_id
FROM orders_archive;


-- identify duplicate rows in the table 'orders archive'
-- and return a clean result without any duplicates

SELECT 
	*
FROM
(
SELECT 
	*,
    RANK() OVER(PARTITION BY orderid ORDER BY creationtime DESC) id
FROM orders_archive) t
WHERE id=1;

-- ntile divide the rows into a specified number of approximately
-- equal groups (buckets)


