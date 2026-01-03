/*
===========================================================
Advanced Pricing & AI Monetization Analysis
Context: SaaS DevSecOps platform with AI features
Purpose: Support pricing, discount, and usage-based decisions
===========================================================
*/

-- =========================================================
-- 1. Month-over-Month AI Usage Growth (Window Function)
-- Question: Is AI usage accelerating by customer?
-- =========================================================
SELECT
  customer_id,
  usage_month,
  ai_tokens_used,
  ai_tokens_used -
  LAG(ai_tokens_used) OVER (
    PARTITION BY customer_id
    ORDER BY usage_month
  ) AS mom_growth_tokens
FROM ai_usage
ORDER BY customer_id, usage_month;

-- =========================================================
-- 2. AI Usage Cohort Analysis by Customer Segment
-- Question: Which segments drive AI consumption?
-- =========================================================
SELECT
  c.segment,
  a.usage_month,
  SUM(a.ai_tokens_used) AS total_tokens
FROM ai_usage a
JOIN customers c ON a.customer_id = c.customer_id
GROUP BY c.segment, a.usage_month
ORDER BY a.usage_month, c.segment;

-- =========================================================
-- 3. Free vs Billable AI Usage (Pricing Threshold Logic)
-- Question: How much AI usage should be monetized?
-- =========================================================
SELECT
  s.customer_id,
  s.plan,
  SUM(a.ai_tokens_used) AS total_tokens,
  t.free_tokens,
  GREATEST(SUM(a.ai_tokens_used) - t.free_tokens, 0) AS billable_tokens
FROM ai_usage a
JOIN subscriptions s ON a.customer_id = s.customer_id
JOIN ai_pricing_tiers t ON s.plan = t.plan
GROUP BY s.customer_id, s.plan, t.free_tokens;

-- =========================================================
-- 4. AI Revenue vs Cost (Unit Economics)
-- Question: Are we profitable on AI usage?
-- =========================================================
SELECT
  u.customer_id,
  ROUND((u.billable_tokens / 100000) * t.price_per_100k, 2) AS ai_revenue,
  ROUND((u.billable_tokens / 100000) * c.cost_per_100k_tokens, 2) AS ai_cost,
  ROUND(
    ((u.billable_tokens / 100000) * t.price_per_100k) -
    ((u.billable_tokens / 100000) * c.cost_per_100k_tokens), 2
  ) AS ai_margin
FROM (
  SELECT
    a.customer_id,
    s.plan,
    GREATEST(SUM(a.ai_tokens_used) - t.free_tokens, 0) AS billable_tokens
  FROM ai_usage a
  JOIN subscriptions s ON a.customer_id = s.customer_id
  JOIN ai_pricing_tiers t ON s.plan = t.plan
  GROUP BY a.customer_id, s.plan, t.free_tokens
) u
JOIN ai_pricing_tiers t ON u.plan = t.plan
JOIN ai_costs c;

-- =========================================================
-- 5. Discount Leakage + AI Usage Risk
-- Question: Which accounts combine deep discounts and high AI usage?
-- =========================================================
SELECT
  s.customer_id,
  c.segment,
  d.discount_percent,
  SUM(a.ai_tokens_used) AS total_tokens
FROM subscriptions s
JOIN customers c ON s.customer_id = c.customer_id
JOIN discounts d ON s.customer_id = d.customer_id
JOIN ai_usage a ON s.customer_id = a.customer_id
GROUP BY s.customer_id, c.segment, d.discount_percent
HAVING d.discount_percent > 30 AND total_tokens > 500000
ORDER BY total_tokens DESC;

-- =========================================================
-- 6. Rank Customers by AI Cost Impact
-- Question: Who should pricing teams focus on first?
-- =========================================================
SELECT
  customer_id,
  SUM(ai_tokens_used) AS total_tokens,
  RANK() OVER (ORDER BY SUM(ai_tokens_used) DESC) AS usage_rank
FROM ai_usage
GROUP BY customer_id;

-- =========================================================
-- 7. Plan-Level AI Overuse Rate
-- Question: Are pricing thresholds set correctly?
-- =========================================================
SELECT
  s.plan,
  COUNT(DISTINCT s.customer_id) AS customers,
  COUNT(DISTINCT CASE
    WHEN a.ai_tokens_used > t.free_tokens THEN s.customer_id
  END) AS overuse_customers
FROM subscriptions s
JOIN ai_usage a ON s.customer_id = a.customer_id
JOIN ai_pricing_tiers t ON s.plan = t.plan
GROUP BY s.plan;
