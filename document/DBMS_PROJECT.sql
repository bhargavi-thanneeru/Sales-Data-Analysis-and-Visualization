show databases;

create database orders_db;
use orders_db;

drop table orders;

CREATE TABLE orders (
  OrderId INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  OrderNumber VARCHAR(20),
  QuantityOrdered INT,
  ItemPrice DECIMAL(8,2),
  OrderLineNumber INT,
  Sales DECIMAL(8,2),
  OrderDate DATE,
  Status VARCHAR(15),
  Qtr_Id INT,
  Month_Id INT, 
  Year_Id INT,
  ProductCategory VARCHAR(25), 
  ProductPrice DECIMAL(8,2),
  ProductCode VARCHAR(25),
  CustomerName VARCHAR(65), 
  Phone VARCHAR(20),
  AddressLine1 VARCHAR(60), 
  AddressLine2 VARCHAR(60),
  City VARCHAR(25),
  State VARCHAR(20),
  PostalCode VARCHAR(15),
  Country VARCHAR(25),
  Territory VARCHAR(20),
  Sales_Contact_LastName VARCHAR(30),
  Sales_Contact_FirstName VARCHAR(20),
  DealSize VARCHAR(10)
);


create table customer(
  CustomerId INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  CustomerName VARCHAR(65), 
  City VARCHAR(25),
  PostalCode VARCHAR(15),
  Country VARCHAR(25),
  Sales_Contact_LastName VARCHAR(30),
  Sales_Contact_FirstName VARCHAR(20),
  DealSize VARCHAR(10));
  


-- delete from orders;

-- drop table customer;

select count(*) from orders;

select * from customer;



-- sales table
CREATE TABLE sales (
  OrderId INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  OrderNumber VARCHAR(20),
  QuantityOrdered INT,
  ItemPrice DECIMAL(8,2),
  Sales DECIMAL(8,2),
  OrderDate DATE,
  Status VARCHAR(15),
  Qtr_Id INT,
  Month_Id INT, 
  Year_Id INT);


select * from sales;

create table product(
  ProductCode VARCHAR(25) PRIMARY KEY,
  ProductCategory VARCHAR(25), 
  ProductPrice DECIMAL(8,2));
  
select count(*) from product;


-- Add CustomerId column as Foriegn key to orders table
ALTER TABLE orders
ADD COLUMN CustomerId INT,
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (CustomerId) REFERENCES customer(CustomerId);


-- ALTER TABLE orders
-- DROP FOREIGN KEY fk_orders_customer;

-- ALTER TABLE orders
-- DROP COLUMN CustomerId;

-- drop table orderDetailJunction;

select count(*) from orderDetailJunction;  


select * from orders;

-- Update CustomerId in orders based on CustomerName
UPDATE orders o
JOIN customer c ON o.CustomerName = c.CustomerName
SET o.CustomerId = c.CustomerId;

select count(*) from orders;
select * from orders;

-- create junction table;

-- Create orderDetailJunction table with foreign key references
CREATE TABLE orderDetailJunction (
  OrderDetailId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  ProductCode VARCHAR(25),
  CustomerId INT,
  OrderId INT,
  
  FOREIGN KEY (ProductCode) REFERENCES product(ProductCode),
  FOREIGN KEY (CustomerId) REFERENCES customer(CustomerId),
  FOREIGN KEY (OrderId) REFERENCES sales(OrderId)
);

INSERT INTO orderDetailJunction (ProductCode, CustomerId, OrderId)
SELECT ProductCode, CustomerId, OrderId
FROM orders;

select count(*) from orderDetailJunction;


select count(*) from product;



select count(*) from customer;




-- Query 1 : Get total sales by product category

SELECT ProductCategory, SUM(Sales) AS TotalSales 
FROM orders
GROUP BY ProductCategory
ORDER BY TotalSales DESC;






-- Query 2: Get total quantity sold of each product

SELECT ProductCode, SUM(QuantityOrdered) AS TotalQty
FROM orders
GROUP BY ProductCode
ORDER BY TotalQty DESC;




