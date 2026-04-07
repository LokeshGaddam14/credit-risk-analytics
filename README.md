# 📊 Credit Risk Analytics Dashboard
> End-to-end data analytics project on 307K+ loan applications — from raw data to interactive Power BI dashboard.

![Dashboard Preview]
([<img width="1492" height="808" alt="image" src="https://github.com/user-attachments/assets/182b38c6-b08d-4b69-a5b0-ca1b7ab45985" />](https://drive.google.com/file/d/14SJ5R5Qe4aqw0-CZOxbqCFOdUXAZa9PO/view?usp=sharing))

---

## 🎯 Project Overview

This project analyzes credit default risk using the **Home Credit Default Risk** dataset (Kaggle). The goal is to identify high-risk borrower segments and surface actionable insights through a fully interactive Power BI dashboard.

**Business Question:** Which borrower segments are most likely to default, and how can lenders use this to make better credit decisions?

---

## 🗂️ Project Phases

| Phase | Description | Tools |
|-------|-------------|-------|
| 1 — Data Cleaning | Null handling, outlier treatment, type fixes | Python, Pandas |
| 2 — EDA | Distribution analysis, correlation, risk patterns | Matplotlib, Seaborn |
| 3 — Feature Engineering | AGE_GROUP, INCOME_BRACKET, ANNUITY_INCOME_RATIO | Python, Pandas |
| 4 — SQL Analysis | Default rate segmentation queries | MySQL |
| 5 — ML Modeling | XGBoost, LightGBM, SHAP explainability | Scikit-learn, SHAP |
| 6 — Power BI Dashboard | Interactive KPI dashboard via ODBC connection | Power BI, DAX |

---

## 📈 Key Findings

- **Age risk:** Under-25 borrowers default at **11.74%** vs. **5.18%** for 55+ cohort
- **Income risk:** Low-income (<90K) borrowers default at **8.2%** vs. **6.1%** for higher brackets
- **Loan type:** Cash Loans make up **94.81%** of total portfolio exposure
- **Overall default rate:** **8.07%** across 307,511 applications

---

## 🖥️ Dashboard Visuals

| Visual | Description |
|--------|-------------|
| KPI Cards | Total Applicants (307K+) · Overall Default Rate (8.07%) |
| Bar Chart | Default Rate by Income Bracket |
| Bar Chart | Default Rate by Age Group |
| Donut Chart | Portfolio Exposure by Loan Type (₹ Millions) |
| Table | Top High-Risk Applicants |
| Slicer | Filter by Loan Type (Cash / Revolving) |

---

## 🛠️ Tech Stack

```
Python 3.x       — Data cleaning, EDA, feature engineering, ML modeling
MySQL            — Database storage, SQL analysis queries
Power BI Desktop — Dashboard, DAX measures, Power Query (ODBC)
XGBoost          — Gradient boosted classifier
LightGBM         — Fast gradient boosting with SHAP explainability
SHAP             — Model interpretability
Pandas / NumPy   — Data manipulation
Matplotlib / Seaborn — EDA visualizations
```

---

## 📁 Repository Structure

```
credit-risk-analytics/
│
├── notebooks/
│   ├── 01_data_cleaning.ipynb
│   ├── 02_eda.ipynb
│   ├── 03_feature_engineering.ipynb
│   ├── 04_sql_analysis.ipynb
│   └── 05_modeling_xgb_lgbm.ipynb
│
├── sql/
│   ├── create_tables.sql
│   ├── default_by_income.sql
│   ├── default_by_age.sql
│   └── portfolio_exposure.sql
│
├── dashboard/
│   └── credit_risk_dashboard.pdf
│
├── images/
│   └── dashboard_preview.png
│
└── README.md
```

---

## ⚙️ Setup & Reproduction

### 1. Clone the repo
```bash
git clone https://github.com/LokeshGaddam14/credit-risk-analytics.git
cd credit-risk-analytics
```

### 2. Install dependencies
```bash
pip install pandas numpy matplotlib seaborn scikit-learn xgboost lightgbm shap mysql-connector-python
```

### 3. Dataset
Download from [Kaggle — Home Credit Default Risk](https://www.kaggle.com/c/home-credit-default-risk/data)  
Place `application_train.csv` in the root directory.

### 4. Run notebooks in order
Execute notebooks 01 → 05 sequentially in Jupyter or Google Colab.

### 5. Power BI Dashboard
- Set up MySQL ODBC DSN (64-bit System DSN)
- Open `dashboard/credit_risk_dashboard.pbix`
- Refresh data source with your local MySQL credentials

---

## 📊 Model Performance

| Model | AUC-ROC | Notes |
|-------|---------|-------|
| XGBoost | ~0.76 | Baseline tuned |
| LightGBM | ~0.78 | Best performer |

*SHAP values used to identify top default predictors: EXT_SOURCE scores, AMT_CREDIT, DAYS_BIRTH*

---

## 🏷️ Dataset

- **Source:** [Home Credit Default Risk — Kaggle](https://www.kaggle.com/c/home-credit-default-risk)
- **Size:** 307,511 rows × 122 columns
- **Target:** Binary (1 = defaulted, 0 = repaid)
- **Class imbalance:** ~8% positive class

---

## 👤 Author

**Lokesh Gaddam**  
B.Tech ECE (Data Science) — KL University, 2026  
📧 lokeshgaddam2514@gmail.com  
🔗 [LinkedIn](https://linkedin.com/in/lokesh-gaddam-data-analyst) · [GitHub](https://github.com/LokeshGaddam14)
