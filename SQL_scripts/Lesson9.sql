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






