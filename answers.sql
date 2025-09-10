-- Question 1: Achieving 1NF (First Normal Form)

-- Issue: Products column contains multiple values (comma-separated), which violates 1NF.
-- Solution: Eliminate repeating groups to ensure atomic values per cell

-- Normalized version of ProductDetail: 1NF
CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50)
);

-- Inserting normalized rows (manually splitting products into individual rows)
INSERT INTO ProductDetail (OrderID, CustomerName, Product) VALUES 
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');


-- Question 2: Achieving 2NF (Second Normal Form)

-- Issue: column CustomerName depends only on OrderID, not on the full composite key (OrderID, Product) — partial dependency violates 2NF.
-- Solution: Decompose into two separate tables so every non-key column is fully dependent on the whole primary key.

-- 1. Creating Orders table with OrderID and CustomerName
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- 2. Creating OrderItems table with OrderID, Product, and Quantity
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Inserting into Orders (no repeated CustomerName)
INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Inserting into OrderItems (products with quantities)
INSERT INTO OrderItems (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);