-- Query 3: Get top 5 customers by total sales amount

SELECT c.CustomerName, SUM(o.Sales) AS TotalSales
FROM orders o
JOIN customer c ON o.CustomerId = c.CustomerId
GROUP BY c.CustomerId
ORDER BY TotalSales DESC
LIMIT 5;

-- Query 4: Get total sales by year

SELECT Year_Id, SUM(Sales) AS TotalSales
FROM orders
GROUP BY Year_Id;

-- Query 5: Get order status breakdown

SELECT Status, COUNT(*) AS OrderCount
FROM orders
GROUP BY Status;

-- Query 6: Get best selling products

SELECT ProductCategory, ProductCode, SUM(QuantityOrdered*ItemPrice) AS TotalSales
FROM orders
GROUP BY ProductCode, ProductCategory
ORDER BY TotalSales DESC
LIMIT 3;

-- Query 7: Join orders and customers table to get sales by customer city

SELECT c.City, SUM(o.Sales) AS TotalSales 
FROM orders o
JOIN customer c ON o.CustomerId = c.CustomerId
GROUP BY c.City 
ORDER BY TotalSales DESC;


-- Query 8: Get order status percentage breakdown
SELECT Status, COUNT(*) / (SELECT COUNT(*) FROM orders) * 100 AS Percent 
FROM orders
GROUP BY Status;


-- Query 9: Get top 5 customers by average order amount
SELECT c.CustomerName, AVG(o.Sales) AS AvgOrderAmount
FROM orders o 
JOIN customer c ON o.CustomerId = c.CustomerId
GROUP BY c.CustomerId
ORDER BY AvgOrderAmount DESC
LIMIT 5;

-- Query 10: Get top 5 customers by average order amount:
SELECT c.CustomerName, AVG(o.Sales) AS AvgOrderAmount
FROM orders o 
JOIN customer c ON o.CustomerId = c.CustomerId
GROUP BY c.CustomerId
ORDER BY AvgOrderAmount DESC
LIMIT 5;

-- Query 11: Get sales by month and year

SELECT YEAR(OrderDate) AS Year, MONTH(OrderDate) AS Month, SUM(Sales) AS TotalSales
FROM orders
GROUP BY Year, Month
ORDER BY Year, Month;

-- Query 12: Get moving annual total sales by year

SELECT 
    Year_Id AS Year,
    SUM(Sales) AS AnnualSales,
    (SELECT SUM(Sales) 
     FROM orders 
     WHERE YEAR(OrderDate) BETWEEN Year_Id-1 AND Year_Id) AS MovingAnnualSales
FROM orders
GROUP BY Year_Id;


-- Query 13: Get order status percentage breakdown by year

SELECT o.Year_Id, o.Status, COUNT(*) / (SELECT COUNT(*) FROM orders o2 WHERE o2.Year_Id = o.Year_Id) * 100 AS Percent
FROM orders o
GROUP BY o.Year_Id, o.Status;

-- Query 14: Get sales by country and deal size:

SELECT c.Country, c.DealSize, SUM(o.Sales) AS TotalSales
FROM customer c
JOIN orders o ON c.CustomerId = o.CustomerId
GROUP BY c.Country, c.DealSize;

-- Query 15: Get sales percentage by country
SELECT 
    c.Country,
    SUM(o.Sales) AS TotalSales,
    SUM(o.Sales) / (SELECT SUM(Sales) FROM orders) * 100 AS Percentage
FROM
    orders o
        JOIN
    customer c ON o.CustomerId = c.CustomerId
GROUP BY c.Country
ORDER BY TotalSales DESC;

-- Query 16: Get total sales by product category and country

SELECT 
  c.Country, 
  p.ProductCategory,
  SUM(o.Sales) AS TotalSales
FROM orders o
JOIN customer c ON o.CustomerId = c.CustomerId
JOIN product p ON o.ProductCode = p.ProductCode 
GROUP BY c.Country, p.ProductCategory
ORDER BY TotalSales DESC;









