-- ============================================================
-- Credit Risk Analytics — Database Setup
-- File: 01_create_tables.sql
-- Description: Create the applications table schema
-- ============================================================

CREATE DATABASE IF NOT EXISTS credit_risk;
USE credit_risk;

DROP TABLE IF EXISTS applications;

CREATE TABLE applications (
    SK_ID_CURR          BIGINT PRIMARY KEY,
    TARGET              TINYINT(1) COMMENT '1=Defaulted, 0=Repaid',
    NAME_CONTRACT_TYPE  VARCHAR(50),
    AMT_CREDIT          DECIMAL(15,2),
    AMT_ANNUITY         DECIMAL(15,2),
    AMT_INCOME_TOTAL    DECIMAL(15,2),
    AMT_GOODS_PRICE     DECIMAL(15,2),
    AGE                 INT,
    AGE_GROUP           VARCHAR(20),
    INCOME_BRACKET      VARCHAR(20),
    DAYS_BIRTH          INT,
    DAYS_EMPLOYED       INT,
    DAYS_REGISTRATION   INT,
    ANNUITY_INCOME_RATIO DECIMAL(10,4),
    CREDIT_INCOME_RATIO  DECIMAL(10,4),
    CODE_GENDER         VARCHAR(5),
    FLAG_OWN_CAR        VARCHAR(5),
    FLAG_OWN_REALTY     VARCHAR(5),
    NAME_INCOME_TYPE    VARCHAR(50),
    NAME_EDUCATION_TYPE VARCHAR(100),
    NAME_FAMILY_STATUS  VARCHAR(50),
    REGION_POPULATION_RELATIVE DECIMAL(10,6),
    EXT_SOURCE_1        DECIMAL(10,6),
    EXT_SOURCE_2        DECIMAL(10,6),
    EXT_SOURCE_3        DECIMAL(10,6)
);

-- Verify table created
DESCRIBE applications;
