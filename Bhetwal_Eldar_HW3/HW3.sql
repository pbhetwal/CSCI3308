/*
Parikshit Bhetwal
Omer Eldar
*/ 

/* 1. Create an alphabetical listing (First Name, Last Name) of all employees not
living in the USA who have been employed with company for at least 5 years as of
today. (4)*/
SELECT FirstName, LastName
FROM Employees 
WHERE Country != 'USA' AND (HireDate <= now() - INTERVAL '5 years') 
ORDER BY FirstName ASC, LastName ASC; 

/*2. Prepare a Reorder List for products currently in stock. (Products in stock have at
least one unit in inventory.) Show Product ID, Name, Quantity in Stock and Unit
Price for products whose inventory level is at or below the reorder level. (17)*/
SELECT ProductID, ProductName, UnitsInStock, UnitPrice
FROM Products 
WHERE UnitsInStock <= ReorderLevel and UnitsInStock >= 1; 

/*3. What is the name and unit price of the most and least expensive product sold by
company? Use a sub-query. (2)*/
SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice = (SELECT MIN(UnitPrice) FROM Products)
OR UnitPrice = (SELECT MAX(UnitPrice) FROM Products);

/*4. Create a list of the products in stock which have an inventory value (the number
of units in stock multiplied by the unit price) over $1000. Show the answer set
columns as Product ID, Product Name and “Total Inventory Value” in order of
descending inventory value (highest to lowest.) (25)*/
SELECT ProductID, ProductName, UnitsInStock*UnitPrice AS "Total Inventory Value"
FROM Products
WHERE UnitsInStock*UnitPrice > 1000 
ORDER BY UnitsInStock*UnitPrice DESC; 

/*5. List the country and a count of Orders for all the orders that shipped outside the
Germany during October 2013 in descending country sequence. (12)*/
SELECT ShipCountry, COUNT(ShipCountry) AS "Count of Orders" 
FROM Orders
WHERE ShippedDate BETWEEN '2013-10-01' AND '2013-10-31' AND NOT ShipCountry = 'Germany'
GROUP BY ShipCountry
ORDER BY ShipCountry DESC; 

/*6. List the CustomerID and ShipName of the customers who have more than or
equal to 10 orders. (37)*/ 
SELECT CustomerID, ShipName
FROM Orders
GROUP BY CustomerID, ShipName
HAVING COUNT(CustomerID) >= 10;

/*7. Create a Supplier Inventory report (by Supplier ID) showing the total value of
their inventory in stock. (“value of inventory” = UnitsInStock * UnitPrice.) List
only those suppliers from whom company receives more than or equal to 5
different items. (2)*/
SELECT SupplierID, SUM(UnitsInStock*UnitPrice) AS "Total Value of Inventory"
FROM Products
GROUP BY SupplierID
HAVING COUNT(SupplierID) >= 5; 

/*8. Create a SUPPLIER PRICE LIST showing the Supplier CompanyName,
ProductName and UnitPrice for all products from suppliers located in the United
States of America or Germany. Sort the list in order from HIGHEST price to
LOWEST price. (21)*/ 
SELECT s.CompanyName, p.ProductName, p.UnitPrice
FROM Products AS p 
INNER JOIN Suppliers AS s ON p.SupplierID = s.SupplierID
WHERE s.Country = 'Germany' OR s.Country = 'USA'
ORDER BY p.UnitPrice DESC; 

/*9. Create an EMPLOYEE ORDER LIST showing, in reverse alphabetical order
(LastName, FirstName), the LastName, FirstName, Title, Extension and Number
of Orders for each employee who has more than 50 orders. (7)*/ 
SELECT e.Lastname, e.FirstName, e.Title, e.Extension, COUNT(o.OrderID) AS "Numer of Orders"
FROM Employees as e 
INNER JOIN Orders as o ON e.EmployeeID = o.EmployeeID 
GROUP BY LastName, FirstName, Title, Extension
HAVING COUNT(o.OrderID) > 50
ORDER BY e.Lastname DESC, e.FirstName DESC; 

