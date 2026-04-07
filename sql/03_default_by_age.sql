-- ============================================================
-- Credit Risk Analytics
-- File: 03_default_by_age.sql
-- Description: Default rate segmentation by age group
-- ============================================================

USE credit_risk;

-- Query 1: Default rate by age group
SELECT
    AGE_GROUP,
    COUNT(*)                                        AS applicants,
    SUM(TARGET)                                     AS total_defaults,
    ROUND(SUM(TARGET) * 100.0 / COUNT(*), 2)       AS default_rate_pct,
    ROUND(AVG(AGE), 1)                             AS avg_age,
    ROUND(AVG(AMT_INCOME_TOTAL), 0)                AS avg_income
FROM applications
GROUP BY AGE_GROUP
ORDER BY default_rate_pct DESC;


-- Query 2: Age group x loan type cross analysis
SELECT
    AGE_GROUP,
    NAME_CONTRACT_TYPE,
    COUNT(*)                                        AS applicants,
    ROUND(SUM(TARGET) * 100.0 / COUNT(*), 2)       AS default_rate_pct
FROM applications
GROUP BY AGE_GROUP, NAME_CONTRACT_TYPE
ORDER BY AGE_GROUP, default_rate_pct DESC;


-- Query 3: Young borrowers (under 25) deep dive
SELECT
    INCOME_BRACKET,
    COUNT(*)                                        AS applicants,
    ROUND(SUM(TARGET) * 100.0 / COUNT(*), 2)       AS default_rate_pct,
    ROUND(AVG(AMT_CREDIT), 0)                      AS avg_credit
FROM applications
WHERE AGE_GROUP = '<25'
GROUP BY INCOME_BRACKET
ORDER BY default_rate_pct DESC;


-- Query 4: Employment tenure vs default rate
SELECT
    CASE
        WHEN DAYS_EMPLOYED < 365   THEN '< 1 Year'
        WHEN DAYS_EMPLOYED < 1825  THEN '1-5 Years'
        WHEN DAYS_EMPLOYED < 3650  THEN '5-10 Years'
        ELSE '10+ Years'
    END AS employment_tenure,
    COUNT(*)                                        AS applicants,
    ROUND(SUM(TARGET) * 100.0 / COUNT(*), 2)       AS default_rate_pct
FROM applications
GROUP BY employment_tenure
ORDER BY default_rate_pct DESC;
