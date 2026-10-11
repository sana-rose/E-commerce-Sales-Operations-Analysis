-- ============================================================
-- TARGET CASE STUDY (Brazil) | 02. IN-DEPTH EXPLORATION
-- ============================================================

-- Q1. Is there a growing trend in the number of orders placed over the years?
SELECT
    COUNT(order_id) AS no_of_orders,
    EXTRACT(YEAR FROM order_purchase_timestamp) AS per_year
FROM orders
GROUP BY per_year
ORDER BY per_year;

-- Q2. Monthly seasonality in the number of orders
SELECT
    COUNT(order_id) AS no_of_orders,
    EXTRACT(YEAR FROM order_purchase_timestamp)  AS per_year,
    EXTRACT(MONTH FROM order_purchase_timestamp) AS per_month
FROM orders
GROUP BY per_year, per_month
ORDER BY per_year, per_month;

-- Q3. Time of day when Brazilian customers mostly place orders
-- Dawn (0-6 hrs), Morning (7-12 hrs), Afternoon (13-18 hrs), Night (19-23 hrs)
SELECT
    COUNT(order_id) AS total_orders,
    CASE
        WHEN EXTRACT(HOUR FROM order_purchase_timestamp) BETWEEN 0 AND 5   THEN 'Dawn'
        WHEN EXTRACT(HOUR FROM order_purchase_timestamp) BETWEEN 6 AND 11  THEN 'Morning'
        WHEN EXTRACT(HOUR FROM order_purchase_timestamp) BETWEEN 12 AND 16 THEN 'Afternoon'
        ELSE 'Night'
    END AS time_of_day
FROM orders
GROUP BY time_of_day
ORDER BY total_orders DESC;
