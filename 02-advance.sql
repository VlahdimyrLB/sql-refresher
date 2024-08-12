
-- NOTE: Accomplish the basics queries here are based on the Database and Tables use there,
--       and import more data for better experience/understanding.

-- SUBQUERIES
-- A query within other query which is embeded within WHERE, FROM or HAVING clause

-- This will select the average of all prices then
-- Select all products that has a price grater than average prices
SELECT * FROM `products` 
WHERE price > (SELECT AVG(price) FROM `products`);

-- Select the price of Product 4
-- Selects all the prices that are less than or equal to Product 4
SELECT * FROM `products` 
WHERE price <= (SELECT price FROM `products` WHERE name = 'Product 4')