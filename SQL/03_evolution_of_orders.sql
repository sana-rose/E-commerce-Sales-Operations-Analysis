-- ============================================================
-- TARGET CASE STUDY (Brazil) | 03. EVOLUTION OF E-COMMERCE ORDERS IN BRAZIL
-- ============================================================

-- Q1. Month-on-month number of orders placed in each state
SELECT
    c.customer_state,
    COUNT(o.order_id) AS total_orders,
    YEAR(o.order_purchase_timestamp)  AS per_year,
    MONTH(o.order_purchase_timestamp) AS month_on_month
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_state, per_year, month_on_month
ORDER BY c.customer_state, per_year, month_on_month;

-- Q2. Distribution of customers across the states
SELECT
    COUNT(DISTINCT customer_id) AS no_of_customers,
    customer_state
FROM customers
GROUP BY customer_state
ORDER BY customer_state, no_of_customers;
