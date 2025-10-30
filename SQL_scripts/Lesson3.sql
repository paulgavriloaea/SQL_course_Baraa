-- Insert into table_name (col1, col2..)
-- values(val1, val2..), values(val1, val2..)

USE MyDatabase;

SELECT * 
FROM customers;

INSERT INTO customers(id, first_name, country, score)
VALUES
	(6, 'Anna', 'USA', NULL),
    (7, 'Sam', NULL, 100);
    
INSERT INTO customers # you can omit the column names if you are inserting values in all columns
VALUES
	(8, 'John', 'Australia', NULL);
    
INSERT INTO customers(id, first_name, country)
VALUES
	(9, 'Jim', 'UK');	
    
INSERT INTO customers(id, country)
VALUES
	(10, 'UK');
    
    
    
-- use data from a source table and insert it into a target table
-- copy data from customers and insert it into table persons

CREATE TABLE persons(
	id INT NOT NULL,
	person_name VARCHAR(50) NOT NULL,
    birth_date VARCHAR(50) NULL,
    phone VARCHAR(50) NOT NULL,
	CONSTRAINT pk_id PRIMARY KEY(id)
);

SELECT *
FROM customers;

INSERT INTO persons (id, person_name, birth_date, phone)
SELECT
	id,
    COALESCE(first_name, 'Unkown'), -- Helps me avoid null values in first_name column
    NULL,
    'Unknown'
FROM customers;

SELECT *
FROM persons;

-- UPDATE table_name / SET col1 = val1, col2 = val2 / WHERE condition 

-- change the score of customer in customers table with id 4 to 0

SELECT * 
FROM customers;

UPDATE customers
SET score = 0
WHERE id = 4;

-- Change the score of customer with ID 10 to 0 and update the country to Spain
UPDATE customers
SET 
	score=0,
    country='Spain'
WHERE id = 10;

SELECT * 
FROM customers
WHERE score IS NULL;

-- update all customers with a score null to a score of 0

/* Tried to do it using UPDATE customers
SET 
	score = 0
WHERE score IS NULL;*/

-- However i get the following error:
/* 15:27:56	UPDATE customers SET   score = 0 WHERE score IS NULL	Error Code: 1175. 
   You are using safe update mode and you tried to update a table without a WHERE that uses 
   a KEY column.  To disable safe mode, toggle the option in Preferences -> 
   SQL Editor and reconnect.	0.00066 sec*/
   
-- I am temporarily turning SQL_SAFE_UPDATES OFF
SET SQL_SAFE_UPDATES = 0;

UPDATE customers
SET 
	score = 0
WHERE score IS NULL;

SET SQL_SAFE_UPDATES = 1;

SELECT * 
FROM customers;

-- Removing rows with delete : DELETE FROM table-name WHERE conidtion

-- Del all customers with an id GT 5 



DELETE FROM customers
WHERE id>5;

-- Delete all data from table persons

-- instead of DELETE FROM persons; you can use TRUNCATE TABLE persons which is faster, doesnt have checks , especially imp for large tables

TRUNCATE TABLE persons;












   

    
    