-- =============================================================================
-- iFood Marketing Campaign Analysis
-- SQL Queries for Portfolio
-- Database: iFood.db  |  Table: ifood_customers
-- Author: Ngatho Kamande
-- =============================================================================
-- TABLE NOTES
-- The ifood_customers table contains 2,205 customer records.
-- Derived columns added during prep:
--   Age_Bracket             — Binned from Age (18-29 | 30-39 | 40-49 | 50-59 | 60+)
--   Has_Children            — "Yes" if Kidhome + Teenhome > 0, else "No"
--   Total_Spend             — Alias for MntTotal_Corrected (sum of all product spend)
--   Total_Campaigns_Accepted— Alias for AcceptedCmpOverall (campaigns 1–5 accepted)
--   Income_Bracket          — Binned from Income (<30k | 30k-50k | 50k-70k | 70k-90k | 90k+)
-- =============================================================================


-- =============================================================================
-- QUERY 1: Campaign Acceptance by Age Bracket
-- Business question: Which age groups are most responsive to marketing campaigns?
-- Metrics: total customers, total campaigns accepted, average campaigns per
--          customer, and percentage of customers who accepted at least one campaign.
-- =============================================================================

SELECT
    Age_Bracket,
    COUNT(*)                                           AS Total_Customers,
    SUM(Total_Campaigns_Accepted)                      AS Campaigns_Accepted,
    ROUND(AVG(Total_Campaigns_Accepted), 2)            AS Avg_Campaigns_Per_Customer,
    ROUND(
        100.0 * SUM(CASE WHEN Total_Campaigns_Accepted > 0 THEN 1 ELSE 0 END)
        / COUNT(*), 1
    )                                                  AS Pct_Any_Campaign
FROM ifood_customers
GROUP BY Age_Bracket
ORDER BY Age_Bracket;

-- Key finding: 18–29 year-olds show the highest acceptance rate (32.6%)
-- despite being the smallest cohort. The 40–49 bracket has the lowest (16.4%).


-- =============================================================================
-- QUERY 2: Channel Preference by Family Type
-- Business question: Do customers with children shop differently than
--                    those without?
-- Metrics: average purchases per channel (web, catalog, store, deals)
--          broken down by family status.
-- =============================================================================

SELECT
    Has_Children,
    ROUND(AVG(NumWebPurchases),     2) AS Avg_Web,
    ROUND(AVG(NumCatalogPurchases), 2) AS Avg_Catalog,
    ROUND(AVG(NumStorePurchases),   2) AS Avg_Store,
    ROUND(AVG(NumDealsPurchases),   2) AS Avg_Deals,
    COUNT(*)                           AS Total_Customers
FROM ifood_customers
GROUP BY Has_Children
ORDER BY Has_Children;

-- Key finding: Customers without children favour catalog (4.71) and store (7.32)
-- channels. Customers with children use deals significantly more (2.79 vs 1.13)
-- and are lower across all premium channels — suggesting price sensitivity.


-- =============================================================================
-- QUERY 3: Spend by Product Category and Income Bracket
-- Business question: How does income level influence spending across
--                    each product category?
-- Metrics: average spend per category and overall, segmented by income bracket.
-- =============================================================================

SELECT
    Income_Bracket,
    ROUND(AVG(MntWines),         2) AS Avg_Wines,
    ROUND(AVG(MntFruits),        2) AS Avg_Fruits,
    ROUND(AVG(MntMeatProducts),  2) AS Avg_Meat,
    ROUND(AVG(MntFishProducts),  2) AS Avg_Fish,
    ROUND(AVG(MntSweetProducts), 2) AS Avg_Sweets,
    ROUND(AVG(MntGoldProds),     2) AS Avg_Gold,
    ROUND(AVG(Total_Spend),      2) AS Avg_Total_Spend,
    COUNT(*)                         AS Total_Customers
FROM ifood_customers
GROUP BY Income_Bracket
ORDER BY
    CASE Income_Bracket
        WHEN '<30k'    THEN 1
        WHEN '30k-50k' THEN 2
        WHEN '50k-70k' THEN 3
        WHEN '70k-90k' THEN 4
        WHEN '90k+'    THEN 5
        ELSE 6
    END;

-- Key finding: Spend scales sharply with income across all categories.
-- Wine is the dominant category at every income level. The 90k+ bracket
-- spends ~30x more on wine than the sub-30k bracket (820 vs 14 avg).
-- =============================================================================
