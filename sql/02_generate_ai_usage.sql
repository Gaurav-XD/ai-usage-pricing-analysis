-- Generate realistic multi-month AI usage data
INSERT INTO ai_usage (customer_id, usage_month, ai_tokens_used)
SELECT
  c.customer_id,
  m.usage_month,
  CASE
    WHEN c.segment = 'SMB' THEN FLOOR(20000 + RAND()*80000)
    WHEN c.segment = 'Mid-Market' THEN FLOOR(100000 + RAND()*300000)
    ELSE FLOOR(300000 + RAND()*1700000)
  END AS ai_tokens_used
FROM customers c
CROSS JOIN (
  SELECT DATE('2024-01-01') AS usage_month
  UNION ALL SELECT '2024-02-01'
  UNION ALL SELECT '2024-03-01'
  UNION ALL SELECT '2024-04-01'
  UNION ALL SELECT '2024-05-01'
  UNION ALL SELECT '2024-06-01'
) m;
