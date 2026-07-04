# iFood Customer & Campaign Analysis

**Tool stack:** Excel · SQL (SQLite) · Tableau Public  
**Dataset:** iFood Marketing Campaign, Kaggle (2,205 customers analysed, 29 variables)  
**Dashboard:** [View on Tableau Public](https://public.tableau.com/app/profile/david.kamande2809/viz/iFoodCustomerCampaignAnalysis-DavidKamande/Dashboard1)

---

## Problem

iFood ran 5 marketing campaigns across a diverse customer base.
This analysis asks: which customer segments actually converted,
and what does that mean for channel strategy and spend behaviour?

---

## Approach

- Dataset is 2,205 records from Kaggle. Standardised `2n Cycle`
  education values (198 records) to `Master`, since Bologna
  second-cycle qualifications map to Master's level
- Engineered features in Excel: age brackets, income brackets,
  household type, total spend, campaign acceptance totals
- Queried aggregated insights using SQL (SQLite)
- Visualised findings in a four-chart Tableau dashboard

---

## Key Findings

1. **The 40–49 bracket is the largest segment but the least
   campaign-responsive** (16.4% accepted at least one campaign vs
   32.6% for 18–29), suggesting current campaign targeting is
   misaligned with the most populated demographic.

2. **Childless customers use catalog purchasing at 2.6× the rate
   of customers with children** (4.71 vs 1.82), pointing to
   leisure-driven browsing behaviour that disappears with family
   commitments.

3. **Wine spend is the strongest income signal in the dataset**,
   scaling nearly 60× from the lowest to highest bracket (£13.78
   → £820.49). Below £30k, meat outspends wine. It's the only
   bracket where necessity-led purchasing overtakes discretionary
   spend.

---

## Files

| File | Description |
|---|---|
| `iFood.xlsx` | Cleaned dataset with engineered features |
| `ifood_analysis.sql` | SQL queries used for aggregated analysis |
