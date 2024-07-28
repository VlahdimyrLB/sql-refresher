# SQL - STRUCTURED QUERY LANGUAGE
##    - createad to work with relational databases
##    - MySQL, PostgreSQL, Oracle, MS SQL Server, SQLite etc...
##    - Comman Line Client, Adminer, PHPMyAdmin, MySQL Workbench etc...

# Create Database
CREATE DATABASE test;

# Delete Database
DROP DATABASE test;

# Create Tables inside test DB
CREATE TABLE customers(
	id INT NOT NULL AUTO_INCREMENT, # set auto increment so ids will be unique
    firstName VARCHAR(255),
    lastName VARCHAR(255),
	email VARCHAR(255),
    address VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    zipcode VARCHAR(255),
    PRIMARY KEY(id) # set id as primary key
);

# INSERT data in the database table(customers)
INSERT INTO customers (firstName, lastName, email, address, city, state, zipcode) VALUES ("Vlahdimyr", "Bambalan", "vlahd@gmail.com", "Solano", "Solano", "NV", "3709")

# UPDATE a row data in customers table
UPDATE customers 
SET email = 'shar@gmail.com'
WHERE id = 1

# DELTE a row data in customers table
DELETE FROM customers
WHERE id = 3

# ALTER table
# let say you want to edit something in a table just use alter (add columns, edit type, delete columns etc.)

ALTER TABLE customers 
ADD testColumn VARCHAR(255)

ALTER TABLE customers 
MODIFY testColumn INT(11) # update syntax may vary to other this is MySQL

ALTER TABLE customers
DROP COLUMN testColumn

# SELECT statements / fetch data

# * means ALL
SELECT * FROM customers;

# limit SELECT
SELECT firstName, lastName FROM customers;

# SELECT specific customer
SELECT * FROM customers WHERE id = 2;

# SORT - ASC is default
SELECT * FROM customers ORDER BY lastName DESC;

# NO DUPLICATE using distinct
SELECT DISTINCT state FROM customers

# SELECT with operators
SELECT * FROM `customers` WHERE age < 30;

# SQL OPERATORS 
# || = || > || < || <> or != || >= || <= || BETWEEN || LIKE || IN || IS || IS NOT || IS NOT DISTINC FROM || AS

# we can use the NOT keyword to specify falsy query

# SELECT BETWEEN
SELECT * FROM customers
WHERE age
BETWEEN 22 AND 30

# LIKE (matching pattern)
# % wildcard that means anything 
# if written at the start(ends with) end(starts with) both(anywhere)
# the query below will return all city that has o in it
SELECT * FROM customers
WHERE city LIKE '%o%'

# IN - instead of using multiple where to specify multiple columns
SELECT * FROM customers
WHERE state IN ('New York', 'Philippines')

# INDEXES - find/search data more quickly and efficiently just like an index of a book
#   - used to speed up queries
#   - a pointer of data to a table
#   - used for frequently search columns/tables
# index will show a silver key in column

# ex. frequently search customers by city, we add index to city
CREATE INDEX CIndex
ON customers(city)

# remove an index using the index name
DROP INDEX CIndex ON customers

# RELATIONSHIPS AND FOREIGN KEYS
