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
SELECT
	customer_id,
	COUNT(order_id) AS Order_count
FROM transaction
GROUP BY customer_id
HAVING COUNT(order_id) > 1
ORDER BY order_count DESC;
