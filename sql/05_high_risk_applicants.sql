-- ============================================================
-- Credit Risk Analytics
-- File: 05_high_risk_applicants.sql
-- Description: Identify and segment high-risk borrowers
-- ============================================================

USE credit_risk;

-- Query 1: Top 20 high-risk applicants by credit amount
SELECT
    SK_ID_CURR,
    NAME_CONTRACT_TYPE,
    AMT_CREDIT,
    AMT_INCOME_TOTAL,
    AMT_ANNUITY,
    AGE,
    AGE_GROUP,
    INCOME_BRACKET,
    ROUND(ANNUITY_INCOME_RATIO, 4)                 AS annuity_income_ratio,
    ROUND(CREDIT_INCOME_RATIO, 4)                  AS credit_income_ratio,
    TARGET
FROM applications
WHERE TARGET = 1
ORDER BY AMT_CREDIT DESC
LIMIT 20;


-- Query 2: Risk score segmentation
-- Combines age risk + income risk + credit burden
SELECT
    SK_ID_CURR,
    AGE_GROUP,
    INCOME_BRACKET,
    NAME_CONTRACT_TYPE,
    ROUND(AMT_CREDIT, 0)                           AS amt_credit,
    ROUND(CREDIT_INCOME_RATIO, 2)                  AS credit_income_ratio,
    ROUND(ANNUITY_INCOME_RATIO, 2)                 AS annuity_income_ratio,
    TARGET,
    -- Simple composite risk flag
    CASE
        WHEN AGE_GROUP = '<25'
         AND INCOME_BRACKET = '<90K'
         AND CREDIT_INCOME_RATIO > 4 THEN 'Very High Risk'
        WHEN AGE_GROUP IN ('<25', '25-35')
         AND CREDIT_INCOME_RATIO > 3 THEN 'High Risk'
        WHEN ANNUITY_INCOME_RATIO > 0.4 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_segment
FROM applications
WHERE TARGET = 1
ORDER BY CREDIT_INCOME_RATIO DESC
LIMIT 50;


-- Query 3: Default concentration by gender and education
SELECT
    CODE_GENDER,
    NAME_EDUCATION_TYPE,
    COUNT(*)                                        AS applicants,
    ROUND(SUM(TARGET) * 100.0 / COUNT(*), 2)       AS default_rate_pct
FROM applications
GROUP BY CODE_GENDER, NAME_EDUCATION_TYPE
ORDER BY default_rate_pct DESC;


-- Query 4: Overall portfolio summary
SELECT
    COUNT(*)                                        AS total_applicants,
    SUM(TARGET)                                     AS total_defaults,
    ROUND(SUM(TARGET) * 100.0 / COUNT(*), 2)       AS overall_default_rate_pct,
    ROUND(SUM(AMT_CREDIT) / 1000000, 2)            AS total_portfolio_millions,
    ROUND(AVG(AMT_CREDIT), 0)                      AS avg_loan_amount,
    ROUND(AVG(AMT_INCOME_TOTAL), 0)                AS avg_income,
    ROUND(AVG(AGE), 1)                             AS avg_age
FROM applications;
