/* RETAIL INVENTORY AND SALES ANALYTICS SYSTEM */

/* CREATING DATABASE */
CREATE DATABASE Retail_Analytics;
USE Retail_Analytics;

/* CREATING TABLES */
-- 1. Customers: Stores customer demographic information.
 CREATE TABLE Customers (
    customer_id INT PRIMARY KEY NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    city VARCHAR(50),
    country VARCHAR(50) DEFAULT 'USA',
    join_date DATE NOT NULL
);
desc customers;

-- 2. Categories: Defines product categories. 
CREATE TABLE Categories (
    category_id INT PRIMARY KEY NOT NULL,
    category_name VARCHAR(50) UNIQUE NOT NULL
);
desc Categories;

-- Suppliers: Stores supplier information.
CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY NOT NULL,
    supplier_name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100),
    phone VARCHAR(20)
);
desc Suppliers;

-- 4. Products: Contains detailed product information
CREATE TABLE Products (
    product_id INT PRIMARY KEY NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    category_id INT NOT NULL,
    supplier_id INT NOT NULL,
    price DECIMAL(10, 2) CHECK (price >= 0) NOT NULL,
    cost DECIMAL(10, 2) CHECK (cost >= 0) NOT NULL,
    reorder_level INT CHECK (reorder_level > 0) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);
desc Products;

-- 5. Stores: Lists the physical retail store locations.
CREATE TABLE Stores (
    store_id INT PRIMARY KEY NOT NULL,
    store_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL
);
desc Stores;

