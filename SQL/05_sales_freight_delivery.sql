-- ============================================================
-- TARGET CASE STUDY (Brazil) | 05. SALES, FREIGHT AND DELIVERY TIME
-- ============================================================

-- Q1. Delivery time and difference from estimated delivery date
SELECT
    order_id,
    DATEDIFF(order_delivered_customer_date, DATE(order_purchase_timestamp)) AS delivery_time,
    DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date)  AS difference,
    CASE
        WHEN DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) < 0 THEN 'Early'
        WHEN DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) > 0 THEN 'Late'
        WHEN DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) = 0 THEN 'On_Time'
        ELSE 'Invalid'
    END AS delivery_status
FROM orders;

-- Q2. Top 5 states with HIGHEST average freight value
SELECT
    c.customer_state,
    AVG(oi.freight_value) AS avg_freight
FROM order_items oi
JOIN orders o
    ON o.order_id = oi.order_id
JOIN customers c
    ON c.customer_id = o.customer_id
GROUP BY c.customer_state
ORDER BY avg_freight DESC
LIMIT 5;

-- Q2. Top 5 states with LOWEST average freight value
SELECT
    c.customer_state,
    AVG(oi.freight_value) AS avg_freight
FROM order_items oi
JOIN orders o
    ON o.order_id = oi.order_id
JOIN customers c
    ON c.customer_id = o.customer_id
GROUP BY c.customer_state
ORDER BY avg_freight ASC
LIMIT 5;

-- Q3. Top 5 states with HIGHEST average delivery time
SELECT
    c.customer_state,
    AVG(DATEDIFF(DATE(o.order_delivered_customer_date),
                 DATE(o.order_purchase_timestamp))) AS avg_delivery_time
FROM customers c
JOIN orders o
    ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY avg_delivery_time DESC
LIMIT 5;

-- Q3. Top 5 states with LOWEST average delivery time
SELECT
    c.customer_state,
    AVG(DATEDIFF(DATE(o.order_delivered_customer_date),
                 DATE(o.order_purchase_timestamp))) AS avg_delivery_time
FROM customers c
JOIN orders o
    ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY avg_delivery_time ASC
LIMIT 5;

-- Q4. Top 5 states where delivery is really fast compared to the estimated date
SELECT
    c.customer_state,
    ROUND(AVG(DATEDIFF(DATE(o.order_delivered_customer_date),
                       DATE(o.order_estimated_delivery_date))), 0) AS avg_delivery_time
FROM customers c
JOIN orders o
    ON o.customer_id = c.customer_id
GROUP BY c.customer_state
HAVING avg_delivery_time < 0
ORDER BY avg_delivery_time ASC
LIMIT 5;
