-- ============================================================
-- Credit Risk Analytics
-- File: 04_portfolio_exposure.sql
-- Description: Portfolio exposure and concentration by loan type
-- ============================================================

USE credit_risk;

-- Query 1: Portfolio exposure by loan type
SELECT
    NAME_CONTRACT_TYPE,
    COUNT(*)                                        AS total_loans,
    ROUND(SUM(AMT_CREDIT) / 1000000, 2)            AS total_credit_millions,
    ROUND(AVG(AMT_CREDIT), 0)                      AS avg_credit,
    ROUND(MIN(AMT_CREDIT), 0)                      AS min_credit,
    ROUND(MAX(AMT_CREDIT), 0)                      AS max_credit,
    ROUND(SUM(TARGET) * 100.0 / COUNT(*), 2)       AS default_rate_pct
FROM applications
GROUP BY NAME_CONTRACT_TYPE;


-- Query 2: Portfolio share by loan type
SELECT
    NAME_CONTRACT_TYPE,
    COUNT(*)                                        AS total_loans,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM applications), 2) AS portfolio_share_pct,
    ROUND(SUM(AMT_CREDIT) / 1000000, 2)            AS total_credit_millions,
    ROUND(SUM(AMT_CREDIT) * 100.0 /
        (SELECT SUM(AMT_CREDIT) FROM applications), 2) AS credit_share_pct
FROM applications
GROUP BY NAME_CONTRACT_TYPE;


-- Query 3: High value loans (top 10%) default analysis
SELECT
    NAME_CONTRACT_TYPE,
    COUNT(*)                                        AS applicants,
    ROUND(SUM(TARGET) * 100.0 / COUNT(*), 2)       AS default_rate_pct,
    ROUND(AVG(AMT_CREDIT), 0)                      AS avg_credit
FROM applications
WHERE AMT_CREDIT > (
    SELECT PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY AMT_CREDIT)
    FROM applications
)
GROUP BY NAME_CONTRACT_TYPE;


-- Query 4: Credit-to-income ratio risk bands
SELECT
    CASE
        WHEN CREDIT_INCOME_RATIO < 2    THEN 'Low (<2x)'
        WHEN CREDIT_INCOME_RATIO < 4    THEN 'Medium (2-4x)'
        WHEN CREDIT_INCOME_RATIO < 6    THEN 'High (4-6x)'
        ELSE 'Very High (>6x)'
    END AS credit_income_band,
    COUNT(*)                                        AS applicants,
    ROUND(SUM(TARGET) * 100.0 / COUNT(*), 2)       AS default_rate_pct,
    ROUND(AVG(AMT_CREDIT), 0)                      AS avg_credit
FROM applications
GROUP BY credit_income_band
ORDER BY default_rate_pct DESC;
