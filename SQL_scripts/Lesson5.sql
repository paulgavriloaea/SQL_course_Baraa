-- JOIN to stack columns

-- SET operators to stack rows

-- JOIN types INNER FULL LEFT AND RIGHT

-- SET types UNION UNION ALL EXCEPT INTERSECT

 -- For JOIN we have to define keys
 
 -- for SET we need exactly the same number of columnsm but no key necessary
 
 USE MyDatabase;
 
 SELECT * from customers;
 
 SELECT * from persons; 
 
 -- No JOIN
 /* Retrieve all data from customers and orders
 as separate results */
 
 SELECT * 
 FROM customers;
 
 SELECT *
 FROM orders;
 
 -- INNER Join
-- Return only the matching data from both tables


-- Default type is inner join
-- Get all customers along with their orders,
-- but only for customers who have placed an order

SELECT 
	c.id, #it's good practice to assign a table name
    c.first_name,
    o.order_id,
    o.sales
FROM customers AS c
INNER JOIN orders AS o 
ON c.id=o.customer_id;

-- LEFT JOIN
-- Return all the rows from the left
-- table and only the matching from the right

-- Get all customers along with their orders
-- includeing those without orders

SELECT 
c.id,
c.first_name,
o.order_date,
o.order_id
FROM customers AS c
LEFT JOIN orders AS o
ON c.id=o.customer_id;

-- Right Join
-- Returns all rows from right table
-- plus the matching from left table

-- Get all customers along with their orders
-- including orders without matching customers


SELECT 
	c.id,
	c.first_name,
	o.order_date,
	o.order_id
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id=o.customer_id;

-- SOLVE the same task as above using LEFT JOIN

SELECT 
	c.id,
	c.first_name,
	o.order_date,
	o.order_id
FROM orders AS o
LEFT JOIN customers AS c
ON o.customer_id=c.id;

-- Full JOIN  is not supported by Mysql
-- get the matching and unmatching

-- I will use a combination of LEFT , RIGH JOIN and UNION

-- Get all customers and all orders even if there's no match


-- Here I basically use two of the prevs queries and
-- put a union in between
SELECT 
	c.id,
	c.first_name,
	o.order_date,
	o.order_id
FROM customers AS c
LEFT JOIN orders AS o
ON c.id=o.customer_id

UNION

SELECT 
	c.id,
	c.first_name,
	o.order_date,
	o.order_id
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id=o.customer_id;

-- LEFT ANTI JOIN 
-- Returns row from left that has no match in right
-- and nothing from right


-- Get all customers who haven't placed any order

SELECT 
	c.id,
	c.first_name,
	o.order_date,
	o.order_id
FROM customers AS c
LEFT JOIN orders AS o
ON c.id=o.customer_id
WHERE o.order_date IS NULL;

-- RIGHT ANTI JOIN
-- Return the rows from the right table that has no mtach in the left

-- Get all orders without matching customers
SELECT 
	c.id,
	c.first_name,
	o.order_date,
	o.order_id
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id=o.customer_id
WHERE c.first_name IS NULL;


-- Solve the same task as before using LEFT JOIN
SELECT 
	c.first_name,
	c.id,
	o.order_date,
	o.order_id
FROM orders AS o
LEFT JOIN customers AS c
ON o.customer_id=c.id
WHERE c.id IS NULL;

-- FULL ANTI-JOIN 
-- Returns only rows that don't match in either tables
SELECT 
	c.id,
	c.first_name,
	o.order_date,
	o.order_id
FROM customers AS c
LEFT JOIN orders AS o
ON c.id=o.customer_id
WHERE o.order_date IS NULL

UNION

SELECT 
	c.first_name,
	c.id,
	o.order_date,
	o.order_id
FROM orders AS o
LEFT JOIN customers AS c
ON o.customer_id=c.id
WHERE c.id IS NULL;

-- Get all customers along with their orders
-- but only for customers who have placed an order
-- WITHOUT Using INNER JOIN

-- A shame 
SELECT 
	c.id,
	c.first_name,
	o.order_date,
	o.order_id
FROM customers AS c
LEFT JOIN orders AS o
ON c.id=o.customer_id
WHERE o.order_date IS NOT NULL

UNION

SELECT 
	c.id,
	c.first_name,
	o.order_date,
	o.order_id
FROM orders AS o
LEFT JOIN customers AS c
ON o.customer_id=c.id
WHERE c.id IS NOT NULL;



SELECT * 
FROM customers;


-- CROSS JOIN
-- Combine every row from left with every row from right
 -- if A has two rows and B has 3 cross join gives me 2x3 = 6 rows
 
 -- Generate all possible combinations of customers and orders
 SELECT *
 FROM customers
 CROSS JOIN orders;
 
 -- How to join between JOINS?
 
 
 -- Using SalesDB, retrieve a list of all orders, along with the
 -- related customer, product, and employee details.
 -- For each order, display
 -- order ID, customer's name , product name, sales amount, product price, salesperson's name
 USE salesdb;
 
SELECT *
FROM customers;

SELECT *
FROM employees;

SELECT *
FROM orders;

SELECT *
FROM orders_archive;

SELECT *
FROM products;


SELECT 
	o.orderid,
    c.firstname AS Customer_FN,
    c.lastname AS Customer_LN,
    p.product,
    o.sales,
    p.price,
    e.firstname AS Employee_FN,
    e.lastname AS Employee_LN
FROM orders AS o
INNER JOIN customers AS c ON o.customerid=c.customerid -- instead here you could use LEFT JOIN and below you could set WHERE c.customerid IS NOT NULL
INNER JOIN products AS p ON p.productid=o.productid
INNER JOIN employees AS e ON e.employeeid=o.salespersonid
ORDER BY o.orderid ASC;



-- I can achieve the same result using LEFT JOIN , see below

SELECT 
	o.orderid,
    c.firstname AS Customer_FN,
    c.lastname AS Customer_LN,
    p.product,
    o.sales,
    p.price,
    e.firstname AS Employee_FN,
    e.lastname AS Employee_LN
FROM orders AS o
LEFT JOIN customers AS c ON o.customerid=c.customerid -- instead here you could use LEFT JOIN and below you could set WHERE c.customerid IS NOT NULL
LEFT JOIN products AS p ON p.productid=o.productid
LEFT JOIN employees AS e ON e.employeeid=o.salespersonid
ORDER BY o.orderid ASC;


 