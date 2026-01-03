-- Total AI usage by customer
SELECT
  customer_id,
  SUM(ai_tokens_used) AS total_tokens
FROM ai_usage
GROUP BY customer_id
ORDER BY total_tokens DESC;

-- Identify high discount + high usage risk
SELECT
  s.customer_id,
  d.discount_percent,
  SUM(a.ai_tokens_used) AS total_tokens
FROM subscriptions s
JOIN discounts d ON s.customer_id = d.customer_id
JOIN ai_usage a ON s.customer_id = a.customer_id
GROUP BY s.customer_id, d.discount_percent
HAVING d.discount_percent > 30 AND total_tokens > 500000;
