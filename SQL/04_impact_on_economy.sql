-- ============================================================
-- TARGET CASE STUDY (Brazil) | 04. IMPACT ON ECONOMY
-- ============================================================

-- Q1. Price and freight value by state and year
SELECT
    c.customer_state,
    YEAR(o.order_purchase_timestamp) AS each_year,
    ROUND(SUM(oi.price), 2)         AS total_price,
    ROUND(AVG(oi.price), 2)         AS avg_price,
    ROUND(SUM(oi.freight_value), 2) AS total_freight,
    ROUND(AVG(oi.freight_value), 2) AS avg_freight
FROM order_items oi
JOIN orders o
    ON o.order_id = oi.order_id
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_state, each_year
ORDER BY each_year ASC, total_price DESC, total_freight DESC;

-- Q2. % increase in the cost of orders from 2017 to 2018 (Jan to Aug only)
SELECT
    `2017_Cost`,
    `2018_Cost`,
    ROUND(((`2018_Cost` - `2017_Cost`) / `2017_Cost`) * 100, 2) AS percentage_increase
FROM (
    SELECT
        ROUND(SUM(CASE
            WHEN MONTH(o.order_purchase_timestamp) BETWEEN 1 AND 8
             AND YEAR(o.order_purchase_timestamp) = 2017
            THEN oi.price + oi.freight_value
            ELSE 0 END), 2) AS `2017_Cost`,
        ROUND(SUM(CASE
            WHEN MONTH(o.order_purchase_timestamp) BETWEEN 1 AND 8
             AND YEAR(o.order_purchase_timestamp) = 2018
            THEN oi.price + oi.freight_value
            ELSE 0 END), 2) AS `2018_Cost`
    FROM order_items oi
    JOIN orders o
        ON o.order_id = oi.order_id
) t;

-- Q3. Total and average price and freight value for each state
SELECT
    c.customer_state,
    ROUND(SUM(oi.price), 2)         AS total_price,
    ROUND(SUM(oi.freight_value), 2) AS total_freight,
    ROUND(AVG(oi.price), 2)         AS average_price,
    ROUND(AVG(oi.freight_value), 2) AS average_freight_value
FROM order_items oi
JOIN orders o
    ON o.order_id = oi.order_id
JOIN customers c
    ON c.customer_id = o.customer_id
GROUP BY c.customer_state
ORDER BY total_price DESC;
