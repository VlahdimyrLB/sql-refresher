-- STRUCTURED QUERY LANGUAGE
--  createad to work with relational databases
--  MySQL, PostgreSQL, Oracle, MS SQL Server, SQLite etc...
--  Comman Line Client, Adminer, PHPMyAdmin, MySQL Workbench etc...

-- Create Database
CREATE DATABASE test;

-- Delete Database
DROP DATABASE test;

-- Create Tables inside test DB
CREATE TABLE customers(
	id INT NOT NULL AUTO_INCREMENT, -- set auto increment so ids will be unique
    firstName VARCHAR(255),
    lastName VARCHAR(255),
	email VARCHAR(255),
    address VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    zipcode VARCHAR(255),
    PRIMARY KEY(id) -- set id as primary key
);

-- INSERT data in the database table(customers)
-- insert as many as you wannt for example make em unique each for better experience
INSERT INTO customers (firstName, lastName, email, address, city, state, zipcode) VALUES ("Vlahdimyr", "Bambalan", "vlahd@gmail.com", "Quezon", "Solano", "Philippines", "3709")

-- UPDATE a row data in customers table
UPDATE customers 
SET email = 'shar@gmail.com'
WHERE id = 1

-- DELTE a row data in customers table
DELETE FROM customers
WHERE id = 3

-- ALTER table
-- let say you want to edit something in a table just use alter (add columns, edit type, delete columns etc.)

ALTER TABLE customers 
ADD testColumn VARCHAR(255)

ALTER TABLE customers 
MODIFY testColumn INT(11) 
-- update/modify syntax may vary to other sql this is MySQL

ALTER TABLE customers
DROP COLUMN testColumn


-- SELECT statements / fetch data

-- * means ALL
SELECT * FROM customers;

-- limit SELECT
SELECT firstName, lastName FROM customers;

-- SELECT specific customer
SELECT * FROM customers WHERE id = 2;

-- SORT = ASC is default
SELECT * FROM customers ORDER BY lastName DESC;

-- NO DUPLICATE using distinct
SELECT DISTINCT state FROM customers

-- SELECT with operators
SELECT * FROM `customers` WHERE age < 30;

-- SQL OPERATORS 
-- || = || > || < || <> or != || >= || <= || BETWEEN || LIKE || IN || IS || IS NOT || IS NOT DISTINC FROM || AS

-- we can use the NOT keyword to specify falsy query

-- SELECT BETWEEN
SELECT * FROM customers
WHERE age
BETWEEN 22 AND 30


-- LIKE (matching pattern)
-- % wildcard that means anything 
-- if written at the start(ends with) end(starts with) both(anywhere)
-- the query below will return all city that has o in it
SELECT * FROM customers
WHERE city LIKE '%o%'


-- IN - instead of using multiple where to specify multiple columns
SELECT * FROM customers
WHERE state IN ('New York', 'Philippines')


-- INDEXES - find/search data more quickly and efficiently just like an index of a book
--   - used to speed up queries
--   - a pointer of data to a table
--   - used for frequently search columns/tables
-- index will show a silver key in column

-- ex. frequently search customers by city, we add index to city
CREATE INDEX CIndex
ON customers(city)


-- remove an index using the index name
DROP INDEX CIndex ON customers


-- RELATIONSHIPS AND FOREIGN KEYS

-- PRIMARY KEY constraint uniquely identifies each record in a table which is commonly the id field because its UNIQUE.


-- create two new tables for example
CREATE TABLE products (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255),
    price INT,
    PRIMARY KEY(id)
)


-- FOREIGN KEY will match up to table id
-- ex. productID will match to products.id
CREATE TABLE orders(
    id INT NOT NULL AUTO_INCREMENT,
    orderNumber INT,
    productId INT, -- foreign key field
    customerId INT, -- foreign key field
    orderDate DATETIME default CURRENT_TIMESTAMP,
    PRIMARY KEY(id),

    -- FK restraints and reference table(id field)
    FOREIGN KEY(customerId) REFERENCES customers(id), 
    FOREIGN KEY(productId) REFERENCES products(id)
)