-- 6. Sales: Records every transaction line item.
CREATE TABLE Sales (
    transaction_id INT PRIMARY KEY NOT NULL,
    sale_date DATE NOT NULL,
    customer_id INT NOT NULL,
    store_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT CHECK (quantity > 0) NOT NULL,
    total_price DECIMAL(10, 2) CHECK (total_price > 0) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (store_id) REFERENCES Stores(store_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
desc Sales;

-- 7. Inventory: Tracks current stock levels.
CREATE TABLE Inventory (
    inventory_id INT PRIMARY KEY NOT NULL,
    product_id INT NOT NULL,
    store_id INT NOT NULL,
    stock_level INT DEFAULT 0 NOT NULL,
    last_updated TIMESTAMP NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (store_id) REFERENCES Stores(store_id)
);
desc Inventory;

/* ADD VALUES */
-- /* 1. Customers table */ Stores customer information.
INSERT INTO Customers (customer_id, first_name, last_name, email, join_date) VALUES
(1, 'Alice', 'Johnson', 'alice.j@email.com', '2023-01-15'),
(2, 'Bob', 'Williams', 'bob.w@email.com', '2023-02-20'),
(3, 'Charlie', 'Brown', 'charlie.b@email.com', '2023-03-10'),
(4, 'Diana', 'Miller', 'diana.m@email.com', '2023-04-05'),
(5, 'Edward', 'Clark', 'edward.c@email.com', '2023-05-18');
SELECT * FROM Customers;

-- /* 2. categories table */ Defines the product categories. 
INSERT INTO Categories (category_id, category_name) VALUES
(1, 'Electronics'),
(2, 'Home Goods'),
(3, 'Apparel'),
(4, 'Books'),
(5, 'Groceries');
SELECT * FROM categories;

-- /* 3. Suppliers table */ Defines the suppliers for the products. 
INSERT INTO Suppliers (supplier_id, supplier_name, contact_person, phone) VALUES
(1, 'Tech Innovations Inc.', 'Jane Doe', '555-0101'),
(2, 'Home Essentials LLC', 'John Smith', '555-0102'),
(3, 'Fashion Forward Co.', 'Emily Davis', '555-0103'),
(4, 'Literary Emporium', 'Michael Brown', '555-0104'),
(5, 'Fresh Market Partners', 'Sarah Wilson', '555-0105');
SELECT * FROM Suppliers;

-- /* 4. Products table */ Contains product details and references the Categories and Suppliers tables.
INSERT INTO Products (product_id, product_name, category_id, supplier_id, price, cost, reorder_level) VALUES
(1, 'Laptop', 1, 1, 1200.00, 900.00, 10),
(2, 'Wireless Mouse', 1, 1, 35.00, 20.00, 25),
(3, 'Coffee Maker', 2, 2, 75.00, 50.00, 15),
(4, 'Throw Pillow', 2, 2, 25.00, 15.00, 30),
(5, 'T-Shirt', 3, 3, 20.00, 8.00, 50),
(6, 'Denim Jeans', 3, 3, 50.00, 25.00, 30),
(7, 'Sci-Fi Novel', 4, 4, 15.00, 7.00, 40),
(8, 'Cookbook', 4, 4, 30.00, 18.00, 20),
(9, 'Organic Apples', 5, 5, 5.00, 2.50, 100),
(10, 'Milk Gallon', 5, 5, 4.00, 2.00, 150);
SELECT * FROM Products;

-- /* 5. Stores table */ Defines the retail store locations.
INSERT INTO Stores (store_id, store_name, city) VALUES
(101, 'Downtown Store', 'New York'),
(102, 'Uptown Store', 'New York'),
(103, 'West Coast Flagship', 'Los Angeles'),
(104, 'Midwest Hub', 'Chicago');
SELECT * FROM Stores;

-- /* 6. Sales table */ Records individual sales transactions.
INSERT INTO Sales (transaction_id, sale_date, customer_id, store_id, product_id, quantity, total_price) VALUES
(1001, '2024-09-01', 1, 101, 1, 1, 1200.00),
(1002, '2024-09-01', 2, 102, 5, 2, 40.00),
(1003, '2024-09-02', 3, 101, 3, 1, 75.00),
(1004, '2024-09-02', 1, 103, 7, 3, 45.00),
(1005, '2024-09-03', 4, 104, 9, 5, 25.00),
(1006, '2024-09-03', 5, 102, 2, 1, 35.00),
(1007, '2024-09-04', 2, 103, 6, 1, 50.00),
(1008, '2024-09-04', 4, 101, 10, 2, 8.00),
(1009, '2024-09-05', 3, 104, 4, 2, 50.00),
(1010, '2024-09-05', 5, 101, 8, 1, 30.00);
SELECT * FROM Sales;

-- /* 7. Inventory table */ Records the current stock level of products in each store. 
INSERT INTO Inventory (inventory_id, product_id, store_id, stock_level, last_updated) VALUES
(1, 1, 101, 8, '2024-10-11 10:00:00'),
(2, 2, 101, 20, '2024-10-11 10:00:00'),
(3, 3, 101, 12, '2024-10-11 10:00:00'),
(4, 4, 101, 25, '2024-10-11 10:00:00'),
(5, 5, 102, 48, '2024-10-11 10:00:00'),
(6, 6, 102, 29, '2024-10-11 10:00:00'),
(7, 7, 103, 37, '2024-10-11 10:00:00'),
(8, 8, 103, 19, '2024-10-11 10:00:00'),
(9, 9, 104, 95, '2024-10-11 10:00:00'),
(10, 10, 104, 148, '2024-10-11 10:00:00');
SELECT * FROM Inventory;

/* CREATING VIEWS */
-- /* 1. v_sales_summary */
-- Provides a daily sales summary, aggregating revenue and profit by store and product. 
CREATE VIEW v_sales_summary AS
SELECT
    s.sale_date,
    st.store_name,
    p.product_name,
    c.category_name,
    SUM(s.quantity) AS total_quantity_sold,
    SUM(s.total_price) AS total_revenue,
    SUM(s.total_price - (s.quantity * p.cost)) AS total_profit
FROM
    Sales s
JOIN
    Stores st ON s.store_id = st.store_id
JOIN
    Products p ON s.product_id = p.product_id
JOIN
    Categories c ON p.category_id = c.category_id
GROUP BY
    s.sale_date, st.store_name, p.product_name, c.category_name;
desc v_sales_summary;

-- /* 2. v_low_stock_products */
-- Identifies products with stock levels below their reorder level, 
-- useful for inventory management. 
CREATE VIEW v_low_stock_products AS
SELECT
    p.product_name,
    st.store_name,
    i.stock_level,
    p.reorder_level
FROM
    Inventory i
JOIN
    Products p ON i.product_id = p.product_id
JOIN
    Stores st ON i.store_id = st.store_id
WHERE
    i.stock_level <= p.reorder_level;
desc v_low_stock_products;

-- /* 3. v_customer_lifetime_value */
-- Calculates the total amount spent by each customer, 
-- which can be used for customer segmentation and loyalty programs. 
CREATE VIEW v_customer_lifetime_value AS
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    SUM(s.total_price) AS total_amount_spent
FROM
    Sales s
JOIN
    Customers c ON s.customer_id = c.customer_id
GROUP BY
    c.customer_id, c.first_name, c.last_name, c.email;
desc v_customer_lifetime_value;


 /* QUERIES */
-- 1. Top 5 best-selling products by total revenue in the last 30 days
SELECT
    p.product_name,
    SUM(s.total_price) AS total_revenue
FROM
    Sales s
JOIN
    Products p ON s.product_id = p.product_id
WHERE
    s.sale_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 150 DAY)
GROUP BY
    p.product_name
ORDER BY
    total_revenue DESC
LIMIT 5;


-- 2. Total sales revenue per store for the current year
SELECT
    st.store_name,
    SUM(s.total_price) AS total_revenue
FROM
    Sales s
JOIN
    Stores st ON s.store_id = st.store_id
WHERE
    YEAR(s.sale_date) = YEAR(CURRENT_DATE())
GROUP BY
    st.store_name;

-- 3. Monthly sales trend for a specific category
SELECT
    DATE_FORMAT(s.sale_date, '%Y-%m') AS sale_month,
    c.category_name,
    SUM(s.total_price) AS monthly_revenue
FROM
    Sales s
JOIN
    Products p ON s.product_id = p.product_id
JOIN
    Categories c ON p.category_id = c.category_id
WHERE
     -- Replace with your desired category (c.category_name = 'Electronics')
    c.category_name = 'Books'
GROUP BY
    sale_month, c.category_name
ORDER BY
    sale_month;
    
-- 4. Top 5 customers by total spending
SELECT
    first_name,
    last_name,
    total_amount_spent
FROM
    v_customer_lifetime_value
ORDER BY
    total_amount_spent DESC
LIMIT 5;

-- 5. Calculate the average purchase quantity per customer
SELECT
    c.first_name,
    c.last_name,
    AVG(s.quantity) AS average_quantity
FROM
    Sales s
JOIN
    Customers c ON s.customer_id = c.customer_id
GROUP BY
    c.first_name, c.last_name;
    
-- 6. Find the most popular product category based on quantity sold
SELECT
    c.category_name,
    SUM(s.quantity) AS total_quantity
FROM
    Sales s
JOIN
    Products p ON s.product_id = p.product_id
JOIN
    Categories c ON p.category_id = c.category_id
GROUP BY
    c.category_name
ORDER BY
    total_quantity DESC
LIMIT 1;

-- 7. Identify products that are low in stock
SELECT * FROM v_low_stock_products;

-- 8. List suppliers of the top 3 best-selling products
SELECT
    s.supplier_name,
    p.product_name,
    SUM(sl.quantity) AS total_quantity_sold
FROM
    Sales sl
JOIN
    Products p ON sl.product_id = p.product_id
JOIN
    Suppliers s ON p.supplier_id = s.supplier_id
GROUP BY
    s.supplier_name, p.product_name
ORDER BY
    total_quantity_sold DESC
LIMIT 3;


-- 9.Find the store with the highest average transaction value
SELECT
    st.store_name,
    AVG(s.total_price) AS average_transaction_value
FROM
    Sales s
JOIN
    Stores st ON s.store_id = st.store_id
GROUP BY
    st.store_name
ORDER BY
    average_transaction_value DESC
LIMIT 1;

-- 10. Calculate the profit margin for each product
SELECT
    product_name,
    price,
    cost,
    (price - cost) / price AS profit_margin
FROM
    Products
ORDER BY
    profit_margin DESC;
    
-- 11. Find all stores where the total sales revenue
--  is higher than the overall average sales revenue for all stores 
SELECT
    st.store_name,
    SUM(s.total_price) AS total_store_revenue
FROM
    Sales s
JOIN
    Stores st ON s.store_id = st.store_id
GROUP BY
    st.store_name
HAVING
    SUM(s.total_price) > (
        SELECT
            AVG(total_price)
        FROM
            Sales
    )
ORDER BY
    total_store_revenue DESC;


-- 12. Find all customers who have purchased a product from the 'Electronics' category
SELECT DISTINCT
    c.first_name,
    c.last_name,
    c.email
FROM
    Sales s
JOIN
    Customers c ON s.customer_id = c.customer_id
JOIN
    Products p ON s.product_id = p.product_id
JOIN
    Categories cat ON p.category_id = cat.category_id
WHERE
    cat.category_name = 'Electronics';

-- 13. Count the total number of customers
SELECT COUNT(customer_id) AS total_customers
FROM Customers;

-- 14. Find all products with a price over $50
SELECT
    product_name,
    price
FROM
    Products
WHERE
    price > 50.00
ORDER BY
    price DESC;
    
-- 15. Get a list of all unique cities where stores are located
SELECT DISTINCT
    city
FROM
    Stores;
    
-- 16.  Find the total number of items sold per product
SELECT
    p.product_name,
    SUM(s.quantity) AS total_quantity_sold
FROM
    Sales s
JOIN
    Products p ON s.product_id = p.product_id
GROUP BY
    p.product_name
ORDER BY
    total_quantity_sold DESC;

-- 17. Find the customer with the earliest join date
SELECT
    first_name,
    last_name,
    join_date
FROM
    Customers
ORDER BY
    join_date ASC
LIMIT 1;

-- 18. Get the total inventory value for each store
SELECT
    st.store_name,
    SUM(i.stock_level * p.cost) AS total_inventory_value
FROM
    Inventory i
JOIN
    Products p ON i.product_id = p.product_id
JOIN
    Stores st ON i.store_id = st.store_id
GROUP BY
    st.store_name
ORDER BY
    total_inventory_value DESC;

-- 19. Find the top 3 suppliers by total revenue from their products
SELECT
    sup.supplier_name,
    SUM(s.total_price) AS total_revenue
FROM
    Sales s
JOIN
    Products p ON s.product_id = p.product_id
JOIN
    Suppliers sup ON p.supplier_id = sup.supplier_id
GROUP BY
    sup.supplier_name
ORDER BY
    total_revenue DESC
LIMIT 3;

-- 20. Find all sales made in a specific store on a specific date
SELECT
    s.transaction_id,
    c.first_name,
    p.product_name,
    s.quantity
FROM
    Sales s
JOIN
    Customers c ON s.customer_id = c.customer_id
JOIN
    Products p ON s.product_id = p.product_id
WHERE
    s.store_id = 101
    AND s.sale_date = '2024-09-01';

-- 21. Get a count of products per category
SELECT
    c.category_name,
    COUNT(p.product_id) AS number_of_products
FROM
    Products p
JOIN
    Categories c ON p.category_id = c.category_id
GROUP BY
    c.category_name
ORDER BY
    number_of_products DESC;

-- 22. Find stores with more than 100 units of a specific product in stock
SELECT
    s.store_name,
    i.stock_level
FROM
    Inventory i
JOIN
    Stores s ON i.store_id = s.store_id
WHERE
    i.product_id = 205
    AND i.stock_level > 100;

-- 23. Find the top-spending customer for each store
    SELECT
    st.store_name,
    c.first_name,
    c.last_name,
    sub.top_spend AS total_amount_spent
FROM
    (SELECT 
        store_id, 
        customer_id, 
        SUM(total_price) AS top_spend
    FROM Sales
    GROUP BY store_id, customer_id) AS sub
JOIN
    Stores st ON sub.store_id = st.store_id
JOIN
    Customers c ON sub.customer_id = c.customer_id
JOIN
    (SELECT 
        store_id, 
        MAX(total_spend) AS max_spend
    FROM (
        SELECT 
            store_id, 
            customer_id, 
            SUM(total_price) AS total_spend
        FROM Sales
        GROUP BY store_id, customer_id
    ) AS aggregated_sales
    GROUP BY store_id) AS max_sales
    ON sub.store_id = max_sales.store_id AND sub.top_spend = max_sales.max_spend;


    
-- 24. Compare each product's sales to its category's average sales
SELECT
    p.product_name,
    c.category_name,
    SUM(s.total_price) AS product_sales,
    (SELECT AVG(s2.total_price)
     FROM Sales s2
     JOIN Products p2 ON s2.product_id = p2.product_id
     WHERE p2.category_id = p.category_id) AS category_average_sales,
    SUM(s.total_price) - (SELECT AVG(s3.total_price)
     FROM Sales s3
     JOIN Products p3 ON s3.product_id = p3.product_id
     WHERE p3.category_id = p.category_id) AS sales_difference
FROM
    Sales s
JOIN
    Products p ON s.product_id = p.product_id
JOIN
    Categories c ON p.category_id = c.category_id
GROUP BY
    p.product_name, c.category_name, p.category_id
ORDER BY
    c.category_name, product_sales DESC;

-- 25. Total revenue per product category
SELECT
    c.category_name,
    SUM(s.total_price) AS total_revenue
FROM
    Sales s
JOIN
    Products p ON s.product_id = p.product_id
JOIN
    Categories c ON p.category_id = c.category_id
GROUP BY
    c.category_name
ORDER BY
    total_revenue DESC;
