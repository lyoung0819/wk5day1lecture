-- Hello World SQL Query, Select all records from a table
-- Syntax: SELECT column_name FROM table_name
-- * or wildcard will select all available
SELECT * FROM actor;

-- To query specific columns, add them in the SELECT statement
SELECT first_name, last_name FROM actor;

-- Filter rows by using the WHERE clause (comes after the FROM)

SELECT first_name, last_name FROM actor WHERE first_name = 'Nick';

-- Can also use the keyword "LIKE". This allows us to add wildcards to the string 
SELECT first_name, last_name FROM actor WHERE first_name LIKE 'Nick';

-- With a LIKE keyword, '%' represents wildcards or any number of characters 
SELECT first_name, last_name FROM actor WHERE first_name LIKE 'J%'; 

-- This is saying give me everything that starts with a J and everyting after

-- With a LIKE keyword, '_' represents one character. Must use the like keyword 
SELECT first_name, last_name FROM actor WHERE first_name LIKE 'K__';

-- using AND and OR in WHERE clause 
-- OR - only one needs to be true
-- AND - both need to be true
SELECT * FROM actor WHERE first_name LIKE 'N%' OR last_name LIKE 'W%';

SELECT * FROM actor WHERE first_name LIKE 'N%' AND last_name LIKE 'W%';

-- Comparison operators in SQL:
-- Greater Than >
-- Less Than < 
-- Greater Than or Equal to >=
-- Less Than or Equal to <=
-- Equals =
-- Not Equals <> or != 

SELECT * FROM payment;

-- Query all the payments of more that $7.00
SELECT * FROM payment WHERE amount > 7;

-- Query for all less than 7
SELECT * FROM payment p WHERE amount <= 6.99;

-- Not Equals
SELECT * FROM staff WHERE staff_id <> 1;

SELECT * FROM staff s WHERE staff_id !=2;

-- Can also use the 'not' keyword
SELECT * FROM film f WHERE title NOT LIKE 'F%'

-- Get all of the payments between $3.00 and $8.00
SELECT * FROM payment p WHERE amount >= 3 AND amount <= 8;

-- OR use between/and clause - (*inclusive)
SELECT * FROM payment p WHERE amount BETWEEN 3 AND 8;

SELECT * FROM film f WHERE film_id BETWEEN 10 AND 20;

-- Order the rows of data using the ORDER BY clause
-- Default is ascending order (add DESC for descending)
-- Syntax: ORDER BY column_name (that you want to order by)

SELECT * FROM film f ORDER BY replacement_cost;

SELECT * FROM film f ORDER BY title DESC;

-- ORDER BY Comes after the WHERE clause(if present)
SELECT * FROM payment p WHERE customer_id = 123 ORDER BY amount;


-- Ex1: Write a query that will return all of the films that have an 'h' in the title and order it by rental duration(in ascending order)
SELECT * FROM film f WHERE title ILIKE '%h%' ORDER BY rental_duration;



--- SQL Aggregations -> SUM() AVG() COUNT() MIN() MAX()
-- take in a column name and return a single value

-- SUM - find the sum of a column
SELECT SUM(amount) FROM payment p ;

SELECT SUM(amount) FROM payment WHERE customer_id = 123;

-- AVG - will find the average of a column
SELECT AVG(amount)FROM payment p ;

-- MIN/MAX - find the smallest and largest value in a column
SELECT MIN(amount), MAX(amount) FROM payment p ;
-- Alias column names using "as" - col_name AS alias_name
SELECT MIN(amount) AS smallest_amount, MAX(amount) AS largest_amount FROM payment p ;

-- Min & Max can work with strings (VarChar)
SELECT MIN(first_name), MAX(last_name)  FROM actor a ;

-- COUNT() - Takes in either a column_name OR * for all columns
-- If column name, will count any NON-NULL rows in that column
-- If *, will count all rows
SELECT * FROM staff;

SELECT count(*) FROM staff; -- will return 2 because there ARE 2 rows 

SELECT count(picture) FROM staff; -- will RETURN 1 because ONLY 1 staff MEMBER has a picture, the other IS NULL 

-- To count unique values, use the distinct keyword
SELECT * FROM actor a WHERE first_name LIKE 'A%' ORDER BY first_name;

SELECT count(first_name) FROM actor a WHERE first_name LIKE 'A%'; 

SELECT count(DISTINCT first_name) FROM actor a WHERE first_name LIKE 'A%'; 


-- Aggregations for a certain grouping
-- GROUP BY clause
SELECT * FROM payment p ORDER BY amount;

SELECT COUNT(*) FROM payment p WHERE amount = 0;

SELECT count(*) FROM payment p WHERE amount = 0.99;

SELECT count(*) FROM payment p WHERE amount = 1.99;

SELECT count(*) FROM payment p WHERE amount = 2.99; 

-- If I want to run this function (count currently) for every single ammount.... 
SELECT amount, count(*), sum(amount) FROM payment p GROUP BY amount ORDER BY amount 


-- columns selected from the table must also be in the group by 
SELECT amount, customer_id, count(*) FROM payment p GROUP BY amount, customer_id;


-- aggregations can be used in the Order By clause 
SELECT customer_id, sum(amount)
FROM payment p 
GROUP BY customer_id 
ORDER BY sum(amount) DESC;

-- We can use aliased column names in the Order By clause

SELECT customer_id, sum(amount) AS total_spend 
FROM payment p 
GROUP BY customer_id 
ORDER BY total_spend DESC;

-- HAVING Clause - Having is to GROUP BY/AGGREGATIONS as WHERE is to SELECT 
SELECT * 
FROM payment p 
WHERE amount > 10

SELECT customer_id, SUM(amount) AS total_spend
FROM payment p 
GROUP BY customer_id 
HAVING sum(amount) > 200
ORDER BY total_spend DESC;


SELECT customer_id, SUM(amount)
FROM payment p 
GROUP BY customer_id
HAVING SUM(amount) BETWEEN 75 AND 100;

-- LIMIT AND OFFSET clauses 

-- LIMIT - limits the number of rows that are returned 
SELECT * FROM city c LIMIT 15;

SELECT * FROM film f LIMIT 10;

-- OFFSET - will start your rows after a certain name
SELECT *
FROM city c 
OFFSET 5; -- OFFSET the FIRST five ROWS AND START FROM there

SELECT * FROM city c OFFSET 20 LIMIT 10;

-- ORDER OF OPERATIONS For clauses (SELECT and FROM are the only mandatory clauses)

-- SELECT (column_names or *)
-- FROM (table name)
-- WHERE (row filter)
-- GROUP BY (aggreations) 
-- HAVING (filter the aggregations)
-- ORDER BY (column_value, def= ASC, or DESC)
-- OFFSET (number of rows to skip)
-- LIMIT (max number of rows to display)

SELECT first_name, count(*)
FROM actor a WHERE actor_id > 10
GROUP BY first_name 
HAVING first_name LIKE '%t%'
ORDER BY first_name 
OFFSET 5
LIMIT 5;