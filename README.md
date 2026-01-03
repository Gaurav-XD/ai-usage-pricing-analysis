# AI Usage-Based Pricing & Discount Leakage Analysis (SaaS)

## Overview
This project analyzes how AI feature usage and discounting impact pricing effectiveness and unit economics for a SaaS DevSecOps platform. The analysis focuses on identifying discount leakage, evaluating usage-based pricing thresholds, and assessing AI profitability across customer segments.

The project simulates real-world pricing challenges faced by modern SaaS companies offering compute-intensive AI features.

---

## Business Problem
As SaaS platforms introduce AI-powered features, costs increasingly scale with customer usage rather than flat subscriptions. Traditional pricing models risk margin erosion when:
- High-usage customers pay the same base price as low-usage customers
- Deep discounts are applied without accounting for AI compute costs
- Usage thresholds are not aligned with customer value

This project aims to answer:
- Which customers consume disproportionate AI resources?
- Where are discounts misaligned with usage and value?
- Should AI features be monetized using usage-based pricing?

---

## Data Model
The analysis uses a relational data model designed to reflect real SaaS operations:

- **customers**: customer segment and company size  
- **subscriptions**: plan type and base subscription pricing  
- **discounts**: negotiated discount percentages  
- **ai_usage**: monthly AI token consumption by customer  
- **ai_pricing_tiers**: free usage thresholds and overage pricing  
- **ai_costs**: per-unit AI compute cost  

All datasets are generated using SQL to ensure reproducibility and scalability.

---

## SQL Workflow
The project follows a structured SQL workflow:

1. **Database reset**
   - Safely clears existing data while maintaining referential integrity

2. **Base data insertion**
   - Customers, subscriptions, and discounts inserted in dependency order

3. **AI usage generation**
   - Multi-month AI usage generated dynamically by customer segment

4. **Analysis queries**
   - Pricing, usage, discount, and unit economics analysis using advanced SQL

---

## Advanced SQL Techniques Used
- Window functions (LAG, RANK)
- Cohort analysis by customer segment
- Usage-based pricing threshold calculations
- Revenue vs cost (unit economics) modeling
- Discount leakage detection
- Risk prioritization for pricing teams

---

## Key Insights
- Enterprise customers account for the majority of AI usage growth.
- Flat pricing models fail to capture the cost of high AI consumption.
- High discounts combined with high AI usage create negative contribution margins.
- Usage-based pricing thresholds are exceeded frequently in higher-tier plans.

---

## Pricing Recommendations
- Introduce AI usage thresholds by plan tier.
- Charge overage fees per defined AI usage unit.
- Cap discounts for AI-heavy enterprise customers.
- Align AI pricing with underlying compute costs and customer value.

---

## Repository Structure