/*10. Create an ORDERS EXCEPTION LIST showing the CustomerID and the
CompanyName of all customers who have no orders on file. (2)*/ 
SELECT c.CustomerID, c.CompanyName 
FROM Customers as c 
LEFT JOIN Orders as o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;  

/*11. Create an OUT OF STOCK LIST showing the Supplier CompanyName, Supplier ContactName, Product CategoryName,
CategoryDescription, ProductName and UnitsOnOrder for all products that are out of stock
(UnitsInStock = 0). (5)*/ 
SELECT s.CompanyName, s.ContactName, c.CategoryName, c.Description, p.ProductName, p.UnitsOnOrder
FROM Suppliers AS s 
INNER JOIN Products AS p ON s.SupplierID = p.SupplierID
INNER JOIN Categories AS c on p.CategoryID = c.CategoryID
WHERE p.UnitsInstock = 0; 

/*12. List the productname, suppliername, supplier country and UnitsInStock for all
the products that come in a bags or bottles. (16)*/ 
SELECT p.ProductName, s.CompanyName, s.Country, p.UnitsInStock
FROM Suppliers AS s 
INNER JOIN Products AS p ON s.SupplierID = p.SupplierID 
WHERE p.QuantityPerUnit LIKE '%bottles%' OR p.QuantityPerUnit LIKE '%bags%'; 

/*13. Create a NEW table named “Top_Items” with the following columns: ItemID
(integer), ItemCode (integer), ItemName (varchar(40)), InventoryDate
(timestamp), SupplierID (integer), ItemQuantity (integer)and ItemPrice (decimal
(9,2)) . None of these columns can be NULL. Include a PRIMARY KEY constraint
on ItemID. (No answer set needed.)*/ 
CREATE TABLE IF NOT EXISTS Top_Items(
	ItemID INT PRIMARY KEY NOT NULL, 
	ItemCode INT NOT NULL, 
	ItemName VARCHAR(40) NOT NULL,
	InventoryDate TIMESTAMP NOT NULL, 
	SupplierID INT NOT NULL, 
	ItemQuantity INT NOT NULL, 
	ItemPrice DECIMAL(9,2) NOT NULL
);

/*14. Populate the new table “Top_Items” using these columns from the products
table.
ProductID ➜ ItemID
CategoryID ➜ ItemCode
ProductName ➜ ItemName
Today’s date ➜ Inventory Date
UnitsInStock ➜ ItemQuantity
UnitPrice ➜ ItemPrice
SupplierID ➜ SupplierID
for those products whose inventory value is greater than $1,500. (No answer set
needed.)
(HINT: the inventory value of an Item is ItemPrice times ItemQuantity. ) (16 rows
inserted)*/ 
INSERT INTO Top_Items(ItemID, ItemCode, ItemName, InventoryDate, ItemQuantity, ItemPrice, SupplierID)
SELECT ProductID, CategoryID, ProductName, now(), UnitsInstock, UnitPrice, SupplierID
FROM Products 
WHERE UnitsInstock * UnitPrice > 1500; 

/*15. Delete the rows in Top_Items for suppliers from USA or Canada. (6 rows
deleted. No answer set needed.)*/ 
DELETE FROM Top_Items AS ti
USING Suppliers as s
WHERE (ti.SupplierID=s.SupplierID) AND (s.Country = 'Canada' or s.Country = 'USA');

/*16. Add a new column to the Top_Items table called InventoryValue ((decimal
(9,2))). No answer set needed.*/
ALTER TABLE Top_Items 
ADD COLUMN InventoryValue DECIMAL(9,2); 

/*17. Update the Top_Items table, setting the InventoryValue column equal to
ItemPrice times ItemQuantity. (No answer set needed.)*/ 
UPDATE Top_Items 
SET InventoryValue = (ItemPrice * ItemQuantity); 

/*18. Drop the Top_Items table. No answer set needed.*/ 
DROP TABLE Top_Items; 