-- the structure will show a key icon that will tell its a foreign key
-- FK will prevent data corruption, avoid unstable database
-- FK constraint is used to prevent actions that would destroy links between tables.


/* JOINS
    - use to combines rows from two or more tables based on common fields
    - INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL JOIN
*/

-- add data to products and orders for example
INSERT INTO products(name, price) 
VALUES ('Product 1', 10),
        ('Product 2', 5),
        ('Product 3', 65),
        ('Product 4', 50),
        ('Product 5', 100);


INSERT INTO orders(orderNumber, productId, customerId) 
VALUES (001, 1, 1),
        (001, 2, 2),
        (002, 3, 1),
        (003, 4, 2),
        (004, 5, 1),
        (005, 2, 2);


-- INNER JOIN returns all rows when there is at least one matching in both tables 
-- basically selects records that have matching values in both tables.
SELECT customers.firstName, customers.lastName, orders.orderNumber
FROM customers
INNER JOIN orders
ON customers.id = orders.customerId -- matching statement
ORDER BY customers.firstName


-- LEFT JOIN 
-- returns all records from the left table (table1), and the matching records from the right table (table2). The result is 0 records from the right side, if there is no match.
-- returns all records from the left table (customers), even if there are no matches in the right table (Orders).
SELECT customers.firstName, orders.orderNumber, orders.orderDate
FROM customers
LEFT JOIN orders
ON customers.id = orders.customerId
ORDER BY customers.lastName


-- RIGHT JOIN just the opposite of left join :>
SELECT orders.orderNumber, customers.firstName, products.name
FROM orders
INNER JOIN products
ON orders.productId = products.id
RIGHT JOIN customers
ON orders.customerId = customers.id
ORDER BY orders.orderNumber

-- we can do more than 2 joins


-- ALLIASES give tables or columns a temporary name for readability
-- also used to manage or avoid duplicate names when joining tables
SELECT firstName AS 'First Name', lastName AS 'LAST NAME' 
FROM customers


-- COMBINE columns using CONCAT()
SELECT CONCAT(firstName, ' ', lastName) AS 'Full Name', address, city, state 
FROM customers


-- AGGREGATE FUNCTIONS
-- pretty straightforward, just find appropriate use-cases
SELECT AVG(age) FROM customers
SELECT COUNT(age) FROM customers;
SELECT MAX(age) FROM customers; -- or MIN
SELECT SUM(age) FROM customers;


-- GROUP BY 
-- is often used with aggregate functions
-- groups rows that have the same values into summary rows, like "find the number of customers in each country"
SELECT customers.city AS city, COUNT(orders.customerId) AS numberOfCustomers
FROM orders
INNER JOIN customers
ON orders.customerId = customers.id
GROUP BY customers.city;


-- HAVING
-- clause was added to SQL because the WHERE keyword cannot be used with aggregate functions.
SELECT customers.city AS city, COUNT(orders.customerId) AS numberOfCustomers
FROM orders
INNER JOIN customers
ON orders.customerId = customers.id
GROUP BY customers.city
HAVING COUNT(orders.customerId) > 5;
-- Filters the groups to include only those cities that have more than 5 customers.

-- YOU case jk its UPPERCASE
SELECT UCASE(firstName) FROM customers; 
-- or lCASE for lowercase

/*
    TOPICS THAT IS NOT COVERED WITHIN THIS
    (listed by importance level)
    - Transactions
    - Normalization
    - Subqueries
    - Vies
    - Triggers
    - Stored Procedures
    - Indexing (types)

    - Advance Joins (full, self, cross)
    - Window Functions
    - Table Expressions
    - Database Security
    - Optimization Techniques

    - DB Backup and Restore
    - FK Constraints (cascade, integrity)
    - Partitioning
    - Replication
    - JSON functions
*/