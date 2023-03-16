-- Problem 1 & 2
-- 1. Using JOINs in a single query, combine data from all three tables (employees, products, sales) to view all sales with complete employee and product information in one table.
SELECT * FROM employees INNER JOIN sales ON employees.EmployeeID = sales.SalesPersonID INNER JOIN products ON sales.ProductID = products.ProductID;
-- 2a. Create a View for the query you made in Problem 1 named "all_sales"
CREATE VIEW all_sales AS SELECT EmployeeID, FirstName, MiddleInitial, LastName, SalesID, CustomerID, sales.ProductID, Name, Price, Quantity FROM employees INNER JOIN sales ON employees.EmployeeID = sales.SalesPersonID INNER JOIN products ON sales.ProductID = products.ProductID;
-- NOTE: You'll want to remove any duplicate columns to clean up your view!
-- 2b. Test your View by selecting all rows and columns from the View
SELECT * FROM all_sales;
-- Problem 3
-- Find the average sale amount for each sales person
SELECT DISTINCT employeeID, firstname, lastname, avg(PRICE), avg(quantity) FROM all_sales group by employeeid, firstname, lastname order by avg(price) DESC;
-- Problem 4
-- Find the top three sales persons by total sales
SELECT DISTINCT employeeID, firstname, lastname, avg(PRICE), avg(quantity) FROM all_sales group by employeeid, firstname, lastname order by avg(quantity) DESC LIMIT 3;
-- Problem 5
-- Find the product that has the highest price
SELECT * FROM products order by price DESC LIMIT 1;
-- Problem 6
-- Find the product that was sold the most times
SELECT COUNT(productid) AS amount_sold, name, price FROM all_sales group by name, price order by amount_sold DESC LIMIT 1;
-- Problem 7
-- Using a subquery, find all products that have a price higher than the average price for all products
SELECT * FROM products WHERE price > (SELECT avg(price) FROM products) ORDER BY price;

-- Problem 8
-- Find the customer who spent the most money in purchased products
SELECT customerID, SUM(price) AS amount_spent FROM all_sales GROUP BY customerID ORDER BY amount_spent DESC LIMIT 1;
-- customerID 8241

-- Problem 9
-- Find the total number of sales for each sales person
SELECT employeeID, firstname, lastname, SUM(quantity) AS pieces_sold FROM all_sales GROUP BY employeeID, firstname, lastname ORDER BY pieces_sold DESC;

-- Problem 10
-- Find the sales person who sold the most to the customer you found in Problem 8
SELECT * FROM all_sales WHERE customerid = 8241;
-- The query works for this problem because it seems like only one rep was selling to this customer. I want to figure out how to write a query that will group results by rep and count how many sales each rep had to that customer. Maybe a subquery that includes (SELECT COUNT(employeeid) AS rep_loyalty_score FROM all_sales GROUP BY employee_id) but I'm not sure exactly where to place it/what operator to use.