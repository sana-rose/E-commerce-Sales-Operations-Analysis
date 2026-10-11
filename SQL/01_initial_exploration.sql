-- ============================================================
-- TARGET CASE STUDY (Brazil) | 01. INITIAL EXPLORATION
-- Database: MySQL | Schema: target_case_study
-- ============================================================

-- Q1. Structure of every table
DESCRIBE customers;
DESCRIBE orders;
DESCRIBE order_items;
DESCRIBE payments;
DESCRIBE order_reviews;
DESCRIBE products;
DESCRIBE sellers;
DESCRIBE geolocation;

-- Q2. Data type of columns in the customers table
-- (Result grid shows all columns are of datatype text)
SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'target_case_study'
  AND table_name = 'customers';

-- Q3. Time period for which the data is given
SELECT
    MIN(order_purchase_timestamp) AS earliest_order,
    MAX(order_purchase_timestamp) AS latest_order
FROM orders;

-- Q4. Number of cities and states from which orders were placed
SELECT
    COUNT(DISTINCT c.customer_city)  AS city,
    COUNT(DISTINCT c.customer_state) AS state
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id;
