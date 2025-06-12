-- menghitung RFM dan membaginya menjadi 7 segment
WITH rfm As (
	SELECT
		customer_id,
		DATE '2025-05-05' - MAX(order_date) AS recency,
		COUNT(order_id) AS frequency,
		SUM(payment_value) AS monetary
	FROM transaction
	GROUP BY customer_id
	ORDER BY customer_id
),
rfm_scored AS (
	SELECT 
		customer_id,
		recency,
		frequency,
		monetary,
		NTILE(4) OVER (ORDER BY recency DESC) AS r_score,
		NTILE(4) OVER (ORDER BY frequency DESC) AS f_score,
		NTILE(4) OVER (ORDER BY monetary DESC) AS m_score
	FROM rfm
)

SELECT *,
	CASE
		WHEN r_score = 4 AND f_score = 4 AND m_score = 4 THEN 'Core Customer'
		WHEN r_score >= 3 AND f_score >= 3 THEN 'New Potential'
		WHEN r_score = 4 AND f_score <= 2 THEN 'Recent Buyer'
		WHEN r_score <= 2 AND f_score >= 3 THEN 'Consistent Saver'
		WHEN r_score <= 2 AND m_score >= 3 THEN 'Value Buyer'
		WHEN r_score = 1 THEN 'Inactive'
		ELSE 'Low Engagement'
	END AS segment
FROM rfm_scored;

-- Repeat Purchase Customer
WITH monthly_orders AS (
    SELECT
        customer_id,
        DATE_TRUNC('month', order_date) AS order_month,
        COUNT(DISTINCT order_id) AS order_count
    FROM transaction
    GROUP BY customer_id, order_month
)
SELECT
    customer_id,
    COUNT(*) AS repeat_months
FROM monthly_orders
WHERE order_count > 1
GROUP BY customer_id
ORDER BY repeat_months DESC;

-- EXPLAIN
EXPLAIN
WITH monthly_orders AS (
    SELECT
        customer_id,
        DATE_TRUNC('month', order_date) AS order_month,
        COUNT(DISTINCT order_id) AS order_count
    FROM transaction
    GROUP BY customer_id, order_month
)

SELECT
    customer_id,
    COUNT(*) AS repeat_months
FROM monthly_orders
WHERE order_count > 1
GROUP BY customer_id
ORDER BY repeat_months DESC;

