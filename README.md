# AI Usage-Based Pricing & Discount Leakage Analysis (SaaS)

## Overview
This project analyzes how AI feature usage and discounting impact pricing effectiveness and unit economics for a SaaS DevSecOps platform. It simulates real-world challenges faced by modern SaaS companies offering compute-intensive AI features, where costs scale with usage rather than flat subscriptions.

The analysis focuses on identifying discount leakage, evaluating usage-based pricing thresholds, and assessing AI profitability across customer segments using advanced SQL.

---

## Business Problem
As SaaS platforms introduce AI-powered features, traditional flat pricing models become risky. Key challenges include:

- High-usage customers paying the same base price as low-usage customers
- Deep enterprise discounts applied without considering AI compute costs
- Lack of usage thresholds aligned with customer value
- Margin erosion due to unmonetized AI consumption

This project answers:
- Which customers consume disproportionate AI resources?
- Where are discounts misaligned with usage and value?
- Should AI features be monetized using usage-based pricing?
- Which accounts pose the highest pricing and margin risk?

---

## Data Model
The project uses a relational data model designed to reflect real SaaS operations:

- customers – customer segmentation and company size
- subscriptions – plan tier and base subscription pricing
- discounts – negotiated discount percentages
- ai_usage – monthly AI token consumption per customer
- ai_pricing_tiers – free usage thresholds and overage pricing
- ai_costs – per-unit AI compute cost

All data is generated programmatically using SQL to ensure reproducibility and scalability.

---

## SQL Workflow
1. Database reset to ensure clean, reproducible analysis
2. Base data insertion for customers, subscriptions, and discounts
3. Automated generation of multi-month AI usage data (100+ rows)
4. Advanced SQL analysis for pricing, usage, discounts, and unit economics

---

## Advanced SQL Techniques Used
- Window functions (LAG, RANK)
- Month-over-month growth analysis
- Cohort analysis by customer segment
- Usage-based pricing threshold logic
- AI revenue vs cost (unit economics)
- Discount leakage detection
- Pricing risk prioritization

---

## Key Insights
- Enterprise customers drive the majority of AI usage growth.
- Flat pricing models fail to recover AI compute costs for heavy users.
- High discounts combined with high AI usage lead to negative margins.
- Usage thresholds are frequently exceeded in higher-tier plans.

---

## Pricing Recommendations
- Introduce AI usage thresholds by plan tier
- Charge overage fees per defined AI usage unit
- Cap discounts for AI-heavy enterprise customers
- Align AI pricing with underlying compute costs and customer value

---

## Repository Structure
```
ai-usage-pricing-analysis/
├── README.md
├── sql/
│   ├── 00_reset_database.sql
│   ├── 01_insert_base_data.sql
│   ├── 02_generate_ai_usage.sql
│   ├── 03_analysis_queries.sql
│   └── 04_advanced_pricing_analysis.sql
├── insights/
│   ├── key_findings.md
│   └── pricing_recommendations.md
└── screenshots/
    ├── 01_ai_usage_row_count.png
    ├── 02_customer_segments.png
    ├── 03_top_ai_consumers.png
    ├── 04_mom_usage_growth.png
    └── 05_discount_leakage_risk.png
```

Each folder is purposefully separated to ensure clarity, reproducibility, and a professional analytics workflow.

---

## Query Results
Screenshots in the screenshots/ folder demonstrate:
- Scaled AI usage data (100+ rows)
- Customer segmentation
- Concentration of AI usage among top customers
- Advanced SQL window function outputs
- Discount leakage and pricing risk identification

---

## How This Relates to GitLab
This project reflects pricing and monetization challenges faced by AI-enabled DevSecOps platforms, including usage-based AI monetization, pricing alignment with compute-intensive workloads, and cross-functional pricing analytics for Product, Finance, and Sales teams.
