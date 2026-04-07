-- ============================================================
-- Credit Risk Analytics
-- File: 02_default_by_income.sql
-- Description: Default rate segmentation by income bracket
-- ============================================================

USE credit_risk;

-- Query 1: Default rate by income bracket
SELECT
    INCOME_BRACKET,
    COUNT(*)                                        AS applicants,
    SUM(TARGET)                                     AS total_defaults,
    ROUND(SUM(TARGET) * 100.0 / COUNT(*), 2)       AS default_rate_pct,
    ROUND(AVG(AMT_INCOME_TOTAL), 0)                AS avg_income,
    ROUND(AVG(AMT_CREDIT), 0)                      AS avg_credit
FROM applications
WHERE INCOME_BRACKET IS NOT NULL
  AND INCOME_BRACKET <> ''
GROUP BY INCOME_BRACKET
ORDER BY default_rate_pct DESC;


-- Query 2: Default rate by income bracket AND loan type (cross-cut)
SELECT
    INCOME_BRACKET,
    NAME_CONTRACT_TYPE,
    COUNT(*)                                        AS applicants,
    ROUND(SUM(TARGET) * 100.0 / COUNT(*), 2)       AS default_rate_pct
FROM applications
WHERE INCOME_BRACKET IS NOT NULL
  AND INCOME_BRACKET <> ''
GROUP BY INCOME_BRACKET, NAME_CONTRACT_TYPE
ORDER BY INCOME_BRACKET, default_rate_pct DESC;


-- Query 3: High-default income brackets (above overall average)
SELECT
    INCOME_BRACKET,
    COUNT(*)                                        AS applicants,
    ROUND(SUM(TARGET) * 100.0 / COUNT(*), 2)       AS default_rate_pct
FROM applications
GROUP BY INCOME_BRACKET
HAVING default_rate_pct > (
    SELECT ROUND(SUM(TARGET) * 100.0 / COUNT(*), 2)
    FROM applications
)
ORDER BY default_rate_pct DESC;
