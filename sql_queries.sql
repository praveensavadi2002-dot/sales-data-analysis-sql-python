-- CREATE TABLE
CREATE TABLE sales (
    order_id INT,
    customer_id TEXT,
    customer_name TEXT,
    product_id TEXT,
    product TEXT,
    category TEXT,
    quantity INT,
    price INT,
    order_date DATE,
    city TEXT
);

-- ==============================
-- BASIC / INTERMEDIATE QUERIES
-- ==============================

-- Monthly Revenue
SELECT strftime('%m', order_date) AS month,
       SUM(quantity * price) AS revenue
FROM sales
GROUP BY month;

-- Category-wise Sales
SELECT category, SUM(quantity * price) AS revenue
FROM sales
GROUP BY category;

-- Repeat Customers
SELECT customer_name, COUNT(order_id) AS orders
FROM sales
GROUP BY customer_name
HAVING COUNT(order_id) > 1;


-- Top Customers
SELECT customer_name,
       SUM(quantity * price) AS total_spent
FROM sales
GROUP BY customer_name
ORDER BY total_spent DESC;


-- ==============================
-- ADVANCED (DATABASE DESIGN)
-- ==============================

-- Create Tables
CREATE TABLE customers (
    customer_id TEXT,
    customer_name TEXT,
    city TEXT
);

CREATE TABLE products (
    product_id TEXT,
    product TEXT,
    category TEXT,
    price INT
);

CREATE TABLE orders (
    order_id INT,
    customer_id TEXT,
    product_id TEXT,
    quantity INT,
    order_date DATE
);

-- ==============================
-- ADVANCED QUERIES (JOIN)
-- ==============================

SELECT c.customer_name,
       SUM(o.quantity * p.price) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;


-- ==============================
-- WINDOW FUNCTION
-- ==============================

SELECT customer_name,
       SUM(quantity * price) AS total_spent,
       RANK() OVER (ORDER BY SUM(quantity * price) DESC) AS rank
FROM sales
GROUP BY customer_name;
