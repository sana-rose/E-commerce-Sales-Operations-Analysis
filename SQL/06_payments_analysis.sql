-- ============================================================
-- TARGET CASE STUDY (Brazil) | 06. ANALYSIS BASED ON PAYMENTS
-- ============================================================

-- Q1. Month-on-month number of orders placed using different payment types
SELECT
    COUNT(DISTINCT o.order_id) AS no_of_orders,
    YEAR(o.order_purchase_timestamp)  AS per_year,
    MONTH(o.order_purchase_timestamp) AS per_month,
    p.payment_type
FROM payments p
JOIN orders o
    ON o.order_id = p.order_id
GROUP BY per_year, per_month, p.payment_type
ORDER BY per_year, per_month, no_of_orders DESC;

-- Q2. Number of orders by payment installments
SELECT
    COUNT(DISTINCT o.order_id) AS no_of_orders,
    p.payment_installments
FROM payments p
JOIN orders o
    ON o.order_id = p.order_id
GROUP BY p.payment_installments
ORDER BY p.payment_installments DESC;
